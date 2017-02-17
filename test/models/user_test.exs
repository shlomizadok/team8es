defmodule Team8es.UserTest do
  use Team8es.ModelCase

  alias Team8es.User

  @valid_attrs %{email: "me@example.org", password: "MyPassword", password_confirmation: "MyPassword"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "User should have valid email address" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?

    invalid = %{email: "email", password: "MyPassword", password_confirmation: "MyPassword"}
    changeset = User.changeset(%User{}, invalid)
    refute changeset.valid?
  end

  test "User password should be minimum six chars" do
    invalid = %{email: "email@example.org", password: "My", password_confirmation: "My"}
    changeset = User.changeset(%User{}, invalid)
    refute changeset.valid?
    assert {:password, "should be at least 6 character(s)"} in errors_on(%User{}, invalid)
  end

  test "User email should be unique" do
    changeset = User.changeset(%User{}, @valid_attrs)
    Repo.insert(changeset)
    changeset2 = User.changeset(%User{}, @valid_attrs)
    {:error, failed} = Repo.insert(changeset2)
    refute failed.valid?
  end
end
