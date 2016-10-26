STABILITY:
* Tests needs to run fast and fail fast. In the book, code was written to send the devs an email when errors appeared so that can can fix bugs while selenium tests were running
* Reloading test database on every build keeps clean and consistent test env. Use a configuration management tool to keep all dependencies. examples are https://www.chef.io/ and https://puppet.com/
* AJAX can make a suite unstable.

The Luhn test algorithm tests is a formula used to generating credit card numbers.

WAITING FOR AJAX REQUESTS:
Adding sleep in our tests can have long term consequences. We can waste time while sleep finishes after the AJAX calls went through.
Waiting time can also be too short, failing tests.
AJAX requests are instant in Continuous Integration env, the delay appears in the staging env.

We can use jQuery.active function call with AJAX requests. It will return 0 if page is fully loaded, or a nonzero number when there are current background requests.Our tests can execute JS commands using the execute_script method.

WAITING FOR JAVASCRIPT ANIMATIONS:
The ElementNotVisibleError appears in the following cases:
* Sometimes the element is not currently visible.
* A defect is in play, an element could be covering another element although we know where the element is at. Selenium does not allow us to click anything a person can't click on.
* Using JS to have elements move from out of screen to move into screen can throw the error.

ACTION WRAPPER:
Idea is to collect all of common pain points, and automatically implement them every time an action is performed. It accounts for things that commonly cause tests to be unstable.
PROS -
* Single location for actions such as clicking and typing on AJAX requests are all under a single class. Make sit easy to modify and find.
* Increases build stability.
* We can add more information to the class for debugging purposes.
* Helps to add functionality that will capture screenshots of test failures

CONS -
* Increases time, but not drastically.

In our SeleniumWrapper class, begin-rescue wraps out methods in order to capture any errors and take a screenshot of the errors along with identifying where the error is at.

File chapt_5_run_test.rb created to have our dependencies in one file and run it all.

BLACK HOLE PROXY PATTERN:
This gets rid of third-party uncertainties. These reduce the stability of our tests. This takes all HTTP requests going to third-parties and blocks them. In a production env, we do not block these assets, and should be properly loaded using the proxy whitelist feature.
PROS -
* Improves speed due to no waiting time for third-parties.
* Improves stability through verifying that the core functionality of our app still functions since we have removed any third-party dependencies. These may include social buttons, and tracking.
* The tests have higher control over the env, reducing failures.

CONS -
* A broken layout appears when removing third-party content.
* Third-party content tests brake. Any test that check logging using social media accounts will brake.

We get Timeout::Error when third-parties have a slow connection with our app; the tests timed out while waiting for third-parties.
In the initialize method, we do not need to use a fake proxy to send our requests to. We can use an external proxy server that logs all external URLs to a logfile. This server needs to return a 200 response. We can use BrowserMob Proxy for this.

FINAL THOUGHTS:
Run our tests several times before considering it stable. Test our tests in multiple browsers. 


#
