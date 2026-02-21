,
fluidRow(column(width = 9,
                card(
                  class = "vb-compact",
                  card_header("Most included"),
                  layout_columns(
                    col_widths = c(3, 3, 3, 3),
                    value_box(
                      title = "Townsfolk",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Outsider",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Minion",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Demon",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    )))),
         column(width = 3)),
fluidRow(column(width = 9,
                card(
                  class = "vb-compact",
                  card_header("Most included"),
                  layout_columns(
                    col_widths = c(3, 3, 3, 3),
                    value_box(
                      title = "Townsfolk",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Outsider",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Minion",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    ),
                    value_box(
                      title = "Demon",
                      value = textOutput("totalgamesbox"),
                      theme = "white"
                    )))),
         column(width = 3)),




totals,
colnames = c("Name", "Games Played", "Good Games", "Evil Games", "Wins", "Good Wins", "Evil Wins"),
options = list(
  paging = FALSE,
  dom = 't',
  columnDefs = list(
    list(width = "10%", className = 'dt-left',   targets = 0),
    list(width = "13%", className = 'dt-center', targets = 1:6)
  )
),
rownames = FALSE,
fillContainer = FALSE) 