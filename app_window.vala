using Gtk;

[GtkTemplate (ui = "/org/koidict/app/result_entry.ui")]
public class ResultEntry : Label {


	public ResultEntry (string? str) {
		set_label (str);
	}
}


[GtkTemplate (ui = "/org/koidict/app/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	private List<string> list;
	

	public AppWindow (Gtk.Application app) {
		Object(application: app);
		list = new List<string> ();
		list.append ("red");
		list.append ("macintosh");
		list.append ("gala");
	}

	// [GtkCallback]
	// private void buttonClick (Button button) {
	// 	print ("The button was clicked with entry text:\n");
	// }

	[GtkCallback]
	private void stopSearch (SearchEntry s) {
		s.text = "";
	}

	[GtkCallback]
	private void searchChanged (SearchEntry s) {
		string t = s.text;
		print (@"are you looking for ... $t\n");
		// print ("%s\n", list.nth_data(0));
		foreach (string element in list) {
			if (t == element) {
				KoiResultsList.insert (new ResultEntry (t), -1);
			}
			
		}

		var testQuery = @"select * from entries where title like '$t'";
		DictEntry.query(testQuery);
		// print ("It seems like you are looking for: %s\n", s.text);
	}

	[GtkChild]
	private ListBox KoiResultsList;

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}