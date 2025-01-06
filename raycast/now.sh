#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title todos-now
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "DO THIS NOW" }

#!/bin/bash
nats pub todos.now "\"$1\""
