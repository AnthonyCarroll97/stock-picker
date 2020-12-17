require ('httparty')
require ('colorize')
    
def sticker_price(ticker)
sticker_financials = ["eps_basic?period=FY", "total_equity?period=FY-9:FY", "price_to_earnings?period=FY-9:FY", "price?period=FY"]
sticker_financials.each do |financial|
    begin
        query = "https://public-api.quickfs.net/v1/data/#{ticker}:AU/#{financial}&api_key=e402e5e80284839d46c702e520e64add610df30d"
        response = HTTParty.get(query)
        # Parse JSON response and convert into array
        info = JSON.parse response.to_s
        arr = info["data"]
    rescue
        return "It appears there was an error connecting to the QuickFS API. Please check your internet connection and try again."
    end 

    case financial
    when "eps_basic?period=FY"
        @ttm_eps = arr[0]
    when "total_equity?period=FY-9:FY"
        if arr[0] == 0
            arr.shift(5)
            @growth_rate = ((arr.last.to_f / arr.first.to_f).round(2) ** ( 1/4.0)) - 1

            else    
            @growth_rate = ((arr.last.to_f / arr.first.to_f).round(2) ** ( 1/9.0)) - 1
        end
    when "price_to_earnings?period=FY-9:FY"
        if arr[0] == 0
            arr.shift(5) 
            @avg_pe = ((arr.sum) / 5).round(2)
            @pe_ratio = "#{@avg_pe} (5 year average)"
        else
            @avg_pe = ((arr.sum) / 10).round(2)
            @pe_ratio = "#{@avg_pe} (10 year average)"
        end
    when "price?period=FY"
        @current_price = arr
    end
end

future_eps = @ttm_eps * ((1 + @growth_rate) ** 10)
future_price = future_eps * @avg_pe
#color current price
if @current_price < (future_price/8)
    @current_price = @current_price.to_s.green
else
    @current_price = @current_price.to_s.red
end
return "Future EPS: $#{future_eps.round(2)}
Future share price: $#{future_price.round(2)}
Sticker price: $#{(future_price / 4).round(2)}
Margin of safety price: $#{(future_price / 8).round(2)}
#{ticker} last closed at $#{@current_price} per share
----------------------------
Results calculated from the following:
TTM EPS: #{@ttm_eps}
Equity growth rate: #{(@growth_rate * 100.0).round(2)}%
Average PE ratio: #{@pe_ratio}"
end



