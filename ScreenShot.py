import json
import time
from requests import post, get

#Your CBT credentials
user = "ellen.kranzen@iths.se"
authkey = "u2578f8afad30827"

#Screenshot parameters
test_url = "https://google.com/"
devices_list = "Mac10.14|FF67, Win10|Chrome75X64"

#Send the request to CrossBrowserTesting to start the test
request = post("https://"+user+":"+authkey+"@crossbrowsertesting.com/api/v3/screenshots/?browsers="+devices_list+"&url="+test_url)
results = request.json()



#active test
active_test = True

#Used to store finished test results
finished_test_results = None

#Test ID
test_id = results['screenshot_test_id']

#Check if test is complete, if not try again in 10s
while active_test:
    print ("Checking if test is still active")

    #Send HTTP request to CrossBrowserTesting to see if test is still running
    request = get("https://"+user+":"+authkey+"@crossbrowsertesting.com/api/v3/screenshots/"+str(test_id))
    results = request.json()

    #Status of the test
    test_status = results['versions'][0]['active']

    #Check active parameter if is false, if so stop the loop
    if test_status is False:
        active_test = False

        # Put test results into finished test results
        finished_test_results = results['versions'][0]

        print("Test is complete!")

    else:
        print("Test is still running, checking again in 10 seconds")

        # Wait 10 seconds and retry loop
        time.sleep(10)

#Test results URL
test_url = finished_test_results['show_results_web_url']

#Get pass/fail from test results
test_results = finished_test_results['result_count']
pass_results = str(test_results['successful'])
fail_results = str(test_results['failed'])

#Show test results
print ("Pass: "+pass_results+" Failed: "+fail_results)

print("To view these results visit: "+test_url)




