# Welcome to Munch!!

Ever wonder what new and exciting restaurants are around your neighborhood?? Do you live in New York City? Well then we've got what you need. Munch is your basic CLI (Command Line Interface) application that generates a restaurant based on your location, desired price range, and cuisine of preference. 

---

## Table of Contents 
 - [1. Association](#1-Association)
 - [2. ERD](#2-ERD)
 - [3. Functionality](#3-functionality)

     - [3.1 User](#31-User)
     - [3.2 Restaurant](#32-Restaurant)
     - [3.3 UserRestaurant](#33-UserRestaurant)
     - [3.4 Geocoder](#34-Geocoder)
     - [3.5 API](#35-API)
     - [3.6 CLI](#36-CLI)

## Associations 
Munch is a 7-model domain: `User`, `UserRestaurant`, `Restaurant`, `UserStyle`, `Style`, `UserLocation`, `Location`. 
The associations are as follows:
- User has many UserRestaurants and Restaurants through UserRestaurants,
- UserRestaurant belongs to a User and a Restaurant,
- Restaurant has many UserRestaurants and Users through UserRestaurants,
- Restaurant also has many RestaurantStyles and Styles through RestaurantStyle,
- Restaurant also has many RestaurantLocations and Locations through RestaurantLocations,
- RestaurantStyle belongs to Style and a Restaurant,
- Style has many RestaurantStyles and Restaurants through RestaurantStyles,
- RestaurantLocation belongs to Restaurant and Location,
- Location has many RestaurantLocations and Restaurants through RestaurantLocations.

## ERD

```
User
|
^
UserRestaurant
v
|
Restaurant—<RestStyle>—Style
|
^
RestLoc >—Location
```

## Functionality

