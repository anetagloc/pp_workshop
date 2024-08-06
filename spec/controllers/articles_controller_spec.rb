require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    subject(:index) { get :index }

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in user }

      it { is_expected.to be_successful }
    end

    context "when user is not logged in" do
      it { is_expected.to_not be_successful }
      it "redirects to the login page" do
        redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    subject(:show) { get :show, params: { id: article.id } }
    let(:article) { create(:article) }

    context "when user is logged in" do
      let(:user) { create(:user) }

      before { sign_in user }

      it "is successful" do
        subject
        expect(response).to be_successful
      end

      it "redirects to the show page" do
        redirect_to(:show)
      end
    end

    context "when user is not logged in" do
      it "redirects to the login page" do
        redirect_to(new_user_session_path)
      end
    end
end

describe "POST #create" do
  context "when the article is valid" do
    let(:valid_attributes) { { title: "Very valid title", body: "Very very valid value", published: true } } 
    subject(:post_create) {post :create, params: { article: valid_attributes}}
    let(:user) {create(:user)}

    before { sign_in user }

    it "creates new articles" do 
      expect{subject}.to change(Article, :count).from(0).to(1)
      expect(Article.last.user_id ).to eq(user.id)
    end
    it "redirect to article" do 
      subject
      expect(response).to redirect_to (articles_path)
    end
    end
  context "when the article is invalid" do
    let(:invalid_attributes) { { title: "a", body: "This is a valid body." } } # Assuming the title is invalid

    subject(:create_article) { post :create, params: { article: invalid_attributes } }

    it "does not create a new article" do
    expect { create_article }.not_to change(Article, :count)
    end
  end
end

describe "PATCH #update" do
    let(:article) { create(:article) }
    let(:new_title) { "Very good title" }
    let(:invalid_title) { "a" }

    context "when user is logged in" do
      let(:user) { create(:user) }
      before { sign_in user }

      context "with valid attributes" do
        subject(:update) { patch :update, params: { id: article.id, article: { title: new_title } } }

        it "updates the article" do
          subject
          expect(article.reload.title).to eq(new_title)
        end

        it "redirects to the article's show page" do
          subject
          expect(response).to redirect_to(article_path(article))
        end
      end

      context "with invalid attributes" do
        subject(:update) { patch :update, params: { id: article.id, article: { title: invalid_title } } }

        it "does not update the article" do
          subject
          expect(article.reload.title).not_to eq(invalid_title)
        end

        it "renders the edit template" do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when user is not logged in" do
      subject(:update) { patch :update, params: { id: article.id, article: { title: new_title } } }

      it "does not update the article" do
        subject
        expect(article.reload.title).not_to eq(new_title)
      end

      it "redirects to the login page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:article) { create(:article) }

    context "when user is logged in" do
      let(:user) { create(:user) }
      before { sign_in user }

      subject(:destroy) { delete :destroy, params: { id: article.id } }

      it "destroys the article" do
        expect { subject }.to change(Article, :count).by(-1)
      end

      it "redirects to the articles index" do
        subject
        expect(response).to redirect_to(articles_path)
      end
    end

    context "when user is not logged in" do
      subject(:destroy) { delete :destroy, params: { id: article.id } }

      it "does not destroy the article" do
        expect { subject }.not_to change(Article, :count)
      end

      it "redirects to the login page" do
        subject
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end