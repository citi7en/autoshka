require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar",
                 :password_confirmation => "foobar")
		admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    21.times do |n|
      title = Faker::Lorem.sentence(3)
      rubric = Faker::Lorem.sentence(2)
      autor = Faker::Name.name
      content = Faker::Lorem.paragraphs(15)
      Article.create!(:title => title,
                      :rubric => rubric,
                      :autor => autor,
                      :release => 21,
                      :date => "2010-12-16",
                      :content => content)
    end
  end
end
