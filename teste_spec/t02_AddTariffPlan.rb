require "capybara/rspec"
require "selenium/webdriver"
require "rspec_junit_formatter"

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
  config.add_formatter("RSpecJUnitFormatter", "test2_report.xml")
end

RSpec.describe "Teste de Adicionar Plano Personalizado", type: :feature do
  it "Adicionar tarifas corretamente" do
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

    expect(page).to have_content("Congratulation you add Tariff Plan")

    click_link("Home", match: :first, count: 3)
    sleep (5)
  end

  it "Adicionar Tarefas incorretamente(Caracteres)" do
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
  end

  it "Limite de valores inseridos nos campos obrigatórios" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan")
    click_link "Add Tariff Plan"

    fill_in_fields = {
      "Monthly Rental" => "9",
      "Free Local Minutes" => "9",
      "Free International Minutes" => "9",
      "Free SMS Pack" => "9",
      "Local Per Minutes Charges" => "9",
      "Inter. Per Minutes Charges" => "9",
      "SMS Per Charges" => "9",
    }

    max_length = {}

    fill_in_fields.each do |field, value|
      max_length[field] = value
      fill_in field, with: value
      while find_field(field).value.length < find_field(field)["maxlength"].to_i
        value += "9"
        fill_in field, with: value
        max_length[field] = value
      end
    end

    click_button "submit"

    expect(page).to have_content("Congratulation you add Tariff Plan")

    click_link("Home", match: :first, count: 3)
    sleep(5)

    puts "Máximo de caracteres permitidos:"
    max_length.each { |field, max| puts "#{field}: #{max.length}" }
  end

  it "Deixar os campos obrigatórios em branco" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan")
    click_link "Add Tariff Plan"

    click_button "submit"

    alert = page.driver.browser.switch_to.alert
    if alert.text == "please fill all fields Correct Value"
      alert.accept
      puts "Teste passou."
    else
      fail "Teste falhou."
    end
  end

  it "Preencher os espaços com valores negativos" do
    visit "https://demo.guru99.com/telecom/index.html"
    expect(page).to have_content("Add Tariff Plan")
    click_link "Add Tariff Plan"
    initial_values = {
      "Monthly Rental" => find_field("Monthly Rental").value,
      "Free Local Minutes" => find_field("Free Local Minutes").value,
      "Free International Minutes" => find_field("Free International Minutes").value,
      "Free SMS Pack" => find_field("Free SMS Pack").value,
      "Local Per Minutes Charges" => find_field("Local Per Minutes Charges").value,
      "Inter. Per Minutes Charges" => find_field("Inter. Per Minutes Charges").value,
      "SMS Per Charges" => find_field("SMS Per Charges").value,
    }

    fill_in "Monthly Rental", with: "-2"
    fill_in "Free Local Minutes", with: "-43"
    fill_in "Free International Minutes", with: "-47"
    fill_in "Free SMS Pack", with: "-30"
    fill_in "Local Per Minutes Charges", with: "-3"
    fill_in "Inter. Per Minutes Charges", with: "-3"
    fill_in "SMS Per Charges", with: "-5"

    expect(find_field("Monthly Rental").value).to be >= 0
    expect(find_field("Free Local Minutes").value).to be >= 0
    expect(find_field("Free International Minutes").value).to be >= 0
    expect(find_field("Free SMS Pack").value).to be >= 0
    expect(find_field("Local Per Minutes Charges").value).to be >= 0
    expect(find_field("Inter. Per Minutes Charges").value).to be >= 0
    expect(find_field("SMS Per Charges").value).to be >= 0
  end
end
