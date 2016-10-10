using Gtk;

[GtkTemplate (ui = "/koidict/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	public AppWindow (Gtk.Application app) {
		Object(application: app);
	}

	[GtkCallback]
	private void buttonClick (Button button) {
		print ("The button was clicked with entry text:\n");
	}

	[GtkCallback]
	private void stopSearch (SearchEntry s) {
		s.text = "";
	}

	[GtkCallback]
	private void searchChanged (SearchEntry s) {
		string t = s.text;
		var testQuery = @"select * from entries where title like '$t'";
		DictEntry.query(testQuery);
		print ("It seems like you are looking for: %s\n", s.text);
	}

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}