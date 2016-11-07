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

[GtkTemplate (ui = "/org/koidict/app/ui/entry_category.ui")]
public class KoiEntryCategory : Box {

	[GtkChild] private Label type;
	[GtkChild] private Box meaningsBox;

	public KoiEntryCategory(DictEntry[] entries) {
		foreach (var e in entries) {
			if (e.WordType == "") {
				type.destroy();
			} else {
				this.type.label = e.WordType;
			}
			break;
		}

		for (var i = 0; i < entries.length; i++) {
			meaningsBox.pack_start(new KoiEntryMeaning (i + 1, entries[i]));
		}
	}
}