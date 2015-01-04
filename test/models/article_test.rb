require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

	test "new state when creating" do
		article = Article.create
		assert_equal( article.state, "pending_publication")
	end

	 test "change field state the value published" do
		article = Article.create
		article.select_state_published
		assert_equal( article.state, "published")
 	 end

	 test "change field state the value rejected" do
		article = Article.create
		article.select_state_rejected
		assert_equal( article.state, "rejected")
 	 end

	 test "change field state the value archive" do
		article = Article.create
		article.select_state_archive
		assert_equal( article.state, "archive")
 	 end

	 test "change field category the value sale" do
		article = Article.create
		article.select_category_sale
		assert_equal( article.category, "sale")
 	 end

	 test "change field category the value purchase" do
		article = Article.create
		article.select_category_purchase
		assert_equal( article.category, "purchase")
 	 end

	 test "change field category the value currency" do
		article = Article.create
		article.select_category_currency
		assert_equal( article.category, "currency")
 	 end

	 test "change field category the value service" do
		article = Article.create
		article.select_category_service
		assert_equal( article.category, "service")
 	 end

	 test "change field category the value rent" do
		article = Article.create
		article.select_category_rent
		assert_equal( article.category, "rent")
 	 end

	 # test "record the user name in the creather field article" do      #not see current user in erb console
	 # 	current_user = User.create(name: "test_name")
	 # 	article = Article.create
	 # 	assert_equal( article.creater, current_user.name)
	 # end	

end