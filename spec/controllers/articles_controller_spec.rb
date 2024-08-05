require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
  subject(:index) { get :index }

      context "when user is logged in" do
        let(:user) { create (:user)}

        before { sign_in user }

        it { is_expected.to be_successful }
      end

      context "when user is not loggged in" do
        it { is_expected.to_not be_successful}
      end
  end

  describe "GET #show" do
      subject(:show) { get :show, params: { id: article.id } }
      let(:article) { create(:article) }

      it { is_expected.to be_successful }
  end

  describe "POST #create" do
      context "when the article is valid" do
      let(:valid_attributes) { { title: "Very valid title", body: "Very very valid value", published: true } } 
      subject(:post_create) {post :create, params: { article: valid_attributes}}
        it "creates new articles" do 
          expect{subject}.to change(Article, :count).from(0).to(1)
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

        it "renders the new template" do
          create_article
          expect(response).to have_http_status(:unprocessable_entity)  
  end
end
end

describe "PATCH #update" do
  let(:article) { create(:article) }

    context "when title is valid" do
      let(:new_title) { "Very good title" }
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

    context "when title is invalid" do
      let(:new_title) { "a" }  

      subject(:update) { patch :update, params: { id: article.id, article: { title: new_title } } }

      it "does not update the article" do
        subject
        expect(article.reload.title).not_to eq(new_title)
      end

      it "renders the edit template" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    subject(:destroy) { delete :destroy, params: { id: article.id } }
    let!(:article) { create(:article) }

    it "destroys the article" do
      expect { subject }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles index" do
      subject
      expect(response).to redirect_to(articles_path)
    end
end
end 
