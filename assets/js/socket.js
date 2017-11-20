
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("rooms:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket


// UI Stuff
let chatInput = $("#chat-input");
let messagesContainer = $("#messages");

chatInput.on("keypress", event => {
  if(event.keyCode === 13){
    channel.push("new_message", {body:chatInput.val()});
    chatInput.val("");
  }
});

channel.on("new_message", payload => {
  messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
})
