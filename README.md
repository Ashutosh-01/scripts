# scripts
calculateTime.sh script

Let's get to the point
> What does the script do?<br>The answer is quite simple , the script will run your sort program for different number of inputs and give you result in a file. This file can be later used to plot graph using GNUPlot

## How to use ?
<ol>
<li> Make sure your program works !!!
<li> Remove all unnecessary printf statements from your code.(This is very important for creating a proper data file)
<li> If you want to see time calculated using time command, you should not have <b>ANY</b> printf statement in your code
<li> If you are going to calculate time using gettimeofday() function(NOT included in the code). Make sure you have only one printf statement have the following format <br> `printf("%lf\n", timeOfFunction)`
<li> Make sure you don't have any unnecessary printf statement (Yes, check again !!!)
<li> Now that your program is ready, start editing the script variables
<li> Edit the values of variables according to your program.
<li> The most important entry is a numRecords array. Enter only those values for which you want to calculate time.
<li> After everything is set, make the shell script executable by `chmod a+x calculateTime.sh` and then run it using `./calculateTime.sh`
<li> Done !
<li> You will get a datafile with specified name which you can give to GNUPlot for plotting graph
</ol>

## Example :
> The example script which is given here has numRecords = ("1000" "2500" "5000"). So the program will give 1000/2500/5000 numbers respectively to the sorting program and will calculate time required for program using <i>"time"</i> command. The time values will also be stored in the file specified in DATA_NAME variable. 
Here's what you should see on terminal.
<pre>
>. ./calculateTime.sh<br>
Calculating time using "time command" ...<br>
For 1000 records :<br>

0.00<br>
-----------------------------<br>
For 2500 records :<br>

0.03<br>
-----------------------------<br>
For 5000 records :<br>

0.10<br>
-----------------------------<br>
</pre>
