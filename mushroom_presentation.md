Is this mushroom poisonous?
========================================================
author: Johan Jordaan
date: 2016-12-12
autosize: true



The need
========================================================

- Resurgence in mushrooming
- Health hazard
- Mobile app 
- No connectivity

The data 
========================================================

- Sources from Kaggle
- Dataset uses simulated data
- Need to do independent data gathering
- Feature selection
  - Exclude non visual features (odor)
  - Minimal features
  

The model
========================================================

- Random Forest Decision Tree
- 5 Features
- Model Performance


```
Cross-Validated (5 fold, repeated 5 times) Confusion Matrix 

(entries are percentual average cell counts across resamples)
 
          Reference
Prediction    e    p
         e 51.4  0.4
         p  0.4 47.8
                            
 Accuracy (average) : 0.9913
```

The product - Now and the Future
========================================================

- Demo product (MVP)
  - Proves that the prediction model works
  - Proves that a very small set of feature are required

- Can features be detected from images ?

- Build mobile app 
  -  User takes photo
  -  Feature Extraction Model extracts features from photo
  -  Predition Model uses Features to predict : Posionous/Edible
  
  

