require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    subject(:index) { get :index }

    it { is_expected.to be_successful }
  end

  describe "GET #show" do
    subject(:show) { get :show, params: { id: article.id } }
    let(:article) { create(:article) }

    it { is_expected.to be_successful }
  end

  describe "POST #create" do
  subject(:post_create) {post :create, params: { article: { title: "Very valid title", body: "Very very valid value", published: true}}}
  it "creates new articles" do 
    expect{subject}.to change(Article, :count).from(0).to(1)
 end
it "redirect to article" do 
    subject
    expect(response).to redirect_to (articles_path)
end
end

describe "PATCH #update" do
subject(:update) {patch :update, params: {id: article.id, article: { title: "Very good title"} }}
let(:article) {create(:article)}
it "updates the article" do 
    expect{subject}.to change{article.reload.title}.to("Very good title")
 end
it "redirects to the article's show page" do 
    subject
    expect(response).to redirect_to (article_path(article))
end
end

  describe "DELETE #destroy" do
  end
end
