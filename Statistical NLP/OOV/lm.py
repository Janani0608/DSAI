from collections import Counter
from copy import deepcopy
import numpy as np
import math
from typing import List


class LanguageModel:
    
    def __init__(self, train_tokens: List[str], test_tokens: List[str], N: int, alpha: float, epsilon=1.e-10):
        """ 
        :param train_tokens: list of tokens from the train section of your corpus
        :param test_tokens: list of tokens from the test section of your corpus
        :param N: n of the highest-order n-gram model
        :param alpha: pseudo count for lidstone smoothing
        :param epsilon: threshold for probability mass loss, defaults to 1.e-10
        """
        self.N = N
        self.alpha = alpha
        self.train = train_tokens
        self.test = test_tokens

    ''' 
    """ Non-optimal version: takes 4 times as lons as the optimal function"""
    def get_ngrams(self, corpus_indicator, n):
        ngrams = []
        if corpus_indicator == "train":
          tokens = self.train
        else:
          tokens = self.test
        for i in range(len(tokens)):
          ngram = []
          for j in range(n):
            ngram.append(tokens[(i+j)%len(tokens)])
          ngrams.append(tuple(ngram))
        return ngrams
    '''

    def get_ngrams(self, corpus_indicator, n):
      if corpus_indicator == "train":
        tokens = self.train
      else:
        tokens = self.test
      if n == 1:
        return tokens
      else:
        return list(zip(*[tokens[i:] for i in range(n)]))
    '''
    def get_rfs(self, ngrams):
      rfs = dict()
      for ngram in list(set(ngrams)):
        rfs[ngram] = ngrams.count(ngram) / len(ngrams)
      return rfs
    '''

    def get_rfs(self, ngrams):
      rfs = Counter(ngrams)
      return rfs


    def perplexity(self):
        """ returns the perplexity of the language model for n-grams with n=n """
        train_ngrams = self.get_ngrams("train", self.N)
        train_probs = self.lidstone_smoothing("train", train_ngrams, self.alpha)
        test_ngrams = self.get_ngrams("test", self.N)
        summation = 0
        rfs = self.get_rfs(test_ngrams)
        for ngram in list(set(test_ngrams)):
          if ngram in train_probs.keys():
            prob = math.log(train_probs[ngram], 2)
            prod = rfs[ngram]/len(test_ngrams) * prob
            summation = summation + prod
          else:
            continue
        return 2**(-summation)


    def lidstone_smoothing(self, corpus_indicator, ngrams, alpha: float):
        """ applies lidstone smoothing on train counts

        :param alpha: the pseudo count
        :return: the smoothed counts
        """
        probs = dict()
        unigrams = self.get_ngrams(corpus_indicator, 1)
        if self.N == 1:
          ngrams = unigrams
          ngrams_count = Counter(ngrams)
          for ngram in list(set(ngrams)):
            #prob = (ngrams.count(ngram) + alpha) / (len(ngrams) + (alpha * len(list(set(ngrams)))))
            prob = (ngrams_count[ngram] + alpha) / (len(ngrams) + (alpha * len(ngrams)))
            probs[ngram] = prob
          return probs
        else:
          ngrams = self.get_ngrams(corpus_indicator, self.N)
          N_1_grams = self.get_ngrams(corpus_indicator, self.N - 1)
          ngrams_count = Counter(ngrams)
          N_1_grams_count = Counter(N_1_grams)
          for ngram in list(set(ngrams)):
            #prob = (ngrams.count(ngram) + alpha) / (N_1_grams.count(tuple(ngram[0:self.N-1])) + (alpha * len(unigrams)))
            prob = (ngrams_count[ngram] + alpha) / (N_1_grams_count[tuple(ngram[0:self.N-1])] + (alpha * len(unigrams)))
            probs[ngram] = prob
          return probs
