BEHAVIOR-DRIVEN DEVELOPMENT:
* Encourages us to step back and think about end to end behavior, then focus on minor details.

PROS -
* If the test is written properly, we are able to understand what the test plans will do without confused by code details
* The methods that perform actual implementation become modular, can be shared while testing.
* By sticking closely to behavior, it becomes easy to have one defined behavior running in multiple envs.
* Several BDD frameworks available for many programming languages.
* Data is extracted out of behavior definition, making ti easy to manage data in long run.

CONS -
* Many people may have a different interpretation of how things should behave. There needs to be a consistent standard.
* Becomes easy to add implementations into a definition, mixing behavior and implementation, confusing and hardcoded tests.
* Several BDD tools available, debatable which one to use
* Adds overhead. Too many layers, increases uses of resources such as processing power.
* Each framework requires a learning curve.  

We use Gherkin to help others who are not familiar with the code aspects of BDD. It come sin the form of:
Feature: Gives an overview of whole feature. Describes a groups of scenarios ex. Users add
Scenario: Describes test variations ex. Anonymous user adds product to cart
Given: Starting point for tests, pre-conditions tests need to start successfully
When: Used to start performing actions, ex. add items to cart
Then: Describes the final state of the application.
And: ex-changeable with Given, When and Then. Allows a natural human readable flow of the description of the feature.

BDD is not always needed, may depend on project size. An IDE that handles regular expressions is needed.

CUCUMBER:
A tool used to turn BDD behavior definitions into executable steps in many languages.
* The feature dir contains all feature definitions.
* the step_definitions dir contains Ruby files that implement steps in the features dir. Standard practice to name the files name_of_steps.rb.
* setup_teardown.rb dir contains two blocks that starts the test and quit them.
* The config dir is a reserved dir for cucumber. Store anything that relates to how tests are executed here.
* In cucumber.yml we use to store Cucumber profiles. Ruby code lives between <% %>
* In the env.rb file, we store gem requirements, global variables, and anything else tests needs to access.

Use the -p flag to specify a different profile. ex cucumber -p ci
We can also execute a single test, ex cucumber -p features/add_item_to_cart.feature
We can also execute many files we want by adding more as args.


WRITE ONCE, TEST EVERYWHERE PATTER:
The concept takes advantage of shared behavior between multiple implementations of one application. Users should be able to purchase a product on different devices and app versions.
Well written feature definitions can be used interchangeably.
PROS -
* Pattern forces architect of test to think ahead and boil down every feature/ behavior into simple, common list of ideas.
* The behavior definition becomes reusable amongst mobile, native and desktop app versions.
* We have a single test that runs on multiple platforms, increasing simplicity. No need for multiple test suites.

CONS -
* Runtime context switching: We are using RUby's ability to require the correct step definitions on the fly base don profile. It is a more difficult challenge with static languages such as Java
* Project structure may become convoluted and difficult to understand.

TESTING ON MOBILE:
* Changes to product_review.feature will be made to handle mobile. Can be beneficial to run these test son actual devices with Appium and others alike.
* We modify how firefox identifies itself in to websites by changing user agent in the SeleniumWrapper class.

TESTING WITH API:
Curl and wget are command-line apps allowing users to make Get, Post and other HTTP requests directly from terminal/ shell scripts.

The #make_post_request from HttpHelper module takes a URL and a hash of the POST params, build and execute a HTTP request, and returns the body of the response from server. The time was increased to take into account the load of the api.

run all profiles cucumber -p ci && cucumber -p mobile %% cucumber -p api



#
