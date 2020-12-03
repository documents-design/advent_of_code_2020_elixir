defmodule Day3 do
  def input() do
    {:ok, data} = File.read("input")
    lines = data
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))

    height = length(lines)
    width = lines |> Enum.at(0) |> String.length()

    {lines, height, width}
  end
end

defmodule Day3Part1 do
  def run() do
    {lines, height, width} = Day3.input()
    Enum.reduce(lines, %{x: 0, y: 0, trees: 0}, fn (line, %{x: x, y: y, trees: trees}) ->
      nx = rem((x + 3), width)
      ny = y + 1
      if ny >= height - 1 do
        %{x: nx, y: ny, trees: trees}
      else
        line = Enum.at(lines, ny)
        case line |> String.at(nx) do
          "#" -> %{x: nx, y: ny, trees: trees + 1}
          _ -> %{x: nx, y: ny, trees: trees}
        end
      end
    end)
  end
end

defmodule Day3Part2 do
  def check_slope(right, down) do
    {lines, height, width} = Day3.input()
    Enum.reduce(lines, %{x: 0, y: 0, trees: 0}, fn (line, %{x: x, y: y, trees: trees}) ->
      nx = rem((x + right), width)
      ny = y + down
      if ny >= height - 1 do
        %{x: nx, y: ny, trees: trees}
      else
        line = Enum.at(lines, ny)
        case line |> String.at(nx) do
          "#" -> %{x: nx, y: ny, trees: trees + 1}
          _ -> %{x: nx, y: ny, trees: trees}
        end
      end
    end)
  end

  def trees(%{trees: t}), do: t

  def run() do
    [{1,1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(fn {right, down} -> check_slope(right, down) |> trees end)
    |> Enum.reduce(1, fn b, a -> b * a end)
  end
end

Day3Part1.run() |> IO.inspect()
Day3Part2.run() |> IO.inspect()
