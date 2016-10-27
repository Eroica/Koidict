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



public class DictEntry {
	public DictEntry(string entryId, 
					 string heteronymId, 
					 string definitionId, 
					 string title, 
					 string? radical, 
					 string? strokeCount, 
					 string? nonRadicalStrokeCount,
	 				 string? bopomofo, 
	 				 string? pinyin,
	 				 string? wordType, 
	 				 string? definition, 
	 				 string? example,
					 string? quote, 
					 string? synonyms, 
					 string? antonyms,
					 string? link) {

		EntryID = int.parse(entryId);
		HeteronymID = int.parse(heteronymId);
		DefinitionID = int.parse(definitionId);
		Title = title;
		Radical = radical ?? "";
		StrokeCount = (strokeCount != null) ? int.parse(strokeCount) : 0;
		NonRadicalStrokeCount = (nonRadicalStrokeCount != null) ? int.parse(nonRadicalStrokeCount) : 0;
		Bopomofo = bopomofo ?? "";
		Pinyin = pinyin ?? "";
		WordType = wordType ?? "";
		Definition = definition ?? "";
		Example = example ?? "";
		Quote = quote ?? "";
		Synonyms = synonyms ?? "";
		Antonyms = antonyms ?? "";
		Link = link ?? "";
	}

	public string String() {
		return @"
		Entry ID: $EntryID
		HeteronymID: $HeteronymID
		Definition ID: $DefinitionID
		Title: $Title
		Radical: $Radical
		Stroke count: $StrokeCount
		Non-radical stroke count: $NonRadicalStrokeCount
		Bopomofo: $Bopomofo
		Pinyin: $Pinyin
		Word type: $WordType
		Definition: $Definition
		Example: $Example
		Quote: $Quote
		Synonyms: $Synonyms
		Antonyms: $Antonyms
		Link: $Link
		";
	}
	
	public const string DictID = "1";
	public int EntryID { get; private set;}
	public int HeteronymID { get; private set;}
	public int DefinitionID { get; private set; }

	public string Title { get; private set; }

	public string Radical { get; private set; }
	public int StrokeCount { get; private set; }
	public int NonRadicalStrokeCount { get; private set; }
	public string Bopomofo { get; private set; }
	public string Pinyin { get; private set; }

	public string WordType { get; private set; }
	public string Definition { get; private set; }
	public string Example { get; private set; }
	public string Quote { get; private set; }
	public string Synonyms { get; private set; }
	public string Antonyms { get; private set; }
	public string Link { get; private set; }
}