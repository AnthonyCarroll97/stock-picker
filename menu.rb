require ('tty-prompt')
require_relative ('./sticker-price.rb')
require_relative ('stock-picker.rb')
prompt = TTY::Prompt.new
menu = ["financials", "Look at debt/cash flow", "Calculate sticker & MOS price","Print company report", "Exit"]
# Get ticker code and validate

if ARGV.length > 0
    if ARGV[0].length == 3
        ticker = ARGV[0].upcase
    else
        puts "Invalid ticker code passed as argument"
        print "Enter ticker code: "
        ticker = gets.chomp.upcase
    end
else 
    print "Enter ticker code: "
    ticker = gets.chomp.upcase
end

while true
    input = prompt.select("Analysing #{ticker}", menu)
    case input
    when "financials"
        system "clear"
        @table = print_table(ticker)
        puts @table
        print "press ENTER key to continue"
        gets
    when "Look at debt/cash flow"
        system "clear"
        puts "under construction"
        print "press ENTER key to continue"
        gets
    when "Calculate sticker & MOS price"
        system "clear"
        @prices = sticker_price(ticker)
        puts @prices
        print "press ENTER key to continue"
        gets
    when "Print company report"
        system "clear"
        puts "printing company report..."
        puts @table
        puts 
        puts @prices
        puts "press ENTER key to continue"
        gets
    when "Exit"
        break
    end
end
puts "Exiting program..."