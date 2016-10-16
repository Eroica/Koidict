class DictEntry {
	public DictEntry(string entryId, string heteronymId, string definitionId, 
					 string title, string? radical, string? strokeCount, string? nonRadicalStrokeCount,
					 string? bopomofo, string? pinyin, string? wordType, string? definition, string? example,
					 string? quote, string? synonyms, string? antonyms) {
		EntryID = int.parse(entryId);
		HeteronymID = int.parse(heteronymId);
		DefinitionID = int.parse(definitionId);
		Title = title;
		Radical = radical;
		StrokeCount = int.parse(strokeCount);
		NonRadicalStrokeCount = int.parse(nonRadicalStrokeCount);
		Bopomofo = bopomofo;
		Pinyin = pinyin;
		WordType = wordType;
		Definition = definition;
		Example = example;
		Quote = quote;
		Synonyms = synonyms;
		Antonyms = antonyms;

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
}