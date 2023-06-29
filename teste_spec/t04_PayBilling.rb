require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.add_formatter("RSpecJUnitFormatter", "test4_report.xml")
end

RSpec.describe "Testes de Pagamento de Dependencias", type: :feature do
  it "Adicionar um cliente com entradas válidas" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Pay Billing")

    click_link "Pay Billing"

    fill_in "Enter Your Customer ID", with: "384242"
    click_button "submit"
  end

  it "Adicionar um cliente com entradas válidas" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Pay Billing")

    click_link "Pay Billing"

    click_button "submit"

    alert = page.driver.browser.switch_to.alert
    if alert.text == "Please Correct Value Input"
      alert.accept
      puts "Teste passou."
    else
      fail "Teste falhou."
    end
  end
end
