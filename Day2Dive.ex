defmodule Day2Dive do
  def dive(list), do: dive(list, {0, 0})

  defp dive({:forward, amt}, {horizontal, depth}), do: {horizontal + amt, depth}
  defp dive({:up, amt}, {horizontal, depth}), do: {horizontal, depth - amt}
  defp dive({:down, amt}, {horizontal, depth}), do: {horizontal, depth + amt}

  defp dive([], {horizontal, depth}), do: {horizontal, depth}
  defp dive([head|list], tuple), do: dive(list, dive(head, tuple))
end


file =
  File.read("Day2Input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(fn n ->
      [a,b] = String.split(n ," ")
      {String.to_atom(a), String.to_integer(b)}
     end)


{h, d} = Day2Dive.dive(file)
IO.inspect(h*d)
