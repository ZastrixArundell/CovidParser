# CovidParser
A relay server for queries and blazing fast response about the situation of Covid19. 

## How does this work?
CovidParses gets the data from [john_hopkins_csse_data](https://wuflu.banic.stream/john_hopkins_csse_data.json) or any site specified with `COVID_DATA_URL` (**The structure of the JSON response needs to be the same as csse_data!**) and stores in the ETS for fast response. 

It as wells allows for the end user to user parameters in the URL for specified filters on the data.

## General usage via REST and filters.
If you go to `/api` you will get all of the whole bulky JSON message. If you want to use as less processing on the client side you can then use the 2 parameters in the query, `date` and `country`.

* `/api?country=sweden` will respond with every data which corresponds to Sweden.
* `/api?country=china` will repsond with every data which corresponds to China and every province/state in it. This only does 0(1) filtering.
* `/api?date=2020-03-24` will respond with every data which corresponds to the data 24th March 2020. (This checks the data in the format `YYYY-MM-DD HH-mm GMT` for highest precision).
* `/api?country=serbia&date=2020-03-24%2014` will respond with every data corresponding to Serbia and with the time of `2020-03-04 14` (14 hours).

## In which format should I expect the data?
You can except data in this format:
```json
{
  "latest_fetch": "2020-03-24 15:16 UTC",
  "timestamped_data": [
    {
      "date": "2020-03-24 14:30 UTC",
      "areas": [
        {
          "name": "China",
          "real_name": "China",
          "stats": {
            "confirmed": 81588,
            "deaths": 3281,
            "recoveries": 73279
          }
        },
        {
          "name": "Netherlands",
          "real_name": "Netherlands",
          "stats": {
            "confirmed": 5578,
            "deaths": 277,
            "recoveries": 3
          }
        }
      ]
    }
  ]
}
```
* `latest_fetch` is the added JSON param which shows the time of when the server performed the latest check.
* ***Just to note:*** *some areas have sub-areas*.


## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
