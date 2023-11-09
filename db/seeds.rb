# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Generate Admin
User.create(
  username: 'KiyoScript',
  email: 'KiyoScript@tasktifier.com',
  gender: 'male',
  role: 'admin',
  password: 'KiyoScr1p5@MisY23',
  password_confirmation: 'KiyoScr1p5@MisY23'
)
