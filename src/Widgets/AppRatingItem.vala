// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2014-2016 elementary LLC. (https://elementary.io)
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
 * Authored by: Dane Henson <thegreatdane@gmail.com>
 */

namespace AppCenter.Widgets {
    public class AppRatingItem : Gtk.Grid {

        private Gtk.Image image;
        private Gtk.Label label;

        public AppRatingItem (double rating, string icon) {
            set_column_homogeneous (true);

            image = new Gtk.Image.from_icon_name (icon, Gtk.IconSize.LARGE_TOOLBAR);
            label = new Gtk.Label ("");
            set_rating (rating);

            this.attach (image, 0, 0, 1, 1);
            this.attach (label, 0, 1, 1, 1);
        }

        public void set_rating (double rating) {
            var percent = "%f".printf (rating * 100);
            var label_text = percent.split(".", 2);
            label.set_label (label_text[0] + "%");
        }
    }
}