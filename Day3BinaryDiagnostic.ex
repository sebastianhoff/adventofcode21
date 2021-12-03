defmodule Day3BinaryDiagnostic do
  def gamma(list), do: get_value(list, 0)
  def delta(list), do: get_value(list, 1)

  def oxygen(list) do
    find_binary(list, 0, &most_common_value/2)
      |> binary_list_to_int
  end

  def co2(list) do
    find_binary(list, 0, &least_common_value/2)
      |> binary_list_to_int
  end

  defp find_binary([item], _, _), do: item
  defp find_binary(list, level, value_selector) do
    value = value_selector.(list, level)
    list
      |> Enum.filter(fn x -> Enum.at(x, level) == value end)
      |> find_binary((level + 1), (value_selector))
  end

  defp get_value(list, value) do
    width = Enum.count(Enum.at(list, 0))-1

    Enum.to_list(0..width)
    |> Enum.map(&count(list, &1, value))
    |> Enum.map(fn n -> (n > (Enum.count(list)/2)) end)
    |> Enum.map(&boolean_to_integer/1)
    |> binary_list_to_int
  end

  defp most_common_value(list, position) do
    zero = count(list, position, 0)
    one = count(list, position, 1)
    if (zero > one), do: 0, else: 1
  end

  defp least_common_value(list, position) do
    zero = count(list, position, 0)
    one = count(list, position, 1)
    if (zero > one), do: 1, else: 0
  end

  defp count(list, column, value) do
    list
    |> Enum.map(fn n -> Enum.at(n, column) end)
    |> Enum.count(&(&1 == value))
  end

  defp binary_list_to_int(list) do
    list
    |> Enum.map(&to_string/1)
    |> Enum.join("")
    |> Integer.parse(2)
    |> elem(0)
  end

  defp boolean_to_integer(true), do: 1
  defp boolean_to_integer(false), do: 0
end

file =
  File.read("Day3Input")
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Enum.map( fn n ->
      String.codepoints(n)
      |> Enum.map(&String.to_integer/1)
  end)

  #IO.inspect(file)

  gamma = Day3BinaryDiagnostic.gamma(file)
  delta = Day3BinaryDiagnostic.delta(file)
  IO.puts(to_string(gamma) <> " * " <> to_string(delta) <> " = " <> to_string(gamma*delta)) # 2921 * 1174 = 3429254

  oxygen = Day3BinaryDiagnostic.oxygen(file)
  co2 = Day3BinaryDiagnostic.co2(file)
  IO.puts(to_string(oxygen) <> " * " <> to_string(co2) <> " = " <> to_string(oxygen*co2)) # 1471 * 3678 = 5410338
