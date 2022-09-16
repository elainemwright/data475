hmk_03
================
Elaine M. Wright

# Data Input & Output

-   This chunk of code loads the tidyverse package and silences/hides
    the message that displays when the tidyverse package and sub
    packages load in

``` r
library(tidyverse)
```

-   I made up a fake data set about cats, about their color, months of
    age, whether or not they like to play with feathers, what type of
    food they eat, and whether or not they like to play with chaser
    toys. I saved it as a .csv file within the same homework directory
    that I work in and ran the read.csv function.

``` r
library (tidyverse)

read.csv("fake_data.csv")
```

           Color Age..months. Likes.feathers Food Likes.chasers
    1      black            9             No  Dry           Yes
    2      tabby           12            Yes  Wet            No
    3     calico           24             No  Wet           Yes
    4      white            4            Yes  Dry           Yes
    5 tortishell           16            Yes  Wet           Yes

# Investigating Data Frames Properties

Use two different functions that both give some kind of summary or
overview of the data frame. Which one do you think is more useful?

-   The first function that gave a summary of the data frame used is the
    print function. The csv file is assigned to the object “cats,” and
    the print function accesses the csv file through the object named
    “cats” and a summary of the file is printed to the screen in the
    form of a table.

``` r
library (tidyverse)

read.csv("fake_data.csv")
```

           Color Age..months. Likes.feathers Food Likes.chasers
    1      black            9             No  Dry           Yes
    2      tabby           12            Yes  Wet            No
    3     calico           24             No  Wet           Yes
    4      white            4            Yes  Dry           Yes
    5 tortishell           16            Yes  Wet           Yes

``` r
cats <- read_csv("fake_data.csv")

print(cats)
```

    # A tibble: 5 × 5
      Color      `Age (months)` `Likes feathers` Food  `Likes chasers`
      <chr>               <dbl> <chr>            <chr> <chr>          
    1 black                   9 No               Dry   Yes            
    2 tabby                  12 Yes              Wet   No             
    3 calico                 24 No               Wet   Yes            
    4 white                   4 Yes              Dry   Yes            
    5 tortishell             16 Yes              Wet   Yes            

-   The second function used was the structure function, this provides
    the class for the inputs as well as showing each category of data
    with a : and then denotes the structure type as well as the values
    within each category of data

``` r
library (tidyverse)

read.csv("fake_data.csv")
```

           Color Age..months. Likes.feathers Food Likes.chasers
    1      black            9             No  Dry           Yes
    2      tabby           12            Yes  Wet            No
    3     calico           24             No  Wet           Yes
    4      white            4            Yes  Dry           Yes
    5 tortishell           16            Yes  Wet           Yes

``` r
str(cats)
```

    spec_tbl_df [5 × 5] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
     $ Color         : chr [1:5] "black" "tabby" "calico" "white" ...
     $ Age (months)  : num [1:5] 9 12 24 4 16
     $ Likes feathers: chr [1:5] "No" "Yes" "No" "Yes" ...
     $ Food          : chr [1:5] "Dry" "Wet" "Wet" "Dry" ...
     $ Likes chasers : chr [1:5] "Yes" "No" "Yes" "Yes" ...
     - attr(*, "spec")=
      .. cols(
      ..   Color = col_character(),
      ..   `Age (months)` = col_double(),
      ..   `Likes feathers` = col_character(),
      ..   Food = col_character(),
      ..   `Likes chasers` = col_character()
      .. )
     - attr(*, "problems")=<externalptr> 

-   Currently, the print function is easier for me to use when wanting a
    summary of the data because it prints a nice table that is easy to
    read

# Manipulating Data Frames

-   To create a new column, I created a new object name to represent my
    new column, and then assigned the arithmetic operation to the name.
    I did this by accessing the numerical column of data with a \$, and
    then performed the multiplication operator by 5 to show me the age
    of the cats (in months) five years from now.

-   Once the arithmetic function was completed, I created a new object
    name: newcats, and used the cbind function to add this new column to
    my original data set. The cbind function combines two objects
    together, the first parameter is the original data set, and the
    second parameter is the new column that you want added to the
    original data set.

-   I then printed the new object to make sure the new column was added
    properly to the entire data set.

``` r
library (tidyverse)

read.csv("fake_data.csv")
```

           Color Age..months. Likes.feathers Food Likes.chasers
    1      black            9             No  Dry           Yes
    2      tabby           12            Yes  Wet            No
    3     calico           24             No  Wet           Yes
    4      white            4            Yes  Dry           Yes
    5 tortishell           16            Yes  Wet           Yes

``` r
cats <- read_csv("fake_data.csv")

`Age In Five Years` <- cats$`Age (months)`*5

newcats <- cbind(cats, `Age In Five Years`) 

print(newcats)
```

           Color Age (months) Likes feathers Food Likes chasers Age In Five Years
    1      black            9             No  Dry           Yes                45
    2      tabby           12            Yes  Wet            No                60
    3     calico           24             No  Wet           Yes               120
    4      white            4            Yes  Dry           Yes                20
    5 tortishell           16            Yes  Wet           Yes                80

# Working With Columns

-   The mean function requires a numerical or logical value to function
    correctly. I first used the structure function to confirm the data
    type of my new column. I then used the mean function to calculate
    the mean of the new column.

``` r
library (tidyverse)

read.csv("fake_data.csv")
```

           Color Age..months. Likes.feathers Food Likes.chasers
    1      black            9             No  Dry           Yes
    2      tabby           12            Yes  Wet            No
    3     calico           24             No  Wet           Yes
    4      white            4            Yes  Dry           Yes
    5 tortishell           16            Yes  Wet           Yes

``` r
cats <- read_csv("fake_data.csv")

`Age In Five Years` <- cats$`Age (months)`*5

newcats <- cbind(cats, `Age In Five Years`) 

print(newcats)
```

           Color Age (months) Likes feathers Food Likes chasers Age In Five Years
    1      black            9             No  Dry           Yes                45
    2      tabby           12            Yes  Wet            No                60
    3     calico           24             No  Wet           Yes               120
    4      white            4            Yes  Dry           Yes                20
    5 tortishell           16            Yes  Wet           Yes                80

``` r
str(`Age In Five Years`)
```

     num [1:5] 45 60 120 20 80

``` r
mean(`Age In Five Years`)
```

    [1] 65

# Accessing Elements of Data Frames

-   newcats\[1\] - This calls the first column of the data frame and
    displays all the rows within only that column in the standard data
    frame table format
-   newcats\[\[1\]\] - This notation calls the first column of the data
    frame and lists all the objects within the column as a series of
    individual words not in a table format
-   newcats\$color - This format is how you directly access a portion of
    your data frame and manipulate it but does not
-   newcats\[1, 1\] - This format prints the first item in the first
    column of the data frame
-   newcats\[ , 1\] - This format prints every item in the first column,
    similar to the newcats\[\[1\]\] notation
-   newcats\[1, \] - This format displays the first row of all columns
    in a table format

``` r
newcats[1]
```

           Color
    1      black
    2      tabby
    3     calico
    4      white
    5 tortishell

``` r
newcats[[1]]
```

    [1] "black"      "tabby"      "calico"     "white"      "tortishell"

``` r
newcats$color
```

    NULL

``` r
newcats[1, 1]
```

    [1] "black"

``` r
newcats[ , 1]
```

    [1] "black"      "tabby"      "calico"     "white"      "tortishell"

``` r
newcats[1, ]
```

      Color Age (months) Likes feathers Food Likes chasers Age In Five Years
    1 black            9             No  Dry           Yes                45
