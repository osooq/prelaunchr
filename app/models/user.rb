require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email

  REFERRAL_STEPS = [
    {
      'count' => 5,
      'html' => 'Amis<br>Inscrits',
      'class' => 'two',
      'image' =>  ActionController::Base.helpers.asset_path(
        'http://osooq.fr/ref/1.png')
    },
    {
      'count' => 10,
      'html' => 'Amis<br>Inscrits',
      'class' => 'three',
      'image' => ActionController::Base.helpers.asset_url(
        'http://osooq.fr/ref/2.png')
    },
    {
      'count' => 25,
      'html' => 'Amis<br>Inscrits',
      'class' => 'four',
      'image' => ActionController::Base.helpers.asset_path(
        'http://osooq.fr/ref/3.png')
    },
    {
      'count' => 50,
      'html' => 'Amis<br>Inscrits',
      'class' => 'five',
      'image' => ActionController::Base.helpers.asset_path(
        'http://osooq.fr/ref/4.png')
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.delay.signup_email(self)
  end
end
