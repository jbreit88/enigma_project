# enigma_project
This project comepleted in requirement of the Turing 2110-Mod1 Back-End Program

Project specs can be found here: [Turing Enigma Project](https://backend.turing.edu/module1/projects/enigma/index)

![languages](https://img.shields.io/github/languages/top/jbreit88/enigma_project?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/jbreit88/enigma_project)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov) <!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/contributors-1-orange.svg?style=flat)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

**Author** ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/jbreit88"><img src="https://avatars.githubusercontent.com/u/88853324?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Brad (he/him)</b></sub></a><br /><a href="https://github.com/jbreit88/enigma_project/commits?author=jbreit88" title="Code">💻</a> <a href="#ideas-jbreit88" title="Ideas, Planning, & Feedback">🤔</a> <a href="https://github.com/jbreit88/enigma_project/commits?author=jbreit88" title="Tests">⚠️</a> <a href="https://github.com/jbreit88/enigma_project/pulls?q=is%3Apr+reviewed-by%3Ajbreit88" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification.

# Self Assessment
Self assessment is based on the rubric found [here](https://backend.turing.edu/module1/projects/enigma/rubric)

## *Functionality* - self-assessed score: **3.5**
As of writing this README, my decryption program is able to crack a message knowing that it has been enciphered with the Caesar cipher implementing an ABCD shift, and knowing that the final four characters of a message are " end". 

However, it yet lacks the functionality to reproduce the key used to encipher it. Because it does not follow the interaction pattern output exactly, but does still maintain functionality, I would score myself between a 3 and 4 for this section.

## *Object Oriented Programming (OOP)* - self-assessed score: **3.5**
In regards to OOP I would say my decryption program meets expectations. I have broken it into logical component parts, used each component to execute the functions of the program, and attempted to maintain SRP throughout my code base.

In order to keep my enigma class code clean, and further organize the helper methods needed to operate the enigma program, I incorporated a module: Helpable. The scope of this project was limited, but it is my intent that should this program come to encapsulate further functionality for decryption in the future, these helper methods may be used more broadly to validate, generate, and organize information across the program.

I believe that my organization of the code base and the implementation of OOP concepts lands me solidly in meets expectations, and I would score myself between a 3 and a 4.

## *Ruby Conventions and Mechanics* - self-assessed score: **3.0**
I believe my code is all properly indented with relatively short, readable lines, and clear spacing between methods and within them. Variable names demonstrate their function and improve the readability of my code overall. I believe I have used a variety of enumerables, and while in some places I rely on #each more than I would like, as I was writing the code it seemed the most accessible iterator for the places where I used it. With a refactor I don't doubt I would find a number of places with more apt enumerables to use.

At the time of writing this README one can clearly see in my enigma class that I was unable to keep the 3 main methods (#encrypt, #decrypt, and #crack) below ten lines of code. I was able to refactor a number of repetetive if-statements in all three of my main methods in order to reduce the total space taken. But in its current iteration, I do not think my project exceeds expectations in my use of enumerables nor in the length of my longest methods.

I would put myself solidly in the 'meets expectations' column in this category and score myself a 3.

## *Test Driven Development* - self-assessed score: **3.5**
My code base is at 100% coverage according to the [SimpleCov coverage report](https://user-images.githubusercontent.com/88853324/141726327-71f56a25-fc1a-4ed7-a475-425e93ab1338.png). I believe I have total coverage at both the unit and integration levels for my methods. For most of my testing suite, my commit history should indicate that I produce my tests before writing my methods, and that I have started writing my expected values into the tests (rather than writing an empty test and filling in the expected value after running it). However, during the course of this project I learned new ways to write tests and interact with my code through testing, so some smaller methods were only tested at the integration level initially, but were later updated to be tested at the unit level. 

As far as advanced testing practices go, I was able to test my module methods by creating a dummy class and cover every method in my module at the unit level through that. In my other classes, as well, I make ample use of mocks to test the various functionality of my methods and change the arguments input to test each method. Barring any egregious oversight on my part I believe that the organization of my tests, the way they are written, and my use of various testing concepts meets expectations and approaches 'above expectations.' I would grade myself between a 3 and 3.5 in this category.
