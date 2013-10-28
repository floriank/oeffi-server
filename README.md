oeffi-server
============

The JRuby implementation of a small server that utilizes the oeffi-gem, based on the public transport enabler library by Andreas Schildbach, which powers [Oeffi](http://oeffi.schildbach.de).

Requires JRuby.


To start the server:

1. clone the project
2. bundle
3. Start the server:
````
trinidad -r config.ru
````
4. curl (or [httpie](https://github.com/jkbr/httpie)) the server:
```
curl http://localhost:3000
```
5. The automcomplete can be found as a POST to /suggest
