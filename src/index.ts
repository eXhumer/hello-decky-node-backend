import { WebSocket, WebSocketServer } from "ws";

let sockets: WebSocket[] = [];

const wss = new WebSocketServer({ port: 3000 });

wss.on("connection", ws => {
  sockets.push(ws);

  ws.on("message", msg => {
    ws.send(msg);
  });

  ws.on("close", () => {
    sockets = sockets.filter(socket => socket !== ws);
  });
});
