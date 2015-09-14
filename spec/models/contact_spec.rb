require 'rails_helper'

RSpec.describe Contact, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe Contact do

    it "is has a valid factory" do
      # expect(FactoryGirl.build(:contact)).to be_valid
      expect(build(:contact)).to be_valid
    end

    # it "is valid with a firstname, lastname and email" do
    #   contact = Contact.new(
    #     firstname: 'Aaron',
    #     lastname: 'Sumner',
    #     email: 'tester@example.com')
    #   expect(contact).to be_valid
    # end

    it "is invalid without a firstname" do
      contact = build(:contact , firstname: nil)
      contact.valid?
      expect(contact.errors[:firstname]).to include("can't be blank")
    end

    it "is invalid without a lastname" do
      contact = build(:contact , lastname: nil)
      contact.valid?
      expect(contact.errors[:lastname]).to include("can't be blank")
    end

    it "is invalid without an email address" do
      contact = FactoryGirl.build(:contact, email: nil)
      contact.valid?
      expect(contact.errors[:email]).to include("can't be black")
    end

    # earlier validation examples omitted ..
    it "returns a contact's full name as a string" do
      contact = FactoryGirl.build(:contact ,
        firstname: "Jane",
        lastname: "Smith")
      expect(contact.name).to eq 'Jane Smith'
    end

    it "is invalid with a duplicate email address" do
      # Contact.create(
      #   firstname: 'Joe', lastname: 'Tester',
      #   email: 'tester@example.com'
      # )
      # contact = Contact.new(
      #   firstname: 'Jane', lastname: 'Tester',
      #   email: 'tester@example.com'
      # )
      # contact.valid?
      # expect(contact.errors[:email]).to include("has already been taken")
      FactoryGirl.create(:contact, email: 'aaron@example.com')
      contact = FactoryGirl.build(:contact, email: 'aaron@example.com')
      contact.valid?
      expect(contact.errors[:email]).to include('has already been taken')

    end

    it "is invalid with a duplicate email address" do
      FactoryGirl.create(:contact , email: 'aaron@example.com')
      contact = FactoryGirl.build(:contact, email: 'aaron@example.com')
      contact.valid?
      expect(contact.errors[:email]).to include('has already been taken')
    end

    
    # it "has three phone numbers" do
    #   expect(create(:contact).phones.count).to eq 3
    # end

   

    describe "filter last name by letter" do
      # filtering examples ...
      before :each do
        @smith = Contact.create(
          firstname: 'John',
          lastname: 'Smith',
          email: 'jsmith@example.com'
        )
        @jones = Contact.create(
          firstname: 'Tim',
          lastname: 'Jones',
          email: 'tjones@example.com'
        )
        @johnson = Contact.create(
          firstname: 'John',
          lastname: 'Johnson',
          email: 'jjohnson@example.com'
        )
      end

      context "with matching letters" do
        # matching examples ...
        it "returns a sorted array of results that match" do
          expect(Contact.by_letter("J")).to eq [@johnson, @jones]
        end
      end

      context "with non-matching letters" do
        it "omits results that do not match" do
          expect(Contact.by_letter("J")).not_to include @smith
        end
      end
    end

  end
end
