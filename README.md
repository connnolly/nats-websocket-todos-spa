# Single-Page TODO List App with NATS over WebSockets

A single-page application designed to introduce and demonstrate basic NATS concepts to developers new to NATS and Synadia Cloud. This app showcases how to leverage NATS for real-time communication, message publishing, and subscription handling within a simple but practical/concrete application.

## Features
_rewrite this_
* Real-time TODO list management with NATS WebSocket protocol and Synadia Cloud
* Categorization of tasks into NOW, NEXT, and LATER sections.
* Tasks added/synced through NATS publish/subscribe.
* Archival of completed tasks in JetStream stream 
* Minimalistic UI.

## Prerequisites
* Sign up at [Synadia Cloud](https://synadia.com/cloud) for a free account
* A browser that supports websockets
    
## Setup  
### Update the Credentials

* Retrieve your NATS credentials from Synadia Cloud.
* Replace the placeholder in the html file with your JWT credentials:  const creds \= \`Your JWT Here\`;  

### Configure persistence
* Create and configure a JetStream stream to capture completed tasks (via Cloud UI)
* Update html file with to publish completed tasks to subject(s) that stream is ingesting on, e.g. 

  `await nc.publish(`${subject}.done`, sc.encode(doneMessage));`

  All tasks marked as done are published to `todo.now.done`, `todo.next.done`, or `todo.later.done`. The corresponding stream ingests `todos.*.done`
  
### Load/open the html file on your display of choice 

* Any modern browser should be able to open the file and connect

### Add TODOs

* Publish messages to the configured subjects (e.g. `todo.now`) via NATS CLI
* manually: `nats pub todos.next "draft launch blog"
* via script, e.g [shell script](raycast/now.sh) [launched with Raycast](https://github.com/raycast/script-commands)
  
## Websockets

### Connecting to Synadia Cloud's global NATS server 
This app uses the [NATS.js WebSocket client](https://github.com/nats-io/nats.js) for connectivity:  

```
const nc \= await connect({  
  servers: \["wss://connect.ngs.global"\],  
  authenticator: credsAuthenticator(new TextEncoder().encode(creds)),  
});
```

## UI/UX Overview

* **Sections**: The app includes three sections for organizing todos. Customize to your own needs as you see fit.
* **NOW**: Immediate tasks
* **NEXT**: Tasks planned for the near future
* **LATER**: Long-term tasks
* **Interactivity**: Each task has a checkbox for marking as done, with visual feedback (strikethrough). Done tasks remain on the UI for 8 hours. Tasks marked as done are persisted in a JetStream stream that can be accessed on Synadia Cloud.
  
## Dependencies

* [NATS.js WebSocket Client](https://github.com/nats-io/nats.js): For simple real-time communication
* [Synadia Cloud](https://synadia.com/cloud): A hosted global NATS server. The app can be configured to work with any NATS server  
 
## Future Enhancements

* **Task Management**: Allow users to remove, promote, or reorder tasks
* **Authentication UI**: Improve security / storage for JWT handling.
* **Offline Support**: Cache tasks locally when disconnected.  
