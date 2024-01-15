# githubList
List to search for github users in iOS.

## Setup
- Provide an API key in APIConfig.swift
    - A token can be generated [here](https://github.com/settings/tokens)
- Build and run the app

## Unit Tests
The app currently has no business logic. The github API does searching for us, so the only job of our app is to call the API and display what it gives us. We could write some integration tests to guarantee that our API layer is working as expected, especially the pagination being used and potentially making sure we get user data for each returned 'item' in the initial search, however that is out of scope for me right now.

## Other
The requirements of this project included searching organizations -- I was uncertain how to do that. It doesn't look like the API provides a 'search' option regarding them.