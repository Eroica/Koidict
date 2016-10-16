using Gtk;

const string WINDOW_BUTTONS_RIGHT = "menu:minimize,maximize,close";
const string WINDOW_BUTTONS_LEFT = "minimize,maximize,close:menu";

[GtkTemplate (ui = "/org/koidict/app/result_entry.ui")]
public class ResultEntry : Label {
	public ResultEntry (string? str) {
		set_label (str);
	}
}


[GtkTemplate (ui = "/org/koidict/app/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	private GLib.ListStore model = new GLib.ListStore (typeof (ResultEntry));

	public AppWindow (Gtk.Application app) {
		Object(application: app);

		// By default, the header bar's buttons are located on the right side (assuming that the window buttons are located on the left).
		// The following code changes their position to the left if the window buttons are found on the right.		
		if (Gtk.Settings.get_default ().gtk_decoration_layout == WINDOW_BUTTONS_RIGHT) {
			KoiHeaderBar.@foreach ((child) => KoiHeaderBar.child_set_property (child, "pack-type", Gtk.PackType.START));
		}
		
		KoiResultsList.bind_model (model, item => { return item as ResultEntry; });
	}


	[GtkCallback]
	private void stopSearch (SearchEntry s) {
		s.text = "";
	}

	[GtkCallback]
	private void searchChanged (SearchEntry s) {
		model.remove_all ();
		if (s.text != "") {
			var results = KoiDB.singleton().queryTitle(s.text);
			print(@"are you looking for ... " + s.text + "\n");

			foreach (string element in results) {
				model.append (new ResultEntry (element));
			}
		}
	}

	[GtkChild]
	private ListBox KoiResultsList;

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}