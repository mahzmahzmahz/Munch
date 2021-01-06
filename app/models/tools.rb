 require 'json'
 require 'rest-client'
#  require 'rubygems'
#  require 'zomato'
 #require 'romato'

class Tools 
#     response = RestClient.get("https://developers.zomato.com/api/v2.1/cities?q=]} {user-key: 285cd5fbd4736f1cfef4d09c58ef09b4})
# RestClient.get(url, headers={})
    # def zomato_url
    #     'https://developers.zomato.com/api/v2.1/geocode?lat=40.7498243&lon=-73.7976337'
    # end

    response =  RestClient.get "https://developers.zomato.com/api/v2.1/search?count=5&lat=40.7498243&lon=-73.7976337",
    {content_type: :json, accept: :json, "user-key": "285cd5fbd4736f1cfef4d09c58ef09b4"}
    # response.parse 

    parsed = JSON.parse(response)
    puts parsed["restaurants"][0]["restaurant"]["location"]["locality"]




end




# response =  RestClient.get "https://developers.zomato.com/api/v2.1/cities?q=#{params["city"]}",
#     {content_type: :json, accept: :json, "user-key": ENV["API_KEY"]}