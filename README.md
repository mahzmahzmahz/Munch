# Munch
> Find what's cookin in your neighborhood!

> Developed by Alex Marz and Elvis Landi

Ever wonder what new and exciting restaurants are in your neighborhood? Do you live in New York City? Well then we've got what you need. Munch is a CLI (Command Line Interface) application that generates a restaurant suggestion for the user unique to their location, desired price range, and cuisine of preference. 

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

 - [4. Expansion Goals](#4-expansion-goals)

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
    
At first glance our ERD seems extensive, however much of this can be simplified and navigated around through the use of our API (Application Programming Interface), which we will discuss.


### 3.1 User

Within our User model you will find helper methods that assisted our app from within the CLI.rb model. These helper methods allowed the app to destroy and create features specific to the User. 

For example, the following User class method is called on within the CLI model to destroy an User's account.

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

The Geocoder gem is a marvel that will be heavily featured in an upcoming blog post written by Alex Marz, Co-Founder of Munch. 

Essentially, this gem has the ability to take in a location (Queens, The Statue of Liberty, 1600 Pennsylvania Ave) and deliver to you the exact longitude and latitude of said location. 
```
  def self.geocode(location)
        place = Geocoder.search(location).first.coordinates
        latitude = place[0]
        longitude = place[1]
        return {lat: latitude, lon: longitude} 
    end
```
The code above is a class method simply performing ONE OF the capabilities of Geocoder and displaying its explicit results. In the Munch app, the argument of location is filled by the User's selection of one of the five boroughs of NYC. The longitude and latitude are then returned. 

These longitudes and latitudes are then plugged into the Zomato API, which we will discuss in the following section.


### 3.5 Zomato API

The single most important element of our entire app this little beauty right here. It provided us with the data needed to make our app functional. 

```
response =  RestClient.get "https://developers.zomato.com/api/v2.1/search?count=20&lat=#{user_lat}&lon=#{user_lon}&radius=3500&sort=real_distance",
            {content_type: :json, accept: :json, "user-key": "APIKEY"}
```
These 6 lines of code are responsible for providing us with all the restaurant information within the confines of New York City (for now).

```
count=20
```
The count reflects the maximum ammount of restaurant information we were allowed to gather the Zomato API. This info was then iterated over and over to pull out our specific data.

```
lat=#{user_lat}&lon=#{user_lon}
```
This, together with our Geocoder Gem, allowed us to specify the exact location (Queens, Brooklyn, Staten Island, etc..) and return restaurants from ONLY these specific areas. 


```
radius=3500
```
By setting a radius of 3500 meters, we are able to seach for restaurants over a large area, while still remaining within the User-specified borough. 

```
sort=real_distance
```

After several failed attempts, and an increase of knowledge of the restaurants within the Mount Gambier area of Australia, we were able to consistently return results within the five boroughs thanks to this.


### 3.6 CLI

The CLI (Command Line Interface) model is the bread, butter, toaster, kitchen, and house of our app. Within it lies a series of sophisticated class methods that call upon each other, guiding the User through features that Munch offers. 



```
@restaurant = CLI.api_restaurants(user_location, user_price_point, 
cuisine_choice)
```

This...single line of code means more to us than most people we know...


## Expansion Goals

As we hinted above the Zomato Api is not limited to NYC.
In fact with just a few modifications we could make this app function on a global scale by changing the longitude and latitude. 

The api also provides us with the restaurants menu, delivery ability, available reservations, and so much more. 
Over time it would be possible to make Munch the next UberEats and Yelp all in one.










