oeffi-server
============

The JRuby implementation of a JSON-APi for the Java-based Oeffi library.

Requires JRuby.

Uses the public enabler library by Andreas Schildbach, which powers [Oeffi](http://oeffi.schildbach.de).

The only method currently supported is a simple autocomplete for a given string. The current provider used is the NASA Provider.

To start the server:

1. clone the project
2. bundle
3. Start the server:

> trinidad -r config.ru

4. curl (or [httpie](https://github.com/jkbr/httpie)) the server:


> curl http://localhost:3000

or

> http GET http://localhost:3000


5. The automcomplete can be found as a POST to /search
