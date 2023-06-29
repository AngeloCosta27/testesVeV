require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.add_formatter("RSpecJUnitFormatter", "test_report.xml")
end

RSpec.describe "Teste de Adicionar Plano Personalizado para um cliente", type: :feature do
  it "Adicionar um cliente com entradas válidas" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan to Customer")
    click_link "Add Tariff Plan to Customer"

    fill_in "Enter Your Customer ID", with: "384242"

    click_button "submit"

    testei tudo e não consegui achar esse checkbox
    find("input[type='checkbox'] + label, input[type='radio'] + label").click
  end

  it "Confirmar adoção do plano sem seleção de planos." do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan to Customer")
    click_link "Add Tariff Plan to Customer"

    fill_in "Enter Your Customer ID", with: "384242"

    click_button "submit"
    expect(page).to have_content("Add Tariff Plan to Customer")
    click_button "submit"
  end

  it "Teste de reação do sistema a input incompleto de ID." do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan to Customer")
    click_link "Add Tariff Plan to Customer"

    fill_in "Enter Your Customer ID", with: "3842"
    click_button "submit"
    if page.has_content?("Please Input Your Correct Customer ID")
      puts "Teste passou."
      click_button "submit"
    else
      fail "Teste falhou."
    end
  end

  it "Teste de reação do sistema a input incompleto de ID." do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan to Customer")
    click_link "Add Tariff Plan to Customer"
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
