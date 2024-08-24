require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    subject { user }

    context "when username is empty" do
      let(:user) { build(:user, username: nil) }

      it "throws an error" do
        expect(subject).to_not be_valid
        expect(subject.errors[:username]).to include("can't be blank")
      end
    end

    context "when email is already taken" do
      let!(:user1) { create(:user, email: "test@example.com") }
      let(:user2) { build(:user, email: "test@example.com", password: "password", password_confirmation: "password") }

      it 'does not allow creation of a user with an already taken email' do
        expect(user2).not_to be_valid
        expect(user2.errors[:email]).to include("has already been taken")
      end
    end

    context "when email is invalid" do
      let(:invalid_emails) { ["plainaddress", "zeroToken"] }
    
      it 'does not allow creation of a user with an invalid email' do
        invalid_emails.each do |invalid_email|
          user = build(:user, email: invalid_email, password: "password", password_confirmation: "password")
          expect(user).not_to be_valid
    
          unless user.valid?
            puts "Testing invalid email: #{invalid_email}"
            puts user.errors.full_messages
          end
    
          expect(user.errors[:email]).to include("is invalid")
        end
      end
    end
  end
  describe 'associations' do
    it { should have_many(:articles).dependent(:nullify)}
  end
end
