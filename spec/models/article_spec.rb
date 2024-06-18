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
        end

        context "when title is too long" do
        end

        context "when body is empty" do
        end

        context "when body is too short" do
        end

        context "when body is too long" do
        end

        context "when published is not a boolean" do
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
end
