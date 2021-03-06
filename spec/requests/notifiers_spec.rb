require 'rails_helper'

RSpec.describe 'Notifiers', type: :request do
  describe '#show' do
    context 'ログイン済みのとき' do
      let(:user) { FactoryGirl.create(:user) }
      
      before { login_as user }

      it 'ステータスコード 200 を返す' do
        get notifier_path
        expect(response).to have_http_status(:ok)
      end
    end

    context '未ログインのとき' do
      it 'ログインページにリダイレクトする' do
        get notifier_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#create' do
    let(:user) { FactoryGirl.create(:user) }
    
    before { login_as user }

    subject { post notifier_path(notifier: { user_id: user.id, slack_user_name: 'test' }) }
        
    it 'Slack通知管理ページにリダイレクトする' do
      subject
      expect(response).to redirect_to notifier_path
    end

    context 'Slack通知が未登録のとき' do
      it 'notifiers に新しいレコードを保存する' do
        subject
        expect(user.notifier).not_to be_nil
      end
    end

    context 'slack通知が登録済みのとき' do
      before do
        Notifier.create(user_id: user.id)
      end

      it '既存のレコードを更新しない' do
        expect { subject }.not_to change { user.notifier }
      end

      it '新規にレコードを登録しない' do
        subject
        expect(Notifier.where(user_id: user.id).count).to eq 1
      end
    end
  end

  describe '#destroy' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:notifier) { FactoryGirl.create(:notifier, user_id: user.id) }
    
    before { login_as user }

    it 'ログイン中ユーザの Slack 通知設定を削除する' do
      delete notifier_path
      expect(user.reload.notifier).to be_nil
    end
  end
end