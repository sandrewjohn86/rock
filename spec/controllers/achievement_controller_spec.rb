require 'rails_helper'

describe AchievementsController do

	#index action
	describe "GET index" do
		it "renders :index template" do
			get :index
			expect(response).to render_template(:index)
		end

		it "assigns only public achievement to template" do
			public_achievement = FactoryGirl.create(:public_achievement)
			private_achievement = FactoryGirl.create(:private_achievement)
			get :index
			expect(assigns(:achievements)).to match_array([public_achievement])
		end
	end

	#edit action
	describe "GET edit" do
		let(:achievement) { FactoryGirl.create(:public_achievement) }
		
		it "renders :edit template" do
			get :edit, id: achievement
			expect(response).to render_template(:edit)
		end

		it "assigns the requested achievement to template" do
			get :edit, id: achievement
			expect(assigns(:achievement)).to eq(achievement)
		end
	end

	#new action
	describe "GET new" do
		it "renders :new template" do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns new Achievement to @achievement" do
			get :new
			expect(assigns(:achievement)).to be_a_new(Achievement)
		end
	end

	#show action
	describe "GET show" do
		let(:achievement) {FactoryGirl.create(:public_achievement)}
		it "renders :show template" do
			get :show, id: achievement.id
			expect(response).to render_template(:show)
		end

		it "assigns requested achievement to @achievement" do
			get :show, id: achievement
			expect(assigns(:achievement)).to eq(achievement)
		end
	end

	#create action
	describe "POST create" do
		let(:valid_data) { FactoryGirl.attributes_for(:public_achievement) }
		context "Valid data" do
			it "redirects to achievements#show" do
				post :create, achievement: valid_data
				expect(response).to redirect_to(achievement_path(assigns[:achievement]))
			end

			it "creates new achievement in database" do
			#	get :show, id: achievement
				expect {
					post :create, achievement: valid_data
				}.to change(Achievement, :count).by(1)
			end
		end

		context "invalid data" do
			let(:invalid_data) { FactoryGirl.attributes_for(:public_achievement, title: '') }
			it "renders :new template" do
				post :create, achievement: invalid_data
				expect(response).to render_template(:new)
			end
			it "doesn't create new achievement in the database" do
				expect {
					post :create, achievement: invalid_data
				}.not_to change(Achievement, :count)
			end
		end
	end
end