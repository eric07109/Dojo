namespace :test_data do
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
		puts "totall #{Comment.count} comments are created"
	end

	task friendships: :environment do
		Friendship.destroy_all
		75.times do |i|
			Friendship.create!(
				sender_id: User.all.sample.id,
				receiver_id: User.all.sample.id,
				approved: [true, false].sample
			)
		end
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

end