require ('httparty')
# require_relative ('./stock-picker.rb')    
i = 1
sticker_financials = ["eps_basic?period=FY", "total_equity?period=FY-9:FY", "price_to_earnings?period=FY-9:FY"]
sticker_financials.each do |financial|
    
    query = "https://public-api.quickfs.net/v1/data/FMG:AU/#{financial}&api_key=e402e5e80284839d46c702e520e64add610df30d"
    response = HTTParty.get(query)
    # Parse JSON response and convert into array
    info = JSON.parse response.to_s
    arr = info["data"]
    case i
    when 1
        @ttm_eps = arr
        puts @ttm_eps
    when 2
        @growth_rate = ((arr.last.to_f / arr.first.to_f) ** ( 1/10.0)) - 1
        @growth_rate = (@growth_rate * 100).round(2)
        puts @growth_rate
    when 3
        @pe_ratio = ((arr.sum) / 10).round(2)
        puts @pe_ratio
    end
    i += 1
end


# I need the following
# EPS for the past financial year 2.24
# total equity growth rate for the past however many years 23.88
# average PE ratio for the past 10 years 9.28
# "eps_basic?period=FY", "total_equity?period=FY-9:FY", "price_to_earnings?period=FY-9:FY",
# ttm_eps = 2.24
# growth_rate = 0.24
# pe_ratio = 9.28

future_eps = @ttm_eps * ((1 + @growth_rate) ** 10)
puts future_eps
future_price = future_eps * @pe_ratio
puts future_price
puts "The sticker price is #{future_price / 4}"
puts "The MOS price is #{future_price / 8}"