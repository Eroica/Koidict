using Sqlite;

class DictEntry {
	public static void query(string search) {
		Database dictDb;
		var rc = Database.open("/path/to/koidict/ui/application_window.ui", out dictDb);
		if (rc == Sqlite.OK) {
			dictDb.exec(search, (numCols, values, colNames) => {
            for (int i = 0; i < numCols; i++) {
                stdout.printf ("%s = %s\n", colNames[i], values[i]);
            }
            stdout.printf ("\n");

            return 0;
            }, null);
		} else {
			stdout.printf("Query failed with sql response code: %d", rc);
		}
		if (rc != Sqlite.OK) {
			stdout.printf("DB access failed with sql response code: %d", rc);	
		}
	}

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