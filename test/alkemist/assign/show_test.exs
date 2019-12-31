defmodule Alkemist.Assign.ShowTest do
  use Alkemist.DataCase, async: true
  alias Alkemist.Assign.Show
  alias Alkemist.{Post, Fixtures}
  doctest Show

  describe "default_opts" do
    test "it adds default generated options" do
      opts = Show.default_opts([], Post)
      assert opts[:resource] == Post
      assert length(opts[:rows]) == 5
    end

    test "it customizes rows when passed" do
      opts = Show.default_opts([rows: [:id, :title]], Post)
      assert length(opts[:rows]) == 2
    end
  end

  describe "assigns" do
    test "it creates default assigns" do
      post = Fixtures.post_fixture()

      assert assigns = Show.assigns(post, [])
      assert assigns[:resource] == post
      assert assigns[:struct] == :post
      assert assigns[:mod] == Post
      assert assigns[:panels] == []
      assert length(assigns[:rows]) == 5
    end

    test "it preloads resource" do
      category = Fixtures.category_fixture()
      post = Fixtures.post_fixture(%{category_id: category.id})

      assert assigns = Show.assigns(post, [preload: [:category]])
      assert assigns[:resource].category.id == category.id
    end
  end
end