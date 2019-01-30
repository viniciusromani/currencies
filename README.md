# Currencies

This is an application that will fetch a list of currencies from a web service and show it in a table. The values are in Euro.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Cocoa Pods (https://guides.cocoapods.org/using/getting-started.html)

```
sudo gem install cocoapods
```

### Installing

Clone the repo by executing the command

```
git clone https://github.com/viniciusromani/currencies.git
```

Install dependencies with cocoapods

```
pod install
```

## Running the tests

Unit tests were written for this application using XCode tool. To run tests go to the tests tab and press play button.

## Usage

Once the application is run, the currencies will be shown to the user in a table, the system updates values every second with a new web service fetch. The user is able to simulate any value in any of the shown currencies by either tapping a cell or selecting the desired currency value. Once the user is updating a currency, the system stopps fetching from service and updates the values based on what the user is typing. Once the keyboard is dismissed (by sliding it down), the refresh button at the top is reenabled so, the user can see the new values for the typed currency and then starting updating based on the webservice result again.

## Built With

* [Alamofire](https://github.com/Alamofire/Alamofire.git) - Networking library
* [Swinject](https://github.com/Swinject/Swinject.git) - For dependency injection
* [R.swift](https://github.com/mac-cain13/R.swift) - Similar to R in Android
* [SnapKit](https://github.com/SnapKit/SnapKit.git) - For auto layout by code
* [Nimble](https://github.com/Quick/Nimble.git) - Wrapper for XCTest

