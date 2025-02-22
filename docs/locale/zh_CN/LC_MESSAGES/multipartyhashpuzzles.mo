��          L               |   D  }      �    �  {   �     X  �  q  )  )  ,   S  �   �  h   |     �   In a hash puzzle contract, the spender has to provide a preimage ``x`` that hashes to a predefined value ``y`` to unlock a UTXO. It can be extended to multiple parties so that multiple preimages have to be provided such that ``y1 = H(x1)``, ``y2 = H(x2)``, ..., ``yN = H(xN)`` [#]_. Below shows an examples of three parties. Multiparty Hash Puzzles The above solution is problematic when ``N`` is large since all ``N`` hashes have to be included in the locking script, bloating the transaction. Instead, we can combine all ``y``'s into a single y such that ``y = H(H(y1 || y2) || y3)`` [#]_ as shown below. ``H`` is a hash function. An online hash calculator can be found `here <https://www.pelock.com/products/hash-calculator>`_. ``||`` is concatenation. Project-Id-Version:  sCrypt
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2021-10-08 12:13+0800
PO-Revision-Date: 2021-10-07 06:10+0000
Last-Translator: qtom zheng <zhfnjust@qq.com>, 2021
Language: zh_CN
Language-Team: Chinese (China) (https://www.transifex.com/scrypt-1/teams/121283/zh_CN/)
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.9.1
 在哈希谜题合约中，花费者必须提供一个原像 ``x``，它散列到一个预定义的值 ``y`` 来解锁一个 UTXO。它可以扩展到多方，因此必须提供多个原像，使得 ``y1 = H(x1)``, ``y2 = H(x2)``, ..., ``yN = H(xN) )`` [#]_.下面显示了一个三方的例子。 多方哈希谜题 (Multiparty Hash Puzzles) 当 N 很大时，上述解决方案是有问题的，因为所有的 N 哈希都必须包含在锁定脚本中，从而使交易膨胀。相反，我们可以将所有 ``y`` 组合成一个 y，使得 ``y = H(H(y1 || y2) || y3)`` [#]_ 如下所示。 ``H`` 是一个哈希函数。`在线哈希计算器 <https://www.pelock.com/products/hash-calculator>`_ ``||`` 表示串联。 