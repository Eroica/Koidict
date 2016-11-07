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

[GtkTemplate (ui = "/org/koidict/app/ui/entry_view.ui")]
public class KoiEntryView : Box {

	[GtkChild] private Label title;
	[GtkChild] private Label bopomofo;
	[GtkChild] private Label pinyin;
	[GtkChild] private Box categoriesBox;

	public KoiEntryView(int heteronym_id, DictEntry[] entries) {
		foreach (var e in entries) {
			title.label = e.Title;
			bopomofo.label = e.Bopomofo;
			pinyin.label = e.Pinyin;
			break;
		}

		string[] categories = {};
		DictEntry[] entries_without_category = {};
		foreach (var e in entries) {
			if (e.WordType == "") {
				entries_without_category += e;
			} else if (!(e.WordType in categories)) {
				categories += e.WordType;
			}
		}
		if (categories.length > 0) {
			foreach (var c in categories) {
				DictEntry[] filtered_entries = {};
				foreach (var e in entries) {
					if (e.WordType == c) {
						filtered_entries += e;
					}
				}
				categoriesBox.pack_end(new KoiEntryCategory(filtered_entries));
			}
		}
		if (entries_without_category.length > 0) {
			categoriesBox.pack_end(new KoiEntryCategory(entries_without_category));
		}
	}
}