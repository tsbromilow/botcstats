server <- function(input, output) {
  
  output$totals_dt <- renderReactable({
    reactable(totals,
              columns = list(
                Name = colDef(align = "left", minWidth = 130),
                "Games Played" = colDef(align = "center", minWidth = 120),
                "Win %" = colDef(align = "center", format = colFormat(percent = TRUE)),
                "Good Win %" = colDef(align = "center", format = colFormat(percent = TRUE)),
                "Evil Win %" = colDef(align = "center", format = colFormat(percent = TRUE)),
                "Good Games"   = colDef(align = "center", minWidth = 110),
                "Evil Games"    = colDef(align = "center"),
                Wins    = colDef(align = "center"),
                "Good Wins"     = colDef(align = "center"),
                "Evil Wins"     = colDef(align = "center")
              ),
              pagination = FALSE,
              searchable = FALSE,
              outlined = FALSE,
              striped = TRUE,
              highlight = TRUE,
              onClick = "select",
              
              
              rowStyle = JS("
      function(rowInfo) {
        if (rowInfo.expanded) {
          return { backgroundColor: '#C2504E', color: '#0F1115' };
        }
      }
    "),
              
              
              rowClass = JS("
      function(rowInfo) {
        return rowInfo.expanded ? 'is-expanded' : '';
      }
    "),
              
              details = function(index) {
                name_data <- inline[inline$Name == totals$Name[index], ]
                htmltools::div(reactable(
                  name_data,
                  outlined = FALSE,
                  pagination = FALSE,
                  searchable = FALSE,
                  compact = TRUE,
                  striped = TRUE,
                  highlight = TRUE,
                  columns = list(
                    Name = colDef(show = FALSE),
                    Game    = colDef(align = "left"),
                    Role   = colDef(align = "center"),
                    Alignment    = colDef(align = "center"),
                    "Won?"     = colDef(align = "center"),
                    Script     = colDef(align = "center")
                  )
                ))
              }
    )
    
  })
  
  
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
    tf_roles <- tb_role_summary %>%
      filter(Character == "Townsfolk") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_t <- paste(tf_roles, collapse = " and the ")
    verb_t <- if (length(tf_roles) > 1) "were" else "was"
    
    
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
    verb_m <- if (length(minion_roles) > 1) "were" else "was"
    
    
    played_m <- tb_role_summary %>%
      filter(Character == "Minion") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played) 
    
    name_d <- tb_role_summary %>%
      filter(Character == "Demon") %>% 
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    
    tags$span(
      "The stats for all the times we've played Trouble Brewing are below. Out of the Townsfolk, the ",
      tags$strong(name_t), " ", verb_t,
      " included in the bag the most times. They were played ",
      tags$strong(played_t),
      " times. For Outsiders it was ",
      tags$strong(name_o),
      " at ",
      tags$strong(played_o),
      " times. Out of the minions, the ",
      tags$strong(name_m), " ", verb_m,
      " most common at ",
      tags$strong(played_m),
      " times. And the ",
      tags$strong(name_d),
      " was, of course, played in every game."
    )
    
    
  })
  
  
  output$sv_text <- renderUI({
    
    tf_roles <- sv_role_summary %>%
      filter(Character == "Townsfolk") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_t <- paste(tf_roles, collapse = " and the ")
    verb_t <- if (length(tf_roles) > 1) "were" else "was"
    
    
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
    verb_m <- if (length(m_roles) > 1) "were" else "was"
    
    
    played_m <- sv_role_summary %>%
      filter(Character == "Minion") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    d_roles <- sv_role_summary %>%
      filter(Character == "Demon") %>%
      slice_max(order_by = Played, n = 1, with_ties = TRUE) %>%
      pull(Role)
    
    name_d <- paste(d_roles, collapse = " and the ")
    verb_d <- if (length(d_roles) > 1) "were" else "was"
    
    played_d <- sv_role_summary %>%
      filter(Character == "Demon") %>% 
      slice_max(order_by = Played, n = 1, with_ties = FALSE) %>%
      pull(Played)
    
    tags$span(
      "The stats for all the times we've played Sects & Violets are below. Out of the Townsfolk, the ",
      tags$strong(name_t), " ", verb_t,
      " included in the bag the most times. They were played ",
      tags$strong(played_t),
      " times. For Outsiders it was ",
      tags$strong(name_o),
      " at ",
      tags$strong(played_o),
      " times. Out of the minions, the ",
      tags$strong(name_m), " ", verb_m,
      " most common at ",
      tags$strong(played_m),
      " times. Looking at Demons, the ",
      tags$strong(name_d), " ", verb_d,
      " included ",
      tags$strong(played_d),
      " times."
    )
  })
}