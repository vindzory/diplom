from http.server import BaseHTTPRequestHandler, HTTPServer

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Hello, world!")

if __name__ == "__main__":
    server_address = ("", 8080) 
    httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)
    print("Server running on port 8080...")
    httpd.serve_forever()