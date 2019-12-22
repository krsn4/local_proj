tolower()
toupper()
splitNames <- strsplit(names(file),, "\\.") #split at "."
strsplit("vector.a.22", "\\.")
#[[1]]
#[1] "vector" "a"      "22"    
firstElement <- function(x){x[1]}
sapply(strsplit("vector.a.22", "\\."), firstElement)

sub("_", "", names(file)) #first _ occurence only
gsub("_", "", ...) #all _ removed "this_is_test"

grep("Alamega", cameraData#intersection ) # returns vector indices
table(grepl("Alamega", cameraData#intersection)) # returns logical vector (and table counts here)
grep("", vector, value = TRUE) # returns vector component values
library(stringr)
nchar("Jeffery Leek")
substr("Jeffrey Leek",1,7)
paste("Jeffery", "Leek")
paste0("Jeffery", "Leek")
str_trim("Jeff     ")
#Variables with character values
# should usually be made into factor variables
# should be descriptive (TRUE/FALSE instead of 1/0, Male/Female versue 0/1/ or M/F)

#regular expressions: thought of as a combination of literals(words) and metacharacters (grammar)
# ^i think ("^" represents the start of a line)
# morning$ ("$" represents the end of a line)
# [Bb][Uu][Ss][Hh]  (all "Bush" cases, bUsH)
# ^[Ii] am
# ^[0-9][a-zA-Z] (or [a-z])
# [^?.]$  (Matches any line that ends with **anything other than ? or . **)  When "^" is used at
# the beginninf of a character class [], it is also a metacharacter and indicates matching characters
# NOT in the indicated class

# "." is used to refer to any character, 9.11 will match "... 9-11 rules", ... 9/11...", "169.114.66",
# "..9:11,", etc.
# "|" (or), flood|fire|earthquake|...
# ^[Gg]ood|[Bb]ad (matches 'good' at the beginnin of the line, or 'bad' in *any* place of the line)
# ^([Gg]ood|[Bb]a)
# [Gg]eorge( [Ww]\.)? [Bb]ush  (matches George Bush (without W., since ()? is optional, 
# .=any (. as metacharacter), \.=dot (. as a literal)))
# * indicates repetition of any number including none, + means "at least one of the item"
# (.*)  = any line including empty enclosed in ()
# [0-9]+ (.*)[0-9]+  "atleast one of 0-9, followed by any number of characters, followed by at least one of 0-9/
# {,} "interval quantifiers", [Bb]ush( +[^ ]+ +){1,5} debate

#  +([a-zA-Z]+) +\1 +   (at least one space followed by at least one from [a-zA-Z] followed by at least one space
# followed by **what's in ()* followed by at least one space, \1 remembers () from previous)
# matches "blah blah", "so so", etc. (spaces are important!)
# * is greedy:
# ^S(.*)s  (longest possible line of text starting with s, ending at s)  "sitting at starbucks" (not "sitting at s")
# ^s(.*?)s (not necessarily longest possible line of text)

d1 <- date();d1
class(d1)
d2 <- Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")
# %d day as number (0-31), %a abbrev weekday, %A unabbrev weekday, 
# %m month(00-12), %b abbrev month, %B unabbrev month, %y 2-digit year, %Y four-digit year
x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z[1]-z[2]
as.numeric(z[1]-z[2])
#Converting to Julian
weekdays(d2)
months(d2)
julian(d2)
#
library(lubridate)
ymd("20140108")
ymd("19-jan-8")
ymd("12-feb-02")
mdy("08/04/2013")
dmy("03-04-2013")
ymd_hms("2011-08-3 10:15:03")
ymd_hms("2011-08-3 10:15:03", tz="Pacific/Auckland")
?Sys.timezone
y <- dmy(x)
wday(y)
wday(y, label = TRUE)
# open government sites
http://data.un.org/  (UN)
http://www.data.gov/ (US)
http://www.data.go.jp/
  
Gapminder
http://gapminder.org/ (data for human developments)

http://www.kaggle.com/

http://data.gov/opendatasites (other than UK France Germany, etc)


#Quiz Wk4
1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "Coursera/Data/mds2006.csv")
mds2006 <- read.csv("Coursera/Data/mds2006.csv")
strsplit(gsub("(wgtp)([0-9]*)", "\\1 \\2", names(mds2006)), " ")[[123]]

2
gdpdata$GDP <- as.numeric(str_replace_all(gdpdata$GDP, ",", "")) # stringr::str_replace_all
# was done in previous quiz

3
grep("^United", gdpdata$Country)
4
mergeData$Special.Notes[grep("[Ff]iscal(.*)[Jj]une", mergeData$Special.Notes)]
5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes)==2012)
sum(year(sampleTimes)==2012 & wday(sampleTimes)==2)