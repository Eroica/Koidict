using Gtk;

const string WINDOW_BUTTONS_RIGHT = "menu:";
const string WINDOW_BUTTONS_LEFT = ":menu";

[GtkTemplate (ui = "/org/koidict/app/ui/result_entry.ui")]
public class ResultEntry : Label {
	public ResultEntry (string? str) {
		set_label (str);
	}
}


[GtkTemplate (ui = "/org/koidict/app/ui/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	[GtkChild] private ListBox KoiResultsList;
	[GtkChild] public HeaderBar KoiHeaderBar;
	private GLib.ListStore model = new GLib.ListStore (typeof (ResultEntry));

	public AppWindow (Gtk.Application app) {
		Object(application: app);

		// If the current WM settings place the window buttons on the left instead of the right,
		// move all HeaderBar items to the right.
		if (WINDOW_BUTTONS_LEFT in Gtk.Settings.get_default ().gtk_decoration_layout) {
			KoiHeaderBar.@foreach ((child) => KoiHeaderBar.child_set_property (child, "pack-type", Gtk.PackType.END));
		}
		
		KoiResultsList.bind_model (model, item => { return item as ResultEntry; });
	}

	[GtkCallback]
	private void results_row_selected(ListBoxRow? row) {
		if (row != null) {
			var result_entry = model.get_item (row.get_index ()) as ResultEntry;
			var dict_entry = KoiDB.Singleton ().Get (result_entry.label);
		} 
	}

	[GtkCallback]
	private void stopSearch (SearchEntry s) {
		s.text = "";
	}

	[GtkCallback]
	private void searchChanged (SearchEntry s) {
		model.remove_all ();
		if (s.text != "") {
			var results = KoiDB.Singleton().QueryTitle(s.text);
			foreach (string element in results) {
				model.append (new ResultEntry (element));
			}
		}
	}
}