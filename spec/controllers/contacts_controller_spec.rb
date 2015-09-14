require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ContactsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ContactsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all contacts as @contacts" do
      contact = Contact.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:contacts)).to eq([contact])
    end

    context 'with params[:letter]' do
      it "populates an array of contacts starting with the letter" do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index, letter: 'S'
        expect(assigns(:contacts)).to match_array([smith])
      end

      it "renders the :index template" do
        get :index, letter: 'S'
        expect(response).to render_template :index
      end
    end

    context 'without params[:letter]' do
      it "populates an array of all contacts" do
        smith = create(:contact, lastname: 'Smith')
        jones = create(:contact, lastname: 'Jones')
        get :index
        expect(assigns(:contacts)).to match_array([smith, jones])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

  end

  describe "GET #show" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :show, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end

    it "renders the :show template" do
      contact = create(:contact)
      get :show,id: contact
      expect(response).to render_template :show
    end

  end

  describe "GET #new" do
    it "assigns a new contact as @contact" do
      get :new, {}, valid_session
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :edit, {:id => contact.to_param}, valid_session
      expect(assigns(:contact)).to eq(contact)
    end

    it "renders the :edit template" do
      contact = create(:contact)
      get :edit,id: contact
      expect(response).to render_template :edit
    end

  end

  describe "POST #create" do

    before :each do
      @phones = [
        attributes_for(:phone),
        attributes_for(:phone),
        attributes_for(:phone)
      ]
    end

    context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{
          post :create, contact: attributes_for(:contact,
            phones_attributes: @phones)
        }.to change(Contact, :count).by(1)
      end

      it "redirects to contacts#show" do
        post :create,
          contact: attributes_for(:contact,
            phones_attributes: @phones)
        expect(response).to redirect_to contact_path(assigns[:contact])
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        expect{
          post :create,
            contact: attributes_for(:invalid_contact)
        }.not_to change(Contact, :count)
      end

      it "re-renders the :new template" do
        post :create,
          contact: attributes_for(:invalid_contact)
        expect(response).to render_template :new
      end
    end

    describe "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, {:contact => valid_attributes}, valid_session
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        post :create, {:contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

      it "redirects to the created contact" do
        post :create, {:contact => valid_attributes}, valid_session
        expect(response).to redirect_to(Contact.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contact as @contact" do
        post :create, {:contact => invalid_attributes}, valid_session
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it "re-renders the 'new' template" do
        post :create, {:contact => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH #update" do

    before :each do
      @contact = create(:contact,
        firstname: 'Lawrence',
        lastname: 'Smith'
      )
    end

    context "valid attributes" do
      it "locates the requested @contact" do
        # allow(contact).to \
        #   receive(:update).with(valid_attributes.stringify_keys) { true }
        patch :update, id: @contact,
          contact: attributes_for(:contact)
        expect(assigns(:contact)).to eq @contact
      end

      it "changes @contact's attributes" do
        patch :update, id: @contact,
          contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: 'Smith'
          )
        @contact.reload
        expect(@contact.firstname).to eq 'Larry'
        expect(@contact.lastname).to eq 'Smith'
      end

      it "redirects to the updated contact" do
        patch :update, id: @contact, contact: attributes_for(:contact)
        expect(response).to redirect_to @contact
      end
    end

      context "invalid attributes" do
        # before :each do
        #   allow(contact).to receive(:update).with(invalid_attributes.stringify_keys) { false }
        #   patch :update, id: contact, contact: invalid_attributes
        # end

        it "does not change the contact's attributes" do
          patch :update, id: @contact,
            contact: attributes_for(:contact,
            firstname: 'Larry',
            lastname: nil)
          @contact.reload
          expect(@contact.firstname).to_not eq('Larry')
          expect(@contact.lastname).to eq('Smith')
        end


        # it "does not change the contact's attributes" do
        #   expect(assigns(:contact).reload.attributes).to eq contact.attributes
        # end

        it "re-renders the edit method" do
          patch :update, id: @contact,
            contact: attributes_for(:invalid_contact)
          expect(response).to render_template :edit
        end
      end

    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => new_attributes}, valid_session
        contact.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(assigns(:contact)).to eq(contact)
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => valid_attributes}, valid_session
        expect(response).to redirect_to(contact)
      end
    end

    describe "with invalid params" do
      it "assigns the contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_attributes}, valid_session
        expect(assigns(:contact)).to eq(contact)
      end

      it "re-renders the 'edit' template" do
        contact = Contact.create! valid_attributes
        put :update, {:id => contact.to_param, :contact => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    
    before :each do
      @contact = create(:contact)
    end

    it "deletes the contact" do
      expect{
        delete :destroy, id: @contact
      }.to change(Contact,:count).by(-1)
    end

    it "redirects to contacts#index" do
      delete :destroy, id: @contact
      expect(response).to redirect_to contacts_url
    end


    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, {:id => contact.to_param}, valid_session
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, {:id => contact.to_param}, valid_session
      expect(response).to redirect_to(contacts_url)
    end
  end
  
  describe "administrator access" do
    before :each do
      user = create(:admin)
      session[:user_id] = user.id
    end

    describe 'GET #index' do
      context 'with params[:letter]' do
        it "populates an array of contacts starting with the letter" do
          smith = create(:contact, lastname: 'Smith')
          jones = create(:contact, lastname: 'Jones')
          get :index, letter: 'S'
          expect(assigns(:contacts)).to match_array([smith])
        end
    
        it "renders the :index template" do
          get :index, letter: 'S'
          expect(response).to render_template :index
        end
      end

      context 'without params[:letter]' do
        it "populates an array of all contacts" do
          smith = create(:contact, lastname: 'Smith')
          jones = create(:contact, lastname: 'Jones')
          get :index
          expect(assigns(:contacts)).to match_array([smith, jones])
        end
        it "renders the :index template" do
          get :index
          expect(response).to render_template :index
        end
      end
    end

    describe 'GET #show' do
      it "assigns the requested contact to @contact" do
        contact = create(:contact)
        get :show, id: contact
        expect(assigns(:contact)).to eq contact
      end

      it "renders the :show template" do
        contact = create(:contact)
        get :show, id: contact
        expect(response).to render_template :show
      end

    end
  end
end
