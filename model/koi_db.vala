using Sqlite;

class KoiDB {
	private static Database dictDb;
	private static KoiDB instance;
	
	private KoiDB() {
		var rc = Database.open("/path/to/koidict/data/dict-revised.sqlite3", out dictDb);
		if (rc != Sqlite.OK) {
			error("DB access failed with sql response code: %d\n", rc);
		}
	}

	public static KoiDB singleton() {
		if (instance == null) {
			instance = new KoiDB();
		} 
		return instance;
	}

	public string[] queryTitle(string text) {
		var search = @"select title from entries where title like \"%$text%\" order by length(title) asc, title asc";
		string[] result;
		int nrows;
		int ncols;
		string errormsg;
		var queryrc = dictDb.get_table(search, out result, out nrows, out ncols, out errormsg);
		if (queryrc != Sqlite.OK) {
			error("Query failed with sql response code: %d\n", queryrc);
		}
		return result;
	}
}