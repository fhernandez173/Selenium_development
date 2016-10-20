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

Fixtures:
These are any test data that lives outside a particular test, used to set
application in a certain state. t allows a constant to compare individual test runs against.
Best with env in high accessibility scale. We fill up our local env with
fixed data. 

#
