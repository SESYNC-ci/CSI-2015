Intro to functions
======================================

“If you really want to understand something, the best way is to try and explain it to someone else. That forces you to sort it out in your mind. And the more slow and dim-witted your pupil, the more you have to break things down into more and more simple ideas. And that’s really the essence of programming. By the time you’ve sorted out a complicated idea into little steps that even a stupid machine can deal with, you’ve learned something about it yourself.” --Douglas Adams (from Dirk Gentley’s Holistic Detective Agency).

Functions enable easy reuse within a project, helping you not to repeat yourself. If you see blocks of similar lines of code through your project, those are usually candidates for being moved into functions.

If your calculations are performed through a series of functions, then the project becomes more modular and easier to change. This is especially the case for which a particular input always gives a particular output.

Three components of functions

* __body__: the code inside the function
* __arguments__: control how you can call the function


### Basic syntax of a function
  
A function needs to have a name, probably at least one argument (although it doesn’t have to), and a body of code that does something. At the end it usually should (although doesn’t have to) return an object out of the function. The important idea behind functions is that objects that are created within the function are local to the environment of the function – they don’t exist outside of the function. But you can “return” the value of the object from the function, meaning pass the value of it into the global environment.

```r
myfunction <- function(x) {
  # do something to x here
  # return a value of interest
}
```

The base R language does not have a function to calculate the standard error of the mean. Since this is a common statistical value of interest, let's write a function to calculate the standard error. Recall that the standard error is calculated as the square root of the variance over the sample size. 

First subset the surveys table to get rid of the values with `NA`. We'll use a handy function called `na.omit()`.

```r
surveys <- na.omit(surveys)
```

The 3 functions needed for the standard error calculation are `sqrt` for square root, `var` for variance, and `length` for sample size. Calculate the standard error of the `wgt` column using these three functions. 

```r
sqrt(var(surveys$wgt)/length(surveys$wgt))
```

When you might want to use a function:
* It is difficult to read - what is doing?
* There are large amounts of repeated code.
* When we want to change something, we need to do it in many places.
* The code adds lots of objects to the workspace. These are difficult to keep track of and make bugs more likely.

We can generalize the calculation that we made by storing it as a **function** called stderr. The calculation that we made above goes into the **body** of the function. 

```r
stderr <- function(x){
  # this function returns the standard error of the mean
  sqrt(var(x)/length(x))}
```

Q: Calculate the standard error of the mean for the subset of surveys done in 1990
Q: Calculate the standard error of the mean for all surveys done in the month of June


Additional information
----------------------

http://adv-r.had.co.nz/Functions.html
http://nicercode.github.io/guides/functions/

**Good function writing practices**

* Keep your functions short. Remember you can use them to call other functions! If things start to get very long, you can probably split up your function into more manageable chunks that call other functions. This makes your code cleaner and easily testable. It also makes your code easy to update. You only have to change one function and every other function that uses that function will also be automatically updated.
* Put in comments on what are the inputs to the function, what the function does, and what is the output.
* Check for errors along the way. Try out your function with simple examples to make sure it’s working properly. Use debugging and error messages, as well as sanity checks as you build your function.

