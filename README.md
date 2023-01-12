# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
create db "testtask" manually
* Database initialization
sudo docker exec -it positrace-geo_api_1 bash
rails db:migrate

localhost:49156
user root
password:

Bugfix Error from emoji:
ALTER TABLE geolocations  
  CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
MODIFY location_data VARCHAR(2500)
    CHARACTER SET utf8mb4 COLLATE utf8mb4_bin

* How to run 
sudo docker-compose up --build

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
#Service provider https://ipstack.com/
config: config/local_env.yml

* Deployment instructions

* ...

