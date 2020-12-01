defmodule Day1 do
    def input() do
        with {:ok, data} <- File.read("input"),
            lines <- String.split(data, "\n"),
            as_nums <- lines |> Enum.filter(&(&1 != "")) |> Enum.map(&(String.to_integer(&1))) do
            as_nums
        else
            []
        end
    end
end

defmodule Day1Part1 do
    def run() do
        input = Day1.input()
        {a, b} = Enum.reduce(input, {0, 0}, fn num, {m1, m2} ->
            if m1 != 0 do
                {m1, m2}
            else
                case Enum.find(input, fn a -> a == (2020 - num) end) do
                    nil -> {0, 0}
                    a -> {num, a}
                end 
            end
        end)
        IO.inspect("#{a}, #{b}, #{a * b}")
    end
end

defmodule Day1Part2 do
    def run() do
        input = Day1.input()
        {a, b, c} = Enum.reduce(input, {0, 0, 0}, fn num, {z, _, _} = global_out ->
            case z do
                0 -> case Enum.filter(input, fn a -> a < (2020 - num) end) do
                    [] -> {0, 0, 0}
                    candidates -> Enum.reduce(candidates, {0, 0, 0}, fn c, {b, _, _} = partial_out ->
                        case b do
                            0 -> case Enum.find(candidates, fn cand -> num + c + cand == 2020 end) do
                                nil -> {0, 0, 0}
                                match -> {num, c, match}
                            end
                            a -> partial_out
                        end
                    end)
                end
                a -> global_out
            end
        end)
        IO.inspect("#{a}, #{b}, #{c}, #{a * b * c}")
    end
end

Day1Part1.run()
Day1Part2.run()