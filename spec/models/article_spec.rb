require 'rails_helper'

RSpec.describe Article, type: :model do
    describe "validations" do
        subject(:article) { article }

        context "when title is empty" do
            let(:article) { build(:article, title: nil) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("can't be blank")
            end
        end

        context "when title is too short" do
                let(:article) { build(:article, title: "a") }
              
                it "throws an error" do
                  expect(article).to_not be_valid
                  expect(article.errors[:title]).to include("is too short (minimum is 2 characters)")
                end
        end

        context "when title is too long" do
            let(:article) { build(:article, title: "a" * 31) }
              
            it "throws an error" do
              expect(article).to_not be_valid
              expect(article.errors[:title]).to include("is too long (maximum is 30 characters)")
            end
        end

        context "when body is empty" do
            let(:article) { build(:article, body: nil) }
              
            it "throws an error" do
              expect(article).to_not be_valid
              expect(article.errors[:body]).to include("can't be blank")
            end
        end

        context "when body is too short" do
            let(:article) { build(:article, body: "a") }
              
                it "throws an error" do
                  expect(article).to_not be_valid
                  expect(article.errors[:body]).to include("is too short (minimum is 15 characters)")
                end
        end

        context "when body is too long" do
            let(:article) { build(:article, body: "a" * 301) }
              
            it "throws an error" do
              expect(article).to_not be_valid
              expect(article.errors[:body]).to include("is too long (maximum is 300 characters)")
            end
        end

        context "when published is not a boolean" do
            let(:article) { build(:article, published: "not a boolean") }

            it "throws an error" do
            expect(article[:published]).to be_in([true, false])
            end
        end

        context "when all params are valid" do
            let(:article) { build(:article) }

            it { expect(subject).to be_valid }
        end
    end

    context "with image attached" do
        let!(:article) { create(:article, :with_image)}

        it { expect(article.image).to be_attached }
    end
    describe 'associations' do
        it { should belong_to(:user).optional }
      end
end

