using Gtk;

public class MyApplication : Gtk.Application {

	const GLib.ActionEntry[] actions = {
		{"quit", quit},
		{"about", null},
	};

	const string[] test = {"<Primary>Q"};

	public MyApplication () {
		Object(application_id: "org.koidict.app", flags: ApplicationFlags.FLAGS_NONE);

	}

	protected override void activate () {
		var css = new CssProvider ();
		css.load_from_resource (@"$resource_base_path/style.css");

		Gtk.StyleContext.add_provider_for_screen (
			Gdk.Screen.get_default (), css, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

		Gtk.ApplicationWindow window = new AppWindow (this);
		window.show ();
	}

	protected override void startup () {
		base.startup ();
		add_action_entries(actions, this);
		set_accels_for_action("app.quit", test);
	}
}

int main(string[] args) {
	MyApplication app = new MyApplication ();
	return app.run (args);
}