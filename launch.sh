#!/bin/bash
set -e
clear

# Required values
REQUIRED_EMAIL="mybusinesspartnereric@gmail.com"
REQUIRED_PROJECT="dev-exchanger-459910-i8"

# Fetch current gcloud settings
ACTIVE_EMAIL=$(gcloud config get-value account 2>/dev/null)
ACTIVE_PROJECT=$(gcloud config get-value project 2>/dev/null)

# Show header
echo "Authenticated as: $ACTIVE_EMAIL"
echo "Active Project:   $ACTIVE_PROJECT"
echo

# Check email
if [[ "$ACTIVE_EMAIL" != "$REQUIRED_EMAIL" ]]; then
  echo "ERROR: gcloud account mismatch."
  echo "Expected account: $REQUIRED_EMAIL"
  echo "Run: gcloud auth login $REQUIRED_EMAIL"
  exit 1
fi

# Auto‐switch project if needed
if [[ "$ACTIVE_PROJECT" != "$REQUIRED_PROJECT" ]]; then
  echo "Switching gcloud project to $REQUIRED_PROJECT"
  gcloud config set project "$REQUIRED_PROJECT" >/dev/null
  ACTIVE_PROJECT="$REQUIRED_PROJECT"
  echo "Now Active Project: $ACTIVE_PROJECT"
  echo
fi

# Recompute token
ACCESS_TOKEN=$(gcloud auth print-access-token)

# Show menu
echo "RADEST Central Command"
echo "-----------------------"
echo "1) status        - List Cloud Functions"
echo "2) deploy kindra - Launch AI agents"
echo "12) toggle theme - Trigger themeToggle"
echo "q) quit"
echo
read -p "Command> " cmd
echo

# Helper: Datastore commit call
datastore_commit() {
  local KIND=$1
  local PROP_NAME=$2
  local PROP_VALUE=$3

  cat <<EOF | \
  curl -s -X POST \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    "https://datastore.googleapis.com/v1/projects/$REQUIRED_PROJECT:commit"
{
  "mode":"NON_TRANSACTIONAL",
  "mutations":[
    {
      "upsert":{
        "key":{"path":[{"kind":"radest","name":"$KIND"}]},
        "properties":{ "$PROP_NAME":{ "booleanValue": $PROP_VALUE } }
      }
    }
  ]
}
EOF
}

# Dispatch
case "$cmd" in
  1)
    echo "Listing Cloud Functions..."
    firebase functions:list --project="$REQUIRED_PROJECT"
    ;;

  2)
    echo "Deploying Kindra..."
    if datastore_commit "deploy" "active" true | grep -q '"indexUpdates";'; then
      echo "SUCCESS: Kindra deployed."
    else
      echo "FAILED: could not deploy Kindra."
    fi
    ;;

  12)
    echo "Toggling themeToggle..."
    if datastore_commit "themeToggle" "trigger" true | grep -q '"indexUpdates";'; then
      echo "SUCCESS: themeToggle updated."
    else
      echo "FAILED: could not toggle theme."
    fi
    ;;

  q|quit)
    echo "Exiting."
    exit 0
    ;;

  *)
    echo "Unknown command: $cmd"
    exit 1
    ;;
esac

