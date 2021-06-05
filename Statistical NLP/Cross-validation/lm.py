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
        self.epsilon = epsilon
    
    def get_ngrams(self, corpus_indicator, n):
        """
        :param corpus_indicator: String indicating whther to get ngrams of train or the test set
        :param n: 'n' value of the desired n-grams
        :returns a list of ngrams based on the value of 'n'
        """
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
    #Utility function to get ngrams based on the given 'n' value
    def get_ngrams(self, corpus_indicator, n):
      """
      :param corpus_indicator: indicates whether the tokens need to be taken from the train or test set
      """
      if corpus_indicator == "train":
        tokens = self.train
      else:
        tokens = self.test
      if n == 1:
        return tokens
      else:
        return list(zip(*[tokens[i:] for i in range(n)]))
    '''
    #Utility function to get the relative frequencies of the ngrams
    def get_rfs(self, ngrams):
      """

      :param ngrams: ngrams list for which relative frequencies need to calculated
      :returns the hashtable with tokens and the no of times the token has appeared
      """
      rfs = Counter(ngrams)
      return rfs


    def perplexity(self):
        """ returns the perplexity of the language model for n-grams with n=n """
        train_ngrams = self.get_ngrams("train", self.N)
        train_probs = self.lidstone_smoothing("train", train_ngrams, self.alpha)
        test_ngrams = self.get_ngrams("test", self.N)
        summation = 0
        #rfs has the empirical counts of each ngram in the given set of ngrams
        rfs = self.get_rfs(test_ngrams)
        #Checking whether the relative frequencies sum to 1
        assert np.abs(1-sum([rf/len(test_ngrams) for rf in rfs.values()])) < self.epsilon, "Relative frequencies don't sum to 1"
        for ngram in list(set(test_ngrams)):
          if ngram in train_probs.keys():
            #Getting the smoothed conditional probability of the corresponding ngram from the train set
            prob = math.log(train_probs[ngram], 2)
            prod = rfs[ngram]/len(test_ngrams) * prob
            summation = summation + prod
          else:
            #Skipping the probability if the ngram is not found in train, 
            #because the probability mass is already distributed, accounting for the unknown words in the smoothing step
            continue
        #returning the perplexity value
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
            prob = (ngrams_count[ngram] + alpha) / (len((ngrams)) + (alpha * len(set(ngrams))))
            probs[ngram] = prob
          #checking whether the smoothed probabilities of unigrams sum to 1
          assert np.abs(1-sum(probs.values())) < self.epsilon, "Conditional probabilities don't sum to 1"
          return probs
        else:
          ngrams = self.get_ngrams(corpus_indicator, self.N)
          N_1_grams = self.get_ngrams(corpus_indicator, self.N - 1)
          ngrams_count = Counter(ngrams)
          N_1_grams_count = Counter(N_1_grams)
          history_prob = dict()
          for history in N_1_grams:
            history_prob[history] = 0
          for ngram in list(set(ngrams)):
            #prob = (ngrams.count(ngram) + alpha) / (N_1_grams.count(tuple(ngram[0:self.N-1])) + (alpha * len(unigrams)))
            prob = (ngrams_count[ngram] + alpha) / (N_1_grams_count[tuple(ngram[0:self.N-1])] + (alpha * len(set(unigrams))))
            history_prob[tuple(ngram[0:self.N-1])] = history_prob[tuple(ngram[0:self.N-1])] + prob
            probs[ngram] = prob
          #Checking whether the smoothed conditional probabilities of the histories individually sum to 1
          assert [np.abs(1-prob) < self.epsilon for prob in history_prob.values()], "Conditional probabilities don't sum to 1"
          return probs
