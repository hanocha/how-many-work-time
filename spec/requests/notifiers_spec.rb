require 'rails_helper'

RSpec.describe 'Notifiers', type: :request do
  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }
    
    before { login_as user }

    context 'Slack通知が未登録のとき' do
      it 'notifiers に新しいレコードを保存する' do
        post notifier_path
        expect(user.notifier).not_to be_nil
      end
    end

    context 'slack通知が登録済みのとき' do
      before do
        Notifier.create(user_id: user.id)
      end

      it '既存のレコードを更新しない' do
        expect { post notifier_path }.not_to change { user.notifier }
      end

      it '新規にレコードを登録しない' do
        post notifier_path
        expect(Notifier.where(user_id: user.id).count).to eq 1
      end
    end
  end
end