require ('tty-prompt')
require_relative ('./sticker-price.rb')
prompt = TTY::Prompt.new
menu = ["financials", "Look at debt/equity", "Calculate sticker price","Print company report", "Exit"]
# Get ticker code and validate
print "Enter ticker code: "
ticker = gets.chomp.upcase

while true
    input = prompt.select("Select an option", menu)
    case input
    when "financials"
        system "clear"
        puts "hello"
        puts "press ENTER key to continue"
        gets
    when "Look at debt/equity"
        system "clear"
        puts "under construction"
        puts "press ENTER key to continue"
        gets
    when "Calculate sticker price"
        system "clear"
        sticker_price(ticker)
        puts "press ENTER key to continue"
        gets
    when "Print company report"
        system "clear"
        puts "under construction"
        puts "press ENTER key to continue"
        gets
    when "Exit"
        break
    end
end
puts "Exiting program..."