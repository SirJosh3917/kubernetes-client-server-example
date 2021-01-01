const http = require("http");

setInterval(
  () =>
    http.get("http://kubeserver", (res) => {
      res.setEncoding("utf-8");
      res.on("data", (d) => {
        console.log(d);
      });
    }),
  1000
);
