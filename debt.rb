require ('httparty')

def debt_levels(ticker)
    debt_financials = ["lt_debt", "fcf"]
    debt_financials.each do |financial|
        query = "https://public-api.quickfs.net/v1/data/#{ticker}:AU/#{financial}?period=FY&api_key=e402e5e80284839d46c702e520e64add610df30d"
        response = HTTParty.get(query)
        # Parse JSON response and convert into array
        info = JSON.parse response.to_s
        arr = info["data"]
        case financial 
        when "lt_debt"
            @lt_debt = arr[0]
        when "fcf"
            @fcf = arr[0]
        end
    end
    years = @lt_debt.to_f / @fcf.to_f

    return "#{ticker} can pay off their long term debt in #{years.round(1)} years."
end 

puts debt_levels('FMG')
