require ('tty-prompt')
require_relative ('./sticker-price.rb')
require_relative ('stock-picker.rb')
prompt = TTY::Prompt.new
menu = ["financials", "Look at debt/equity", "Calculate sticker price","Print company report", "Exit"]
# Get ticker code and validate
ticker = ""
    if ARGV.length > 0 && ARGV[0].length == 3
        ticker = ARGV[0].upcase
    else 
        while ticker.length != 3
        puts "invalid code"
        print "Enter ticker code: "
        ticker = gets.chomp.upcase
        end
    end


while true
    input = prompt.select("Analysing #{ticker}", menu)
    case input
    when "financials"
        system "clear"
        @table = print_table(ticker)
        puts @table
        print "press ENTER key to continue"
        a = gets
    when "Look at debt/equity"
        system "clear"
        puts "under construction"
        print "press ENTER key to continue"
        
    when "Calculate sticker price"
        system "clear"
        @prices = sticker_price(ticker)
        puts @prices
        print "press ENTER key to continue"
        
    when "Print company report"
        system "clear"
        puts "printing company report..."
        puts @table
        puts 
        puts @prices
        puts "press ENTER key to continue"
        
    when "Exit"
        break
    end
end
puts "Exiting program..."