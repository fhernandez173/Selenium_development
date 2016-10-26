Relevance is a scale of how closely our env mimics prod env.
Accessibility is a scale of how easy it is to control data in a given env.
Below is a graph depicting where the env's fall in these two scales.
Points higher represent closest to production data.

                | * Prod Env
                |                   * Staging Env
                |
                |
                |
Relevance       |                       * Test Env
                |
                |
                |
                |
                |
                |                               * Local Env
                __________________________________________
                        Accessibility

Hardcoding affects the following:
* URLs as they are the direction to our env.
* Hardcoded product.
* Private user data should not be in a test env due to legal reasons from prod env.

We use hidden data as the test do not need to know the data we are inputing. This
information is stored in a variable.

Without the DRY principle, we would have to locate every test that navigated to home page. Having a method alone to target URL makes using the TestData class easier.

To change env from terminal, use export environment=production.

FIXTURES:
These are any test data that lives outside a particular test, used to set
application in a certain state. t allows a constant to compare individual test runs against.
Best with env in high accessibility scale. We fill up our local env with
fixed data. Example:
__________________________________________
fixture_1:
  id :1
  name: Closeness and Togetherness
  description: Show how much...
  rating: 0.5
  price: 5.77
  url: /closeness-and-togetherness
  image: /wp-content/../being_close.png

__________________________________________

A script is used to parse the YAML file and insert it in the site's database.
Ruby does the work for us with YAML, the end result being a ruby hash with data.

MULTIPLE TEST MODELS:
Pros -
* Clear tests: Each test describes what it is testing
* Clear test failures: We know which tests fail due to clear tests
* We can execute all tests in parallel

Cons -
* Very verbose: the test files can grow greatly
* Duplication: each test i identical to another. Only difference is specific product being tested. Managing these can grow tiresome.


SINGLE TEST MODEL:
Pros -
* Less duplication: A single test is cleaner
* Automatic catalog updates: if product catalog changes, add/ remove some items, our tests follow suit. No need to add/ remove new tests.
* Faster runtime: We do not need to restart browser (in multiple test models, this arguments become weaker)

Cons -
* Obfuscation: There is no clear separation between products if one a new 1 is added.
* Testing all products: We do not always need to test all products, an advantage multiple test models provide.
* Single test runtime increase: If tests are densely involved, runtime for that one case can be long.

In using a loop for our fixtures for the #test_all_products_with_fixtures, we give up expressive test failures. Having individual tests per product can give us more information on the failure. We use assertions to be more descriptive.

API FIXTURE DATA:
We are able to use an API to load data into our env. The API used in the example returns.

Data like credit cads are external and often validated outside the tool. We use stubs responses that are formatted like real responses, but does not do anything. Stubs are pre-made responses in an app's requests.

DEFAULT VALUES PATTERN:
* Isolate irrelevant data from test
* Our tests do not need to always know what it si being fed, such as credit card information for purchasing items or credentials. However, if we do need to validate if a certain credit card is used or certain users are logged in with certain domain mains, then the tests need to know this.  
* Depending on programming language used and framework, we may have to create merge/ overwrite logic ourselves.
* We may not always want static data. The library faker can help us with this when it comes to using unique comments, etc. https://github.com/fhernandez173/faker



#
