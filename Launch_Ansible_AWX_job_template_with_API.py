import requests
import sys
import json

def launch_job(aap_url, api_token, job_template_id, extra_vars):
    # API endpoint for launching the job
    launch_url = f"{aap_url}/api/v2/job_templates/{job_template_id}/launch/"

    # Headers for the POST request
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {api_token}"
    }

    # Payload with extra_vars
    payload = {
        "extra_vars": extra_vars
    }

    # Make the POST request to launch the job
    response = requests.post(launch_url, headers=headers, json=payload)

    # Check if the request was successful and print the response
    if response.status_code == 201:
        print("Job launched successfully.")
        response_json = response.json()
        job_id = response_json.get("id")
        job_name = response_json.get("name")
        print(f'Job ID: {job_id} - {job_name}')
    else:
        print(f"Failed to launch job. Status code: {response.status_code}")

    #print("Response:")
    #print(json.dumps(response.json(), indent=4))

if __name__ == "__main__":
    # AAP API URL, Job Template ID, and API Token
	api_url = 'https://myansible.automation-platform.org.in/api/v2'
	api_token = 'your_api_token'
    job_template_id = "1641"

    # Collect the values from command-line arguments
    host_list = sys.argv[1]

    # Create the extra_vars dictionary with the specified keys and command-line values
    extra_vars = {
        "hosts_list": host_list,
    }

    # Launch the job with the provided extra_vars
    launch_job(aap_url, api_token, job_template_id, extra_vars)
