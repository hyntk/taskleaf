class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_destroy :admin_at_least_one
  # before_destroyコールバックは、dependent: :destroyよりも前に配置する
  # 理由は、そのレコードがdependent: :destroyによって削除されるよりも前にbefore_destroyコールバックが実行されるようにするため
  has_many :tasks,dependent: :destroy

    private

  def admin_at_least_one
    @users = User.all
    number_of_admin = @users.where(admin: true).count
    if self.admin == true
      if number_of_admin == 1
        # errors.add :base, '少なくとも1つ、管理者権限のユーザが必要です'
        throw :abort
      end
    end
  end
end
