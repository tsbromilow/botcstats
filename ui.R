ui <- page_navbar(
  title = "BotC Stats",
  theme = dark_theme,
  nav_panel(
    tagList(icon("home"), "Home"), 
    fluidRow(column(width = 3,
                    card(value_box(
                      title = "Total games",
                      value = paste0(total_games),
                      shiny::markdown(paste0("Tom ST ",totals$`Games Played`[totals$Name=="Alex Daines"],", Alex ST ",totals$`Games Played`[totals$Name=="Tom Bromilow"])),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = icon("clipboard-list", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Good win percentage",
                      value = paste0(round(good_win_percent,2)*100,"%"),
                      theme = value_box_theme(
                        bg = "#32a852",
                        fg = "#0F1115"
                      ), showcase = icon("heart", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Best Good player",
                      value = paste0(best_good_name),
                      shiny::markdown(paste0(round(best_good_rate,2)*100,"% from ",best_good_games," games")),
                      theme = value_box_theme(
                        bg = "#32a852",
                        fg = "#0F1115"
                      ), showcase = bsicons::bs_icon("star-fill",  fill="#EFBF04"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100)))
             
    ),
    fluidRow(column(width = 3,
                    card(value_box(
                      title = "Total TB games",
                      value = paste0(tb_total_games),
                      shiny::markdown(paste0("We are now pros")),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = icon("flask", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Evil win percentage",
                      value = paste0(round(evil_win_percent,2)*100,"%"),
                      theme = value_box_theme(
                        bg = "#C2504E",
                        fg = "#0F1115"
                      ), showcase = icon("skull", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Best Evil player",
                      value = paste0(best_evil_name),
                      shiny::markdown(paste0(round(best_evil_rate,2)*100,"% from ",best_evil_games," games")),
                      theme = value_box_theme(
                        bg = "#C2504E",
                        fg = "#0F1115"
                      ), showcase = bsicons::bs_icon("star-fill",  fill="#EFBF04"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100)))
             
    ),
    fluidRow(column(width = 3,
                    card(value_box(
                      title = "Total S&V games",
                      value = paste0(sv_total_games),
                      shiny::markdown(paste0("Still very much learning")),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = bs_icon("flower1"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))) ,
             column(width = 3,
                    card(value_box(
                      title = "Best win rate",
                      value = paste0(best_name),
                      shiny::markdown(paste0(round(best_rate,2)*100,"% from ",best_games," games")),
                      theme = value_box_theme(
                        bg = "#EFBF04",
                        fg = "#0F1115"
                      ), showcase = icon("head-side-virus", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Most games",
                      value = paste0(most_name),
                      shiny::markdown(paste0(most_games," games")),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = icon("layer-group", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))) 
             
    ),
    fluidRow(column(width = 3,
                    card(value_box(
                      title = "Total BMR games",
                      value = paste0(0),
                      shiny::markdown(paste0("Hours of fun await")),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = bs_icon("cloud-moon-fill"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Worst win rate",
                      value = paste0(worst_name),
                      shiny::markdown(paste0(round(worst_rate,2)*100,"% from ",worst_games," games")),
                      theme = value_box_theme(
                        bg = "#a1691a",
                        fg = "#0F1115"
                      ), showcase = icon("trash-can", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))),
             column(width = 3,
                    card(value_box(
                      title = "Most common game size",
                      value = paste0(most_size),
                      shiny::markdown(paste0(size_games," games")),
                      theme = value_box_theme(
                        bg = "#E6E6E6",
                        fg = "#0F1115"
                      ), showcase = icon("people-group", lib = "font-awesome"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))) 
             
    )
  ),
  
  
  nav_panel(
    tagList(icon("robot"), "Players"),
    fluidRow(
      column(width = 9,
             card(
               height = NULL,
               card_header("Click on a expand icon next to each player to see their games"),
               card_body(reactableOutput("totals_dt")))
      )
      ,
      column(width = 3))),
  
  nav_panel(
    tagList(icon("flask", lib = "font-awesome"), "Trouble Brewing"),
    fluidRow(
      column(width = 9,
             card(uiOutput("tb_text"))),
      column(width = 3)),
    fluidRow(
      column(width = 9,
             card(height = 620,DTOutput("tb_table"))),
      column(width = 3))),
  
  nav_panel(
    tagList(bs_icon("flower1"), "Sects & Violets"),
    fluidRow(
      column(width = 9,
             card(uiOutput("sv_text"))),
      column(width = 3)),
    fluidRow(
      column(width = 9,
             card(height = NULL,DTOutput("sv_table"))),
      column(width = 3))),
  nav_panel(
    tagList(bs_icon("cloud-moon-fill"), "Bad Moon Rising"),
    fluidRow(column(width = 3,
                    card(value_box(
                      title = "Stats for BMR",
                      value = paste0("No games yet!"),
                      theme = value_box_theme(
                        bg = "#C2504E",
                        fg = "#0F1115"
                      ), showcase = bs_icon("cloud-moon-fill"),
                      showcase_layout = "left center", full_screen = FALSE, fill = TRUE,
                      height = 100))))),
  nav_panel(
    tagList(bs_icon("clipboard-data-fill"), "Game Size"),
    fluidRow(column(width = 9,
                    card(
                      height = NULL,
                      card_header("Click on a expand icon next to each player to see their games"),
                      card_body(DTOutput("size_table"))))
             ,
             column(width = 3))),
  nav_panel(
    tagList(bs_icon("table"), "Master Table"),
    DTOutput("master_table")
  )
  
)