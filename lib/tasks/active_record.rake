namespace :active_record do
  desc "TODO"
  task event_counter: :environment do
    puts "Total Events: #{Event.count}"
  end

  desc "TODO"
  task ticket_counter: :environment do
    puts "Total Tickets: #{Ticket.count}"
  end

end
