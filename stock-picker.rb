require ('httparty')
require ('colorize')
require ('tty-table')

def growth(present, past, n, financial)
    if past == 0
        rate = " - "
    else 
    #     # Calculate rate of growth
        rate = (present / past.to_f).round(2) ** ( 1.0/n)
        if rate.class == Complex
            rate = rate.abs
        end 
        rate -= 1
        rate = (rate * 100).round(2) 


        # puts financial
        # a = present/past.to_f
        # puts "a #{a}" 
        # b = a.round(2)
        # puts "b #{b}"  
        # c = 1.0/n 
        # puts "c #{c}"
        # d = b ** c 
        # puts "d #{d}" 
        # if d.class == Complex
        #     d = d.abs
        # end
        # e = d - 1
        # puts "e #{e}"
        
        # puts present
        # puts past
        # # puts "rate: #{rate}"
        # rate = e 
        # rate = (rate * 100).round(2)

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
        return "It appears there was an error connecting to the QuickFS API. Please check your internet connection and try again."
    end
    #send data to growth method
    growth(arr.last, arr.first, 9, financial)
    growth(arr.last, arr[5], 4, financial)
    growth(arr.last, arr[7], 2, financial)
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