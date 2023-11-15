---
id: utbrf
title: Understanding The Basic RegEx Format
linkTitle: Basic RegEx
date: 2020-01-01
authors:
  - name: monsieurDuke
    link: https://github.com/monsieurDuke
excludeSearch: true
cascade:
  type: docs
weight: 99999
---
*Unleash the might of Bash scripting with a focus on simplicity and versatility. In this blog series, we delve into the power of the optional flag, a gem within the realm of Linux scripting. A little journey where we unravel how this unassuming tool can enhance your Bash scripts, adding flexibility to your code and streamlining your processes*
<!--more-->

## What Is Optional Flags?
One of the powerful features of command-line programs is the capability to pass multiple arguments during the time of execution. That way, the program can run straight-up the way we wanted to without having another ```STDIN``` session to take the user input.

There are multiple ways of passing multiple arguments and parsing them so the program can read them without hassle. One of the best approaches is to have optional flags, which either represented by character letters preceded by a hyphen, ```-u duke64```, or by a word preceded by a double hyphen, ```--username duke64```.

One of the program that is designated for this feature is the ```getopts``` utility, which retrieves options and option arguments from a list of parameters. Even though ```getopts``` is a dropdown replacement from its predecessor GNU/Linux utility, ```getopt```, one difference is that one cannot read word-based flags, while ```getopt``` can. To overcome that while still maintaining the script's readability and simplicity from using ```getopt```, we will also be using positional arguments instead, such as ```$1```, that will be passed and parsed manually later on.

## Simple Use Case
There are two cases that we will demonstrate: the use of ```getopts``` in ```testflag-1.sh``` and positional arguments in ```testflag-2.sh```. Both scripts are going to contain the same mockup functions that are later on going to be tested, they are:
- ```usage()```: Lists all the possible flags that refer to the help option
- ```invalid()```: Throw error message of any unknown or incomplete flag(s)
- ```generate()```: Execute the non-argument flag function to develop the whole output message for the arguments from ```$1``` to ```$3```, which are name, age, and sex

```bash {linenos=table,linenostart=1,filename="testflag-1.sh"}
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

### Getopts
In ```getopts```, a collection of the valid option letters, ```OPTSTRING```, will determine whether the flag is argument-based or not. That distinction is defined by the usage of a trailing semicolon ```:```, which indicates that an argument variable called ```OPTARG``` will set that particular argument from the flag. Here are the following snippets on the overall usage of ```getopts```:

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

The argument-based flag in ```OPTSTRING``` that is going to take the user’s arguments are ```n:``` for name, ```a:``` for age, and ```s:``` for sex. As one of the improvement from ```getopts```, it will also throws an error if an argument from the argument-based flag is not supplied, which is set to an explicit ```null```.

Each ```OPTSTRING``` option later on will be iterated from the ```while``` loop and checking it to its corresponding letter via ```case``` statement. If the provided flag by the user does not exist in the ```OPTSRING``` option and one of the ```case``` statements, then the option will be thrown to the ```default``` case to perform an ```invalid()``` function.

Lastly, there's a ```case``` statement that will check if the user wanted to perform ```generate()``` using the ```-g``` flag with all the provided mandatory flags, or the script will throw the ```invalid()``` function to warn the user about an incomplete argument. If all the arguments don't meet any cases defined in the ```case``` statement, the script will display the ```usage()``` function instead.

<img src="/images/blog/suoofibs-1.gif" width="100%" style="border-radius: 0.6yrem;" >

### Positional Arguments
In positional arguments, one of the approaches we take is to create an array called ```args```  that act as a pool of valid options, including letters and their corresponding keywords. While that array stores all the valid arguments, the special variable ```$#``` will store the total arguments that are being passed to the script. Here are the following snippets on the overall usage on positional arguments.

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

<img src="/images/blog/suoofibs-2.gif" width="100%" style="border-radius: 0.6yrem;" >

## The Verdict Is In
To have a script that handles kinds of flags, both ```getopts``` and positional arguments serves well in terms of parsing it. While ```getopts``` more towards simplicity and readability of the overall workflow, using positional arguments and parsing them manually may give you some form of flexibility, especially the capability to read word-based flags like we used to see on other programs in GNU/Linux. Good luck with whatever stuff you're doing.

## Resources
- [testflag-1.sh | **polarpwn.gg**](https://github.com/hotpotcookie/hotpotcookie/blob/main/script/blog/testflag-1.sh)
- [testflag-2.sh | **polarpwn.gg**](https://github.com/hotpotcookie/hotpotcookie/blob/main/script/blog/testflag-2.sh)

## References
- [Bash Tutorial: getopts | **stackchief**](https://www.stackchief.com/tutorials/Bash%20Tutorial%3A%20getopts)
- [Using --getopts to Pick Up Whole Word Flags - Bash | **AppsLoveWorld**](https://www.appsloveworld.com/bash/100/16/using-getopts-to-pick-up-whole-word-flags)
- [How to Pass Command Line Arguments to Bash Script | **Baeldung**](https://www.baeldung.com/linux/pass-command-line-arguments-bash-script)
- [Beginners Guide to Use getopts in Bash Scripts & Examples | **GoLinuxCloud**](https://www.golinuxcloud.com/bash-getopts/#:~:text=getopt%20vs%20getopts,-getopts%20is%20a&text=The%20main%20differences%20between%20getopts,needs%20to%20be%20installed%20separately)
- [getopts(1p) — Linux Manual Page | **man7**](https://man7.org/linux/man-pages/man1/getopts.1p.html)

