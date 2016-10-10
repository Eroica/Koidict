using Gtk;

[GtkTemplate (ui = "/koidict/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	public AppWindow (Gtk.Application app) {
		Object(application: app);
	}

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}