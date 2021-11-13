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

## Functionality - self-assessed score: 3.5
As of writing this README, my decryption program is able to crack a message knowing that it has been enciphered with the Caesar cipher implemnenting an ABCD shift, and knowing that the final four characters of a message are " end". 

However, it yet lacks the functionality to reproduce the keys used to encipher it, or to implement the date in cracking it. Because it does not follow the interaction pattern output exactly, but does still maintain functionality, I would score myself between a 3 and 4 for this section.

## Object Oriented Programming (OOP) - self-assessed score: 3.5
In regard to OOP I would say my decryption program meets expectations. I have broken it into logical component parts, used each component to execute the functions of the program, and attempted to maintain SRP throughout my code base.

In order to keep my enigma class code clean, and further organize the helper methods needed to operate the enigma program, I incorporated a module: Helpable. The scope of this project was limited, but it is my intent that should this program come to encapsulate further functionality for decryption in the future, these helper methods may be used more broadly to validate, generate, and organize information.

I believe that my organization of the code base and the implementation of OOP concepts lands me solidly in meets expectations, and I would score myself between a 3 and a 4.

## Ruby Conventions and Mechanics - self-assessed score: 




