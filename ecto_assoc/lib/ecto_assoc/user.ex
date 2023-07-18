defmodule EctoAssoc.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string
    has_one :avatar, EctoAssoc.Avatar
    has_many :posts, EctoAssoc.Post
    has_many :likes, EctoAssoc.Like
    has_many :like_posts, through: [:likes, :post]
  end
end
