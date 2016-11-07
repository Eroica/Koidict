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
	public string to_string() {
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
	public int EntryID {get; set; default = 0;}
	public int HeteronymID {get; set; default = 0;}
	public int DefinitionID {get; set; default = 0;}

	public string Title {get; set; default = "";}

	public string Radical {get; set; default = "";}
	public int StrokeCount {get; set; default = 0;}
	public int NonRadicalStrokeCount {get; set; default = 0;}
	public string Bopomofo {get; set; default = "";}
	public string Pinyin {get; set; default = "";}

	public string WordType {get; set; default = "";}
	public string Definition {get; set; default = "";}
	public string Example {get; set; default = "";}
	public string Quote {get; set; default = "";}
	public string Synonyms {get; set; default = "";}
	public string Antonyms {get; set; default = "";}
	public string Link {get; set; default = "";}
}