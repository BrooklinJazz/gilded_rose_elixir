defmodule GildedRoseTest do
  use ExUnit.Case

  # system under test
  # context of the system (state)
  # behavior (optional as it's contained in the assertion)

  describe "update_items/1" do
    test "normal item _ decrement sell_in and quality" do
      items = [%Item{name: "foo", sell_in: 30, quality: 50}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 49
      assert item.sell_in == 29
    end

    test "degrades normal item twice as fast after sell by date" do
      items = [%Item{name: "foo", sell_in: 0, quality: 50}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 48
      assert item.sell_in == -1
    end

    test "quality of a normal item is never negative" do
      items = [%Item{name: "foo", sell_in: 30, quality: 0}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 0
    end
  end
end
