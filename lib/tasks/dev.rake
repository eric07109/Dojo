namespace :test_data do
	task admin: :environment do
		puts 'start creating admin user'
		User.create!(
			lastname: "Admin",
			firstname: "Admin",
			email: "admin@example.com",
			password: "12345678",
			admin: true
		)
	end
	
	task users: :environment do
		User.destroy_all
		10.times do |u|
			lastname = FFaker::Name.last_name
			firstname = FFaker::Name.first_name
			description = FFaker::Lorem.paragraph
			User.create!(
				lastname: lastname,
				firstname: firstname,
				description: description,
				email: "#{lastname}@dojoforum.com",
				password: "123123"
			)
			puts "User #{lastname} #{firstname} has been created"
		end
	end

	task categories: :environment do
		Category.destroy_all
		5.times do |c|
			category_name = FFaker::Lorem.word
			Category.create!(
				name: category_name
			)
			puts "Category #{category_name} has been created"
		end
	end

	task posts: :environment do 
		Post.destroy_all
		50.times do |p|
			Post.create!(
				title: FFaker::Lorem.sentence,
				content: FFaker::Lorem.paragraph(rand(1..10)),
				author_id: User.all.sample.id,
				published: [true, false].sample,
				privacy: ["all", "friend", "myself"].sample
			)
		end
		puts "totally #{Post.count} posts are created"
	end

	task post_cat_mappings: :environment do
		PostCategoryMapping.destroy_all
		75.times do |i|
			PostCategoryMapping.create!(
				post_id: Post.all.sample.id,
				category_id: Category.all.sample.id
			)
		end
	end

	task comments: :environment do 
		Comment.destroy_all
		150.times do |i|
			Comment.create!(
				user_id: User.all.sample.id,
				post_id: Post.all.sample.id,
				content: FFaker::Lorem.paragraph(rand(1..5))
			)
		end
		puts "totally #{Comment.count} comments are created"
	end

	task friendships: :environment do
		Friendship.destroy_all
		75.times do |i|
			sender = User.all.sample
			receiver = User.all.sample
			if sender.friends_to_be_approved.include?(receiver) or sender.friends_to_approve.include?(receiver) or sender.friend_with?(receiver)
				puts "relationship between #{sender.lastname} and #{receiver.lastname} already exists"
			elsif sender == receiver
				puts "friendships with oneself cannot be establisehd"
			else
				Friendship.create!(
					sender_id: sender.id,
					receiver_id: receiver.id,
					approved: [true, false].sample
				)
				puts "Create new relationship between #{sender.lastname} and #{receiver.lastname}"
			end

		end
		puts "totally #{Friendship.count} friendships are created"
	end

	task collections: :environment do
		Collection.destroy_all
		75.times do |i|
			Collection.create!(
				user_id: User.all.sample.id,
				post_id: Post.all.sample.id,
			)
		end
	end

	task :all do
		Rake::Task["test_data:users"].invoke
		Rake::Task["test_data:admin"].invoke
	    Rake::Task["test_data:posts"].invoke
	    Rake::Task["test_data:comments"].invoke
	    Rake::Task["test_data:collections"].invoke
	    Rake::Task["test_data:post_cat_mappings"].invoke
	    Rake::Task["test_data:friendships"].invoke
	  end

end