defmodule BusTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
alias BusTracker.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true


    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> validate_required([:name, :email])
  end

  # Password validation
  # From Comeonin docs
  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case valid_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  def valid_password?(password) do
    {:ok, password}
  end
  def valid_password?(_), do: {:error, "The password is too short"}




end
