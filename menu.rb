require ('tty-prompt')
prompt = TTY::Prompt.new
menu = [{name: "Financials", disabled: ""}, "Look at debt/equity", "Calculate sticker price","Print company report", "Exit"]

while true
    prompt.select("Select an option", menu, echo: false)
end