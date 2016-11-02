Selenium WebDriver has been created using OOP.
OBJECTS:
Object properties (attributes) describe current state of an object. Example:
  cup = CoffeeMug
  cup.color = white
The whole in the cup has two functions, to add and remove liquids. Example:
  liquid = coffee
  cup.add(coffee)
Objects can also store other objects. The Page Objects pattern is describing the web page in terms of top-level objects containing more granular and smaller objects. example:
the awful-valentines web site divided into large objects:
___________________________________
|          Header object          |
|_________________________________|
|                      |          |
|                      |          |
|                      |          |
|Body object           | Side bar |
|                      | Object   |
|                      |          |
|                      |          |
|                      |          |
|______________________|__________|
|         Footer object           |
|_________________________________|

page = ContactUsPage
page.header = PageHeader
page.body = PageBody
page.sidebar = PageSidebar
page.footer = PageFooter

The page objects pattern describe the web page in terms of hierarchical Domain Specific Language (DSL). The app specific DSL helps to hide page implementations; tests do not interact with the web page, rather it uses a framework of classes and methods to accomplish the goal.

PROS -
* DSL framework: The frameworks describes the app in a business/ customer perspective. Each test is easy to comprehend.
* The Page Object pattern helps to test desired behavior of app using DSL
* A well implemented Page Object framework has one and only way to accomplish an action, preventing duplication.
* The smaller objects in the Page Object can be shared between multiple Page Objects.
* Intended actions can be clearly stated.

CONS -
* Increase complexity as we would have to design a framework, rather than procedural tests.
* Pattern has to be continued to be followed so that code can be understood and be consistent.
* Is is not needed everywhere, but it tempting to use it.

Inheritance: Allows new classes to be based on another class, creating a subclass. The new class inherits all the parent's class functionality.

Refer to image_reference folder to understand how to divide the cart into sections. Use the YAGNI principle, which states that of you don't need something on the page, do not implement it.

We should keep the YAGNI principle in mind when it comes with the Page Objects pattern. We do not need to spend out time implementing a comprehensive framework instead of writing tests.

Adding a verification method will help us with more details on our errors. Such errors such as ElementNotVisibleError can occur when the tests think they are in a page that the browser is not on, and the verification methods we create will helps us with the screenshots of errors selenium may capture.

In the example, since we are testing the registration flow, we use the verification methods to know that after completing the forms, it takes us to the account page. Our verify method gets current URL and uses URI class to parse it. We grab the current path and compare it to the value of page_path method.

Try your bets to make Page Object element as dumb and blind to anything else happening on the page as possible. We can also expand on our HomePage class with the following:
The below adds to cart by name
HomePage.new(@selenium).special_items.find(" Our love is special!!").add_to_cart

The following takes the first item and adds it to the cart:
HomePage.new(@selenium).special_items.first.add_to_cart

We can expand the SidebarCart class with two methods that will handle viewing the cart and checking out items.

We do not need to convert the entire test suite into a page object framework in order to take advantage of it.





#
