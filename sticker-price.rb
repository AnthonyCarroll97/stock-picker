require ('httparty')
    
def sticker_price(ticker)
i = 1
sticker_financials = ["eps_basic?period=FY", "total_equity?period=FY-9:FY", "price_to_earnings?period=FY-9:FY"]
sticker_financials.each do |financial|
    begin
        query = "https://public-api.quickfs.net/v1/data/#{ticker}:AU/#{financial}&api_key=e402e5e80284839d46c702e520e64add610df30d"
        response = HTTParty.get(query)
        # Parse JSON response and convert into array
        info = JSON.parse response.to_s
        arr = info["data"]
    rescue 
        return "Error! couldn't connect to QuickFS API"
    end
    
    case i
    when 1
        @ttm_eps = arr[0]
    when 2
        @growth_rate = ((arr.last.to_f / arr.first.to_f) ** ( 1/10.0)) - 1
        @growth_rate = @growth_rate.round(2)
    when 3
        @pe_ratio = ((arr.sum) / 10).round(2)
    end
    i += 1
end

future_eps = @ttm_eps * ((1 + @growth_rate) ** 10)
future_price = future_eps * @pe_ratio

return "The future EPS will be $#{future_eps.round(2)}\nThe future share price will be $#{future_price.round(2)}\nThe sticker price is $#{(future_price / 4).round(2)}\nThe MOS price is $#{(future_price / 8).round(2)}"
end

