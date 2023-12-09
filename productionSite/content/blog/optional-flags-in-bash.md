---
title: Simple Usage of Optional Flags in Bash Script 
linkTitle: Optional Flags in Bash
date: 2020-01-01
authors:
  - name: monsieurDuke
    link: https://github.com/monsieurDuke
excludeSearch: true
cascade:
  type: docs
weight: 100000
---
*In this blog series, we are going to dive in to the 10% of the power from a gem within the realm of Linux scripting, which is optional flags. This basic concept would enchance your Bash scripts by miles while adding tons of flexibility to your code and streamlining your process, making it more efficient for the 1337 users*
<!--more-->

## What Is Optional Flags?
One of the powerful features of command-line programs is the capability to pass multiple arguments before the time of execution. That way, the program can run the way we wanted to without having another ```STDIN``` session to take some arguments via user input, which is a common way on running scripts or programs in an unattended fashion.

There are multiple ways of passing multiple arguments and parsing them so the program can read and process them without hassle. One of the best approaches is to have optional flags, which either represented by character letters preceded by a hyphen (short options), such as ```-u duke64```, or by a word preceded by a double hyphen (long options), such as ```--username duke64```, which may bring some sort of clarity on what the usage of the issued flag.

One of the program that is designated for this feature is the ```getopts``` utility, which retrieves both option flags and arguments from the list of parameters that been fed into. Even though ```getopts``` is a dropdown replacement from its predecessor *GNU/Linux* utility, ```getopt```, one big difference is that one cannot read word-based flags (long options) in some standard *shells*, while ```getopt``` can. One of the workaround to achieve that while still maintaining the script's readability and simplicity from using ```getopt``` is that the usage of *Positional Arguments* instead, such as ```$1``` to ```$[n]```, which will be passed and parsed manually within the script later on.

## Simple Use Case
There are two cases that we will demonstrate on using the basic format of optional flags in *Bash*, one is using ```getopts``` in ```testflag-1.sh``` file, and the other one is using manual *Positional Arguments* in ```testflag-2.sh``` file. Both scripts are going to contain the same head mockup functions that are later on going to be added on both case snippet below.
Speaking of functions, here are some of the description that we will going to tested on:
- ```usage()```: This function is going to lists all the possible combination flags, which also refers to the help option. For the simplicity of the context, were just going to print ```list of available options goes here```, which you should modify it regarding to your script's needs
- ```invalid()```: This function is going to throw a simple message as a result for catching an unknown or incomplete flag(s) type of error by the time of execution, by also indicating the usage of ```exit 1```
- ```generate()```: The same type of ```usage()``` function, this final function that act as non-argumented option flag is going to fetch the argumented option flags into a variale arguments in order execute to whole inteded message. Those variable arguments are ```$1``` to ```$3```, which are basically a placeholder for name, age, and sex respectively

```bash {linenos=table,linenostart=1,filename="mockup.sh"}
#!/bin/bash
#----------
usage() {
  echo "list of available options goes here"
  exit 0; }
invalid() {
  echo "testflag: detecting improper option"
  echo "try option '-h' for more information"
  exit 1; }
generate() {
  echo "my name is $1 ($3)" | grep -E --color "$1|$3"  
  echo "i am $2 years old"  | grep -E --color "$2"
  exit 0; }
#----------  
```

