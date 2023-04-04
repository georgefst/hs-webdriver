
# Welcome to `webdriver`

[![Hackage](https://img.shields.io/hackage/v/webdriver.svg)](https://hackage.haskell.org/package/webdriver) ![webdriver](https://github.com/haskell-webdriver/haskell-webdriver/workflows/ci/badge.svg)

haskell-webdriver is a Selenium WebDriver client for the Haskell programming language. You can use it to automate browser sessions for testing, system administration, etc.

For more information about Selenium itself, see http://seleniumhq.org/

# Contents
* [Installation](#installation)
    * [Installation from Hackage](#installation-from-hackage)
    * [Installation from This Repository](#installation-from-this-repository)
* [Getting Started](#getting-started)
    * [Using the Selenium Server](#using-the-selenium-server)
    * [Hello, World!](#hello-world)
* [Integration with Haskell Testing Frameworks](#integration-with-haskell-testing-frameworks)
* [Documentation](#documentation)

# Installation
haskell-webdriver uses the Cabal build system to configure, build, install, and generate documentation on multiple platforms.

For more information on using Cabal and its various installation options, see the Cabal User's Guide at http://www.haskell.org/cabal/users-guide/index.html

## Installation from Hackage
haskell-webdriver is hosted on Hackage under the name webdriver. Thus, the simplest way to download and install the most recent version of haskell-webdriver is to run:

```sh
cabal install webdriver
```
There are also options to do system-wide installation, version selection, and other build options; see cabal-install documentation.

## Installation from this repository

To build and install a git revision for a single user on your system, run these commands from within the repository directory


### Using cabal-install

```sh
cabal install
```

### Using Cabal

For systems without cabal-install available, you can also run the Setup.hs
script, as such:

```sh
runhaskell Setup.hs configure --user
runhaskell Setup.hs build
runhaskell Setup.hs install
```

For more build options, please refer to the Cabal documentation.


# Getting Started

WebDriver is a client-server protocol. Since haskell-webdriver only implements a WebDriver client, you must have a WebDriver server to which you can connect in order to make use of this library.

## Using the Selenium Server
While you can use any WebDriver server out there, probably the simplest server to use with haskell-webdriver is [Selenium Server](http://docs.seleniumhq.org/download/). You'll need an installation of the Java runtime to use this server. Once you've downloaded Selenium Server to your current working directory, you can start the server with this shell command:

    java -jar selenium-server-standalone-*.jar

The server should now be listening at localhost on port 4444.

Currently, `haskell-webdriver` only supports selenium version 2.
The [beginner example](/examples/readme-example-beginner.md) was
tested with `selenium-server-standalone-2.53.1`.

## Hello, World!
With the Selenium server running locally, you're ready to write browser automation scripts in Haskell.

A [simple example can be found here](/examples/readme-example-beginner.md), written in literate Haskell so that you can compile it with GHC yourself. It is very beginner friendly and assumes no prior knowledge of Haskell. For other examples see the [examples](examples/) and [test/etc](test/etc/) directory.


# Integration with Haskell Testing Frameworks

This package does not provide utilities to integrate with popular Haskell testing frameworks. However, other packages exist for this purpose:

* [hspec-webdriver](https://hackage.haskell.org/package/hspec-webdriver)
* [quickcheck-webdriver](https://hackage.haskell.org/package/quickcheck-webdriver)

# Documentation

Documentation for haskell-webdriver is available on Hackage at <http://hackage.haskell.org/package/webdriver>. You can also generate local HTML documentation from this source revision with the following shell command:

```sh
runhaskell Setup.hs haddock
```

Haddock will generate documentation and save it in `dist/doc/html/webdriver`
