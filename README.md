d# Intial Setup

    docker-compose build
    docker-compose run short-app rails db:setup && rails db:migrate

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc

# Algorithm to generate short code

- We use SHA2 with Base 64 Digest to encode the URL
- We add salt to URL before encoding to ensure duplicate URLs are treated separately and for security reasons.
- Take first 8 chars in URL to form short code
- Validate if URL already exists in DB (DB Index also handles this case)
