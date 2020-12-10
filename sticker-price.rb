require ('httparty')    
    
    
    query = "https://public-api.quickfs.net/v1/data/FMG:AU/gross_profit_growth?period=FY-9:FY&api_key=e402e5e80284839d46c702e520e64add610df30d"
    response = HTTParty.get(query)
    # Parse JSON response and convert into array
    info = JSON.parse response.to_s
    arr = info["data"]
puts arr