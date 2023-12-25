import express from "express";
import { createServer } from "http";
import { Server } from "socket.io";
import cors from "cors";

const users = new Set();

// start server and spin up socket
const serverAndSocketConnector = () => {
  const app = express();
  const httpConnection = createServer(app);
  const socket = new Server(httpConnection);

  // Enable CORS
app.use(
  cors({
    origin: "*",
  })
);


  try {
    // create a socket connection
    socket.on("connection", (soc) => {
      console.log("User has been connected");

      // broadcast welcome message to all connected clients
      socket.emit("new user", "Welcome to our chat channel");

      soc.on("new user", () => {
        users.add(soc.id);
        soc.emit("new user", `Welcome user ${soc.id}`);
      });

      soc.on("message", (message) => {
        console.log("Received message:", message);
        // broadcast message to all connected clients
        socket.emit("message", message);
      });

      soc.on("disconnect", () => {
        console.log("User Disconnected");
      });
    });
  } catch (error) {
    throw new Error(
      "An error has occurred while trying to connect to the server"
    );
  }

  httpConnection.listen(3001, () => {
    console.log(`App listening to port 3001`);
  });
};

serverAndSocketConnector();
