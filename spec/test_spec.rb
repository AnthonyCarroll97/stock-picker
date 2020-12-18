require ('rspec')
require_relative ('../stock-picker.rb')
require_relative ('../debt.rb')


describe 'Print_table' do
    it "should return something" do
        expect(print_table("BHP")).to be_truthy
    end
    it "should return a String" do
        expect(print_table("BHP")).to be_an_instance_of(String)
    end
end

describe 'Debt_levels' do
    it "should return something" do
        expect(debt_levels("BHP")).to be_truthy
    end
    it "should return a string" do
        expect(debt_levels("BHP")).to be_an_instance_of(String)
    end
end