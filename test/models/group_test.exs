defmodule Team8es.GroupTest do
  use Team8es.ModelCase

  alias Team8es.Group

  @valid_attrs %{description: "some content", mailing_list_email: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Group.changeset(%Group{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Group.changeset(%Group{}, @invalid_attrs)
    refute changeset.valid?
  end
end
