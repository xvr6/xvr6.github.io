defmodule Xvr6Web.ErrorJSONTest do
  use Xvr6Web.ConnCase, async: true

  test "renders 404" do
    assert Xvr6Web.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Xvr6Web.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
