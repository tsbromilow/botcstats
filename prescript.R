#rm(list=ls())

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

## Read in data ##
data <- read.csv("master.csv")
role_list <- read.csv("data/roles.csv")
tb <- read.csv("data/tb.csv")
sv <- read.csv("data/sv.csv")

tb <- as.vector(tb$Role)
sv <- as.vector(sv$Role)


## Calculate key data points for use in later tables ##
wins <- data %>% 
  slice(n()) %>% 
  select(-Name) %>% 
  pivot_longer(everything(),
                names_to = "Game",
                values_to = "TeamWin")

script <- data %>% 
  slice(n()-1) %>% 
  select(-Name) %>% 
  pivot_longer(everything(),
               names_to = "Game",
               values_to = "Script")

total_games <- data %>% select(-Name) %>% length()
tb_total_games <- script %>% filter(Script == "Trouble Brewing") %>%  nrow()
sv_total_games <- script %>% filter(Script == "Sects & Violets") %>%  nrow()
good_win_percent <- nrow(wins %>% filter(TeamWin == "Good"))/total_games
evil_win_percent <- nrow(wins %>% filter(TeamWin == "Evil"))/total_games


## Generate a list with all players and their game history ##
summary <- data %>%
  slice(-n(),(-(n()-1))) %>%
  pivot_longer(-Name, names_to = "Game", values_to = "Role") %>%
  filter(!is.na(Role), Role != "") %>%
  left_join(role_list %>% select(Role = 1, Alignment = 3), by = "Role") %>%
  left_join(wins, by = "Game") %>% 
  left_join(script, by = "Game") %>% 
  group_by(Name) %>%
  summarise(
    Game = list(
      setNames(
        lapply(seq_along(Role), function(i) list(Role = Role[i], Script = Script[i], Alignment = Alignment[i], Win = ifelse(Alignment[i] == TeamWin[i],"Yes","No"))),
        Game)),
    .groups = "drop") %>%
  deframe()

## Generate a table with win percentages etc ##
totals <- enframe(summary, name = "Name", value = "Games") %>%
  transmute(Name,
            "Games Played" = lengths(Games),
            "Good Games" =map_int(Games, ~ sum(map_chr(.x, "Alignment") == "Good", na.rm = TRUE)),
            "Evil Games" =map_int(Games, ~ sum(map_chr(.x, "Alignment") == "Evil", na.rm = TRUE)),
            Wins = map_int(Games, ~ sum(map_chr(.x, "Win") == "Yes", na.rm = TRUE)),
            "Good Wins" = map_int(Games,
              ~ sum(map_lgl(.x, ~ identical(.x$Win, "Yes") && identical(.x$Alignment, "Good")))),
            "Evil Wins" = map_int(Games,
                               ~ sum(map_lgl(.x, ~ identical(.x$Win, "Yes") && identical(.x$Alignment, "Evil"))))) %>% 
  mutate("Win %" = round(Wins/`Games Played`,2),
         "Good Win %" = round(`Good Wins`/`Good Games`,2),
         "Evil Win %" = round(`Evil Wins`/`Evil Games`,2)) %>% 
  relocate("Win %", .after = "Games Played")%>% 
  relocate("Good Win %", .after = "Win %")%>% 
  relocate("Evil Win %", .after = "Good Win %")

## Generate a table with all roles and stats by script ##
func_role_summary<- function(arg_script){
  output <- enframe(summary, name = "Name", value = "Games") %>%
  mutate(rows = map2(Name, Games,
                     ~ map_dfr(.y, \(g) tibble(
                       Name      = .x,
                       Role      = g$Role,
                       Win       = g$Win,
                       Script = g$Script)))) %>%
  select(rows) %>%
  unnest(rows) %>%
  filter(Script == arg_script) %>% 
  mutate(Role = ifelse(str_detect(Role, "Drunk"),"Drunk",Role),
         Role = ifelse(str_detect(Role, "Marionette"),"Marionette",Role)) %>% 
  count(Role, Win, name = "Games") %>%
  tidyr::complete(Role, Win = c("Yes", "No"), fill = list(Games = 0)) %>%
  group_by(Role) %>% 
  summarise(
    Played = sum(Games),
    Inclusion = round(Played/ifelse(arg_script=="Trouble Brewing", tb_total_games, sv_total_games),2),
    Wins        = sum(Games[Win == "Yes"]),
    Losses      = sum(Games[Win == "No"]),
    "Win Rate"     = round(Wins / Played,2),
    .groups = "drop")  %>%
    left_join(role_list %>% select("Role","Character"), by = "Role") %>% 
    relocate("Character", .before = "Played")%>% 
    slice(match({ if (isTRUE(arg_script == "Trouble Brewing")) tb else sv }, .data$Role))
    }

