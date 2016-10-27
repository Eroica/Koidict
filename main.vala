/** 
 * Koidict -- A Chinese dictionary application for Gtk+
 * Copyright (C) 2016  My-Tien Nguyen, Seba Zheng.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

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
		css.load_from_resource (@"$resource_base_path/ui/style.css");

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