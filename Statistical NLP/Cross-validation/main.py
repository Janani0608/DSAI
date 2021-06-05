# Load data
from importlib import reload
from pathlib import Path
from statistics import mean
import utility
import lm
import matplotlib.pyplot as plt
lm = reload(lm)
utility = reload(utility)

#genesis_text = Path("data/genesis.txt").open('r').read()
#apocalypsis_text = Path("data/apocalypsis.txt").open('r').read()

genesis_text = Path("genesis.txt").open('r').read()
apocalypsis_text = Path("apocalypsis.txt").open('r').read()

# TODO: preprocess
genesis_preprocessed = utility.preprocess_data(genesis_text)
apocalypsis_preprocessed = utility.preprocess_data(apocalypsis_text)

# TODO: concatenate
corpus = genesis_preprocessed + apocalypsis_preprocessed

# TODO: train, test split
train, test = utility.train_test_split_data(corpus)


trigram_lm = lm.LanguageModel(train, test, 3, 1)
pp = trigram_lm.perplexity()
print(f'Perplexity of the trigram model after applying smoothing with alpha = 1: {pp}')

cv_folds = utility.k_validation_folds(corpus, k_folds=5)

#Checking if the k_folds are of the same size
curr_kfold_size = 0
even_kfolds = True
for k_fold in cv_folds:
  if curr_kfold_size == 0:
    curr_kfold_size = len(k_fold)
  else:
    if curr_kfold_size == len(k_fold):
      continue
    else:
      even_kfolds = False
if even_kfolds:
  print(f"Every k_fold is of the same size; one k_fold size = {curr_kfold_size}")

pp = []
for k_fold in cv_folds:
  train_k, test_k = utility.train_test_split_data(k_fold)
  lm_k = lm.LanguageModel(train_k, test_k, 3, 1)
  pp_k = lm_k.perplexity()
  pp.append(pp_k)

print(f"Perplexities calculated for the 5 k-folds: {pp}")
print(f"Average perplexity: {round(mean(pp), 4)}")

alphas = [x*0.01 for x in range(1,101)]
pps_trigram = []
for alpha in alphas:
  # TODO: estimate LMs!
  pp = []
  for k_fold in cv_folds:
    train_k, test_k = utility.train_test_split_data(k_fold)
    lm_k = lm.LanguageModel(train_k, test_k, 3, alpha)
    pp_k = lm_k.perplexity()
    pp.append(pp_k)
  pps_trigram.append(mean(pp))
plt.plot(alphas, pps_trigram)
plt.xlabel("Alpha values")
plt.ylabel("Perplexity scores")
plt.show()

pps_unigram = []
for alpha in alphas:
  pp = []
  for k_fold in cv_folds:
    train_k, test_k = utility.train_test_split_data(k_fold)
    lm_k = lm.LanguageModel(train_k, test_k, 1, alpha)
    pp_k = lm_k.perplexity()
    pp.append(pp_k)
  pps_unigram.append(mean(pp))
print("Unigram perplexity scores:")
plt.plot(alphas, pps_unigram)
plt.xlabel("Alpha values")
plt.ylabel("Perplexity scores")
plt.show()

pps_bigram = []
for alpha in alphas:
  pp = []
  for k_fold in cv_folds:
    train_k, test_k = utility.train_test_split_data(k_fold)
    lm_k = lm.LanguageModel(train_k, test_k, 2, alpha)
    pp_k = lm_k.perplexity()
    pp.append(pp_k)
  pps_bigram.append(mean(pp))
print("Bigram perplexity scores:")
plt.plot(alphas, pps_bigram)
plt.xlabel("Alpha values")
plt.ylabel("Perplexity scores")
plt.show()