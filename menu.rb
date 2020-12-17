require ('tty-prompt')
require_relative ('./sticker-price.rb')
require_relative ('stock-picker.rb')
require_relative ('debt.rb')
prompt = TTY::Prompt.new

# Get ticker code and validate length

while true
    ticker = ""
    if ARGV.length > 0 && ARGV[0].length == 3
        ticker = ARGV[0].upcase
        ARGV.shift
    else 
        while ticker.length != 3
            ARGV.clear
            puts "Enter ticker code: "
            ticker = gets.chomp.upcase
        end
    end
    # Check that company exists on the ASX
    begin 
        query = "https://public-api.quickfs.net/v1/data/#{ticker}:AU/name?period=FY&api_key=e402e5e80284839d46c702e520e64add610df30d"
        response = HTTParty.get(query)
        info = JSON.parse response.to_s
        name = info["data"]
    rescue 
        puts "It appears there was an error connecting to the QuickFS API. Please check your internet connection and try again."
        exit
    end
    
    if name[0].match(/UnsupportedCompanyError/)
        puts "It appears that company does not exist on the ASX, please try again."
    else
        break
    end
end
# Check for optional argument
if ARGV[0] == "-d"
    system "clear"
    puts "Financial report for #{name}"
    puts print_table(ticker)
    puts
    puts debt_levels(ticker)
    puts
    puts sticker_price(ticker)
    exit 
else
    ARGV.clear
end

menu = ["financials", "Look at debt/cash flow", "Calculate sticker & MOS price","Print company report", "Exit"]
while true
    system "clear"
    input = prompt.select("Analysing #{name}", menu)
    
    case input
    when "financials"
        system "clear"
        puts "Printing financials table..."
        @table = print_table(ticker)
        puts @table
        print "press ENTER key to continue"
        gets
    when "Look at debt/cash flow"
        system "clear"
        @debt = debt_levels(ticker)
        puts @debt
        print "press ENTER key to continue"
        gets
    when "Calculate sticker & MOS price"
        system "clear"
        @prices = sticker_price(ticker)
        puts @prices
        puts
        print "press ENTER key to continue"
        gets
    when "Print company report"
        system "clear"
        puts "Financial report for #{name}"
        puts @table
        puts @debt
        puts
        puts @prices
        puts
        puts "press ENTER key to continue"
        gets
    when "Exit"
        break
    end
end
puts "Exiting program..."