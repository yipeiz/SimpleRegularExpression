# A regular expression, regex or regexp[1] (sometimes called a rational expression)[2][3] 
# is, in theoretical computer science and formal language theory, 
# a sequence of characters that define a search pattern. 
# Usually this pattern is then used by string searching algorithms 
# for "find" or "find and replace" operations on strings.


data.text <- c("suspect",
               "three suspects",
               "3 suspects",
               "9mm firearm",
               "483 McNeil Building",
               "3718 Locust Walk",
               "4 Privet Drive",
               "10880 Malibu Point",
               "Philadelphia, PA",
               "PA, Philadelphia",
               "Philly",
               "Phila",
               "Phil.",
               "Phil Dunphy",
               "19104-6286",
               "20015",
               "90291",
               "90210",
               "(215) 573-9097",
               "215-573-9097",
               "2155739097")


# find the letter "a"
grep("a",data.text)
grep("a",data.text,value=TRUE)

# find the number "1"
grep("1",data.text,value=TRUE)

# find numbers
# square brackets contain lists of characters 
grep("[0123456789]",data.text,value=TRUE)
grep("[0-9]",data.text,value=TRUE)

# find four numbers together
grep("[0-9][0-9][0-9][0-9]",data.text,value=TRUE)
grep("[0-9]{4}",data.text,value=TRUE)
# find 5 to 10 numbers together
grep("[0-9]{5,10}",data.text,value=TRUE)

# find capital letters
grep("[A-C]",c("A1","B1","C1","D1","E1","F1"),value=TRUE)
grep("[ABC]",c("A1","B1","C1","D1","E1","F1"),value=TRUE)

# starts with a letter, caret sign
grep("^[A-Za-z]",data.text,value=TRUE)

# ends with a letter
grep("[A-Za-z]$",data.text,value=TRUE)

# find something that's not a letter next to a letter
grep("[^A-Za-z ][A-Za-z]",data.text,value=TRUE)
#find a three-character numeric string 
grep("^[0-9]{3}$",c("123","567","314","1234","5678","3141"),value=TRUE)
grep("^[0-9]{3}[A-Z]",c("123ABC","234BCDEF","435C","1ABC23","2468BC","1234C5"),value=TRUE)

# phone numbers
grep("[0-9]{3}-[0-9]{3}-[0-9]{4}",data.text,value=TRUE)

# exercise
grep("[1-3][A-C]",c("A1","B1","C1","1A","4B","5C"),value=TRUE)

# so far the fun part
# regular expressions have several "special characters"
#   \ ^ $ {} [] () <> . * + ? | &
#   if you want to search for these "protect" them with \\

#   parentheses are special need to "protect" them with \\
#   if it's special to R use one \, special to grep use \\

data.text
temp <- c("[dontworrybehappy].....","123","ppp","[asdf123]","[????]")
grep("[",temp,value=TRUE)
grep("\\[",temp, value = TRUE)
grep("\\[[A-Za-z]+\\]",temp,value=TRUE) #plus means at least one
grep("\\[[a-z0-9]+\\]",temp,value=TRUE) 

grep("\\([0-9]{3}\\) [0-9]{3}-[0-9]{4}",data.text,value=TRUE)
grep("[0-9]{3}-[0-9]{3}-[0-9]{4}",data.text,value=TRUE)
grep("[0-9]{10}",data.text,value=TRUE)

# alternatively: vertical line
#   | represents "or"
grep("[0-9]{3}-[0-9]{3}-[0-9]{4}|\\([0-9]{3}\\) [0-9]{3}-[0-9]{4}|[0-9]{10}",data.text,value=TRUE)



# gsub - global substitution

# remove numbers from text
gsub("[0-9]","",data.text)

# remove anything that is not a number from text
gsub("[^0-9]","",data.text)
gsub(".","",data.text) # dot means everything!

gsub(",","",c("9,453","23,432","4,334,645","1,234")) 

# Delete the "plus four" part of the ZIP code
#   Use parentheses to save parts, saved as \\1, \\2, etc.
gsub("([0-9]{5})-[0-9]{4}","\\1", "19104-6268")

# Add commas to these numbers
c("9453","2332","4645","1234")
gsub("([0-9]{3}$)",",\\1",c("9453","2332","4645","1234"))

# standardize phone numbers
phone.nums <- grep("[0-9]{3}-[0-9]{3}-[0-9]{4}|\\([0-9]{3}\\) [0-9]{3}-[0-9]{4}|[0-9]{10}",data.text,value=TRUE)
phone.nums
phone.nums <- gsub("^\\(([0-9]{3})\\) ([0-9]{3}-[0-9]{4})","\\1-\\2",phone.nums)
phone.nums <- gsub("([0-9]{3})([0-9]{3})([0-9]{4})","\\1-\\2-\\3",phone.nums)

