defmodule HouseholdAccountBookApp.PurchasesTest do
  use HouseholdAccountBookApp.DataCase

  alias HouseholdAccountBookApp.Purchases

  describe "purchases" do
    alias HouseholdAccountBookApp.Purchases.Purchase

    import HouseholdAccountBookApp.PurchasesFixtures

    @invalid_attrs %{date: nil, money: nil, name: nil}

    test "list_purchases/0 returns all purchases" do
      purchase = purchase_fixture()
      assert Purchases.list_purchases() == [purchase]
    end

    test "get_purchase!/1 returns the purchase with given id" do
      purchase = purchase_fixture()
      assert Purchases.get_purchase!(purchase.id) == purchase
    end

    test "create_purchase/1 with valid data creates a purchase" do
      valid_attrs = %{date: ~D[2023-07-25], money: 42, name: "some name"}

      assert {:ok, %Purchase{} = purchase} = Purchases.create_purchase(valid_attrs)
      assert purchase.date == ~D[2023-07-25]
      assert purchase.money == 42
      assert purchase.name == "some name"
    end

    test "create_purchase/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create_purchase(@invalid_attrs)
    end

    test "update_purchase/2 with valid data updates the purchase" do
      purchase = purchase_fixture()
      update_attrs = %{date: ~D[2023-07-26], money: 43, name: "some updated name"}

      assert {:ok, %Purchase{} = purchase} = Purchases.update_purchase(purchase, update_attrs)
      assert purchase.date == ~D[2023-07-26]
      assert purchase.money == 43
      assert purchase.name == "some updated name"
    end

    test "update_purchase/2 with invalid data returns error changeset" do
      purchase = purchase_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update_purchase(purchase, @invalid_attrs)
      assert purchase == Purchases.get_purchase!(purchase.id)
    end

    test "delete_purchase/1 deletes the purchase" do
      purchase = purchase_fixture()
      assert {:ok, %Purchase{}} = Purchases.delete_purchase(purchase)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get_purchase!(purchase.id) end
    end

    test "change_purchase/1 returns a purchase changeset" do
      purchase = purchase_fixture()
      assert %Ecto.Changeset{} = Purchases.change_purchase(purchase)
    end
  end

  describe "categories" do
    alias HouseholdAccountBookApp.Purchases.Category

    import HouseholdAccountBookApp.PurchasesFixtures

    @invalid_attrs %{category_name: nil, color_code: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Purchases.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Purchases.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{category_name: "some category_name", color_code: "some color_code"}

      assert {:ok, %Category{} = category} = Purchases.create_category(valid_attrs)
      assert category.category_name == "some category_name"
      assert category.color_code == "some color_code"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Purchases.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{category_name: "some updated category_name", color_code: "some updated color_code"}

      assert {:ok, %Category{} = category} = Purchases.update_category(category, update_attrs)
      assert category.category_name == "some updated category_name"
      assert category.color_code == "some updated color_code"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Purchases.update_category(category, @invalid_attrs)
      assert category == Purchases.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Purchases.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Purchases.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Purchases.change_category(category)
    end
  end
end
