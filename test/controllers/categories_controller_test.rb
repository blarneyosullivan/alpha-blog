require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports")
    
    #test setup admin user
    @user = User.create(username: "john", email: "john@blarney.com", password: "password", admin: true)

    
  end


  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get categories new" do
    #similuate logged in user
    session[:user_id] = @user.id
    
    get :new
    assert_response :success
  
  end
  
  test "should get categories show" do
    get(:show, { 'id' => @category.id}) 
    assert_response :success
  
  end


  test "should redirect create when not logged in as admin" do
    
    assert_no_difference "Category.count" do
      post :create, category: { name: "sports"}  
    end
    
    assert_redirected_to categories_path
    
    
  end
  
  
end
