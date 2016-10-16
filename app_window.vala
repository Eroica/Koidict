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
		var results = KoiDB.singleton().queryTitle(s.text);
		print(@"are you looking for ... " + s.text + "\n");
		// print ("%s\n", list.nth_data(0));
		foreach (string element in results) {
			print(element + "\n");
		//	KoiResultsList.insert(new ResultEntry(element), -1);
			
		}
		// print ("It seems like you are looking for: %s\n", s.text);
	}

	[GtkChild]
	private ListBox KoiResultsList;

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}