file_path = "/workspace/linmaneechot/q2/allData.csv"

df = read.csv(file_path, header = FALSE)

lifetime_mins = as.numeric(df[,1])
help_score = as.numeric(df[,2])

cor_q2 = cor(lifetime_mins, help_score)
cat(cor_q2)

model = lm(lifetime_mins ~ help_score)

summary_model = summary(model)
cat(summary_model)
