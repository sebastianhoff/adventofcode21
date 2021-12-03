defmodule Day2Dive do
  def dive(list), do: dive(list, {0, 0})
  def dive_aim(list), do: dive_aim(list, {0, 0, 0})

  defp dive({:forward, amt}, {horizontal, depth}), do: {horizontal + amt, depth}
  defp dive({:up, amt}, {horizontal, depth}), do: {horizontal, depth - amt}
  defp dive({:down, amt}, {horizontal, depth}), do: {horizontal, depth + amt}

  defp dive([], {horizontal, depth}), do: {horizontal, depth}
  defp dive([head|list], tuple), do: dive(list, dive(head, tuple))

  defp dive_aim({:forward, amt}, {horizontal, depth, aim}), do: {horizontal + amt, depth + (aim * amt), aim}
  defp dive_aim({:up, amt}, {horizontal, depth, aim}), do: {horizontal, depth, aim - amt}
  defp dive_aim({:down, amt}, {horizontal, depth, aim}), do: {horizontal, depth, aim + amt}

  defp dive_aim([], {horizontal, depth, aim}), do: {horizontal, depth, aim}
  defp dive_aim([head|list], tuple), do: dive_aim(list, dive_aim(head, tuple))
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
IO.puts("part 1: #{h*d}")

{h, d, a} = Day2Dive.dive_aim(file)
IO.puts("part 2: #{h*d}")
