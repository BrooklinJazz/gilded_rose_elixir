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

    test "never updates quality of a normal item to negative" do
      items = [%Item{name: "foo", sell_in: 30, quality: 0}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 0
    end

    test "increases Aged Brie quality the older it gets" do
      items = [%Item{name: "Aged Brie", sell_in: 30, quality: 10}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 11
    end

    test "never updates an item with increasing quality over 50" do
      items = [%Item{name: "Aged Brie", sell_in: 30, quality: 50}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 50
    end

    test "increases Backstage passes quality as sell_in gets closer" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 30, quality: 10}]
      assert [item] = GildedRose.update_quality(items)
      assert item.sell_in == 29
      assert item.quality == 11
    end

    test "increases Backstage passes quality by 2 when there are 10 days or less" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 10}]
      assert [item] = GildedRose.update_quality(items)
      assert item.sell_in == 9
      assert item.quality == 12
    end

    test "increases Backstage passes quality by 3 when there are 5 days or less" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 10}]
      assert [item] = GildedRose.update_quality(items)
      assert item.sell_in == 4
      assert item.quality == 13
    end

    test "updates Backstage passes quality to 0 after sell_in is negative" do
      items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 10}]
      assert [item] = GildedRose.update_quality(items)
      assert item.sell_in == -1
      assert item.quality == 0
    end

    test "never updates Sulfuras sell_in or quality" do
      items = [%Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 30, quality: 50}]
      assert [item] = GildedRose.update_quality(items)
      assert item.quality == 50
      assert item.sell_in == 30
    end
  end
end
