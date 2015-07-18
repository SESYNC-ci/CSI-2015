# CSI 2015 Tip Sheet

### SESYNC resources

**```rstudio.sesync.org```** starts in your in home directory ```~```

**```files.sesync.org```** same place as ```/nfs/yourGroupNam-data```

**```gitlab.sesync.org```**

### R basics

### SQL
#### Basics
* ```SELECT * FROM x``` - all the rows and columns from table _x_

* ```SELECT DISTINCT...``` -- one row per unique combination of requested variables

* Use ```LIMIT 10``` at the very end of a query to show the first 10 records

* ```SELECT a*10 FROM  x``` -- value of column _a_ multiplied by 10 for all the rows

* ```SELECT a FROM x WHERE y=1``` -- column a from table x for rows where _y_=1

* ```SELECT ... FROM ... WHERE ... ORDER BY ```

#### Aggregating
* ```SELECT COUNT(*) FROM x``` - an integer indicating the total number of rows

* ```SELECT a, COUNT(*) FROM x GROUP BY a``` - one row per distinct value of _a_

### Joining
* ```SELECT * FROM t1 JOIN t2 on t1.x = t2.y``` - all columns from t1 and t2 for where x in t1 matches y in t2

### git
* We start with ```fork``` so everyone has their own copy of the repository. Once in RStudio, the following occurs:

* We ```clone``` the repository  from the *remote* location on the gitlab server to the *local* project in your home directory.

* Once we are ready to checkpoint the files, we ```add``` them to the ```commit``` which creates a _local_ checkpoint in your home directory.

* Once files are ready to be shared with others, i.e., uploaded back to the _remote_ gitlab server, we ```push``` the commit.

* When we want to check for updates on the _remote_ server and copy them to our _local_ project, we ```pull```.

### tidyr and dplyr


### Finding resources in R

CRAN (http://cran.r-project.org/) is the main repository of R packages. The web description of a R package on CRAN (e.g. [raster](http://cran.r-project.org/web/packages/raster/index.html) links to two types of documentation:

* The reference manual, which is a dictionary of all functions in the package, individually documented (the same info. that is reported under the "Help" tab in RStudio).

* One or more vignettes that introduce the packages' main features, akin to a tutorial.

If you need to know which R packages are available for a certain type of analysis, CRAN [task views](https://cran.r-project.org/web/views/) are a good place to start.

rOpenSci hosts a variety of [packages](https://ropensci.org/packages/) that provide a R interface to online data repositories and other tools to facilitate reproducible research.


### Additional Resources

* Github repo with an archive of all the lessons and data: https://github.com/SESYNC-ci/CSI-2015/tree/master
* Etherpad: sesync.us/csi2015ep

* Database design tips: https://www.periscope.io/blog/better-sql-schema.html
