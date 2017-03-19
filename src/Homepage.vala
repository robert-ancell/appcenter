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
*              Dane Henson <thegreatdane@gmail.com>
*/

namespace AppCenter {
    public class Homepage: Gtk.Box {

        public Widgets.Banner newest_banner;
        public AppCenter.Views.CategoryView category_view;
        private Gtk.ScrolledWindow scrolled_window;

        public Homepage () {
            scrolled_window = new Gtk.ScrolledWindow (null, null);
            var scrolled_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
            var banner_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);

            newest_banner = new Widgets.Banner ();
            AppCenterCore.Houston.get_default ().changing_newest.connect (update_newest_banner);
            banner_box.add (newest_banner);

            var trending_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            var trending_label = new Gtk.Label ("Trending");
            trending_label.get_style_context ().add_class ("h4");
            trending_label.xalign = 0;

            var trending_more_button_label = new Gtk.Label (_("<small>More</small>"));
            trending_more_button_label.use_markup = true;
            var trending_more_button = new Gtk.Button ();
            trending_more_button.add (trending_more_button_label);
            trending_more_button.halign = Gtk.Align.END;
            trending_more_button.valign = Gtk.Align.CENTER;
            trending_box.add (trending_label);
            trending_box.add (trending_more_button);
            trending_box.homogeneous = true;
            trending_box.margin_left = 12;
            trending_box.margin_right = 12;

            var trending_carousel = new Widgets.AppCarousel ();

            var recent_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            var recent_label = new Gtk.Label ("Recent");
            recent_label.get_style_context ().add_class ("h4");
            recent_label.xalign = 0;

            var recent_more_button_label = new Gtk.Label (_("<small>More</small>"));
            recent_more_button_label.use_markup = true;
            var recent_more_button = new Gtk.Button ();
            recent_more_button.add (recent_more_button_label);
            recent_more_button.halign = Gtk.Align.END;
            recent_more_button.valign = Gtk.Align.CENTER;
            recent_box.add (recent_label);
            recent_box.add (recent_more_button);
            recent_box.homogeneous = true;
            recent_box.margin_left = 12;
            recent_box.margin_right = 12;

            var recent_carousel = new Widgets.AppCarousel ();

            var categories_label = new Gtk.Label ("Categories");
            categories_label.get_style_context ().add_class ("h4");
            categories_label.xalign = 0;
            categories_label.margin_left = 12;

            category_view = new Views.CategoryView ();

            scrolled_box.add (banner_box);
            scrolled_box.add (trending_box);
            scrolled_box.add (trending_carousel);
            scrolled_box.add (recent_box);
            scrolled_box.add (recent_carousel);
            scrolled_box.add (categories_label);
            scrolled_box.add (category_view.category_flow);

            scrolled_window.add (scrolled_box);
            this.add (scrolled_window);

            AppCenterCore.Houston.get_default ().get_newest ();
        }

        public async void update_newest_banner () {
            var houston = AppCenterCore.Houston.get_default ();
            if (houston.newest.length > 0) {
                // var newest_id = houston.newest[1] + ".desktop";
                var newest_id = "com.github.btkostner.vocal.desktop";
                var newest_package = AppCenterCore.Client.get_default ().get_package_for_id (newest_id);
                if (newest_package != null) {
                    newest_banner.set_package (newest_package);
                }
            }
        }
    }
}
