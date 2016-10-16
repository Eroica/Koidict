class DictEntry {
	public string Title { get; private set; }
	
	public string DictID { get; private set;}
	public int EntryID { get; private set;}
	public int HeteronymID { get; private set;}
	public int DefinitionID { get; private set; }

	public string Radical { get; private set; }
	public uint StrokeCount { get; private set; }
	public uint NonRadicalStrokeCount { get; private set; }
	public string Bopomofo { get; private set; }
	public string Pinyin { get; private set; }

	public string WordType { get; private set; }
	public string Definition { get; private set; }
	public string Example { get; private set; }
	public string Quote { get; private set; }
	public string Synonyms { get; private set; }
	public string Antonyms { get; private set; }
}