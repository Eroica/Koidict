using Sqlite;

class KoiDB {
	enum EntryColumns {Id, Title, Radical, StrokeCount, NonRadicalStrokeCount, DictId}
	enum HeteronymColumns {Id, EntryId, Idx, Bopomofo, Bopomofo2, Pinyin}
	enum DefinitionColumns {Id, HeteronymId, Idx, Type, Def, Example, Quote, Synonyms, Antonyms, Link, Source}

	private static Database dictDb;
	private static KoiDB instance;
	
	private KoiDB() {
		var rc = Database.open("/path/to/koidict/data/dict-revised.sqlite3", out dictDb);
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

	public DictEntry Get(string element) {
		var entryQuery = @"select * from entries where title = \"$element\"";
		var entry = query(entryQuery);

		var heteronymQuery = "select * from heteronyms where entry_id = " + entry[EntryColumns.Id];
		var heteronym = query(heteronymQuery);

		var definitionQuery = "select * from definitions where heteronym_id = " + heteronym[HeteronymColumns.Id];
		var def = query(definitionQuery);
		
		return new DictEntry(entry[EntryColumns.Id], 
							 heteronym[HeteronymColumns.Id], 
							 def[DefinitionColumns.Id],
							 entry[EntryColumns.Title], 
							 entry[EntryColumns.Radical], 
							 entry[EntryColumns.StrokeCount], 
							 entry[EntryColumns.NonRadicalStrokeCount],
							 heteronym[HeteronymColumns.Bopomofo], 
							 heteronym[HeteronymColumns.Pinyin],
							 def[DefinitionColumns.Type], 
							 def[DefinitionColumns.Def],
							 def[DefinitionColumns.Example], 
							 def[DefinitionColumns.Quote], 
							 def[DefinitionColumns.Synonyms], 
							 def[DefinitionColumns.Antonyms], 
							 def[DefinitionColumns.Link]);
	}
}