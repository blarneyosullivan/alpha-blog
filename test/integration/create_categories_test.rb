require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
    def setup
    @category = Category.create(name: "sports")
    
    #test setup admin user
    @user = User.create(username: "john333", email: "john333@blarney.com", password: "password", admin: true)

    
    end

  
  test "get new category form abd create category" do

    #this test cant access session directly unlike controller test
    sign_in_as(@user, "password")
    
    
    #check path
    get new_category_path
  
    #go to new category page
    assert_template 'categories/new'
  
    # after this action count difference should be 1
    assert_difference 'Category.count', 1 do
    # post to new page and create record
      post_via_redirect categories_path category: {name: "s3ports"}
    end
    
    # go to index template
    assert_template 'categories/index'
    
    # read post body for match of sports
    assert_match "s3ports", response.body
    
  end
  
  test "invalid category submission results in failure" do

    #this test cant access session directly unlike controller test
    # use test helper method
    sign_in_as(@user, "password")

    #check path
    get new_category_path
  
    #go to new category page
    assert_template 'categories/new'
  
    # after this action count difference should be 1
    assert_no_difference 'Category.count' do
    # post to new page and create record
    #  post_via_redirect categories_path category: {name: " "}
      post categories_path category: {name: " "}
    end
    
    # go back to new insert should have failed
    assert_template 'categories/new'
    
    # read from new page in errors partial 
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
    
  end
    
    
    
end

