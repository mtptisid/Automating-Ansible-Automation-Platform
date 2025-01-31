#!/bin/bash

###########################################################################
######## Script for relaunch job in AAP with API                         ##
######## Created By    : MATHAPATI Siddharamayya                         ##
######## Creation Date : 29th January 2025                               ##
######## Email         : msidrm455@gmail.com                             ##
######## Version       : 2.0                                             ##
###########################################################################

# Function to relaunch an Ansible AWX job
relaunch_aap2_job() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <job_id>"
        exit 1
    fi

    JOB_ID=$1
    AWX_URL="https://your-awx-url"   # Replace with your AWX instance URL
    API_TOKEN="your_api_token_here"  # Replace with your API token

    # Send POST request to relaunch the job
    RESPONSE=$(curl -s -w "%{http_code}" -X POST "$AWX_URL/api/v2/workflow_jobs/$JOB_ID/relaunch/" \
        -H "Authorization: Bearer $API_TOKEN" \
        -H "Content-Type: application/json")

    # Separate the HTTP status code from the response body
    HTTP_STATUS=$(echo "$RESPONSE" | tail -n1)
    RESPONSE_BODY=$(echo "$RESPONSE" | head -n -1)

    if [ "$HTTP_STATUS" -eq 201 ]; then
        echo "Job $JOB_ID has been successfully relaunched."
        echo "Response: $RESPONSE_BODY"
    else
        echo "Failed to relaunch job $JOB_ID. HTTP Status: $HTTP_STATUS"
        echo "Response: $RESPONSE_BODY"
    fi
}

# Call the function with the job ID provided as an argument
relaunch_aap_job "$1"
