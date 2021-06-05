from typing import Dict, List

def plot_pp(pps: Dict):
    """ Plots perplexity vs n for all languages in the corpus

    :param pps: dictionary with langs as keys and lists of perplexity scores as values
    """
    c = {'en': 'blue', 'fi': 'green', 'ru':'red', 'ta': 'yellow'}
    x = list(range(1,len(pps)+1))
    for lang in pps.keys():
      #Perplexity of train data
      y = pps[lang][0]
      plt.xlabel("n values of n-grams")
      plt.ylabel("Perplexity for train data")
      plt.plot(x,y, color = c[lang], legend = lang)
      #Perplexity of test data
      y = pps[lang][1]
      plt.xlabel("n values of n-grams")
      plt.ylabel("Perplexity for test data")
      plt.plot(x,y, color = c[lang], legend = lang)
    plt.legend()


def plot_pp_vs_alpha(pps: List[float], alphas: List[float]):
    """ Plots n-gram perplexity vs alpha
    :param pps: list of perplexity scores
    :param alphas: list of alphas
    """
    #Perplexity of test data for the given alpha range
    plt.plot(alphas, pps[1])
    plt.xlabel("Alpha values")
    plt.ylabel("Test set perplexities")
    plt.show()

