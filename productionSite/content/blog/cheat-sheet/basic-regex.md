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

The following paragraph serves as a context for reference, incorporating various patterns such as numbers, email addresses, and generic wordphrases. Each pattern can be identified and tested against the text for validation or extraction purposes for all the sections below, which you can also test these cases yourself in [RegExr](https://regexr.com/) platform:

{{< callout emoji=" " type="info" >}}
In an era driven by technology where sharks started golfing, you can reach me either at watcher@polarpwn.gg. For any inquiries, feel free to call me at +1-555-4567. Our team is 24 & 7, dedicated to innovation, striving to create solutions that go beyond expectations. With an annual growth rate of 15%, our company is poised for success. We believe in collaboration, and our diverse team ensures a vibrant work environment. Join us in shaping the future, where creativity meets precision and numbers tell a compelling story. Best, Huncho Muncho, prez@polarpwn.gg
{{< /callout >}}

{{< tabs items="Character,Quantifier,Lookaround" >}}
{{< tab >}}
| Expr | Description
| --------  | -------- 
| ```xyz```    | Literal characters will match themselves, which is used as the most generic and basic RegEx expressions. The pattern ```Huncho``` would match the string ```Huncho``` 
| ```[xyz]```  | Square bracket can match any single character or other patterns within the instance. The pattern ```[Ii][ns]``` would match the strings ```In``` ```in``` ```in``` ```is``` 
| ```[^xyz]``` | In the context of bracketed list, the caret expression would act as a negation to the following expressions. The pattern ```[Ii][^ns]``` would match the strings ```iv``` ```it``` ```ir``` ```ie```
| ```\|```     | The vertical bar act as an OR operand that would match either given expressions as multiple options. The pattern ```harks\|tory``` would match the strings ```harks``` ```tory``` 
| ```(xyz)```  | Create capturing groups of characters or expressions, allowing you to extract matched substrings. The pattern ```s(harks\|tory)``` would match the strings ```sharks``` ```story``` 
| ```(?:xyz)```    | Create non-capturing group of characters or expressions by not creating any backreferences to the group, while still match the overall expression. The pattern ```[\w\d]+(?:@polarpwn.gg)``` would match the strings ```watcher@polarpwn.gg``` ```prez@polarpwn.gg``` (improved performance by only processing the string that we need later on)
| ```.```      | Dot symbol will matches any single character in-place except a newline or line break. The pattern ```f...``` would match the strings ```fing``` ```feel``` ```free``` ```f 15```
| ```\```      | Backslashes is act as a character escapes, allowing all kinds of characters to be treated as its nature. The pattern ```...\.gg``` would match the strings ```pwn.gg``` ```pwn.gg```
| ```^```      | In a standalone, caret will act as an achor to match if the terms appear at the beginning of a paragraph or a line. The pattern ```^.n``` would match the string ```In```
| ```$```      | Dollar sign will also act as an anchor to match if the terms appear at the end of a paragprah or a line. The pattern ```.g$``` would match the string ```gg```
| ```\w```     | Represent any single word character, which in most engines includes ASCII letter, digit, and underscore inside them. The pattern ```\w\w``` would match the strings ```In``` ```an``` ```er``` ```dr```
| ```\W```     | Represent any single character other than the above list, which include white space, line break, and special character. The pattern ```\w..\W..``` would match the strings ```era dr``` ``` ven by``` ```her@po```
| ```\d```     | Represent any single digit or numeric character, which is from 0 to 9. The pattern ```\d.\d``` would match the strings ```1-5``` ```5-4``` ```567``` 
| ```\D```     | Represent any single character excluding the digit itself, which include from letter character to line break. The pattern ```\w\D.[123]``` would match the strings ```t +1``` ```is 2``` ```of 1```
| ```\b```     | Represent a word boundary that is not act as a character, but as a zero-width assertion. This expression could be put either on one end or both end of the given expression, which often used to match whole word. • The pattern ```\w.y\b``` would match the strings ```ogy``` ```any``` ```any``` ```ity``` (end of word) • The pattern ```\b\w[aiueo]``` would match the strings ```te``` ```go``` ```yo``` ```ca``` (beginning of word) • The pattern ```\b\w[aiueo]\b``` would match the strings ```me``` ```to``` ```go``` ```We``` (complete word)
{{< /tab >}}

{{< tab >}}
| Expr | Description   
| --------  | -------- 
| ```{n}```    | Curly bracket will matches exactly ```n``` times of the preceeding character or expression, which you can say it as an ```n``` iteration. The pattern ```\w{8}\.\w{2}``` would match the strings ```polarpwn.gg``` ```polarpwn.gg```
| ```{n,}```   | Curly bracket with trailing comma will match atleast ```n``` times, into then as much as the preceeding character or expression could do to the rest. The pattern ```\d{1,}\D{2}``` would match the strings ```4567.``` ```24 &``` ```15%``` ```7, ```, with white space included
| ```{m,n}```  | Curly bracket with 2 digits inside it will indicates the minimum and maximum iteration of the preceeding character or expression. The pattern ```\b\w{3,4}[aiueo]\b``` would match the strings ```where``` ```free``` ```rate``` ```where```
| ```[x-y]```  | In the context of bracketed list, the dash symbol will act as a character range, which works for both digits and letters and can be used for multiple instances within the scope. The pattern ```[A-Ha-h].[O-Zo-z]``` would match the strings ```hno``` ```her``` ```e s``` ```har```    
  | ```+```      | Plus sign will match atleast 1 or more occurrences of preceeding character or expression (greedy), which is the same as ```{1,}```. The pattern ```\w+.\w+``` would match the strings ```In an``` ```era driven``` ```by technology``` ```where sharks```
| ```*```      | Asterisk sign will match that allow 0 or more occurrences of preceeding character or expression (greedy), which is the same as ```{0,}```. The pattern ```(p\w+)*@\w+\.\w+``` would match the strings ```@polarpwn.gg``` ```prez@polarpwn.gg```  
| ```?```      | Question mark sign will make the preceding character or expression as an optional clause, or atleast one occurrence only (lazy), which is the same as ```{0,1}```. The pattern ```\bst?\w+``` would match the strings ```sharks``` ```started``` ```striving``` ```solutions```
{{< /tab >}}

{{< tab >}}
| Expr | Description  
| --------  | -------- 
| ```(?=abc)```    | Positive lookahead asserts that a certain pattern must be present at particular position within the input string (if statement). The pattern ```\d{1,}(?=-\d{3,})``` would match the strings ```1``` ```555``` , with the condition on having ```-``` sign followed by 3 digits or more after the last expression 
| ```(?!abc)```    | Negative lookahead asserts that a certain pattern must not be present at a particular position within the input string (negation if statement). The pattern ```\d{1,}(?!-\d{3,})``` would match the strings ```55``` ```4567``` ```24``` ```7``` , with the condition on having no ```-``` sign and not followed by ```3``` digits or more after the last expression 
| ```(?<=xyz)```   | Positive lookbehind asserts that a certain pattern must be present immidiately before the current position in the input string (if statement). The pattern ```(?<=@)\w+\.\w{2}``` would match the strings ```polarpwn.gg``` ```polarpwn.gg``` , with the condition on having the ```@``` sign before the start of the given expressions
| ```(?<!xyz)```   | Negative lookbehind asserts that a certain pattern must not be present immidiately before the current position in the input string (negation if statement). The pattern ```(?<!\s)\w{3,}``` would match the strings ```riven``` ```echnology``` ```harks``` ```tarted``` , with the condition on having no white space before the start of the given expression
{{< /tab >}}
{{< /tabs >}}

## Exercises and Samples
### **A**. RegexOne
| Match Strings | Expression  
| -------- | --------
| ```abcdefg``` ```abcde``` ```abc``` | ```abc\w+``` ```\w+```
| ```abc123xyz``` ```define "123"``` ```var g = 123;``` | ```\w+(\D+123)?.``` ```\w+(\D+\d+)?.``` 
| ```cat.``` ```896``` ```?=+.``` , skipped ```abc1``` | ```.{0,}\.``` ```(\w+\|\D+)?\.```
| ```can``` ```man``` ```fan``` , skipped ```dan``` ```ran``` ```pan``` | ```[cmf]an``` ```[^drp]an```
| ```Ana``` ```Bob``` ```Cpc``` , skipped ```aax``` ```bby``` ```ccz``` | ```[A-C]\w+``` ```[^a-c]\w+```
| ```wazzzzzup``` ```wazzzup``` , skipped ```wazup``` | ```waz{2,}up```
| ```aaaabcc``` ```aabbbbc``` ```aacc``` , skipped ```a``` | ```a{2,}\w+``` ```a+(b+)?c+```
| ```1 file found?``` ```2 files found?``` ```24 files found?``` , skipped ```No files found.``` | ```\d+\s\w+\s\w+\?``` ```\d+ files? found\?```
| ```1.   abc``` ```2.	abc``` ```3.           abc``` , skipped ```4.abc``` | ```\d\.\s{1,}\w+``` ```[1-4].\W+\w+```
| ```Mission: successful``` , skipped ```Last Mission: unsuccessful``` ```Next Mission: successful upon capture of target``` | ```^Mission: successful``` ```^M\D+``` 
| ```file_record_transcript.pdf``` ```file_07241999.pdf``` ```testfile_fake.pdf.tmp``` | ```^(file\w+)\.pdf```
| ```Jan 1987``` ```May 1969``` ```Aug 2011``` | ```(\w{3}\s(\d+))```
| ```1280x720``` ```1920x1600``` ```1024x768``` | ```((\d+)x(\d+))```
| ```I love cats``` ```I love dogs``` , skipped ```I love logs``` ```I love cogs``` | ```I love (cats\|dogs)``` ```.+(cats\|dogs)```
| ```The quick brown fox jumps over the lazy dog.``` ```There were 614 instances of students getting 90.0% or above.``` ```The FCC had to censor the network for saying &$#*@!.``` | ```.+ ```
| ```3.14529``` ```-255.34``` ```128 1.9e10``` ```123,340.00``` , skipped ```720p``` | ```^-?\d+(,\d+)*(\.\d+(e\d+)?)?$``` ```^-?\d+[,\.\d+]*e?\d+$```
| ```415-555-1234``` ```650-555-2345``` ```(416)555-3456``` ```202 555 4567``` ```4035555678``` ```1 416 555 9292``` , grouped ```415``` ```650``` ```416``` ```202``` ```403``` ```416``` respectively | ```^(?:\d\s)?[\(]?(\d{3})[\)-\s\d{3}]?\d{3}[-\s]?\d{4}``` capturing ```(\d{3})```
| ```tom@hogwarts.com``` ```tom.riddle@hogwarts.com``` ```tom.riddle+regexone@hogwarts.com``` ```tom@hogwarts.eu.com``` ```potter@hogwarts.com``` ```harry@hogwarts.com``` ```hermione+regexone@hogwarts.com``` , grouped ```tom``` ```tom.riddle``` ```tom.riddle``` ```tom``` ```potter``` ```harry``` ```hermione``` respectively | ```^([\w.]*)[\+\w]*@hogwarts\.\w{2,3}(?:\.\w{2,3})?``` capturing ```([\w.]*)```
| ```<a>This is a link</a>``` ```<a href='https://regexone.com'>Link</a>``` ```<div class='test_style'>Test</div>``` ```<div>Hello <span>world</span></div>``` , grouped ```a``` ```a``` ```div``` ```div``` respectively | ```<(a\|div)(?:\s?\w+='.+')?>.+<(?:\/div\|\/a)>``` capturing ```(a\|div)``` 
| ```img0912.jpg``` ```updated_img0912.png``` ```favicon.gif``` , grouped ```img0912``` ```jpg``` ```updated_img0912``` ```png``` ```favicon``` ```gif``` respectively , skipped ```.bash_profile``` ```workspace.doc``` ```documentation.html``` ```img0912.jpg.tmp``` ```access.lock``` | ```^(\w+)\.(jpg\|gif\|png)$``` capturing ```(\w+)``` ```(jpg\|gif\|png)```  
| ```			The quick brown fox...``` ```   jumps over the lazy dog.``` , with both strings have multiple preceeding white spaces | ```^\s+(.+)``` capturing ```(.+)```
| ```E/( 1553):   at widget.List.makeView(ListView.java:1727)``` ```E/( 1553):   at widget.List.fillDown(ListView.java:652)``` ```E/( 1553):   at widget.List.fillFrom(ListView.java:709)``` , grouped ```makeView``` ```ListView.java``` ```1727``` ```fillDown``` ```ListView.java``` ```652``` ```fillFrom``` ```ListView.java``` ```709``` respectively , skipped ```W/dalvikvm( 1553): threadid=1: uncaught exception``` ```E/( 1553): FATAL EXCEPTION: main``` ```E/( 1553): java.lang.StringIndexOutOfBoundsException``` | ```.+\):\s+at widget\.List\.(\w+)\((\w+\.java):(\d+)\)``` capturing ```(\w+)``` ```(\w+\.java)``` ```(\d+)```
| ```...``` | ```...``` 
https://regexone.com/problem/extracting_log_data?

### **B**. Regex 101

## Resources
- [Learn, Build, and Test RegEx | **RegExr**](https://regexr.com/)
- [Learn Regular Expression | **RegexOne**](https://regexone.com/)
- [RegEx 101 | **RegEx Learn**](https://regexlearn.com/learn/regex101)

## References
- [How to Read and Use Regular Expressions | **Hall**](https://www.hallme.com/blog/the-power-of-regular-expressions/)
- [Quick-Start: RegEx Cheat Sheet | **RexEgg**](https://www.rexegg.com/regex-quickstart.html)
- [Regular Expression List | **jacksonfdam/gist**](https://gist.github.com/jacksonfdam/3000275)
- [What Is a Non-Capturing Group in Regular Expressions? | **Educative**](https://www.educative.io/answers/what-is-a-non-capturing-group-in-regular-expressions)
