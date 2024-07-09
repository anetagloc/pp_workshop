require 'rails_helper'

RSpec.describe User, type: :model do
    describe "validations" do
        subject(:user) { user }

        context "when username is empty" do
            let(:user) { build(:user, username: nil) }

            it "throws an error" do
                expect(subject).to_not be_valid
                expect(subject.errors[:username]).to include("can't be blank")
            end
        end
    end
end



