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

[GtkTemplate (ui = "/org/koidict/app/ui/entry_meaning.ui")]
public class KoiEntryMeaning : Box {

	[GtkChild] private Label index;
	[GtkChild] private TextBuffer meaningBuffer;

	public KoiEntryMeaning(int index) {
		this.index.label = index.to_string();
		meaningBuffer.text = "huhu\nneue Zeile";
	}
}