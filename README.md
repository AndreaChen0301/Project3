This is the github repo for STAT 405 Final Project

The data downloaded from Kaggle 100 Million+ Steam Review: https://www.kaggle.com/datasets/kieranpoc/steam-reviews?select=weighted_score_above_08.csv 

Steps taken for downloading the steam-reviews dataset from Kaggle:

    1. one group member downloaded the dataset onto their local machine
    
    2. that dataset was then uploaded to lunchbox using the scp command, where it was copied to 
    `workspace/linmaneechot/steam_data.zip`
    
    3. this dataset is public here and can be viewed, edited, and used from other users workspaces
    
To access the data, run `cd /workspace/linmaneechot/steam_data/all_reviews/all_reviews.csv` in lunchbox


How to Run Analysis:

1. Clone the github repo with `clone git@github.com:AndreaChen0301/Project3.git`

2. Run 1. data.sh, 2. getElglish.sh, 3. splitData.sh

3. There's a directory for each research question. In order to get analysis for each part, run submit script in each directory

       q1/submit1.sh
       q2/submit.sh
       q3/submit.sh

4. All the data are stored in directories (steam_review, q1, q2, q3) in `workspace/linmaneechot/`
