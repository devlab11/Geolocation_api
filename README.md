# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version  

    "3.1.2"

* Database creation  
 ```
   mysql -u root -p  
   CREATE DATABASE testtask;
 ```
* Database initialization
 ```
    sudo docker exec -it geo-api_api_1 bash 
    rails db:migrate
```

Bugfix Error from emoji:
```
    ALTER TABLE geolocations
    CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
    MODIFY location_data VARCHAR(2500)
    CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
```
* How to run  
```
    sudo docker-compose up --build
```
* How to run the test suite
```
    sudo docker exec -it geo-api_api_1 bash 
    rspec
```
* Services 

    Service provider https://ipstack.com/

    > config: config/local_env.yml

* Documentation API

 > https://docs.google.com/document/d/1Xu5nefc9yWNR7VaqCarjgV42-Yr7psVn4iuYxBMn6IE/edit?usp=sharing

