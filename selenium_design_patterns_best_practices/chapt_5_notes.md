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


#
