require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { article_color: @article.article_color, article_description: @article.article_description, article_flaw: @article.article_flaw, article_name: @article.article_name, article_producer: @article.article_producer, article_purchasedate: @article.article_purchasedate, article_receipt: @article.article_receipt, article_size: @article.article_size } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { article_color: @article.article_color, article_description: @article.article_description, article_flaw: @article.article_flaw, article_name: @article.article_name, article_producer: @article.article_producer, article_purchasedate: @article.article_purchasedate, article_receipt: @article.article_receipt, article_size: @article.article_size } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