### **A**. Getopts Utility
In ```getopts``` utility, a collection of the valid option letters, which also called as ```OPTSTRING```, will determine whether the flag is argument-based or not. This type of distinction is defined by the usage of a trailing semicolon ```:``` to each responding option letter. To fetch the value from each argument-based option flag, we are going to use the built-in argument variable called ```OPTARG```, which act as a placeholder for us to assign to responding variable of the option flag. Here are the following snippets on the overall usage of ```getopts``` to get the overall gist of it from the file ```testflag-1.sh```, which can also be inpsect in [here](https://github.com/polarpwn/polarpwn.gg/blob/main/productionSite/static/script/testflag-1.sh):

```bash {linenos=table,linenostart=14,filename="testflag-1.sh"}
#----------
while getopts "n: a: s: g h" opt; do
  case $opt in
    n) n="${OPTARG}" ;;
    a) a="${OPTARG}" ;;
    s) s="${OPTARG}" ;;
    g) opt_sub="generate" ;;
    h) usage ;;
    *) invalid ;;
  esac
done
#----------
case $opt_sub in
  "generate") [[ "$n" && "$a" && "$s" ]] && generate "$n" "$a" "$s" || invalid ;;  
esac
#----------
usage
```

In line ```15```, each option flag that have been declared as the ```OPTSTRING```, namely ```n:``` for name, ```a:``` for age, and ```s:``` for sex, will be iterated through the ```while``` loop and will be checked into its corresponding letter via ```case``` statement. If a user provide a non-valid option flag that is not exist in the ```OPTSRING``` collection or within the ```case``` statements, then the option will be thrown to ```*``` section as a default case to perform ```invalid()``` function, which in this context will abort the program entirely.

Lastly, there's a ```case``` statement in line ```26``` that will check if the user can perform ```generate()``` function using the ```-g``` option flag with all the provided mandatory arguments. If the program found out that it's missing one of them, let say a user doesn't provide an age argument using the ```-a``` option flag, then the script will throw the ```invalid()``` function as well as the built-in error handling to warn the user about an incomplete argument. If all the given arguments have met the requirements, but didn't provide the ```-g``` option flag to generate the message, as it will read from line ```27```, then the program will perform the help option instead to indicate the user on how to properly use the overall script. Here are some of the use case with different type of option flag combinations:

```bash
# making it executable + running the script by default
$ chmod +x testflag-1.sh
$ ./testflag-1.sh
list of available options goes here

# running it with help usage option, (-h)
$ ./testflag-1.sh -h
list of available options goes here

# running it with all the mandatory option flag
$ ./testflag-1.sh -n icat -s male -a 24
list of available options goes here

# running it to generate the whole complete message
$ ./testflag-1.sh -n icat -s male -a 24 -g
my name is icat (male)
i am 24 years old

# running it with missing mandatory option flag, (-a)
$ ./testflag-1.sh -n icat -s male -g
testflag: detecting improper option
try option '-h' for more information

# running it with invalid / unkown option flag, (-z)
$ ./testflag-1.sh -n icat -s male -a 24 -z
./testflag-1.sh: illegal option -- z
testflag: detecting improper option
try option '-h' for more information
```

### **B**. Positional Arguments
In *Positional Arguments*, one of the approaches we are going to take is by creating a simple array first called ```args```. This array will act as a pool of valid option flags, including the letter-based and each corresponding keyword for the long option one. **[+]** While that array stores all the valid arguments, the special variable ```$#``` will store the total arguments that are being passed to the script. Here are the following snippets on the overall usage on positional arguments.

```bash {linenos=table,linenostart=14,filename="testflag-2.sh"}
#----------
args=(n name a age s sex g generate h help)
while [ $# -gt 0 ]; do
  if [[ "$1" == -* ]]; then
    raw_opt=$(printf "%s\n" "$1" | tr -d '-')
    if [[ $raw_opt ]]; then
      if [[ $(echo "${args[@]}" | grep -ow "$raw_opt" | wc -w) -eq 1 ]]; then  
        case $1 in
          -n | --name)      n="$2" ;;
          -a | --age)       a="$2" ;;
          -s | --sex)       s="$2" ;;
          -g | --generate)  opt="generate" ;;
          -h | --help) usage ;;
        esac
      else
        echo "$0: illegal option -- $raw_opt"
        invalid
      fi
    fi
  fi
  shift  
done
#----------
case $opt in
  "generate") [[ "$n" && "$a" && "$s" ]] && generate "$n" "$a" "$s" || invalid ;;  
esac
#----------
usage
```

The first ```if``` statement in line ```17``` is to check whether the passed raw arguments are using the valid flag format. It is determined by checking each flag that at least has the first character as a hyphen in it. Once it passes, the flag in ```$1``` will be truncated and stored in ```raw_opt``` variable so it can be compared just by word or letter from the ```args``` pool.

While the next ```if``` statement at line ```19``` is to check if the flag isn’t ```null```, the last statement at line ```20``` is used to check whether the flag exists within the ```args``` pool. The usage of ```wc``` is going to tell if the ```grep``` command is successful, which giving the output to equal to ```1```. The reason of each positional arguments can be stand still in ```$1``` and ```$2``` as the flag’s and its arguments keep iterating is caused by the usage of```shift``` command, which moves the positional arguments to always begin in ```$1``` for all the flag moving forward.

Unlike using ```getopts```, we need to create our error handling ourself for invalid flag options that may be provided. Since it can't read a ```default``` case like ```getopts```, we can put those invalid cases in the ```else``` block if the flag isn't matched to any of the ```args``` pool. The rest is the same as the ```getopts``` section, which has a specific ```case``` statement to perform the ```generate()``` function if all the mandatory flags are provided.

```bash
$ chmod +x testflag-2.sh
$ ./testflag-2.sh
list of available options goes here

$ ./testflag-1.sh -h
list of available options goes here

$ ./testflag-1.sh --help
list of available options goes here

$ ./testflag-2.sh -n icat -s male -a 24
list of available options goes here

$ ./testflag-2.sh -n icat -s male -a 24 -g
my name is icat (male)
i am 24 years old

$ ./testflag-2.sh --name icat --sex male --age 24 --generate
my name is icat (male)
i am 24 years old

$ ./testflag-2.sh --name icat --sex male --age 24 -z
./testflag-2.sh: illegal option -- z
testflag: detecting improper option
try option '-h' for more information
```

## The Verdict Is In
To have a script that handles kinds of flags, both ```getopts``` and positional arguments serves well in terms of parsing it. While ```getopts``` more towards simplicity and readability of the overall workflow, using positional arguments and parsing them manually may give you some form of flexibility, especially the capability to read word-based flags like we used to see on other programs in GNU/Linux. Good luck with whatever stuff you're doing.

## Resources
- [testflag-1.sh | **polarpwn.gg**](https://github.com/polarpwn/polarpwn.gg/blob/main/productionSite/static/script/testflag-1.sh)
- [testflag-2.sh | **polarpwn.gg**](https://github.com/polarpwn/polarpwn.gg/blob/main/productionSite/static/script/testflag-2.sh)

## References
- [Bash Tutorial: getopts | **stackchief**](https://www.stackchief.com/tutorials/Bash%20Tutorial%3A%20getopts)
- [Using --getopts to Pick Up Whole Word Flags - Bash | **AppsLoveWorld**](https://www.appsloveworld.com/bash/100/16/using-getopts-to-pick-up-whole-word-flags)
- [How to Pass Command Line Arguments to Bash Script | **Baeldung**](https://www.baeldung.com/linux/pass-command-line-arguments-bash-script)
- [Beginners Guide to Use getopts in Bash Scripts & Examples | **GoLinuxCloud**](https://www.golinuxcloud.com/bash-getopts/#:~:text=getopt%20vs%20getopts,-getopts%20is%20a&text=The%20main%20differences%20between%20getopts,needs%20to%20be%20installed%20separately)
- [getopts(1p) — Linux Manual Page | **man7**](https://man7.org/linux/man-pages/man1/getopts.1p.html)

