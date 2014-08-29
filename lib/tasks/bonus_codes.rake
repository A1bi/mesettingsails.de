namespace :bonus_codes do
	desc "Manage bonus codes"
	task :create => :environment do
    puts "How many codes do you want to create?"
    number = $stdin.gets.chomp.to_i
    number.times do
      code = BonusCode.create
      puts code.code
    end
    puts "Finished."
  end
end