tb_role_summary <- func_role_summary("Trouble Brewing")
sv_role_summary <- func_role_summary("Sects & Violets")

## Generate a table for game size stats ##
sizes <- data %>%
  slice(-n(),(-(n()-1))) %>%
  pivot_longer(-Name, names_to = "Game", values_to = "Role") %>%
  filter(!is.na(Role), Role != "") %>% 
  select("Game") %>% 
  count(Game, name = "Size") %>% 
  left_join(wins, by = "Game")


summary_by_size <- sizes %>%
  add_count(Size, name = "Games") %>%
  count(Size, TeamWin, name = "n_wins") %>%
  pivot_wider(
    names_from = TeamWin,
    values_from = n_wins,
    values_fill = 0) %>%
  left_join(sizes %>% count(Size, name = "Games"),by = "Size") %>% 
  arrange(Size) %>% 
  mutate(Size = paste0(Size," players"))  %>% 
  mutate("Game %" = round(Games/sum(Games),2),
         "Good Win %" = round(Good/Games,2),
         "Evil Win %" = round(Evil/Games,2),
         "More Likely" = ifelse(Good==Evil,"Equal",ifelse(Good<Evil,"Good","Evil"))) %>% 
  rename("Good Wins" = "Good", "Evil Wins" = "Evil") %>%
  relocate("Games","Game %", .after = "Size") %>% 
  relocate("Good Win %", .after = "Good Wins") %>% 
  relocate("Evil Win %", .after = "Evil Wins")

       
inline <- data %>%
  slice(-n(),(-(n()-1))) %>%
  pivot_longer(-Name, names_to = "Game", values_to = "Role") %>%
  filter(!is.na(Role), Role != "") %>%
  left_join(role_list %>% select(Role = 1, Alignment = 3), by = "Role") %>%
  left_join(wins, by = "Game") %>% 
  left_join(script, by = "Game")

inline <- inline %>% 
  mutate("Won?" = ifelse(Alignment == TeamWin,"Won","Lost")) %>% 
  select(-"TeamWin")

master <- data %>% rev() %>% relocate(Name)

## Stats ##

best_good_name <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Good Win %`)) %>%
  slice(1) %>%
  pull(Name)

best_good_rate <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Good Win %`)) %>%
  slice(1) %>%
  pull(`Good Win %`)

best_good_games <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Good Win %`)) %>%
  slice(1) %>%
  pull(`Games Played`)

best_evil_name <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Evil Win %`)) %>%
  slice(1) %>%
  pull(Name)

best_evil_rate <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Evil Win %`)) %>%
  slice(1) %>%
  pull(`Evil Win %`)

best_evil_games <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Evil Win %`)) %>%
  slice(1) %>%
  pull(`Games Played`)

best_name <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Win %`)) %>%
  slice(1) %>%
  pull(Name)

best_rate <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Win %`)) %>%
  slice(1) %>%
  pull(`Win %`)

best_games <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(desc(`Win %`)) %>%
  slice(1) %>%
  pull(`Games Played`)

worst_name <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(`Win %`) %>%
  slice(1) %>%
  pull(Name)

worst_rate <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(`Win %`) %>%
  slice(1) %>%
  pull(`Win %`)

worst_games <- totals %>% filter(`Games Played` > 4) %>% 
  arrange(`Win %`) %>%
  slice(1) %>%
  pull(`Games Played`)

most_name <- totals %>% arrange(desc(`Games Played`)) %>%
  slice(1) %>%
  pull(Name)

most_games <- totals %>% arrange(desc(`Games Played`)) %>%
  slice(1) %>%
  pull(`Games Played`)

most_size <- summary_by_size %>% arrange(desc(Games)) %>%
  slice(1) %>%
  pull(Size)

size_games <- summary_by_size %>% arrange(desc(Games)) %>%
  slice(1) %>%
  pull(Games)






