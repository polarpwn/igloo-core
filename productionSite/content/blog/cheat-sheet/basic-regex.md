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

{{< tabs items="Characters,Quantifiers,POSIX Classes,Lookarounds" >}}
{{< tab >}}
| Expr | Description
| --------  | -------- 
| ```xyz```    | Literal characters will match themselves, which is used as the most generic and basic RegEx expressions. The pattern ```Huncho``` would match the string ```Huncho``` 
| ```[xyz]```  | Match any single character or other patterns within the bracketed list. The pattern ```[Ii][ns]``` would match the strings ```In``` ```in``` ```in``` ```is``` 
| ```[^xyz]``` | In the context of bracketed list, the caret expression would act as a negation to the following expressions. The pattern ```[Ii][^ns]``` would match the strings ```iv``` ```it``` ```ir``` ```ie```
| ```\|```     | The vertical bar act as an OR operand that would match either given expressions as multiple options. The pattern ```harks\|tory``` would match the strings ```harks``` ```tory``` 
| ```(xyz)```  | Create capturing groups of characters or expressions, allowing you to extract matched substrings. The pattern ```s(harks\|tory)``` would match the strings ```sharks``` ```story``` 
| ```.```      | Dot symbol will matches any single character in-place except a newline or line break. The pattern ```f...``` would match the strings ```fing``` ```feel``` ```free``` ```f 15```
| ```\```      | Backslashes is act as a character escapes, allowing all kinds of characters to be treated as its nature. The pattern ```...\.gg``` would match the strings ```pwn.gg``` ```pwn.gg```
| ```^```      | In a standalone, caret will act as an achor to match if the terms appear at the beginning of a paragraph or a line. The pattern ```^.n``` would match the string ```In```
| ```$```      | Dollar sign will also act as an anchor to match if the terms appear at the end of a paragprah or a line. The pattern ```.g$``` would match the string ```gg```
| ```\w```     | Represent any single word character, which in most engines includes ASCII letter, digit, and underscore inside them. The pattern ```\w\w``` would match the strings ```In``` ```an``` ```er``` ```dr```
| ```\W```     | Represent any single character other than the above list, which include white space, line break, and special character. The pattern ```\w..\W..``` would match the strings ```era dr``` ``` ven by``` ```her@po```
| ```\d```     | Represent any single digit or numeric character, which is from 0 to 9. The pattern ```\d.\d``` would match the strings ```1-5``` ```5-4``` ```567``` 
| ```\D```     | Represent any single character excluding the digit itself, which also include from letter character to line break. The pattern ```\w\D.[123]``` would match the strings ```t +1``` ```is 2``` ```of 1```
| ```\s```     |
| ```\S```     |
| ```\b```     |
| ```\B```     |
{{< /tab >}}

{{< tab >}}
| Character | Description   
| --------  | -------- 
| ```{x}```    |
| ```{x,}```   |
| ```{x,y}```  |
| ```[x-y]```  |
| ```+```      |
| ```*```      |
| ```?```      |
{{< /tab >}}

{{< tab >}}
| Character | Description  
| --------  | -------- 
| ```[:alpha:]```  |
| ```[:digit:]```  |
| ```[:alnum:]```  |
| ```[:space:]```  |
| ```[:lower:]```  |
| ```[:upper:]```  |
{{< /tab >}}

{{< tab >}}
| Character | Description  
| --------  | -------- 
| ```(?=abc)```    |
| ```(?!abc)```    |
| ```(?<=abc)```   |
| ```(?<!abc)```   |
| ```(?:abc)```    |
{{< /tab >}}
{{< /tabs >}}

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
