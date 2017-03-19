/* Copyright 2017 Blake Kostner <blake@elementary.io>
*
* This program is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program. If not, see http://www.gnu.org/licenses/.
*/

public class AppCenterCore.Houston : Object {
    private const string HOUSTON_API_URL = "http://localhost:3000/api";

    private Soup.Session session;

    public signal void changing_newest ();
    public string[] newest;

    construct {
        session = new Soup.Session ();

        newest = {};
    }

    private Json.Object process_response (string res) throws Error {
        var parser = new Json.Parser ();
        parser.load_from_data (res, -1);

        var root = parser.get_root ().get_object ();

        if (root.has_member ("errors") && root.get_array_member ("errors").get_length () > 0) {
            var err = root.get_array_member ("errors").get_object_element (0).get_string_member ("title");

            if (err != null) {
                throw new Error (0, 0, err);
            } else {
                throw new Error (0, 0, "Error while talking to Houston");
            }
        }

        return root;
    }

    public async void get_newest () {
        var uri = HOUSTON_API_URL + "/newest";
        var message = new Soup.Message ("GET", uri);

        session.queue_message (message, (session, msg) => {
            try {
                var data = process_response ((string) msg.response_body.data).get_array_member ("data");

                stdout.printf ("testing");

                string[] ids = {};
                foreach (var id in data.get_elements ()) {
                    ids += ((string) id.get_value ());
                }
                newest = ids;
            } catch (Error e) {
                stderr.printf ("Unable to fetch newest list from Houston: %s", e.message);
            }

            changing_newest ();
        });
    }

    private static GLib.Once<Houston> instance;
    public static unowned Houston get_default () {
        return instance.once (() => { return new Houston (); });
    }
}
