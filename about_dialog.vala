namespace AboutDialog {

	// public void about (GLib.SimpleAction a, Gtk.Application app);

	// public about t = aber;

	delegate void test (GLib.SimpleAction a, Gtk.Application app);

	public void aber (GLib.SimpleAction a, Gtk.Application app) {
		unowned List<Gtk.Window> windows = app.get_windows();

		Gtk.AboutDialog dialog = new Gtk.AboutDialog ();
		dialog.set_destroy_with_parent (true);
		dialog.set_transient_for (windows.data);
		dialog.set_modal (true);

		dialog.authors = {"Scrooge McDuck", "Gyro Gearloose"};
		dialog.program_name = "Koidict";
		dialog.comments = "Chinese dictionary";
		dialog.copyright = "Copyright © 2016";
		dialog.version = "0.1";

		dialog.license = "Permission is hereby granted, NOT free of charge, ..., very long text";
		dialog.wrap_license = true;

		dialog.website = "http://en.wikipedia.org/wiki/Scrooge_McDuck";
		dialog.website_label = "Scrooge McDuck and Co.";

		dialog.response.connect ((response_id) => {
			if (response_id == Gtk.ResponseType.CANCEL || response_id == Gtk.ResponseType.DELETE_EVENT) {
				dialog.hide_on_delete ();
			}
			});

		// Show the dialog:
		dialog.present ();
	}
}