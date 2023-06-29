require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.add_formatter("RSpecJUnitFormatter", "test1_report.xml")
end

RSpec.describe "Testes de Adicionar Cliente", type: :feature do
  it "Adicionar um cliente com entradas válidas" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Customer")

    click_link "Add Customer"

    find(:css, '.\32u:nth-child(1) > label').click

    fill_in "FirstName", with: "Alvaro"
    fill_in "LastName", with: "Santos"
    fill_in "Email", with: "gostodeminecraft@gmail.com"
    fill_in "Enter your address", with: "r  vicente carlos santiago 1661 bloco 1 703"
    fill_in "Mobile Number", with: "85998432870"

    click_button "Submit"
  end

  it "Adicionar um cliente sem preencher o campo FirstName e LastName" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Customer")

    click_link "Add Customer"

    find(:css, '.\32u:nth-child(1) > label').click

    fill_in "Email", with: "gostodeminecraft@gmail.com"
    fill_in "Enter your address", with: "r  vicente carlos santiago 1661 bloco 1 703"
    fill_in "Mobile Number", with: "85998432870"

    click_button "Submit"

    alert = page.driver.browser.switch_to.alert
    expect(alert.text).to eq("please fill all fields")
    alert.accept
  end
  it "Adicionar um cliente sem preencher nenhum campo" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Customer")

    click_link "Add Customer"

    find(:css, '.\32u:nth-child(1) > label').click

    click_button "Submit"

    alert = page.driver.browser.switch_to.alert
    expect(alert.text).to eq("please fill all fields")
    alert.accept
  end

  it "Resetar o formulário de cadastro" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Customer")

    click_link "Add Customer"

    find(:css, '.\32u:nth-child(1) > label').click

    initial_values = {
      "FirstName" => find_field("FirstName").value,
      "LastName" => find_field("LastName").value,
      "Email" => find_field("Email").value,
      "Enter your address" => find_field("Enter your address").value,
      "Mobile Number" => find_field("Mobile Number").value,
    }

    fill_in "FirstName", with: "Alvaro"
    fill_in "LastName", with: "Santos"
    fill_in "Email", with: "gostodeminecraft@gmail.com"
    fill_in "Enter your address", with: "r  vicente carlos santiago 1661 bloco 1 703"
    fill_in "Mobile Number", with: "85998432870"

    click_button "Reset"

    expect(find_field("FirstName").value).to eq(initial_values["FirstName"])
    expect(find_field("LastName").value).to eq(initial_values["LastName"])
    expect(find_field("Email").value).to eq(initial_values["Email"])
    expect(find_field("Enter your address").value).to eq(initial_values["Enter your address"])
    expect(find_field("Mobile Number").value).to eq(initial_values["Mobile Number"])

    click_button "Submit"

    puts "O formulário foi resetado com sucesso."
  end
end
