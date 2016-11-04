STRATEGIES FOR WRITING TEST SUITES:
Common question to ask, how do you plan to build the test suite?
There are time constraints to automating. Prioritize the growth of the test coverage.
Tests can cross multiple boundaries, and can be grouped together to be executed individually. The smoke test suite can be a subset of regression suite, but need the ability to run smoke test suite without running regression.

DIFFERENT TYPES OF TESTS:
* Unit Test: Smallest test unit. It's written to test individual object/ methods on said objects. This prevents bugs at lowest level. Tends to depend on mock data and not prod data.
- Low level is a term used to describe lower level of abstraction. High level is a term used to describe high level of abstraction, such as user registration in a form.
* Integration Test: Consist of modules of code, passing data to each other. Purpose is to make sure all modules work with each other. These are sometimes referred as functional tests. In our example, it would mean making sure one class can pass data to another. Tests are run in Continuous Integration.
* End to end: Highest level of testing. Test is executed in prod or staging env. This verifies all all components, including third-party services, can communicate with each other. Sometimes referred as Verification and Validation.
A properly hermetically (chapt_3) sealed should run in both integration and end to end envs.

SMOKE TEST SUITE:
Common concept in QA. This will be the smallest of size of tests since it needs a close to instantaneous pass/ fail verdict. Best used after few minutes after new deploy and on prod to make sure things are still running. It does the following:
* Runs application. Checks if site loads or is down.
* Connects to database. Sometimes database is not properly migrated. Test should do read only checks against DB, such as log in with existing user.
* Abnormal amount of exception. Make sure pages do not return error code. Can involve using JS console logs to check wether errors start appearing.

Keep following in mind when smoke testing:
* Avoid writing to database if we cannot clean it up. Not a good idea to register a user in prod, and can be safe to do in staging. It should perform actions that read from DB, not write.
* Do not test too much. Leave extensive testing to other test suites.

THE MONEY PATH SUITE:
In the case of the online store, its ability to add items to cart and pay for it. in an inventory management system, its ability to retrieve and update current inventory. Leave non-critical functionality should be left out, such as updating user's email. These tests should not be included in smoke tests. The primary question is "Is the customer prevented from giving us money?" Every test should answer this question. (This idea can be used with smoke testing Site Tools)

NEW FEATURE GROWTH STRATEGY:
Smoke tests and money path suites are top priority when writing tests. The idea is to keep up with development of application. As new features are added, we add new tests. This does not write tests for existing functionality such as regression strategy. Works well when test writer is embedded in the dev team.

When writing new tests, answer following questions:
* Is this the most critical/ important feature to be tested?
* Are new tests useful right away?

BUG-DRIVEN GROWTH STRATEGY:
Bug driven and new feature strategies are compatible with each other. New feature strategy concentrates on adding a new test on every new feature. Bug-driven strategy concentrates on adding new tests base don bugs found.

THE REGRESSION SUITE:
All tests in suite that test features that test features developed in the past. When understaffed, focus on writing tests for new features. Writing code for sections that have not been touched for  along time is wasting time.

CONTINUOUS INTEGRATION:
Executing tests several times daily shows quality of tests and application. It also shows test instabilities. For continuous integration:
* We need a app to test on, a testing env. (chapt_4)
* We need reliable test data. (chapt_4)
* Develop test suites. Use strategies mentioned above to know where to start. (chapt_5)
* Managing nodes is important. Tests can be negated by test environments.
* We do not need to choose the right CI as a priority.

Managing a CI env is more involved compared to deploying scripts to test env. Build nodes, test data, and scripts need to be managed.

Having same version of tools(Ruby version, Chrome) used for testing will prevent failures that cannot be easily replicated. We use Configuration Management System and Virtualization to help with this.

Configuration management system:
These are available open sourced. They take care of managing third-parties apps, dependencies, and configurations oh large quantities of computers. Some are http://getchef.com/, http://puppetlabs.com/.
We can use shell scripts. We can use Bach scripts to download, install correct tools, and manage configurations of OS.

Virtualization:
It can be combined with configuration management systems. We can set a VM for optimal testing.
We can use the following:
8 Xen project: Open sourced product that allows multiple concurrent VMs. Allows both Linux and Windows based VMs. It can only be hosted in a Linux based machine and requires some admin system skills. http://www.xenproject.org
* http://virtualmachine.org
* Windows virtual PC. http://microsoft.com/windows/virtual-pc/

SELENIUM GRID:
Executing test on our local machine is called standalone mode of execution. The resources we have limit us to our current machine, ex only uses current browser version. The grid helps us by taking over other computers on the network.

UNDERSTANDING STANDALONE AND GRID MODES:
The JsonWire protocol (AKA WebDriver Wire protocol) is a standard set of API calls used to communicate with WebDriver server. When our tests wants to take action, the language binding translates click method call into JsonWire protocol and sends it as HTTP request to WebDriver server. We have been using Ruby binding to control the browser.

Standalone mode -
When running in standalone mode, an instance of WebDriver server is stated in local machine. Server controls browser and we control server through language bindings. Example:
  Test ---> language binding ---> Selenium WebDriver Server ---> Browser
The click command works as follows:
1. Our test finds element it wants and calls click method
2. Language binding, where click is called, builds a simple JSON snippet, which explains what action needs to happen and the target of action to WebDriver server.
3. Selenium WebDriver server tells web driver what action to perform.

Grid mode -
Selenium Grid manages multiple machines/ nodes. Instead of connecting to local WebDriver server, it connects to central hub, which keeps track of all available nodes. The grid hub does the following:
* Keep track of available nodes
* Manage the creation and clean up of test sessions
* Forward JsonWire communication between test bindings and nodes
    Test ---> Language binding ---> Selenium Grid Hub ---> Selenium WebDriver server ---> Browser
Running tests using the grid, test are executed on a remote node in remote browser

INSTALLING SELENIUM GRID:
1. Download latest version
2. Run following command to start Selenium hub, replace PATH-TO-SELENIUM-JAR with download path
  java -jar PATH-TO-SELENIUM-JAR.jar -role hub
3. Add a node in new terminal window.
  java -jar PATH-TO-SELENIUM-JAR.jar -role wd -hub http://localhost:44 -port 5555
* -role wd  flag tells our JAR to start WebDriver mode.
* The -hub flag is used to point node to hub location.
* The default port is 4444, in  example 4444 was used, 5555 was used instead.
4. Go to http://localhost:4444/grid/console in browser.

Instead of using Selenium::WebDriver.for(:firefox), we do selenium = Selenium::WebDriver.for(:remote, :url = > "http://localhost:4444", :desired_capabilities => :firefox)

The :remote param declares test use Grid mode, located in :url param and :desired_capabilities specifies browser we want to use.

SELENIUM GRID EXTRAS:
This takes care of many grid management aspects. This project can handle downloading new versions, restarting nodes, viewing system resource usage. Go to http://github.com/groupon/Selenium-Grid-Extras.

CHOOSING THE CI TOOL:
A CI tool is more of a glorified cron job. A cron job is a software utility on Unix-like systems, which executes a specified task at a specified interval. Windows has Tack Scheduler. Decoupling our test suite from the CI will enable us to switch tools easily. The primary functions of a CI tool is:
1. Looking for code changes in VCS
2. Managing build node availability
3. Provide some rudimentary security system to prevent accident modifications to builds.




#
