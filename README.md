
![image](https://user-images.githubusercontent.com/77694480/125197998-0bd7d800-e22e-11eb-9177-bcf337b9d146.png)

# Spotify: A newly based model that finds the music you are looking for


## Link to Dataset
https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks


# Project Charter
## Project Description


The app can be a useful tool for discovering new music, however it often recommends music similar to the music you're already listening too. It can be difficult and tedious to find new music generally, and especially music that's more disimilar and discover new artists from different genres.

## Objective
Our group is curious to explore the backend of user recommendation machine learning models with Spotify music data, and to also create a model that will provide music recommendations that you can customize to make similar to your music taste or different. Our model will analyze a user's favourite song and provide song suggestions based on the similarity of musical features such as danceability, acousticness, energy, tempo, and so on. We believe by using this model this expands the usefulness of the spotify recommendation platform to help users discover new music, increases user satisfaction with spotify and ultimately increases the number of active users on spotify.

## Data Preprocessing
Data by Artist
- The artists CSVs was loaded in to a pandas dataframe called df_artists
- In the genres column, there were several empty square brackets, so those brackets were stripped and the null values then dropped. The index was then reset

Data by track
- The Tracks CSV was loaded in to a pandas dataframe called df_tracks
- The square brackets and single quotes surrounding the artist names in the artist column were dropped. 
- There were 71 songs with empty name fields, so these rows were dropped.
- The release dates column had inconsistent dates, which were either in the format of YYYY-MM-DD,YYYY-MM, or YYYY. See feature engineering for a description of how year was extracted.
- We noticed that there were songs that had more than one artist and more than one artist id, so regex was used to select the first artists and their related ID.

After both data frames were cleaned, they were merged into a new data frame called df_master and loaded in to a SQLite database using SQLAlchemy.

## Feature Selection and Engineering
The only feature engineering that was performed was the aforementioned binning of release years into a categorical variable that corresponds to the decade in which the track was released. This was implemented in order to try to group tracks at a less granular level than the specific year they released in. The idea behind this is that eras or decades are better capture more information about the tracks in a particular decade than each year. In terms of preliminary feature selection, we decided to drop the explicit column since it did not accurately represent which songs had explicit content (i.e. tracks such as Cardi B's Up and WAP being marked as not explicit) and as a result was heavily skewed in favour of non-explicit tracks. Features which uniquely describe tracks or duplicate information from other features were also dropped before modelling (song id and name, artist id)

## Recommendation Model
In the theory behind recommendation systems there are 2 main types of recommenders: Collaborative filtering and Content-Based. In the former the data used models different users preferences (usually in the form of ratings) and makes suggestions for a new user based how similar their preferences are to other users. While this is a powerful and relatively simple model it suffers from a problem known as cold-start (see [here]( https://en.wikipedia.org/wiki/Cold_start_(recommender_systems) ) ). Content-based models use data that represents how similar items are to each other instead of how similar users are to each other. The data used contains information about the nature content or items (in this case tracks). We choose a purely content-based model. The idea behind it is to use K-means clustering to first group the tracks. When a new song is classified we then fit a K nearest neighbors model on only the data in the new songs cluster, we then suggest the closest songs in the cluster based on the KNN model. The benefits of this model include not needing user profile data, but the model is limited in that it can only recommend tracks in our databse and it makes assumptions about what song features are important to the user. This model could be improved by incorporating user-to-user data, replacing the k nearest neighbors selection with collaborative filtering would mitigate the drawbacks of both approaches and potentially improve the recommendation quality. 

## Training
Currently the model is trained by fitting Kmeans on the entire tracks data  and then breaking the tracks up by their assigned class. We then fit a k nearest neighbors model on each classes track data. The maximum number of iterations for training is set to its default of 300, while more training iterations may help with recommendation quality we discuss the reasons for why it is difficult to tune this value (and any hyperparameters) below. Incorporating user-to-user data (in the form of user ratings) could be used to further train our model, and having users rank our recommendations could also allow us to tune model hyperparameters.

## Testing and Accuracy
Due to the nature of recommendation systems it is very difficult to quantify the perfomance of our model. There is no ground truth for what a user may want out of a recommendation. As such the best way to score a recommendation system is to have a user provide their favourite items and then have them rate which the quality of the recommended items. The scope of this project does not provide the data necessary to score our model and as a result hits the "wall" of the cold-start problem again. Due to the lack of numerical validation we can also skip splitting the data into training and test sets. In fact, we do not want to seperate test data since this provides no benefit and doing so reduces the size of the training set. 

## Model Changes Since Deliverable 2
The methodology behind the recommendation system has not changed since last deliverable. Rather most of the work this deliverable has been around trying to visualize how the recommendation system works to better explain our model.

## Tools and Technology which are used in this project

### Coding Language:
- Python
- SQL

### Resources:
- Spotify API
- Kaggle Spotify Dataset

### Data Storage Method:
- PostgreSQL

### Code Sharing and Task Management Tools:
- Github
- Google Colab

### Presentation Tools:
- Canva
- Google Slides

## Presentation (Draft)
[Link to Canva](https://www.canva.com/design/DAEln2C_Puo/5U6bltmqicBkJ5aE4NftjQ/view#7)

## Dashboard
[Link to Dashboard](https://public.tableau.com/app/profile/vithushan.kuhan/viz/BootcampSpotifyRecommendationProject/BootcampSpotifyRecommendation?publish=yes)
