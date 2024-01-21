import http.server
import socketserver
    # The import statement combines two operations; 
    # it searches for the named module, then it binds 
    # the results of that search to a name in the local scope.

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.path = 'index.html'
        return http.server.SimpleHTTPRequestHandler.do_GET(self)
        # Refer to https://docs.python.org/3/library/http.server.html

# Create an object of the above class
handler_object = MyHttpRequestHandler

PORT = 5000
my_server = socketserver.TCPServer(("", PORT), handler_object)

# Star the server
my_server.serve_forever()
