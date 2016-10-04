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

void main(string[] args) {
    var testQuery = "select * from entries where title like '切'";
    DictEntry.query(testQuery);

    Gtk.init (ref args);
    var win = new Window();
    win.destroy.connect (Gtk.main_quit);

    var widget = new MyWidget ("The entry text!");

    win.add (widget);
    win.show_all ();

    Gtk.main ();
}
