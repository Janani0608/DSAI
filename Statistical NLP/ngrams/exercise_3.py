import numpy as np
import exercise_2
import math
import random
import matplotlib.pyplot as plt
from typing import Dict, List


def train_test_split(corpus:List, test_size:float) -> (List, List):
    """
    Should split a corpus into a train set of size len(corpus)*(1-test_size)
    and a test set of size len(corpus)*test_size.
    :param text: the corpus, i. e. a list of strings
    :param test_size: the size of the training corpus
    :return: the train and test set of the corpus
    """
    #Randomly shuffling the corpus to avoid getting the same train and test data everytime
    random.shuffle(corpus)
    #split the corpus into train and test data of the given size
    train = corpus[:int(len(corpus)*(1-test_size))]
    test = corpus[int(len(corpus)*(test_size)):]
    #Returned the split data: train and test set
    return train, test


def relative_frequencies(tokens:List, model='unigram') -> dict:
    """
    Should compute the relative n-gram frequencies of the test set of the corpus.
    :param tokens: the tokenized test set
    :param model: the identifier of the model ('unigram, 'bigram', 'trigram')
    :return: a dictionary with the ngrams as keys and the relative frequencies as values
    """
    #Initializing the dictionary to store ngrams and the respective relative frequencies
    ngram_rfs = dict()
    if model == 'unigram':
      ngrams = set(tokens)
      total = len(ngrams)
      for unigram in ngrams:
        #Calculating relative frequency as the ratio of total occurrence of the given unigram to the total number of unigrams
        rel_freq = tokens.count(unigram)/total
        ngram_rfs[unigram] = rel_freq
    if model == 'bigram':
      #Using the utility function from exercise 2 to get the list of bigrams from the given set of tokens
      ngrams = exercise_2.get_bigrams(tokens)
      total = len(ngrams)
      for bigram in ngrams:
        #Calculating relative frequency as the ratio of total occurrence of the given bigram to the total number of bigrams
        rel_freq = ngrams.count(bigram)/total
        ngram_rfs[bigram] = rel_freq
    if model == 'trigram':
      #Using the utility function from exercise 2 to get the list of bigrams from the given set of tokens
      ngrams = exercise_2.get_trigrams(tokens)
      total = len(ngrams)
      for trigram in ngrams:
        #Calculating relative frequency as the ratio of total occurrence of the given trigram to the total number of trigrams
        rel_freq = ngrams.count(trigram) / total
        ngram_rfs[trigram] = rel_freq
    return ngram_rfs


def pp(lm:Dict, rfs:Dict) -> float:
    """
    Should calculate the perplexity score of a language model given the relative
    frequencies derived from a test set.
    :param lm: the language model (from exercise 2)
    :param rfs: the relative frequencies
    :return: a perplexity score
    """
    summation = 0 
    #Iterating through both the dictionaries simultaneously to get the required values
    for (k1,v1), (k2,v2) in zip(lm.items(), rfs.items()):
      #v1 - probability values of the ngrams calculated using MLE
      #v2 - relative frequencies of the ngrams 
      #calculating the summation as given in the perplecity formula: Sum of relative frequencies * log(probabilities) with base 2
      summation = summation + (v2 * math.log(v1,2))
    #raising the calculated summation value to the power of 2 to get the perplexity of the given model
    pp = 2**(-summation)
    return pp


def plot_pps(pps:List) -> None:
    """
    Should plot perplexity value vs. language model
    :param pps: a list of perplexity scores
    :return:
    """
    x = ["unigram", "bigram", "trigram"]
    print(x)
    print(pps)
    #Plotting the language models vs the perplexity values calculated in the previous step
    plt.plot(x, pps)
    plt.show()
