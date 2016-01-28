# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


for i in 1..120 do
	# create random content
	@content=""
	for j in 1..10 do
		@content+=(RandomWord.nouns.next + " ")
		@content+=(RandomWord.adjs.next + " ")
		
	end
	# create post
	Post.create(content: @content, title: "Post #{i}")
end