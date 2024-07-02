# README

## Prerequisites
- Docker & docker-compose need to be installed.

## Starting the application
- Make sure that there are no existing processes using the ports `3000, 5432 & 6379`.
- To start the application, run `docker-compose up --build`.

## Improvements
- Add test cases
- Better UI/UX for the form
- Use stimulus controllers and add validations
- Exception handling

## Scalability
- Use load balancing.
- For security, CSRF token would be validated when form is submitted.
- Whenever there is DB operations, ensure SQL injection prevention is handled.
- Add measures to safeguard against cross side scripting.
