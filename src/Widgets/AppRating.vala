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
    public class AppRating : Gtk.Grid {

        private AppRatingItem speed_item;
        private AppRatingItem useful_item;
        private AppRatingItem ease_item;

        public AppRating () {
        }

        public AppRating.with_ratings (double speed, double useful, double ease) {
            set_speed_rating (speed);
            set_useful_rating (useful);
            set_ease_rating (ease);
        }

        construct {
            speed_item = new AppRatingItem (0.0, "object-select-symbolic");
            speed_item.hexpand = true;

            useful_item = new AppRatingItem (0.0, "object-select-symbolic");
            useful_item.hexpand = true;
            
            ease_item = new AppRatingItem (0.0, "object-select-symbolic");
            ease_item.hexpand = true;

            this.attach (speed_item, 0, 0, 1, 1);
            this.attach (useful_item, 1, 0, 1, 1);
            this.attach (ease_item, 2, 0, 1, 1);
        }

        public void set_speed_rating (double rating) {
            speed_item.set_rating (rating);
        }

        public void set_useful_rating (double rating) {
            useful_item.set_rating (rating);
        }

        public void set_ease_rating (double rating) {
            ease_item.set_rating (rating);
        }
    }
}
