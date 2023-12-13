---
title: Understanding The Basic RegEx Format
linkTitle: Basic RegEx
authors:
  - name: monsieurDuke
    link: https://github.com/monsieurDuke
cascade:
  type: docs
weight: 99999
---
*Gain a foundational understanding of different character classes, patterns, and their applications in RegEx. Explore a variety of examples that illustrate how to leverage and navigate the essential concepts of RegEx for common use cases, from matching specific character sets to extracting patterns from text* 
<!--more-->

## What Is RegEx?
Regular Expressions, RegEx, is a powerful method of pattern matching in searching and manipulating text strings, particularly on processing text files. RegEx involves using a wide variety combination of characters, quantifiers, logics, and other built-in classes to form a specific curated strings that represent a pattern that could fetch kinds of strings. For example, we may have list of a ```.csv``` file that contains thousands of email addresses. If you wanted to set such rules to verify either each entry have the proper and valid format or not, instead of doing it manually, you can simply match it againts a specific pattern to get the result of its validation in terms of true or false, then even chaining it within the scripting or programming manner to perform a further and advance action.

There are several use cases on why you wanted atleast master the basics of RegEx in terms of enhancing the effeciency and flexilibity of your workflow with the stuff that you are trying to accomplish. Here are some of the highlights:
- Verify a specific valid format of email address, phone number, credit card number, or any other user-input related that validation controls are one of the top priority to be concern of, which ensure that the entered data follows the expected patterns and guideline
- Extract specific information in log files or network traffic from a consistent to sophisticated manner, which helps to identify any potential security threats or anomalies by matching them with a curated malicious patterns that have been associated with
- Validate and parse malicious URLs by creating patterns that match common characteristics, which helps to unveil the attacker's best practice to perform obfuscation approach to hide their true nature

## RegEx Symbols and Patterns
RegEx are composed by various elements that allows you to define such patterns for matching strings in any situation you're in. These components can be combined in various ways to create complex patterns that define the strings you want to match in a flexible and powerful manner. Understanding these core components is crucial for effectively using regular expressions. Below are some of those sections that are presented in a table format, which may help you understand to get a firm grisp of basic RegEx syntax. After that, you can also follow along with the exercises and use cases that are provided on the [next section](#exercises-and-samples) to build your early familiarity with kinds of RegEx patterns.

The following paragraph serves as a context for reference, incorporating various patterns such as numbers, email addresses, and generic wordphrases. Each pattern can be identified and tested against the text for validation or extraction purposes for all the sections below.

{{< callout emoji=" " type="info" >}}
In an era driven by technology where sharks started golfing, you can reach me either at watcher@polarpwn.gg. For any inquiries, feel free to call me at +1-555-4567. Our team is 24 & 7, dedicated to innovation, striving to create solutions that go beyond expectations. With an annual growth rate of 15%, our company is poised for success. We believe in collaboration, and our diverse team ensures a vibrant work environment. Join us in shaping the future, where creativity meets precision and numbers tell a compelling story. Best, Huncho Muncho, prez@polarpwn.gg
{{< /callout >}}

### **A**. Characters
| Character | Description | Pattern  | Match
| --------  | --------    | -------- | -------- 
| ```abc```    | Literal characters match themselves, which you may used it already in day-to-day activity. For example, the pattern ```John Doe``` will match and retrieve the string ```John Doe``` in the input | | 
| ```[abc]```  |
| ```[^abc]``` |
| ```(abc)```  | 
| ```.```      | 
| ```\```      |
| ```\|```     |
| ```^```      |
| ```$```      |
| ```\w```     |
| ```\W```     |
| ```\d```     |
| ```\D```     |
| ```\s```     |
| ```\S```     |
| ```\b```     |
| ```\B```     |

### **B**. Quantifiers
| Character | Description   
| --------  | -------- 
| ```{x}```    |
| ```{x,}```   |
| ```{x,y}```  |
| ```[x-y]```  |
| ```+```      |
| ```*```      |
| ```?```      |

### **C**. POSIX Classes
| Character | Description  
| --------  | -------- 
| ```[:alpha:]```  |
| ```[:digit:]```  |
| ```[:alnum:]```  |
| ```[:space:]```  |
| ```[:lower:]```  |
| ```[:upper:]```  |

### **D**. Lookarounds
| Character | Description  
| --------  | -------- 
| ```(?=abc)```    |
| ```(?!abc)```    |
| ```(?<=abc)```   |
| ```(?<!abc)```   |
| ```(?:abc)```    |

## Exercises and Samples
abc

## Resources
- [Learn, Build, and Test RegEx | **RegExr**](https://regexr.com/)
- [Learn Regular Expression | **RegexOne**](https://regexone.com/)
- [RegEx 101 | **RegEx Learn**](https://regexlearn.com/learn/regex101)

## References
- [How to Read and Use Regular Expressions | **Hall**](https://www.hallme.com/blog/the-power-of-regular-expressions/)
- [Quick-Start: RegEx Cheat Sheet | **RexEgg**](https://www.rexegg.com/regex-quickstart.html)
- [Regular Expression List | **jacksonfdam/gist**](https://gist.github.com/jacksonfdam/3000275)
