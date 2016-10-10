using Gtk;

[GtkTemplate (ui = "/org/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	public AppWindow (Gtk.Application app) {
		Object(application: app);
	}

	[GtkChild]
	public Gtk.Grid grid;

	[GtkChild]
	public HeaderBar KoiHeaderBar;
}