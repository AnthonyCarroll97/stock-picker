require ('tty-prompt')
require_relative ('./sticker-price.rb')
require_relative ('stock-picker.rb')
require_relative ('debt.rb')
prompt = TTY::Prompt.new

# Get ticker code and validate
ticker = ""
while ticker.length != 3
    if ARGV.length > 0 && ARGV[0].length == 3
        ticker = ARGV[0].upcase
    else 
        ARGV.clear
        puts "Enter ticker code: "
        ticker = gets.chomp.upcase
    end
end
# Check for optional argument
if ARGV[1] == "-d"
    system "clear"
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
    input = prompt.select("Analysing #{ticker}", menu)
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
        print "press ENTER key to continue"
        gets
    when "Print company report"
        system "clear"
        puts "printing company report..."
        puts @table
        puts 
        puts @debt
        puts
        puts @prices
        puts "press ENTER key to continue"
        gets
    when "Exit"
        break
    end
end
puts "Exiting program..."