defmodule Day3BinaryDiagnostic do
  def gamma(list), do: get_value(list, 0)
  def delta(list), do: get_value(list, 1)

  defp get_value(list, value) do
    width = Enum.count(Enum.at(list, 0))-1

    Enum.to_list(0..width)
    |> Enum.map(&count(list, &1, value))
    |> Enum.map(fn n -> (n > (Enum.count(list)/2)) end)
    |> Enum.map(&boolean_to_integer/1)
    |> binary_list_to_int
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
