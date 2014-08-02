require 'spec_helper'

module AuthHelper
  def basic_http_login
    user = 'eric'
    pw = 'github readers only'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
  end
end

describe BlogPostsController do
  include AuthHelper

  let(:valid_attributes) { {'title' => 'some title', 'draft_body' => 'some body'} }
  let(:valid_session) { {} }
  let(:blog_post) { FactoryGirl.create(:blog_post) }

  before :each do
    basic_http_login
  end

  describe 'GET index' do
    it 'should be successful' do
      get :index, {}, valid_session
      expect(response).to be_successful
      expect(response).to render_template :index
    end

    it 'assigns all blog_posts as @blog_posts' do
      blog_post = BlogPost.create! valid_attributes
      get :index, {}, valid_session
      assigns(:blog_posts).should eq([blog_post])
    end

    it 'requires http_basic_authenticate_with' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      get :index, {}, valid_session
      expect(response).to_not be_successful
      expect(response).to_not render_template :index
    end
  end

  describe 'GET show' do
    it 'should be successful' do
      get :show, {:id => blog_post.to_param}, valid_session
      expect(response).to be_successful
      expect(response).to render_template :show
    end

    it 'assigns the requested blog_post as @blog_post' do
      get :show, {:id => blog_post.to_param}, valid_session
      assigns(:blog_post).should eq(blog_post)
    end

    it 'requires http_basic_authenticate_with' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      get :show, {:id => blog_post.to_param}, valid_session
      expect(response).to_not be_successful
      expect(response).to_not render_template :show
    end
  end

  describe 'GET new' do
    it 'should be successful' do
      get :new, {}, valid_session
      expect(response).to be_successful
      expect(response).to render_template :new
    end

    it 'assigns a new blog_post as @blog_post' do
      get :new, {}, valid_session
      assigns(:blog_post).should be_a_new(BlogPost)
    end

    it 'requires http_basic_authenticate_with' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      get :new, {}, valid_session
      expect(response).to_not be_successful
      expect(response).to_not render_template :show
    end
  end

  describe 'GET edit' do
    it 'should be successful' do
      get :edit, {:id => blog_post.to_param}, valid_session
      expect(response).to be_successful
      expect(response).to render_template :edit
    end

    it 'assigns the requested blog_post as @blog_post' do
      get :edit, {:id => blog_post.to_param}, valid_session
      assigns(:blog_post).should eq(blog_post)
    end

    it 'requires http_basic_authenticate_with' do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      get :edit, {:id => blog_post.to_param}, valid_session
      expect(response).to_not be_successful
      expect(response).to_not render_template :edit
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it "'creates a new BlogPost'" do
        expect {
          post :create, {:blog_post => valid_attributes}, valid_session
        }.to change(BlogPost, :count).by(1)
      end

      it 'assigns a newly created blog_post as @blog_post' do
        post :create, {:blog_post => valid_attributes}, valid_session
        expect(assigns :blog_post).to be_a(BlogPost)
        expect(assigns :blog_post).to be_persisted
      end

      it 'redirects to the created blog_post' do
        post :create, {blog_post: valid_attributes}, valid_session
        expect(response).to redirect_to edit_blog_post_path(BlogPost.last)
      end

      context 'when json requested' do
        it 'returns json' do
          post :create, :blog_post => valid_attributes, :format => :json
          expect(response).to_not redirect_to edit_blog_post_path(BlogPost.last)
          expect(assigns :blog_post).to eq BlogPost.last
          puts '#'*80
          puts response.body
          puts '#'*80
          puts BlogPost.last.inspect
        end
      end

      it 'requires http_basic_authenticate_with' do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
        expect {
          post :create, {:blog_post => valid_attributes}, valid_session
        }.to_not change(BlogPost, :count)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved blog_post as @blog_post" do
        # Trigger the behavior that occurs when invalid params are submitted
        BlogPost.any_instance.stub(:save).and_return(false)
        post :create, {:blog_post => {"title" => "invalid value"}}, valid_session
        assigns(:blog_post).should be_a_new(BlogPost)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BlogPost.any_instance.stub(:save).and_return(false)
        post :create, {:blog_post => {"title" => "invalid value"}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    it 'requires http_basic_authenticate_with' do
      BlogPost.any_instance.should_not_receive(:update)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      put :update, {:id => blog_post.to_param, :blog_post => {"title" => ""}}, valid_session
      expect(response).to_not redirect_to(blog_post)
    end

    describe "with valid params" do
      it "updates the requested blog_post" do
        expect(blog_post.title).to_not eq 'r'
        put :update, {:id => blog_post.to_param, :blog_post => {"title" => "r"}}, valid_session
        expect(blog_post.reload.title).to eq 'r'
      end

      it 'assigns the requested blog_post as @blog_post' do
        put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
        assigns(:blog_post).should eq(blog_post)
      end

      it 'redirects to the blog_post' do
        put :update, {:id => blog_post.to_param, :blog_post => valid_attributes}, valid_session
        response.should redirect_to(blog_post)
      end
    end

    describe 'with invalid params' do
      it 'assigns the blog_post as @blog_post' do
        blog_post = BlogPost.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BlogPost.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog_post.to_param, :blog_post => {"title" => "invalid value"}}, valid_session
        assigns(:blog_post).should eq(blog_post)
      end

      it 're-renders the "edit" template' do
        blog_post = BlogPost.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BlogPost.any_instance.stub(:save).and_return(false)
        put :update, {:id => blog_post.to_param, :blog_post => {"title" => "invalid value"}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'requires http_basic_authenticate_with' do
      BlogPost.any_instance.should_not_receive(:destroy)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('no', 'wrong')
      put :update, {:id => blog_post.to_param, :blog_post => {"title" => ""}}, valid_session
      expect(response).to_not redirect_to(blog_post)
    end

    it 'destroys the requested blog_post' do
      blog_post = BlogPost.create! valid_attributes
      expect {
        delete :destroy, {:id => blog_post.to_param}, valid_session
      }.to change(BlogPost, :count).by(-1)
    end

    it 'redirects to the blog_posts list' do
      delete :destroy, {:id => blog_post.to_param}, valid_session
      response.should redirect_to(blog_posts_url)
    end
  end

end
