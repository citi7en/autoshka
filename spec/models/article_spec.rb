require 'spec_helper'

describe Article do
  before(:each) do
    @attr = {
      :title => "Новая статья",
      :rubric => "Новая рубрика",
      :content => "Привет, лунатики!",
      :autor => "Никита Литвинков",
      :release => 1,
      :date => Date.today
    }
  end

  it "should create a new instance given valid attributes" do
    Article.create!(@attr)
  end

  it "should require a title" do
    no_title_article = Article.new(@attr.merge(:title => ""))
    no_title_article.should_not be_valid
  end

  it "should require a rubric" do
    no_rubric_article = Article.new(@attr.merge(:rubric => ""))
    no_rubric_article.should_not be_valid
  end

  it "should require a content" do
    no_content_article = Article.new(@attr.merge(:content => ""))
    no_content_article.should_not be_valid
  end

  it "should require an autor" do
    no_autor_article = Article.new(@attr.merge(:autor => ""))
    no_autor_article.should_not be_valid
  end

  it "should  require a release" do
    no_release_article = Article.new(@attr.merge(:release => ""))
    no_release_article.should_not be_valid
  end

  it "should require a date" do
    no_date_article = Article.new(@attr.merge(:date => ""))
    no_date_article.should_not be_valid
  end

  it "should reject a too long titels" do
    long_title = "a" * 101
    long_title_article = Article.new(@attr.merge(:title => long_title))
    long_title_article.should_not be_valid
  end

  it "should reject a too long rubric" do
    long_rubric = "a" * 101
    long_rubric_article = Article.new(@attr.merge(:rubric => long_rubric))
    long_rubric_article.should_not be_valid
  end

  it "should reject a too long autor" do
    long_autor = "a" * 101
    long_autor_article = Article.new(@attr.merge(:autor => long_autor))
    long_autor_article.should_not be_valid
  end

  it "should reject not-numeric release" do
    release_string = "f"
    release_string_article = Article.new(@attr.merge(:release => release_string))
    release_string_article.should_not be_valid
  end

  it "should reject a too big release number" do
    big_release = 5001
    big_release_article = Article.new(@attr.merge(:release => big_release))
    big_release_article.should_not be_valid
  end

  it "should reject a not-integer release number" do
    float_release = 4.23
    float_release_article = Article.new(@attr.merge(:release => float_release))
    float_release_article.should_not be_valid
  end

end
