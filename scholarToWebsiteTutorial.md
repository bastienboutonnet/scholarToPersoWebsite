
**TODO:**
- check which of the grid packages I can get out of the equation

# Scholar Data 2 Website (or WordPress blog) with R 
This tutorial & code pulls data from the google scholar API, and makes an image (along with an optional graph of your citations per year) that can be hosted online (maybe using services like Dropbox or GoogleDrive's public sharing).

This tutorial is based on an R-bloggers post by XXX with some **graphical changes *and* the ability to display a bit more of useful info.**

## What you need
- a google scholar profile (e.g., INSERT MY GSCHOLAR PROFILE)
- UNIX-based system (e.g., Mac OS X, Linux)
- R (R Website) 
- crontab
- R packages:
    - `scholar`: convenience functions to get data from scholar API
    - `ggplot2`: powerful & flexible plotting package.
    - `grid` : package part of the R-base packages, allows graph layout customisations.


## `Scholar` R Package
James Keirstead, designed a really cool package that interacts with the google scholar API. It pulls data from your scholar profile, like your citation history, and it also contains a cool function to predict your h-index based on the [Acuna et al. (2012)](http://www.nature.com/nature/journal/v489/n7415/full/489201a.html) model which is fine tuned for neuroscience. You can find more info about the R package and its functions on [James' blog](http://www.jameskeirstead.ca/blog/new-r-package-scholar/).

### 1. Getting data from a profile
First, you need to know your **Researcher ID** that google arbitrarily created for you when you made your profile.

For example this is the URL to the profile of a really cool philosopher/psychologist called [Andy Clark](https://en.wikipedia.org/wiki/Andy_Clark). As an aside this researcher has a really interesting view on how the human brain function that is worth checking out if you're interested.
Anyway, back to the URL to his profile: https://scholar.google.co.uk/citations?user=FYrnmlIAAAAJ&hl=en.    
If you look at the URL there is an arbitrary looking string of characters just after `user=` and it stops at the `&` for Andy's profile it's `FYrnmlIAAAAJ`.

#### 1.1. Profile


    #load the package first otherwise R won't be able to find the functions later.
    library(scholar)
    
    #load your profile data FYrnmlIAAAAJ
    profile=get_profile('FYrnmlIAAAAJ')
    
    #look at the information you pulled out
    profile




<dl>
	<dt>$id</dt>
		<dd>'FYrnmlIAAAAJ'</dd>
	<dt>$name</dt>
		<dd>'Andy Clark'</dd>
	<dt>$affiliation</dt>
		<dd>'University of Edinburgh'</dd>
	<dt>$total_cites</dt>
		<dd>21866</dd>
	<dt>$h_index</dt>
		<dd>51</dd>
	<dt>$i10_index</dt>
		<dd>112</dd>
	<dt>$fields</dt>
		<dd>'philosophy of cognitive science'</dd>
	<dt>$homepage</dt>
		<dd>'http://www.philosophy.ed.ac.uk/people/view.php?name=andy-clark-frse'</dd>
</dl>




As you can see, the function has pulled out all the information that you could see on the google page, and it has stored them in sub fields so that you can easily access **just** the *number of citations* or his *h-index* etc.


    #here's how you get only the total citations
    profile$total_cites




21866




    #here's how you get the h-index
    profile$h_index




51



#### 1.2. Citation history
You may also be interested in reproducing the graph that google generates with your citation history. For this we will use the function `get_citation_history()`. We now have a neat little table that contains number of citations per year. Grea! So we can reproduce the google plot!


    history=get_citation_history('FYrnmlIAAAAJ')
    history




<table>
<thead><tr><th></th><th scope=col>year</th><th scope=col>cites</th></tr></thead>
<tbody>
	<tr><th scope=row>1</th><td>2007</td><td>1079</td></tr>
	<tr><th scope=row>2</th><td>2008</td><td>1382</td></tr>
	<tr><th scope=row>3</th><td>2009</td><td>1320</td></tr>
	<tr><th scope=row>4</th><td>2010</td><td>1574</td></tr>
	<tr><th scope=row>5</th><td>2011</td><td>1564</td></tr>
	<tr><th scope=row>6</th><td>2012</td><td>1671</td></tr>
	<tr><th scope=row>7</th><td>2013</td><td>2604</td></tr>
	<tr><th scope=row>8</th><td>2014</td><td>2192</td></tr>
	<tr><th scope=row>9</th><td>2015</td><td>1679</td></tr>
</tbody>
</table>




## Plotting Scholar Cites
I'm using the `ggplot2` R package. It's one of the most popular graphing packages and is super flexible. I'm going to skip over explaining how ggplot works because there are a million tutorials online.


    library(ggplot2)
    
    #set up plot in r 
    histGraph=ggplot(data=history, aes(x=year, y=cites))
    
    #add layers of plot (here bars)
    histGraph=histGraph+geom_bar(stat='identity')
    
    #show basic graph
    histGraph


![svg](output_8_0.svg)

