module SignInSupport
  
  def sign_in(user)
    let!(:user) { create(:user, name:'user', introduction:'test_user', email:'test_user@email.com', password:'password') }
    visit user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    expect(current_path).to eq user_path(id:1)
    expect(page).to have_content "ログインしました"
  end
end
