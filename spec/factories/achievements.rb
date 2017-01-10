FactoryGirl.define do
  	factory :achievement do
  		#sequences
	    sequence(:title) { |n| "Achievement #{n}"}
	    description "description"
	    featured false
	    cover_image "some_file.png"

	    #sub-factory. Inherit all other attribute except the one given
	    factory :public_achievement do
	    	privacy :public_access
	  	end

	  	#sub-factory
	    factory :private_achievement do
	    	privacy :private_access
	  	end
	end
end
