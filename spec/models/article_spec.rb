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
            let(:article) { build(:article, title: "A") }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("title is too short")
            end
        end

        context "when title is too long" do
            let(:article) { build(:article, title: "A" * 101) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("title is too long")
            end
        end

        context "when body is empty" do
            let(:article) { build(:article, body: nil) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:body]).to include("body is empty")
            end
        end

        context "when body is too short" do
            let(:article) { build(:article, title: "A" * 5) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("body is too short")
            end
        end

        context "when body is too long" do
            let(:article) { build(:article, title: "A" * 110) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("body is too long")
            end
        end

        context "when published is not a boolean" do
            let(:article) { build(:article, published: "not_a_boolean") }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:title]).to include("published is not a boolean")
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
end
