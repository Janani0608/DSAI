from typing import List
import random

def preprocess_data(text):
  #Step1: Converted the corpus to lowercase
  preprocessed = []
  text = text.lower()
  #Step2: Split the corpus into words/tokens separated by space
  tokens = text.split()
  #Step3: Created a string of possible punctuations and special characters
  to_remove = '''!()-[]{};:'"\, <>./?@#$%^&*_~'''
  for token in tokens:
    for ch in token:
      #Step4: Removed any occurrence of the punctuation/special characters from every token
      if ch in to_remove:
        token = token.replace(ch, "")
    preprocessed.append(token)
  #Step4: Returned the pre-processed set of tokens
  return preprocessed

def train_test_split_data(corpus: List[str], test_size=0.2):
    """ Splits the input corpus in a train and a test set
    :param text: input corpus
    :param test_size: size of the test set, in fractions of the original corpus
    :return: train and test set
    """
    #Randomly shuffling the corpus to avoid getting the same train and test data everytime
    random.shuffle(corpus)
    #split the corpus into train and test data of the given size
    train = corpus[:int(len(corpus)*(1-test_size))]
    test = corpus[int(len(corpus)*(test_size)):]
    #Returned the split data: train and test set
    return train, test

def k_validation_folds(text: List[str], k_folds=10):
    """ Splits a corpus into k_folds cross-validation folds
    :param text: input corpus
    :param k_folds: number of cross-validation folds
    :return: the cross-validation folds
    """
    fold_size = len(text) / float(k_folds)
    k_folds = []
    last = 0.0

    while last < len(text):
        k_folds.append(text[int(last):int(last + fold_size)])
        last += fold_size
    
    return k_folds
