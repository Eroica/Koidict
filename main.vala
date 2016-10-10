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
	public MyApplication () {
		Object(application_id: "org.koidict.app", flags: ApplicationFlags.FLAGS_NONE);
	}

	protected override void activate () {
        Gtk.ApplicationWindow window = new AppWindow (this);
		window.show ();
    }
}

int main(string[] args) {
    var testQuery = "select * from entries where title like '切'";
    DictEntry.query(testQuery);

    MyApplication app = new MyApplication ();
	return app.run (args);
}