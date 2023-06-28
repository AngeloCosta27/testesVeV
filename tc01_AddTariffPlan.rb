require "capybara/rspec"
require "selenium/webdriver"

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium 

RSpec.describe "Teste de preenchimento de campo", type: :feature do 
    it "Preencher os campos corretamente" do
        visit "https://demo.guru99.com/telecom/index.html"
        expect(page).to have_content("Add Tariff Plan")

        click_link "Add Tariff Plan"

        fill_in "Montly Rental", with: "99"
        fill_in "Free Local Minutes", with: "8"
        fill_in "Free International Minutes", with: "8"
        fill_in "Free SMS Pack", with: "99"
        fill_in "Local Per Minute Charges", with: "8"
        fill_in "Inter. Per Minute Charges", with: "8"
        fill_in "SMS Per Charges", with: "99"
        
        click_button "Submit"

        expect(page).to have_content("Congratulation you add Tariff Plan")
        click_button "Home"
    end
end