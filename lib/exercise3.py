from collections import deque

from itertools import chain, repeat

from common import tokenize

def windowed(seq, n, fillvalue=None, step=1):
    """Return a sliding window of width *n* over the given iterable.
    Note: Taken from library more-itertools
    """
    if n < 0:
        raise ValueError('n must be >= 0')
    if n == 0:
        yield tuple()
        return
    if step < 1:
        raise ValueError('step must be >= 1')

    window = deque(maxlen=n)
    i = n
    for _ in map(window.append, seq):
        i -= 1
        if not i:
            i = step
            yield tuple(window)

    size = len(window)
    if size < n:
        yield tuple(chain(window, repeat(fillvalue, n - size)))
    elif 0 < i < min(step, n):
        window += (fillvalue,) * i
        yield tuple(window)


def find_kmers(file_path):

    tokens = tokenize(file_path)

    for token in tokens:
        if len(token) >= 8:
            print(list(windowed(token, 8)))


