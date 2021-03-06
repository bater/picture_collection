class Product < ApplicationRecord
  validates :name, presence: { message: "请输入商品名称" }
  validates :category_id, presence: { message: "请选择商品分类" }

  belongs_to :category_group
  belongs_to :category
  belongs_to :user
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images

  include AASM

  aasm do
    state :waitting_for_approval, initial: true
    state :approved
    state :rejected

    event :agree do
      transitions from: :waitting_for_approval,         to: :approved
    end

    event :disagree do
      transitions from: :waitting_for_approval,     to: :rejected
    end

    event :update_product do
      transitions from: [:waitting_for_approval, :approved, :rejected], to: :waitting_for_approval
    end
  end

end
