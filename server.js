const http = require("http");

const server = http.createServer((_, res) => {
  console.log("received ping");

  res.writeHead(200, { "Content-Type": "text/plain" });
  res.write("Pong!");
  res.end();
});

server.listen(80);
