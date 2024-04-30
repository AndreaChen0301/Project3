import pandas as pd
import numpy as np
#from wordcloud import WordCloud
import matplotlib.pyplot as plt
from sklearn import model_selection
from sklearn.feature_extraction.text import CountVectorizer
from sklearn import linear_model
from sklearn import metrics
#import math
#from detoxify import Detoxify cannot import this due to dependency issues. All analysis can be seen done in the working.ipynb. this is a show of how we would parallel
#input_dir="/workspace/linmaneechot/steam_data/"




def main(df):
  df=df
  necesary_columns=['X0.1', 'GOAT.Game...']
  df=df[necesary_columns]
  print(df)
  df=df.dropna()
  def assign_value(x):
    if x <= 1:
        return 1
    elif x <= 5:
        return 2
    elif x <= 10:
        return 3
    elif x <= 25:
        return 4
    elif x <= 50:
        return 5
    elif x <= 100:
        return 6
    elif x <= 400:
        return 7
    elif x <= 900:
        return 8
    else:
        return 9

# Apply the function to create a new column 'NewColumn'
df['NewColumn'] = df['X0.1'].apply(assign_value)

# Print the updated DataFrame
print(df.columns.tolist())
x=df['GOAT.Game...']
y=df['X0.1']
from sklearn.model_selection import train_test_split
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics import mean_squared_error

# Assuming you have already loaded your DataFrame df and defined x and y

# Split the data into training and testing sets
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=2022)

# Initialize and fit the CountVectorizer
words_to_exclude = ['game', 'play', 'one', 'will', 'age']
vectorizer = CountVectorizer(ngram_range=(1, 4), min_df=5, stop_words=words_to_exclude)
vectorizer.fit(x_train)

# Transform the text data into feature vectors
X_train = vectorizer.transform(x_train)
X_test = vectorizer.transform(x_test)

# Initialize and train the Gradient Boosting Regression Tree
gbr = GradientBoostingRegressor(random_state=2022)
gbr.fit(X_train, y_train)

# Make predictions on the test data
y_pred = gbr.predict(X_test)

# Calculate the mean squared error
mse = mean_squared_error(y_test, y_pred)
print("Mean Squared Error:", mse)

#the above was run on a local df to see if it would be worth while and if results were accurate enough. They were not, but this is what we would do to implement parralel computing if it was worth while


#the next part is using detoxify which yields good results in working.ipynb, but also cannot be run on chtc due to dependency issues. Once again this is how we would run it in parrallel
for i in df:
  results=Detoxify('original').predict(df['GOAT.Game...'][i])['toxicity']
  df.at[i, 'toxicity']=results
print(df)
#this is for the argument of df called in bagofwords.sh
if __name__ == "__main__":
    if len(sys.argv) > 1:
        data_path = sys.argv[1]  
        df = pd.read_csv(data_path)  
        main(df)

  
