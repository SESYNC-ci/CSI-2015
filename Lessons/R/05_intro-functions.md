Intro to functions
======================================

“If you really want to understand something, the best way is to try and explain it to someone else. That forces you to sort it out in your mind. And the more slow and dim-witted your pupil, the more you have to break things down into more and more simple ideas. And that’s really the essence of programming. By the time you’ve sorted out a complicated idea into little steps that even a stupid machine can deal with, you’ve learned something about it yourself.” --Douglas Adams (from Dirk Gentley’s Holistic Detective Agency).

Functions enable easy reuse within a project, helping you not to repeat yourself. If you see blocks of similar lines of code through your project, those are usually candidates for being moved into functions.

If your calculations are performed through a series of functions, then the project becomes more modular and easier to change. This is especially the case for which a particular input always gives a particular output.

Three components of functions

* __body__: the code inside the function
* __arguments__: control how you can call the function
* __environment__: the "map" of the location of the function's variables (defaults to the global environment)

The procedure for writing any other functions is similar, involving three key steps:

    Define the function,
    Load the function into the R session,
    Use the function.


### Basic syntax of a function
  
A function needs to have a name, probably at least one argument (although it doesn’t have to), and a body of code that does something. At the end it usually should (although doesn’t have to) return an object out of the function. The important idea behind functions is that objects that are created within the function are local to the environment of the function – they don’t exist outside of the function. But you can “return” the value of the object from the function, meaning pass the value of it into the global environment. I’ll go over this in more detail.

Functions need to have curly braces around the statements

### Writing and calling a function

Returning a list of objects

Also, if you need to return multiple objects from a function, you can use list() to list them together

### Good function writing practices


* Keep your functions short. Remember you can use them to call other functions! If things start to get very long, you can probably split up your function into more manageable chunks that call other functions. This makes your code cleaner and easily testable. It also makes your code easy to update. You only have to change one function and every other function that uses that function will also be automatically updated.
* Put in comments on what are the inputs to the function, what the function does, and what is the output.
* Check for errors along the way. Try out your function with simple examples to make sure it’s working properly. Use debugging and error messages, as well as sanity checks as you build your function.





* It is difficult to read - what is doing?
* There are large amounts of repeated code.
* When we want to change something, we need to do it in many places.
* The code adds lots of objects to the workspace. These are difficult to keep track of and make bugs more likely.


Look more carefully at the two statements and see the similarity in form, and what is changing between them. This pattern is the key to writing functions.

make function to calc stand error of the mean

```r
sqrt(var(surveys$wgt)/length(surveys$wgt))
```

```r
sqrt(var(surveys$wgt, na.rm=TRUE)/length(na.omit(surveys$wgt)))
```

```r
sqrt(var(surveys1990$wgt, na.rm=TRUE)/length(na.omit(surveys1990$wgt)))
sqrt(var(surveys1996$wgt, na.rm=TRUE)/length(na.omit(surveys1996$wgt)))
```

Now things are getting repetitive...

```r
stderr <- function(x){
  sqrt(var(x,na.rm=TRUE)/length(na.omit(x)))}
```

Additional information
----------------------

http://adv-r.had.co.nz/Functions.html
http://nicercode.github.io/guides/functions/
