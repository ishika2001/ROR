# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Event.destroy_all
# Organizer.destroy_all
# organizer = User.first
# event = organizer.events.first

# 5.times do |i|
#   Event.create(title: "title#{i+10}", date: Date.today, time: Time.now, venue:"venue#{i+10}", 
#   description:"desc#{i+10}")
# end


# @data=[
#   {
#     title: "Freshers Party",
#     date: Date.today,
#     time: Time.now,
#     venue: "Indore",
#     description: "a college event for interaction",
#     image:'/assets/event_images/img2.avif',
#     organizer_id: 15
#   },
#   {
#     title: "Wedding",
#     date: Date.today,
#     time: Time.now,
#     venue: "Mumbai",
#     description: "Punjabi wedding",
#     image:'/assets/event_images/img4.avif',
#     organizer_id: 15
#   },
#   {
#     title: "Engagement ceremony",
#     date: Date.today,
#     time: Time.now,
#     venue: "Nagpur",
#     description: "Ceremony before wedding",
#     image:'/assets/event_images/img.webp',
#     organizer_id: 15
#   },
#   {
#     title: "Tech-Envisage",
#     date: Date.today,
#     time: Time.now,
#     venue: "Banglore",
#     description: "Technical event",
#     image:'/assets/event_images/img.webp',
#     organizer_id: 15
#   },
#   {
#     title: "Hackathon",
#     date: Date.today,
#     time: Time.now,
#     venue: "Indore",
#     description: "Tech-competition",
#     image:'/assets/event_images/img.webp',
#     organizer_id: 15
#   },
 
# ]
# @data.each do |data_item|
#   Event.create(data_item)
#  end
# @course_ids=Course.pluck(:id)
# @pdf_data.each do |data_item|
#   Course.all.each do |course|
#     course.pdfs.create(data_item)
#   end
# end



AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?