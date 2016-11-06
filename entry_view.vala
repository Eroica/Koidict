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
	[GtkChild] private ListBox koiCategoryList;

	private GLib.ListStore model = new GLib.ListStore (typeof (KoiEntryCategory));

	public KoiEntryView() {
		koiCategoryList.bind_model (model, item => { return item as KoiEntryCategory; });
	}

	public void ChangeDictEntry(DictEntry d) {
		title.label = d.Title;
		bopomofo.label = d.Bopomofo;
		pinyin.label = d.Pinyin;
		model.remove_all();
		model.append(new KoiEntryCategory(d));
		// DefinitionBuffer.text = d.Definition;
	}
}