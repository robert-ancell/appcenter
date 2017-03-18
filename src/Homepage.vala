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
 *				Dane Henson <thegreatdane@gmail.com>
 */

namespace AppCenter {
    public class Homepage: Gtk.Box {

    	public AppCenter.Views.CategoryView category_view;
        private Gtk.ScrolledWindow scrolled_window;

    	public Homepage () {

            var client = AppCenterCore.Client.get_default ();
            var all_packages = 

    	    scrolled_window = new Gtk.ScrolledWindow (null, null);
            var scrolled_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);

            var banner_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);
            Widgets.Banner banner;

            /*
                string featured_app = HoustonClient.get_default ().get_featured_app ();
                AppCenterCore.Package featured_package  = AppCenterCore.Client.get_default ().get_app_package (featured_app);
                string last_known_featured = AppCenter.Settings.get_default ().featured_app;
                AppCenterCore.Package last_featured_package = AppCenterCore.Client.get_default ().get_app_package (last_known_featured);
                banner = new Widgets.Banner ();
                if (featured_package != null) {
                    banner.set_package (featured_package);
                } else if (last_featured_package != null)
                    banner.set_package (last_featured_package);
                }
            */

            banner = new Widgets.Banner ();
            banner_box.add (banner);

    		var trending_label = new Gtk.Label ("Trending");
            trending_label.get_style_context ().add_class ("h4");
            trending_label.xalign = 0;
            trending_label.margin_left = 12;

            var trending_scrolled = new Gtk.ScrolledWindow (null, null);
            trending_scrolled.height_request = 100;
            var trending_carousel = new Widgets.AppCarousel ();
            var trending_sizegroup = new Gtk.SizeGroup (Gtk.SizeGroupMode.HORIZONTAL);
            trending_sizegroup.add_widget (trending_carousel);
            trending_scrolled.add (trending_carousel);

    		var recent_label = new Gtk.Label ("Recent");
            recent_label.get_style_context ().add_class ("h4");
            recent_label.xalign = 0;
            recent_label.margin_left = 12;

            var recent_scrolled = new Gtk.ScrolledWindow (null, null);
            recent_scrolled.height_request = 100;
            var recent_carousel = new Widgets.AppCarousel ();
            recent_scrolled.add (recent_carousel);

    		var categories_label = new Gtk.Label ("Categories"); 
            categories_label.get_style_context ().add_class ("h4");
            categories_label.xalign = 0;
            categories_label.margin_left = 12;

    		category_view = new Views.CategoryView ();

            scrolled_box.add (banner_box);
    		scrolled_box.add (trending_label);
            scrolled_box.add (trending_scrolled);
    		scrolled_box.add (recent_label);
            scrolled_box.add (recent_scrolled);
    		scrolled_box.add (categories_label);
    		scrolled_box.add (category_view.category_flow);

            scrolled_window.add (scrolled_box);
            this.add (scrolled_window);
    	}
	}
}