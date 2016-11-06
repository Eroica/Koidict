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
	[GtkChild] private ListBox meaningsList;
	private GLib.ListStore model = new GLib.ListStore (typeof (KoiEntryMeaning));

	public KoiEntryCategory(DictEntry d) {
		meaningsList.bind_model (model, item => { return item as KoiEntryMeaning; });
		this.type.label = "type";

		for (var i = 0; i < 1; i++) {
			model.append (new KoiEntryMeaning (1));
		}
		// for (var i = 0; i < meanings.length; i++) {
		// 	model.append (new KoiEntryMeaning (i, meanings[i]));
		// }
	}

	public void ChangeDictEntry(string type, DictEntry[] meanings) {

	}
}