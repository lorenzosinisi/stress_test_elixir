# Bingo

```elixir

--url: the url of the web app you want to test
--count: how many parallel\* connections you want to open
--every: how often you want to open those connections (use 0 to run it just once)

Then run:

mix attack --url http://localhost:4000 --count 10 --every 1000
```
