from typing import List, Dict
from collections import defaultdict
from collections import Counter
import random
import operator
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import numpy as np
#Add imports

def preprocess(text) -> List:
    #Step 1: converted the text to lower case
    text = text.lower()
    #Step 2: Split the text into tokens
    tokens = text.split(" ")
    preprocessed = []
    #Step3: Created a string of possible punctuations and special characters
    to_remove = '''!()-[]{};:'"\, <>./?@#$%^&*_~'''
    for token in tokens:
      for ch in token:
        #Step4: Removed any occurrence of the punctuation/special characters from every token
        if ch in to_remove:
          token = token.replace(ch, "")
      preprocessed.append(token)
    return preprocessed


def train_test_split_data(text:List, test_size:float=0.1):
    #Randomly shuffling the corpus to avoid getting the same train and test data everytime
    random.shuffle(text)
    #split the corpus into train and test data of the given size
    train = text[:int(len(text)*(1-test_size))]
    test = text[int(len(text)*(test_size)):]
    #Returned the split data: train and test set
    return train, test
    

def get_oov_rates(train:List, test:List) -> List:
    oov_rates = []
    vocab_size = 15
    train_accumulation = defaultdict()
    test_accumulation = defaultdict()
    unique_train = set(train)
    unique_test = set(test)
    for token in unique_train:
      #Calculating the accumulation value for every token in the train set
      train_accumulation[token] = train.count(token)
    for token in unique_test:
      #Calculating the accumulation value for every token in the test set
      test_accumulation[token] = test.count(token)
    #sorting the train set of accumulation values to get the 'n' most frequent words
    train_sorted = dict(sorted(train_accumulation.items(), key=operator.itemgetter(1),reverse=True))
    train_sorted_15k = dict(list(train_sorted.items())[:15000])
    for i in range(1, vocab_size+1):
      curr_size = i*1000
      #For the current loop, 'i*1000' most frequent words are taken into consideration
      curr_train = dict(list(train_sorted_15k.items())[:curr_size])
      total_count = len(test)
      oov_count = 0
      for word in unique_test:
        #total count is the total number of words in the test data
        #total_count = total_count + value
        if word in curr_train:
          continue
        else:
          #oov count is the number of words that did not not appear int he train data
          oov_count = oov_count + test_accumulation[word]
      #OOV rate is calculated usign the total count and oov count obtained in the previous steps
      oov_rates.append(oov_count/total_count)
    return oov_rates


def plot_oov_rates(oov_rates:Dict) -> None:
    languages = oov_rates.keys()
    x = list(range(1,16))
    c = {'en': 'blue', 'fi': 'green', 'ru':'red', 'ta': 'yellow'}
    for lang in languages:
      y = oov_rates[lang]
      plt.xlabel("Vocabulary size in 1000s")
      plt.ylabel("OOV rates")
      plt.loglog(x,y,color = c[lang], label = lang)
    plt.legend()