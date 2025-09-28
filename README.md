# README

## About this project

This project is the Front-end and should be work together with [ContactList](https://github.com/marcelotoledo5000/ContactList).

It is just a simple website, that running in Sinatra application and consists of used to navigate and to create a new contact via POST, using the REST API. Generating Data Tracking and sending some information to another project (ContactList).

## Technical Informations and dependencies

```code
- Docker            - version 20.10+
- Docker Compose    - version 2.0+
- The Ruby language - version 2.7.5
- Sinatra           - version 2.2+
- Puma              - version 5.6+
```

## To use with Docker

Clone the project and prepare to use:

```Shell
git clone git@github.com:marcelotoledo5000/sample_tracking.git
cd sample_tracking
script/setup
```

### To run app

To check that application runs properly by entering the command:

```Shell
script/server
```

To see the application in action, open a browser window and navigate to <http://localhost:4567>.

## Development

### Local Development (without Docker)

1. Install Ruby 2.7.5 using asdf
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Run the application:
   ```bash
   bundle exec rackup
   ```

### Environment Variables

The application can be configured using environment variables:

- `PORT`: Port to run the application (default: 4567)
- `HOST`: Host to bind the application (default: 0.0.0.0)

#### Template Credits

Used template HTML from html5up.net | @ajlkn

-   Template: Dimension by HTML5 UP
-   [Credits.txt](Credits.txt)
