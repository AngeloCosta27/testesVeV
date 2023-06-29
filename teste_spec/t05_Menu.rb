require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.add_formatter("RSpecJUnitFormatter", "test5_report.xml")
end

RSpec.describe "Testes de Menu Telecom", type: :feature do
  it "Testar menu e Addcostumer" do
    visit "https://demo.guru99.com/telecom/index.html"
    find('a[href="#menu"]').click
    all('a[href="billing.php"]', match: :first, count: 2)[1].click
  end

  it "Testar menu e Add Tariff Plans" do
    visit "https://demo.guru99.com/telecom/index.html"
    find('a[href="#menu"]').click
    all('a[href="addtariffplans.php"]', match: :first, count: 2)[1].click
  end

  it "Testar menu e Add Tariff Plans to Customer" do
    visit "https://demo.guru99.com/telecom/index.html"
    find('a[href="#menu"]').click
    all('a[href="assigntariffplantocustomer.php"]', match: :first, count: 2)[1].click
  end

  it "Testar menu e Billing" do
    visit "https://demo.guru99.com/telecom/index.html"
    find('a[href="#menu"]').click
    all('a[href="billing.php"]', match: :first, count: 2)[1].click
  end

  it "Testar o X" do
    visit "https://demo.guru99.com/telecom/index.html"
    find('a[href="#menu"]').click
    find("a.close").click
  end
end
