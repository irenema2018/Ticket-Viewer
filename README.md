# Ticket-Viewer

## Introduction
This app uses sinatra in Ruby (v2.6.2) for viewing Zendesk tickets via API calls. You can use your own Zendesk account to access the app. Zendesk fonts and colours are used in the app to make it a bit more user friendly.

## Installation
1. [Download](https://www.ruby-lang.org/en/downloads/) and install Ruby if you don't have it on your machine. Using the most recent stable release (v2.6.3) should be fine.

2. Install [Bundler](https://bundler.io/) if you don't have it already. It is used to manage the Ruby gems.
```
gem install bundler
```

## How to run the app
1. Clone the repository

```
git clone https://github.com/irenema2018/Ticket-Viewer.git
```

2. Move into the app directory

```
cd Ticket-Viewer
```

3. Run the command as below:

```
bundle exec ruby main.rb
```
The command will install everything found in Gemfile.lock and run the file main.rb for you. Once the web server is started, open a browser such as Chrome and go to http://localhost:4567/

## Usage
1. On the home page, enter your Zendesk account information: Zendesk Account Name (subdomain), Email and Password. 
2. Click on the *Get Tickets* button and it will lead you to the tickets page.
3. Each tickets page displays 25 tickets showing 6 fields: ID, Subject, Status, Type, Requester and Assignee. 
4. You can use the *Prev* and *Next* buttons to access more pages.
5. The first page does not show the *Prev* button and the last page does not show the *Next* button. 
6. Click on a ticket in the list to go to the individual ticket view.
7. Use the *Home* link at the top of the pages to go back to home and try a different Zendesk account.

## Error handling
1. The three input boxes on the home page are designed as required fields.
2. If the Zendesk API is unavailable, the app will display a friendly message.
3. All errors will be redirected to the error page.

## Testing
In Terminal, run the command as below:
```
ruby main_test.rb
```
Please note - You'll need a valid Zendesk account in order to run the tests.

## Things that can be improved
1. In main.rb, the controllers have code repetition that can be moved into a function.
2. Tried very hard not to have my password visible in the code. Users are asked to enter their Zendesk account details. The same information is also required when running the tests. However, tests should be automatic and not require user input. There may be better ways of dealing with this problem, such as storing passwords in ENV or have a proper login/logout feature added.
3. Http is used but should really be using https to make the app more secure.
4. The routes `/tickets/next_page` and `/tickets/prev_page` can be changed to `/tickets/:page_id` in order to reduce redundant code.

## References
Below are the list of online resources used for building the app:

**Ruby**

[Usage of integers as hash keys](https://stackoverflow.com/questions/7694317/usage-of-integers-as-hash-keys)

[How Rails Sessions Work](https://www.justinweiss.com/articles/how-rails-sessions-work/)

[SINATRA::RELOADER](http://sinatrarb.com/contrib/reloader)

**API**

[https://developer.zendesk.com/rest_api/docs/support/tickets#list-tickets](https://developer.zendesk.com/rest_api/docs/support/tickets#list-tickets)

[https://developer.zendesk.com/rest_api/docs/support/tickets#show-ticket](https://developer.zendesk.com/rest_api/docs/support/tickets#show-ticket)

[https://developer.zendesk.com/rest_api/docs/support/introduction#pagination](https://developer.zendesk.com/rest_api/docs/support/introduction#pagination)

[https://developer.zendesk.com/rest_api/docs/support/side_loading](https://developer.zendesk.com/rest_api/docs/support/side_loading)

[https://github.com/jnunemaker/httparty](https://github.com/jnunemaker/httparty)

**Sinatra Testing**

[TESTING SINATRA WITH RACK::TEST](http://sinatrarb.com/testing.html)

[Minitest](http://recipes.sinatrarb.com/p/testing/minitest?)

[How to hide password input from terminal in ruby script](https://stackoverflow.com/questions/2338889/how-to-hide-password-input-from-terminal-in-ruby-script)
