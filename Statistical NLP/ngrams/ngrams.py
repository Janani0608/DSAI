# Define imports
import collections
import operator
import matplotlib.pyplot as plt
import statistics

def preprocess(text) -> list:
    # TODO Exercise 2.2.
    """
    : param text: The text input which you must preprocess by
    removing punctuation and special characters, lowercasing,
    and tokenising

    : return: A list of tokens
    """
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

def get_ngrams(tokens:List(string), n:int):
  ngrams = []
  for i in range(len(tokens)):
    ngram = []
    for j in range(n):
      ngram.append(tokens[i+j%len(tokens)])
    ngrams.append(tuple(ngram))
  return ngrams



def find_ngram_probs(tokens, model='unigram') -> dict:
    # TODO Exercise 2.2
    """
    : param tokens: Pass the tokens to calculate frequencies
    param model: the identifier of the model ('unigram, 'bigram', 'trigram')
    You may modify the remaining function signature as per your requirements

    : return: n-grams and their respective probabilities
    """
    #Initiliazing the dictionary to store ngrams and their corresponding probabilities
    ngram_probs = collections.defaultdict(list)
    
    #Setting 'n' value based on the given model
    if model == 'unigram':
      n = 1
    if model == 'bigram':
      n = 2
    if model == 'trigram':
      n = 3
    
    #Getting ngrams list and the history of ngrams loist based on the 'n' value
    ngrams = get_ngrams(tokens, n)
    ngrams_count = Counter(ngrams)

    if n-1 == 0:
      print("Unigram model, no history exists")
      ngrams_history = None
    else:
      ngrams_history = get_ngrams(tokens, n-1)

    #Calculating probability based on MLE using teh ratio of the ngram count to the count of the history
    for ngram in ngrams:
      p_ngram = ngrams_count[ngram]
      if ngrams_history:
        ngrams_history_count = Counter(ngrams_history)
        p_history = ngrams_history_count[ngram]
      else:
        p_history = len(tokens)
      ngram_probs[ngram] = p_ngram / p_history
    
    return ngram_probs


def plot_most_frequent(ngrams, tokens, model = 'unigram') -> None:
    # TODO Exercise 2.2
    """
    : param ngrams: The n-grams and their probabilities
    Your function must find the most frequent ngrams and plot their respective probabilities

    You may modify the remaining function signature as per your requirements
    """
    #Sorted the given ngram dictionary in descending order by value to access the 'N' most frequent probabilities for the plot
    sorted_ngrams = dict( sorted(ngrams.items(), key=operator.itemgetter(1),reverse=True))
    if model == 'unigram':
      x = sorted_ngrams.keys()
      y = sorted_ngrams.values()
      #Getting the first 20 pairs in the sorted list(descending order) of (unigram, probability) to plot for 1. of Exercise 2.2
      x = [i for index, i in enumerate(x) if index < 20]
      y = [i for index, i in enumerate(y) if index < 20]
      plt.plot(x,y)
      plt.xticks(rotation = 50)
      plt.show()
    if model == 'bigram':
      #Got the most frequent unigram by identifying the mode of the tokens
      freq_unigram = statistics.mode(tokens)
      x = []
      y = []
      #Iterating through the given ngram (bigram) dict to get a list of bigrams starting with the most frequent unigram
      for key, value in sorted_ngrams.items():
        if key[0] == freq_unigram:
          x.append(key[1])
          y.append(value)
      #Getting the first 20 pairs in the sorted list(descending order) of (bigram, probability) to plot for 2. of Exercise 2.2
      x = [i for index, i in enumerate(x) if index < 20]
      y = [i for index, i in enumerate(y) if index < 20]
      plt.plot(x,y)
      plt.xticks(rotation = 50)
      plt.show()
    if model == 'trigram':
      #Getting the bigram list from the tokens by using the utility function written above
      bigrams = get_bigrams(tokens)
      #Using mode to get the most frequent bigram from the list of bigrams
      freq_bigram = statistics.mode(bigrams)
      x = []
      y = []
      #Iterating through the given ngram (trigram) dict to get a list of trigrams starting with the most frequent bigram
      for key, value in sorted_ngrams.items():
        if key[0] == freq_bigram[0] and key[1] == freq_bigram[1]:
          x.append(key[2])
          y.append(value)
      #Getting the first 20 pairs in the sorted list(descending order) of (trigram, probability) to plot for 2. of Exercise 2.2
      x = [i for index, i in enumerate(x) if index < 20]
      y = [i for index, i in enumerate(y) if index < 20]
      plt.plot(x,y)
      plt.xticks(rotation = 50)
      plt.show()
