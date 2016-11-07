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

const string WINDOW_BUTTONS_RIGHT = "menu:";
const string WINDOW_BUTTONS_LEFT = ":menu";

[GtkTemplate (ui = "/org/koidict/app/ui/result_entry.ui")]
public class ResultEntry : Label {
	public ResultEntry (string? str) {
		label = str;
	}
}


[GtkTemplate (ui = "/org/koidict/app/ui/app_window.ui")]
public class AppWindow : Gtk.ApplicationWindow {

	[GtkChild] private ListBox KoiResultsList;
	[GtkChild] public HeaderBar KoiHeaderBar;
	[GtkChild] private Box DefinitionsView;

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
			var dict_entries = KoiDB.Singleton ()
			.Get (result_entry.label);
			for (int i = 0; i < dict_entries.length; i++) {
				print(@"$(dict_entries.index(i))");
			}

			DictEntry[] ds = {};
			for (var i=0; i < dict_entries.length; i++) {
				ds += dict_entries.index(i);
			}

			int[] heteronym_ids = {};
			for (var i=0; i < dict_entries.length; i++) {
				if (!(dict_entries.index(i).HeteronymID in heteronym_ids)) {
					heteronym_ids += dict_entries.index(i).HeteronymID;
				}
			}

			DefinitionsView.@foreach(child => child.destroy());
			foreach (var id in heteronym_ids) {
				DictEntry[] entries = {};
				foreach (var d in ds) {
					if (d.HeteronymID == id) {
						entries += d;
					}
				}
				DefinitionsView.pack_start(new KoiEntryView(id, entries));
			}
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