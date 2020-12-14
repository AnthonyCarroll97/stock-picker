require ('httparty')
require ('colorize')
require ('tty-table')

def growth(present, past, n, financial)
    if past == 0
        rate = " - "
    else 
        # Calculate rate of growth
        rate = ((present.to_f / past.to_f) ** ( 1/n.to_f )) - 1
        rate = (rate * 100).round(2)

        # colour the growth rate
        if rate < 0
            rate = "#{rate}%".red
        elsif rate > 10
            rate = "#{rate}%".green
        else 
            rate = "#{rate}%"
        end
    end    
    # send to respective array
    case financial
    when "revenue"
        @revenue << rate
    when "total_equity"
        @total_equity << rate
    when "roic"
        @roic << rate
    when "fcf"
        @fcf << rate
    when "eps_basic"
        @eps_basic << rate
    end
end

def print_table(ticker)
#initialize table and results arrays
@table = TTY::Table.new(["Financial", "10-year", "5-year", "3-year"], [])
@revenue = ["Revenue"]
@total_equity = ["Equity"]
@roic = ["ROIC"]
@fcf = ["Free Cash Flow"]
@eps_basic = ["EPS"]

# List of financial metrics to be analysed
financials = ["revenue", "total_equity", "roic", "fcf", "eps_basic"]

financials.each do |financial|
    # Prepare query with variables
    begin
        query = "https://public-api.quickfs.net/v1/data/#{ticker}:AU/#{financial}?period=FY-9:FY&api_key=e402e5e80284839d46c702e520e64add610df30d"
        response = HTTParty.get(query)
        # Parse JSON response and convert into array
        info = JSON.parse response.to_s
        arr = info["data"]
    rescue 
        puts "error!"
    end
    #send data to growth method
    growth(arr.last, arr.first, 10, financial)
    growth(arr.last, arr[5], 5, financial)
    growth(arr.last, arr[7], 3, financial)
end
# populate table
@table << @revenue
@table << @total_equity 
@table << @roic
@table << @fcf
@table << @eps_basic
# output table
return @table.render(:unicode)

end