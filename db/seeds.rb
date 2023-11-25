Tea.create([
  { title: "Green Tea", description: "Healthy green tea", temperature: 80, brew_time: 3 },
  { title: "Black Tea", description: "Bold black tea", temperature: 90, brew_time: 4 },
  { title: "Herbal Tea", description: "Relaxing herbal infusion", temperature: 95, brew_time: 5 },
  { title: "Oolong Tea", description: "Traditional oolong tea", temperature: 85, brew_time: 4 },
  { title: "White Tea", description: "Delicate white tea", temperature: 75, brew_time: 2 }
])

customer = Customer.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  address: Faker::Address.full_address
)

Subscription.create(
  title: "Monthly Green Tea",
  price: 15.99,
  status: "subscribed",
  frequency: "monthly",
  customer: customer,
  tea: Tea.first
)