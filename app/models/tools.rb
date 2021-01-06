class Tools < ActiveRecord::Base
    response = RestClient.get('https://developers.zomato.com/api/v2.1/geocode?lat=40.7498243&lon=-73.7976337
    ')
    def zomato_url
        'https://developers.zomato.com/api/v2.1/geocode?lat=40.7498243&lon=-73.7976337'
    end

    
