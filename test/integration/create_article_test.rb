require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @reg_user = User.create(username: "donjoe", email: "donjoe@example.com",
                              password: "password", admin: false)
    sign_in_as(@reg_user)
    @fat_cat = Category.create(name: "fatcats")
  end

  test "get new article form and post article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: 'best article', description: 'some great article text', category_ids: [1] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'best article', response.body
  end

  # TODO test for unauthenticated user posting articles
end
