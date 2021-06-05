from importlib import reload
import lm
import plots
lm = reload(lm)
plots = reload(plots)

N = 3

PPS = dict()

for lang, (train, test) in corpora.items():
  LM = lm.LanguageModel(train, test, N=N, alpha=1)
  # TODO: calculate perplexity
  PPS[lang] = LM.perplexity()

plots.plot_pp(PPS)

lang = "corpus.en"

K = 100

PPs_train = []
PPs_test = []

#Hyperparameter tuning for one language - trigram model

train, test = corpora[lang]
for alpha in range(0.0,1.0,0.01):
  LM = lm.LanguageModel(train, test, N = N, alpha = alpha)
  PPs_train.append(LM.perplexity()[0])
  PPs_test.append(LM.perplexity()[1])

PPs.append(PPs_train, PPs_test)
alphas = list(range(0.0,1.0,0.01))

plots.plot_pp_vs_alpha(PPs, alphas)