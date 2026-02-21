library(shiny)
library(bslib)
library(dplyr)
library(tidyr)
library(tibble)
library(purrr)
library(stringr)
library(bsicons)
library(DT)
library(reactable)
library(htmltools)
library(htmlwidgets)

server <- function(input, output) {
  
  output$totals_dt <- renderReactable({totals_table})
  
  
  output$size_table <- renderDT({
    datatable(
      summary_by_size,
      options = list(
        paging = FALSE,
        dom = 't',
        columnDefs = list(
          list(width = "10%", className = 'dt-left',   targets = 0),
          list(width = "13%", className = 'dt-center', targets = 1:7)
        )
      ),
      rownames = FALSE,
      fillContainer = FALSE) %>%
      formatPercentage(columns = c(3,5,7), digits = 0)
  })
  
  
  output$tb_table <- renderDT({
    datatable(
      tb_role_summary,
      options = list(
        paging = FALSE,
        dom = 't',
        columnDefs = list(
          list(width = "15%", className = 'dt-left',   targets = 0),
          list(width = "15%", className = 'dt-center', targets = 1),
          list(width = "14%", className = 'dt-center', targets = 2:6)
        )
      ),
      rownames = FALSE,
      fillContainer = FALSE) %>%
      formatPercentage(columns = c(4, 7), digits = 0)
  })
  
  output$sv_table <- renderDT({
    datatable(
      sv_role_summary,
      options = list(
        paging = FALSE,
        dom = 't',
        columnDefs = list(
          list(width = "15%", className = 'dt-left',   targets = 0),
          list(width = "15%", className = 'dt-center', targets = 1),
          list(width = "14%", className = 'dt-center', targets = 2:6)
        )
      ),
      rownames = FALSE,
      fillContainer = FALSE) %>%
      formatPercentage(columns = c(4, 7), digits = 0)
  })
  
  output$master_table <- renderDT({
    datatable(
      master,
      options = list(
        paging = FALSE,
        dom = 't',
        columnDefs = list(
          list(width = "10%", className = 'dt-left',   targets = 0),
          list(width = "4%", className = 'dt-center', targets = 1:22)
        )
      ),
      rownames = FALSE,
      fillContainer = FALSE)
  })
  
  #output$totalgamesbox  <- renderText({paste0(total_games)})
  output$bmrbox  <- renderText({paste0("No games yet!")})
  
  
  output$tb_text <- renderUI({
    name_t <- tb_role_summary %>%
      filter(Character == "Townsfolk") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_t <- tb_role_summary %>%
      filter(Character == "Townsfolk") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    name_o <- tb_role_summary %>%
      filter(Character == "Outsider") %>% 
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_o <- tb_role_summary %>%
      filter(Character == "Outsider") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    minion_roles <- tb_role_summary %>%
      filter(Character == "Minion") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_m <- paste(minion_roles, collapse = " and the ")
    
    played_m <- tb_role_summary %>%
      filter(Character == "Minion") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played) 
    
    name_d <- tb_role_summary %>%
      filter(Character == "Demon") %>% 
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    
    tags$div(
      tags$span("Most played roles:"),
      
      tags$ul(
        tags$li(
          "Townsfolk: ",
          tags$strong(name_t), paste0(" (",played_t),
          " times)"
        ),
        tags$li(
          "Outsider: ",
          tags$strong(name_o), paste0(" (",played_o),
          " times)"
        ),
        tags$li(
          "Minion: ",
          tags$strong(name_m), paste0(" (",played_m),
          " times)"
        ),
        tags$li(
          "Demon: ",
          tags$strong(name_d),
          " (every game)"
        )
      )
    )
    
    
  })
  
  
  output$tb_text_2 <- renderUI({
    
    name_t <- tb_role_summary %>%
      filter(Character == "Townsfolk") %>%
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_t <- tb_role_summary %>%
      filter(Character == "Townsfolk") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    name_o <- tb_role_summary %>%
      filter(Character == "Outsider") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_o <- tb_role_summary %>%
      filter(Character == "Outsider") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    minion_roles <- tb_role_summary %>%
      filter(Character == "Minion") %>%
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_m <- paste(minion_roles, collapse = " and the ")
    
    played_m <- tb_role_summary %>%
      filter(Character == "Minion") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    name_d <- tb_role_summary %>%
      filter(Character == "Demon") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    played_d <- tb_role_summary %>%
      filter(Character == "Demon") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    tags$div(
      tags$span("Best win rates (5 or more games):"),
      
      tags$ul(
        tags$li(
          "Townsfolk: ",
          tags$strong(name_t), paste0(" (",played_t*100,
                                      "% win rate)")
        ),
        tags$li(
          "Outsider: ",
          tags$strong(name_o), paste0(" (",played_o*100,
                                      "% win rate)"),
        ),
        tags$li(
          "Minion: ",
          tags$strong(name_m), paste0(" (",played_m*100,
                                      "% win rate)"),
        ),
        tags$li(
          "Demon: ",
          tags$strong(name_d), paste0(" (",played_d*100,
                                      "% win rate)")
        )
      )
    )
    
    
  })
  
  output$sv_text <- renderUI({
    
    tf_roles <- sv_role_summary %>%
      filter(Character == "Townsfolk") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_t <- paste(tf_roles, collapse = " and the ")
    
    played_t <- sv_role_summary %>%
      filter(Character == "Townsfolk") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    name_o <- sv_role_summary %>%
      filter(Character == "Outsider") %>% 
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_o <- sv_role_summary %>%
      filter(Character == "Outsider") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    m_roles <- sv_role_summary %>%
      filter(Character == "Minion") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_m <- paste(m_roles, collapse = " and the ")

    played_m <- sv_role_summary %>%
      filter(Character == "Minion") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    d_roles <- sv_role_summary %>%
      filter(Character == "Demon") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_d <- paste(d_roles, collapse = " and the ")

    played_d <- sv_role_summary %>%
      filter(Character == "Demon") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    tags$div(
      tags$span("Most played roles:"),
      
      tags$ul(
        tags$li(
          "Townsfolk: ",
          tags$strong(name_t), paste0(" (",played_t),
          " times)"
        ),
        tags$li(
          "Outsider: ",
          tags$strong(name_o), paste0(" (",played_o),
          " times)"
        ),
        tags$li(
          "Minion: ",
          tags$strong(name_m), paste0(" (",played_m),
          " times)"
        ),
        tags$li(
          "Demon: ",
          tags$strong(name_d), paste0(" (",played_d),
          " times)"
        )
      )
    )
  })
  
  output$sv_text_2 <- renderUI({
    
    name_t <- sv_role_summary %>%
      filter(Character == "Townsfolk") %>%
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_t <- sv_role_summary %>%
      filter(Character == "Townsfolk") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    name_o <- sv_role_summary %>%
      filter(Character == "Outsider") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role) %>%
      paste(collapse = " and the ")
    
    played_o <- sv_role_summary %>%
      filter(Character == "Outsider") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    minion_roles <- sv_role_summary %>%
      filter(Character == "Minion") %>%
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_m <- paste(minion_roles, collapse = " and the ")
    
    played_m <- sv_role_summary %>%
      filter(Character == "Minion") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    name_d <- sv_role_summary %>%
      filter(Character == "Demon") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    played_d <- sv_role_summary %>%
      filter(Character == "Demon") %>% 
      filter(Played > 4) %>%
      slice_max(order_by = `Win Rate`, n = 1, with_ties = FALSE) %>%
      pull(`Win Rate`)
    
    # tags$div(
    #   tags$span("Best win rates (5 or more games):"),
    #   
    #   tags$ul(
    #     tags$li(
    #       "Townsfolk: ",
    #       tags$strong(name_t), paste0(" (",played_t*100,
    #                                   "% win rate)")
    #     ),
    #     tags$li(
    #       "Outsider: ",
    #       tags$strong(name_o), paste0(" (",played_o*100,
    #                                   "% win rate)"),
    #     ),
    #     tags$li(
    #       "Minion: ",
    #       tags$strong(name_m), paste0(" (",played_m*100,
    #                                   "% win rate)"),
    #     ),
    #     tags$li(
    #       "Demon: ",
    #       tags$strong(name_d), paste0(" (",played_d*100,
    #                                   "% win rate)"),
    #     )
    #   )
    # )
    
     tags$div(
       tags$span("Win rates to be calculated after 5 games"))
  })
  
}