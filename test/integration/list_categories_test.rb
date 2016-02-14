require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "programming")
  end
  
  test "should show categories listing" do
    #check path
    get categories_path
  
    #go to new category index page
    assert_template 'categories/index'
    
    # check you reach index page
    # and page contains links to category show page with name and id
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
    
    
  end
  
  

    
end

