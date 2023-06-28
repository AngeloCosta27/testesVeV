require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium 

Rspec.configure do |config|
    config.add_formatter("RSpecJUnitFormatter", "test_report.xml")
end

RSpec.describe "Teste de preenchimento de campo", type: :feature do 
    it "Preencher os campos corretamente" do
        visit "https://demo.guru99.com/telecom/index.html"
        expect(page).to have_content("Add Tariff Plan")
        click_link "Add Tariff Plan"

        fill_in "Monthly Rental", with: "99"
        fill_in "Free Local Minutes", with: "8"
        fill_in "Free International Minutes", with: "8"
        fill_in "Free SMS Pack", with: "99"
        fill_in "Local Per Minutes Charges", with: "8"
        fill_in "Inter. Per Minutes Charges", with: "8"
        fill_in "SMS Per Charges", with: "99"
        
        click_button "submit"
        click_button "Home"
    end

    it "Preencher os campos obrigatórios com caracteres" do
        visit "https://demo.guru99.com/telecom/index.html"
        expect(page).to have_content("Add Tariff Plan")
        click_link "Add Tariff Plan"

        fill_in "Monthly Rental", with: " Sed adipiscing"
        fill_in "Free Local Minutes", with: "Lorem Ipsum"
        fill_in "Free International Minutes", with: "Morbi in sem"
        fill_in "Free SMS Pack", with: "Pharetra"
        fill_in "Local Per Minutes Charges", with: "ultricies"
        fill_in "Inter. Per Minutes Charges", with: "tristique"
        fill_in "SMS Per Charges", with: "Nami Opser"

        expect(page).to have_content("Characters are not allowed")

        click_button "submit"

        alert = page.driver.browser.switch_to.alert
        expect(alert.text).to eq("please fill all fields Correct Value")
        alert.accept
    end

end