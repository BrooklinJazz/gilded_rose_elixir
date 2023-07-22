defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item), do: item

  def update_item(%Item{name: "Backstage passes to a TAFKAL80ETC concert"} = item) do
    cond do
      item.sell_in <= 0 ->
        %{item | quality: 0, sell_in: item.sell_in - 1}

      item.sell_in <= 5 ->
        %{item | quality: item.quality + 3, sell_in: item.sell_in - 1}

      item.sell_in <= 10 ->
        %{item | quality: item.quality + 2, sell_in: item.sell_in - 1}

      true ->
        %{item | quality: item.quality + 1, sell_in: item.sell_in - 1}
    end
  end

  def update_item(%Item{name: "Aged Brie"} = item) when item.quality >= 50 do
    %{item | sell_in: item.sell_in - 1}
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    %{item | sell_in: item.sell_in - 1, quality: item.quality + 1}
  end

  # def update_item(%Item{name: "Aged Brie"} = item) do
  #   cond do
  #     item.quality >= 50 ->
  #       %{item | sell_in: item.sell_in - 1}

  #     true ->
  #       %{item | quality: item.quality + 1, sell_in: item.sell_in - 1}
  #   end
  # end

  def update_item(item) do
    if item.sell_in > 0 do
      %{item | quality: max(0, item.quality - 1), sell_in: item.sell_in - 1}
    else
      %{item | quality: max(0, item.quality - 2), sell_in: item.sell_in - 1}
    end
  end
end
