defmodule MoneyMorphWeb.PageControllerTest do
  use MoneyMorphWeb.ConnCase

  describe "GET /" do
    test "it renders the header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "moneymorph"
    end

    test "it renders the lead", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~
               "100% free and open source forex and currency conversion API"
    end

    test "it renders the Introduction header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "Introduction"
    end

    test "it renders the Contribution header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "Contribution"
    end

    test "it renders the /api/latest header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "/api/latest"
    end

    test "it renders the /api/currencies header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "/api/currencies"
    end

    test "it renders the /api/convert/:amount/:from/:to header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert html_response(conn, 200) =~ "/api/convert/:amount/:from/:to"
    end
  end
end
