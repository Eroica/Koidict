using GLib;

public class WordTypes {
	public HashTable<string, string> WordTypesMap;

	static construct {
		WordTypesMap = new HashTable<string, string> (str_hash, str_equal);
		WordTypesMap.insert ("", "test");
	}
}