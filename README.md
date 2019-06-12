# Ticket-Viewer

## Introduction
This app uses sinatra in Ruby to view tickets from API calls. You can use your own Zendesk email and password to access the app. The look and feel is frienldy by using Zendesk fonts and color.

## Installation instructions
For the first time, run the command in terminal as below 
```
bundle exec ruby main.rb
```

The command will install everything in Gemfile.lock and run the file main.rb for you. Go to your browser and a tab has opened for you.
### describe gemfile later

## Usage instructions
1. Go to the tab and you will see the index page. 
2. Type your own information into 3 input boxes, Zendesk Account Name, Email and Password. After clicking the Get Tickets 
   button, it will lead you to the tickets page.
3. Each tickets page displays 25 tickets with 6 titles that are ID, Subject, Status, Type, Requester and Assignee. 
   Clicking the Next or the Prev button can access to the next page or the previous page. 
   The first page has no Prev button and the last page has no Next button. 
   The contents of each ticket is designed as links. It will lead you to the page of an individual ticket.
4. On the page of an individual ticket, it displays more details about the ticket.
5. There is a Home link at the top of all the pages and it can access to the index / log in page.

## Error handling

1. Three input boxes are desiged as required fields.
2. When API is unavailable, it will lead to the error page with a friendly message.
3. 

## Testing
In terminal, use the command as below. It will run the test automatically. 
```
ruby main_test.rb
```
code ~/.bash_profile  store password in ENV

## Things can be improved
1. In main.rb, the controllers of the tickets list and the individual ticket have repetition.


## References
