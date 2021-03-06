require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
  	it 'require title' do
  		achievement = Achievement.new(title: '')
  		#achievement.valid?
  		#expect(achievement.errors[:title]).to include("can't be blank")
  		#expect(achievement.errors[:title]).not_to be_empty
  		expect(achievement.valid?).to be_falsy
  	end

  	it 'requires title to be unique for one user' do
  		user = FactoryGirl.create(:user)
  		first_achievement = FactoryGirl.create(:public_achievement, title: 'First Achievement', user: user)
  		new_achievement = Achievement.new(title: 'First Achievement', user: user)
  		expect(new_achievement.valid?).to be_falsy
  	end

  	it 'allows different users to have achievements with identical titles' do
  		user1 = FactoryGirl.create(:user)
  		user2 = FactoryGirl.create(:user)
  		first_achievement = FactoryGirl.create(:public_achievement, title: 'First Achievement', user: user1)
  		new_achievement = Achievement.new(title: 'First Achievement', user: user2)
  		expect(new_achievement.valid?).to be_truthy
  	end
  end
end
