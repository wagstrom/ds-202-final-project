library(tidyverse)
library(stringr)
df = read.csv("rym_top_5000_all_time.csv")

#Converting to numeric
df$Number.of.Ratings = as.numeric(gsub(",", "", df$Number.of.Ratings))
df$Ranking = as.numeric(df$Ranking)
df$Average.Rating = as.numeric(df$Average.Rating)
df$Number.of.Reviews = as.numeric(df$Number.of.Reviews)

df2 = df
#Converting comma-separated strings into separate columns
df2[c('Genre_1', 'Genre_2', 'Genre_3', 'Genre_4', 'Genre_5')] <- str_split_fixed(df2$Genres, ', ', 5)
df2[c('Desc_1', 'Desc_2', 'Desc_3', 'Desc_4', 'Desc_5', 'Desc_6', 'Desc_7', 'Desc_8',
     'Desc_9', 'Desc_10')] <- str_split_fixed(df2$Descriptors, ', ', 10)
sum(df2$Desc_10 != "")

df3 = df2
#Add column for average rating, average reviews, average ratings, and number of appearances per artist
df3 = df3 %>%
  group_by(Artist.Name) %>%
  mutate(Artist.Average.Score = mean(Average.Rating),
         Artist.Average.Reviews = mean(Number.of.Reviews),
         Artist.Average.Ratings = mean(Number.of.Ratings),
         Artist.Frequency = nrow(as.data.frame(Artist.Name))
         )

View(df3)

df_final = df3

#Summaries
nrow(unique(as.data.frame(df_final$Album)))
  #Some albums have the same names
nrow(unique(as.data.frame(df_final$Artist.Name)))
  #2787 unique artists
nrow(unique(as.data.frame(df_final$Genre_1)))
  #453 unique primary genres


