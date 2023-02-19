Problem statement
-----------------
It's dinner time ! Create an application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home

Open questions (issues):
---
- How to interpret the "most relevant"?
- How do we know what are the ingredients from human written sentences? (white sugar? brown sugar?) (One way to use: "ingreedy") Do we need to know it? Maybe wouldn't be enough to have a list of ingredient names to check to have in the recipe ingredients? That would live place to false positives like: "salt and pepper to taste" if we have just salt or just pepper, then let the human knowledge to filter out the false positives?
- If we have the ingredients at home to make the next ingredient for a more sophisticated recipe (a.k.a. recursivity) should we include that in the match list? ("hamburger buns" can be made at home for "Best Sloppy Joes", but at home we might not have "hamburger buns" out of the box)
- Do we need to check the necessary quantity as well?
 If so then:
  - What to do with unparsable ingredients: "boiling water as needed", "salt and pepper to taste", "hamburger buns", "salt to taste", "canola oil for frying", "lemon, zested and juiced"
  - How to cannonicalize the human written quantitty in the ingredient?
  - How to cannonicalize the quantity? (3/4 cup of ranch dressing)
- How to handle the recipes which can't be parsed?

The above questions show that what is easy for a human is hard for a computer. 

Decision: 
---
Let the human do what He is strong at like comprehending the unit of measurements converting between "spoon of wheat" to "gram", and let the computer do the simple huge data filtering things.

DB:
-----
Inventory of home ingredients a list of max 2 word ingredients.

Algorythm:
----------
If all the ingredients for a recipe contain any of the 2 word ingredients from home then the recipe will be considered "relevant".

Objective
---------
Deliver an application prototype to answer the above problem statement.

By prototype, we mean:

something usable, yet as simple as possible
UI / design is not important
we do not expect features which are outside the basic scope of the problem
We expect to use this prototype as a starting point to discuss current implementation details, as well as ideas for improvement.

Tech must-haves
---------------
 MySQL / PostgreSQL or any other MySQL-compatible database.
 A backend application which responds to queries
 A web interface (can be VERY simple)
 Ruby on Rails (if you're not familiar with Ruby on Rails, use something you're familiar with)

Bonus points
------------
 React
 Application is hosted on heroku

Data
----
We provide two datasets to choose from:

 - french-language recipes scraped from www.marmiton.org with python-marmiton
 - english-language recipes scraped from www.allrecipes.com with recipe-scrapers
Download it with this command if the above link doesn't work:

wget https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz && gzip -dc recipes-en.json.gz > recipes-en.json
Deliverable

the 2-3 user stories which the application implements
the codebase : in a git repo (share it with @quentindemetz @tdeo @rpechayr @soyoh @alex-min @karineHbt @Juleffel @lucasbonin)
the database structure
the application, running on Heroku or on a personal server.
please submit links to the GitHub repo and the hosted application via this form and if you're on Mac, make sure your browser has permission to share the screen
