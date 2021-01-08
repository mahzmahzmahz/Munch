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
     - [3.5 Zomato API](#35-Zomato-API)
     - [3.6 CLI](#36-CLI)

## 1. Associations 
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

## 2. ERD

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

## 3. Functionality
    
At first glance our ERD seems extensive, however much of this can be simplified and navigated around through the use of our API (Application Programming Interface), which we will discuss further ahead.


### 3.1 User

Within our User model you will find helper methods that assisted our app from within the CLI.rb model. These helper methods allowed the app to destroy and create features specific to the User. 

The following method is used to destroy an entire account.

e.g..,
```
    def remove_profile
        self.destroy
    end
```

### 3.2 Restaurant

This model was created for the purpose of holding our restaurant data in our application. 

### 3.3 UserRestaurant

This model helped connect the User and Restaurant models together within our application. 

### 3.4 Geocoder 




### 3.5 Zomato API

The single most important element in our entire app was thanks to the help of this little beauty right here. It provided us with the seed data needed in order for our app to make any sense. 

```
        response =  RestClient.get "https://developers.zomato.com/api/v2.1/search?count=20&lat=#{user_lat}&lon=#{user_lon}&radius=3500&sort=real_distance",
            {content_type: :json, accept: :json, "user-key": "APIKEY"}
        parsed = JSON.parse(response)
```
These 6 lines of code are responsible for providing us with all the restaurant information needed for New York City (for now).

```
count=20
```
The count reflects the maximum ammount of restaurants we were able to feed into our app as allowed by the Zomato API. 

```
lat=#{user_lat}&lon=#{user_lon}
```
This, together with our Geocoder Gem, allowed us to specify the exact location (Queens, Brooklyn, Staten Island, etc..) and return restaurants from these specific areas. 


```
radius=3500
```
By setting a radius of 3500 meters, we are able to seach within each of the five boroughs with a wider range. 

```
sort=real_distance
```

After several failed attempts and an increase of restaurants within the Mount Gambier area of Australia, we were able to consistentally return results within the five boroughs thanks to this.


### 3.6 CLI

The CLI (Command Line Interface) model is the bread and butter, and toaster, and kitchen, and house, of our app. Within lies a series of sophisticated class methods call upon each other guiding the User through features that Munch offers. 



```
@restaurant = CLI.api_restaurants(user_location, user_price_point, 
cuisine_choice)
```

This....single line of code means more to us than most people we know...


### Expansion Goals

As we referenced above the Zomato Api is not limited to NYC.
In fact with just a few modifications we could make this app function on a global scale by changing the longitude and latitude. 

The api also provides us with the restaurants menu, delivery ability, available reservations, and so much more. 
Over time it would be possible to make Munch the next UberEats and Yelp all in one.









