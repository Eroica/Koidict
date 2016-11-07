/** 
 * Koidict -- A Chinese dictionary application for Gtk+
 * Copyright (C) 2016  My-Tien Nguyen, Seba Zheng.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */


using Sqlite;

class KoiDB {
	enum EntryColumns {Id, Title, Radical, StrokeCount, NonRadicalStrokeCount, DictId;
		public static int Num() {
			return DictId + 1;
		}
	}
	enum HeteronymColumns {Id, EntryId, Idx, Bopomofo, Bopomofo2, Pinyin;
		public static int Num() {
			return Pinyin + 1;
		}
	}
	enum DefinitionColumns {Id, HeteronymId, Idx, Type, Def, Example, Quote, Synonyms, Antonyms, Link, Source;
		public static int Num() {
			return Source + 1;
		}
	}

	private static Database dictDb;
	private static KoiDB instance;
	
	private KoiDB() {
		var rc = Database.open(Environment.get_user_data_dir () + "/" + Environment.get_prgname () + "/" + "dict-revised.sqlite3", out dictDb);
		if (rc != Sqlite.OK) {
			error("DB access failed with sql response code: %d\n", rc);
		}
	}

	public static KoiDB Singleton() {
		if (instance == null) {
			instance = new KoiDB();
		} 
		return instance;
	}

	private string[] query(string queryText) {
		string[] result;
		int nrows;
		int ncols;
		string errormsg;
		var queryrc = dictDb.get_table(queryText, out result, out nrows, out ncols, out errormsg);
		if (queryrc != Sqlite.OK) {
			error(@"Query failed with sql response code: $queryrc. \n Error message: $errormsg\n Query: $queryText\n");
		}
		return result[ncols:result.length]; // strip header
	}

	public string[] QueryTitle(string text) {
		var titleQuery = @"select title from entries where title like \"%$text%\" order by length(title) asc, title asc";
		return query(titleQuery);
	}

	public Array<DictEntry> Get(string element) {
		var entryQuery = @"select * from	entries as entry,
									heteronyms  as heteronym,
									definitions as definition
							where	title = \"$element\" and
									heteronym.entry_id = entry.id and
									definition.heteronym_id = heteronym.id";
		var entries = query(entryQuery);
		var results = new Array<DictEntry>();
		var allColumns = EntryColumns.Num() + HeteronymColumns.Num() + DefinitionColumns.Num();
		for (int i = 0; i < entries.length - allColumns + 1; i += allColumns) {
			results.append_val(new DictEntry());
			var dictEntry = results.index(results.length - 1);
			var hOffset = EntryColumns.Num();
			var dOffset = hOffset + HeteronymColumns.Num();

			var entryId = entries[i + EntryColumns.Id];
			dictEntry.EntryID = (entryId != null) ? int.parse(entryId) : 0;
			dictEntry.Title = entries[i + EntryColumns.Title] ?? "";
			dictEntry.Radical = entries[i + EntryColumns.Radical] ?? "";
			var strokeCount = entries[i + EntryColumns.StrokeCount];
			dictEntry.StrokeCount = (strokeCount != null) ? int.parse(strokeCount) : 0;
			var nonRadicalStrokeCount = entries[i + EntryColumns.NonRadicalStrokeCount];
			dictEntry.NonRadicalStrokeCount = (nonRadicalStrokeCount != null) ? int.parse(nonRadicalStrokeCount) : 0;

			var heteronymId = entries[i + hOffset + HeteronymColumns.Id];
			dictEntry.HeteronymID = (heteronymId != null) ? int.parse(heteronymId) : 0;
			dictEntry.Bopomofo = entries[i + hOffset + HeteronymColumns.Bopomofo] ?? "";
			dictEntry.Pinyin = entries[i + hOffset + HeteronymColumns.Pinyin] ?? "";

			var definitionId = entries[i + dOffset + DefinitionColumns.Id];
			dictEntry.DefinitionID = (definitionId != null) ? int.parse(definitionId) : 0;
			dictEntry.WordType = entries[i + dOffset + DefinitionColumns.Type] ?? "";
			dictEntry.Definition = entries[i + dOffset + DefinitionColumns.Def] ?? "";
			dictEntry.Example = entries[i + dOffset + DefinitionColumns.Example] ?? "";
			dictEntry.Quote = entries[i + dOffset + DefinitionColumns.Quote] ?? "";
			dictEntry.Synonyms = entries[i + dOffset + DefinitionColumns.Synonyms] ?? "";
			dictEntry.Antonyms = entries[i + dOffset + DefinitionColumns.Antonyms] ?? "";
			dictEntry.Link = entries[i + dOffset + DefinitionColumns.Link] ?? "";
		}
		return results;
	}
}