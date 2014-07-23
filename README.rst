Trustpilot Anagram
==================

http://followthewhiterabbit.trustpilot.com/cs/step3.html


Strategy
--------

1. Filter down the ``wordlist`` to only contain words that "could work" —
   meaning, that could be part of the secret phrase. (Slow due to me having fun;
   approx. 4 seconds.)

2. Find all combinations of words that has the letters "poultry outwits ants".
   Not more, not less.

3. For any of the above combinations, find all permutations of the words.

4. MD5 hash each of these permutations and check if it matches
   ``4624d200580677270a54ccff86b9610e``.


Run it
------

.. code-block:: sh

    curl -O http://followthewhiterabbit.trustpilot.com/cs/wordlist
    ruby anagram-finder.rb


Thoughts while working on it (and ripping some Far til fire DVDs for the flight)
--------------------------------------------------------------------------------

The hint regarding ``wordlist`` being modified. Is ``trustpilot`` present? Yes.
Obvious anagrams? Dunno, don't care. Programming is faster.

Thinking how to do backtracing. Recursion is just beautiful, but a kid is
waking up all the time. Just use ``#combination`` and ``#permutation``; I'll let
a Digital Ocean droplet to the work for me. (`Pointy finger`_; let's see if it's
fast enough.)

.. _`Pointy finger`: http://blog.codinghorror.com/hardware-is-cheap-programmers-are-expensive/

It gave me ``trustpilot wants you``. Nah. Okay, then why did you have fun
inserting ``trustpilot``?

While watching the "progress bar", I saw repetitions. An error of mine?

.. code-block:: sh

    sort wordlist | uniq -d | wc -l

Nope. Just a pretty weird wordlist with 2720 words present more than once.
"Learn to sanitize"? Well, sloppily created ``wordlist`` I'd say.

Maybe there are even more "gems" like this? ``^C``'ed and fixed the
``wordlist``.  Couldn't hold it back even though it probably wouldn't be
noticeably faster after the fix.


Total run time is approx 15 minutes. Hoped it to be far worse; then I could
justify spending some time on backtracing.
