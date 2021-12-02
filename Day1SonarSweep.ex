defmodule Day1SonarSweep do
  def calculate_window(list), do: calculate(sum(list))
  def calculate(list), do: calc(list, 0)

  defp sum([a,b,c]), do: [a+b+c]
  defp sum([a|tail]), do: [sum([a|Enum.take(tail, 2)]) |  sum(tail)]

  defp calc([a,b], acc) when a < b, do: acc + 1
  defp calc([_,_], acc), do: acc
  defp calc([head | tail], acc), do: calc(tail, calc([head, hd(tail)], acc))
end

file =
  File.read("Day1Input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_integer/1)

IO.puts("part 1: #{Day1SonarSweep.calculate(file)}")
IO.puts("part 2: #{Day1SonarSweep.calculate_window(file)}")
