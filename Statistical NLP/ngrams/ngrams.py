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

def get_bigrams(tokens):
  #Utility function to get the list of bigrams from a given ste of preprocessed tokens
  bigrams = []
  for i in range(len(tokens)):
    #Checks for forming bigrams by considering the corpus as a circular structure
    if i+1 == len(tokens):
      #Check for the last token of the corpus to construct the bigram (w_N,w_1), since
      bigrams.append((tokens[i],tokens[0]))
    else:
      bigrams.append((tokens[i],tokens[i+1]))
  return bigrams

def get_trigrams(tokens):
  #Utility function to get the list of trigrams from a given set of preprocessed tokens
  trigrams = []
  for i in range(len(tokens)):
    #Checks for forming trigrams by considering the corpus as a circular structure
    if i+2 == len(tokens):
      #Check for the last to last token of the set to construct the trigram (w_N-1, w_N, w1)
      trigrams.append((tokens[i], tokens[i+1], tokens[0]))
    elif i+1 == len(tokens):
      #Check for the last token to construct the trigram (w_N, w_1, w_2)
      trigrams.append((tokens[i], tokens[0], tokens[1]))
    else:
      trigrams.append((tokens[i], tokens[i+1], tokens[i+2]))
  return trigrams

def find_ngram_probs(tokens, model='unigram') -> dict:
    # TODO Exercise 2.2
    """
    : param tokens: Pass the tokens to calculate frequencies
    param model: the identifier of the model ('unigram, 'bigram', 'trigram')
    You may modify the remaining function signature as per your requirements

    : return: n-grams and their respective probabilities
    """
    #Initiliazing the dictionary to store ngrams and their corresponding probabilities
    ngram_dict = collections.defaultdict(list)

    #Initializing ngrams list to store the ngrams corresponding to the specified model
    ngrams = []

    unigrams = set(tokens)
    bigrams = get_bigrams(tokens)
    trigrams = get_trigrams(tokens)
    
    total_count = len(tokens)

    if model == 'unigram':
      ngrams = unigrams
      for token in ngrams:
        #Calculating probability using the MLE; for unigrams: ratio of the total occurrence of the unigram to the total number of tokens
        probability = tokens.count(token) / total_count
        #Setting the key value pair (unigram token, probability) in the dictionary initialized earlier
        ngram_dict[token] = probability
    if model == 'bigram':
      ngrams = bigrams
      for bigram in ngrams:
        p_w1 = tokens.count(bigram[0])
        p_w1_w2 = ngrams.count(bigram)
        #Calculating the probability using MLE; for bigrams: ratio of the total occurrence of the bigram to 
        #the total occurences of the first word of the given bigram
        bigram_probability = p_w1_w2/p_w1
        #Setting the key value pair (bigram pair, probability) in the dictionary initialized earlier
        ngram_dict[bigram] = bigram_probability
    if model == 'trigram':
      ngrams = trigrams
      for trigram in ngrams:
        p_w1_w2_w3 = ngrams.count(trigram)
        p_w1_w2 = bigrams.count((trigram[0],trigram[1]))
        #Calculating the probability using MLE; for bigrams: ratio of the total occurrence of the trigram in the corpus to 
        #the total occurences of the first bigram (first two words) in the given trigram
        trigram_probability = p_w1_w2_w3 / p_w1_w2
        #Setting the key value pair (trigram tuple, probability) in the dictionary initialized earlier
        ngram_dict[trigram] = trigram_probability
    #ngram dict corresponding to the specified model is returned
    return ngram_dict


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
