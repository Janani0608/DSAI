from importlib import reload
import ngrams, perplexity
perplexity = reload(perplexity)
ngrams = reload(ngrams)

file = open("orient_express.txt", "r")
text = file.read()

#TODO: Get preprocessed tokens
tokens = ngrams.preprocess(text)

# TODO: split the corpus into a train corpus and a test corpus, with test_size=10%
train, test = exercise_3.train_test_split(tokenized, 0.1)

#TODO: find conditional probabilities of ngrams
unigram_lm = ngrams.find_ngram_probs(tokens, model='unigram')
bigram_lm = ngrams.find_ngram_probs(tokens, model='bigram')
trigram_lm = ngrams.find_ngram_probs(tokens, model='trigram')

#TODO: Plot the most frequent ngrams
ngrams.plot_most_frequent(unigrams, tokens, model = 'unigram')
ngrams.plot_most_frequent(bigrams, tokens, model = 'bigram')
ngrams.plot_most_frequent(trigrams, tokens, model = 'trigram')


# TODO: calculate unigram, bigram, trigram relative frequencies
unigram_rfs = perplexity.relative_frequencies(test)
bigram_rfs = perplexity.relative_frequencies(test, model='bigram')
trigram_rfs = perplexity.relative_frequencies(test, model='trigram')

# "Smoothing"
unigram_rfs = {unigram:rf for unigram, rf in unigram_rfs.items() if unigram in unigram_lm}
bigram_rfs = {bigram:rf for bigram, rf in bigram_rfs.items() if bigram in bigram_lm}
trigram_rfs = {trigram:rf for trigram, rf in trigram_rfs.items() if trigram in trigram_lm}

# TODO: compute perplexity for each LM
unigram_pp = perplexity.pp(unigram_lm, unigram_rfs)
bigram_pp = perplexity.pp(bigram_lm, bigram_rfs)
trigram_pp = perplexity.pp(trigram_lm, trigram_rfs)

# TODO: plot perplexity values against the coresponding ngrams
pps = [unigram_pp, bigram_pp, trigram_pp]
perplexity.plot_pps(pps)