defmodule Day2 do
    def input() do
        with {:ok, data} <- File.read("input"),
            lines <- String.split(data, "\n"),
            l <- Enum.filter(lines, &(&1 != "")) do
            l
        end
    end
end

defmodule Day2Part1 do
    def run() do
        Day2.input() |> Enum.reduce(0, fn (item, out) ->
            [_, n1, n2, letter, pass] = Regex.run(~r/(\d+)-(\d+)\s*(\w):\s*(\w+)/, item)
            in1 = String.to_integer(n1)
            in2 = String.to_integer(n2)
            count = String.graphemes(pass) |> Enum.filter(&(&1 == letter)) |> length
            if in1 <= count and in2 >= count do
                out + 1
            else
                out
            end
        end) |> IO.inspect()
    end
end

defmodule Day2Part2 do
    def run() do
        Day2.input() |> Enum.reduce(0, fn (item, out) ->
            [_, n1, n2, letter, pass] = Regex.run(~r/(\d+)-(\d+)\s*(\w):\s*(\w+)/, item)
            in1 = (String.to_integer(n1) - 1)
            in2 = (String.to_integer(n2) - 1)
            
            flag = if String.at(pass, in1) == letter, do: 1, else: 0
            flag = if String.at(pass, in2) == letter, do: flag + 1, else: flag
            if flag == 1 do
                out + 1
            else
                out
            end
        end) |> IO.inspect()
    end
end

Day2Part1.run()
Day2Part2.run()