using Gtk;

[GtkTemplate (ui = "/koidict/ui/application_window.ui")]
public class MyWidget : Box {
	public string text {
		get { return entry.text; }
		set { entry.text = value; }
	}

	[GtkChild]
	private Entry entry;

	public MyWidget (string text) {
		this.text = text;
	}

	[GtkCallback]
	private void button_clicked (Button button) {
		print ("The button was clicked with entry text: %s\n", entry.text);
	}

	[GtkCallback]
	private void entry_changed () {
		print ("The entry text changed: %s\n", entry.text);

		notify_property ("text");
	}
}


public class MyApplication : Gtk.Application {

	const GLib.ActionEntry[] actions = {
		{"quit", quit},
		{"about", about},
	};

	public MyApplication () {
		Object(application_id: "org.koidict.app", flags: ApplicationFlags.FLAGS_NONE);
	}

	protected override void activate () {
		Gtk.ApplicationWindow window = new AppWindow (this);
		window.show ();
		// var testQuery = "select * from entries where title like '切'";
		// DictEntry.query(testQuery);
	}

	protected override void startup () {
		base.startup ();
		add_action_entries(actions, this);
		set_accels_for_action("app.quit", {"<Primary>Q"});
	}

	void about() {
        unowned List<Gtk.Window> windows = get_windows();
        Gtk.show_about_dialog (
            windows != null ? windows.data : null,
            "program-name", "Showdown",
            "version", "0.4",
            "comments", "Simple Markdown viewer",
            "copyright", "Copyright 2015 Craig Barnes",
            "logo-icon-name", "showdown",
            "license-type", Gtk.License.GPL_3_0,
            "website", "https://github.com/craigbarnes/showdown"
        );
    }
}

int main(string[] args) {
	MyApplication app = new MyApplication ();
	return app.run (args);
}