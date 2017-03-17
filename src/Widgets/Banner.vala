// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2016 elementary LLC. (https://elementary.io)
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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by: Nathan Dyer <mail@nathandyer.me>
 */

 const string BANNER_STYLE_CSS = """
    .banner {
    	background-color: %s;
        color: %s;
    }
    """;

namespace AppCenter.Widgets {
    public class Banner : Gtk.Button {


    	private string _background_color;
    	public string background_color {
    		get {
    			return _background_color;
			} set {
				_background_color = value;
			}
    	}
    	private string _foreground_color;
    	public string foreground_color {
    		get {
    			return _foreground_color;
    		} set {
    			_foreground_color = value;
    		}
    	}

		public Banner () {
			foreground_color = "white";
			background_color = "rgba(66,83,129,255)";
			reload_css ();
			this.height_request = 300;

			var app_name_label = new Gtk.Label ("App Name");
			app_name_label.get_style_context ().add_class ("h1");
			var generic_description_label = new Gtk.Label ("Generic Name");
			generic_description_label.get_style_context ().add_class ("h2");
			var description_label = new Gtk.Label ("Full Description");
			description_label.get_style_context ().add_class ("h3");
			app_name_label.xalign = 0;
			generic_description_label.xalign = 0;
			description_label.xalign = 0;
			description_label.margin_top = 25;

			Gtk.Image icon = new Gtk.Image.from_icon_name ("application-default-icon", Gtk.IconSize.DIALOG);
			icon.xalign = 1;
			icon.margin = 25;
			var horizontal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
			var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

			vertical_box.pack_start (app_name_label, false, false, 0);
			vertical_box.pack_start (generic_description_label, false, false, 0);
			vertical_box.pack_start (description_label, false, false, 0);
			vertical_box.valign = Gtk.Align.CENTER;

			horizontal_box.pack_start (icon, true, true, 0);
			horizontal_box.pack_start (vertical_box, true, true, 0);

			this.add (horizontal_box);
		}

		public Banner.with_package () {

		}

		private void on_any_color_change () {
			reload_css ();
		}

		private void reload_css () {
			

			var provider = new Gtk.CssProvider ();
	        try {
	            var colored_css = BANNER_STYLE_CSS.printf (background_color, foreground_color);
	            provider.load_from_data (colored_css, colored_css.length);
	            var context = get_style_context ();
	            context.add_provider (provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
	            context.add_class ("banner");
				context.remove_class ("button");
	        } catch (GLib.Error e) {
	            critical (e.message);
	        }
		}

	}
}