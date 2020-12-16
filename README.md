## Develop a statement of purpose and scope for your application

### What will the app do?
The app will analyse a company based on the Rule #1 method. This method of company analysis was developed by a man named Phil Town, and codified in his book "Rule #1 Investing". It will present to the user a menu, from which they can select one of 5 options. 

### Identify the problem it will solve and explain why you are developing it
Analysing a companies financial statements is a complex and time-consuming process. Even after you have found the right data you still need to perform a number of math operations to adhere to the Rule #1 method of analysis. This program will automate both of these tasks, requiring only the companies ticker code from the user.

### Identify the target audience
The target audience for this application is investors who are aware of the Rule #1 method of stock analysis and who are tired of searching through financial statements for the relevant data and manually performing the required calculations. The app is not designed for people who are new to investing or who have no knowledge of finance or business.

### Explain how a member of the target audience will use it
The user only needs to enter one value, the ticker code for the company that they are going to analyse. After they have entered the code, they will be taken to a multi-choice menu where they can select which of the applications features they would like to use. After they have finished with their analysis, they can select "exit" from the main menu to stop the program.

## Feature list
- The first feature will be an analysis of five items on the company's financial statements. The program will use the QuickFS API to collect the 10, 5 and 3 year data for the following: Revenue, Equity, Earnings per Share, Free Cash Flow and Return on Invested Capital. It will then calculate the 10, 5 and 3 year growth rates for each of those financial metrics, colour them according to their value and print the results in a formatted table.

- Feature 2 will use the QuickFS API to collect the company's long term debt, and free cash flow for the past 12 months. It will calculate how long it will take the company to pay off it's long term debt with the current level of free cash flow. The results will be printed out to the user in the form of a sentence. Their will be specialied outputs for when the company has posted negative free cash flow, or for when the company is carrying no long term debt.

- Feature 3 will again use the QuickFS API and gather the following data: EPS for the previous year, equity for the past 10 years and profit/earnings ratio for the past 10 years. It will use these numbers to calculate the future (10 year) EPS and using the average profit/earnings ratio, will calculate a future stock price. Then, based on a 15% annual rate of return (The rate that Phil Town requires) it will asses what the stock should be bought at now (sticker price) to acheive this rate of return and future stock price. Lasty the program will halve this value to reach what Phil town calls the "Margin of safety price". All of these values will be printed out to the user.

- The final feature is listed on the menu as 'print company report' This will re-print the output off any previous feature that the user has selected.

## Outline of user interaction and experience
If the user has not entered a company code as a command line argument, they will be prompted to do so by the program. Once they have entered a company code and it has been validated, they will be presented with the main application menu. This menu is where the user can select and use all of the features in the app. The menu has instructions for how to navigate and select a feature printed near the company name.

There are a number of verification methods in place to ensure that the user enters a valid company code and that the code matches up to an existing company on the ASX. Once the user has entered a valid code, an API call will be made to fetch the full name of the company. This call, along with gathering useful data, acts as a form of verification. If there is no company that matches that code, the user will be informed with a message that their code is invalid and prompted to enter another company code. 

Error handling has also been implemented around each API call in the application. This ensures that if the user is not connected to the internet or there is a problem with the API, the user will be presented with a clean and gracefull message asking them to check their internet connection and try again.