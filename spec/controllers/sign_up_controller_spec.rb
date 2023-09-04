require 'rails_helper'

describe SignUpController, type: :controller do
  describe '#show' do
    subject { get :show, params: params }
    let(:params) {}
    it 'renders the correct view' do
      expect(subject).to render_template 'sign_up/create'
    end
  end

  describe '#create' do
    subject { post :create, params: params }

    context 'with correct and complete params' do
      let(:params) do
        {
          first_name: 'robbie',
          last_name: 'katz',
          email: 'test@gmail.com',
          password: 'foobarbaz',
          password_confirmation: 'foobarbaz'
        }
      end

      it 'renders the correct view' do
        expect(subject).to render_template 'sign_up/update'
      end

      it 'creates a new user in the database' do
        expect { subject }.to change { User.count }.by(1)
      end
    end

    context 'without correct and complete params' do
      context 'with incomplete params' do
        let(:params) do
          {
            first_name: 'robbie'
          }
        end

        it 'raises an error' do
          expect { subject }.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with incorrect params' do
        let(:params) do
          {
            first_name: 'robbie',
            last_name: 'katz',
            email: 'fizzbuzz',
            password: 'foobarbaz',
            password_confirmation: 'foobarbaz'
          }
        end

        it 'renders the correct view' do
          expect(subject).to render_template 'sign_up/error'
        end
      end
    end
  end

  describe '#update' do
    subject { patch :update, params: params }
    let!(:user) { create(:user, current_session_id: current_session_id) }
    let(:current_session_id) { '1234' }

    before do
      request.cookies['session_id'] = current_session_id
    end

    context 'with correct params' do
      let(:params) do
        {
          gender: 'male',
          university: 'uct',
          :'date_of_birth(1i)' =>  '1994',
          :'date_of_birth(2i)' => '07',
          :'date_of_birth(3i)' => '18'
        }
      end

      it 'updates the correct user' do
        expect { subject }.to change { user.reload.gender }.from(nil).to('male')
      end

      it 'renders the correct view' do
        expect(subject).to render_template 'sign_up/done'
      end
    end

    context 'with missing or incomplete params' do
      context 'with missing params' do
        let(:params) do
          {
            gender: 'male'
          }
        end

        it 'raises an error' do
          expect { subject }.to raise_error ActionController::ParameterMissing
        end
      end

      context 'with incomplete params' do
        let(:params) do
          {
            gender: 'male',
            university: 'uct',
            :'date_of_birth(1i)' =>  '2010',
            :'date_of_birth(2i)' => '07',
            :'date_of_birth(3i)' => '18'
          }
        end

        it 'renders the correct view' do
          expect(subject).to render_template 'sign_up/error'
        end
      end
    end
  end
end
