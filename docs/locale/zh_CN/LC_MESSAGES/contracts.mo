Þ    O                                   2    ¼  £   Ô  í   x     f      	     	      	  	   8	     B	     S	     c	  ú   p	     k
     s
     
  ×   
     w       Ý        m     r     x               «    ¾  7  À  u   ø     n     q  U   }  U   Ó  B   )  P   l     ½  ¼   Q  1     1   @  G   r  G   º       ¢     ª   B  ¬   í  ²     R   M  U         ö  
     "     $   :     _     g     n          £     ¼     Ò     í     	     %  3   ,  -   `  2     .   Á  Ú  ð     Ë  >   j     ©  4   É     þ               2  >   H  ·       ?     P      a  Ì        Ï  È   Z   £   #!     Ç!     Ú!     á!     ÷!     "     "     %"  ü   2"     /#     ;#     M#  é   _#     I$     V$  ±   [$     %     %     %     &%     3%     H%  è   U%  &  >&  ;   e'     ¡'     ¤'  V   °'  V   (  C   ^(  Q   ¢(     ô(  º   )  .   K*  1   z*  ?   ¬*  :   ì*     '+     Ã+  ¾   `,  ¯   -  ­   Ï-  O   }.  D   Í.     /  
   (/  "   3/  $   V/     {/     /     /     ¦/     ¿/     Ø/  /   î/  9   0  0   X0     0  ?   0  <   Ü0  B   1  D   \1  »  ¡1     ]3  <   ß3     4  :   <4     w4     ~4     4     «4  b   Á4   **Constructor** **Instance methods** A contract can be instantiated by ``new``. A ``public`` function can be called from ``require``, which takes boolean expression as input. A library is the same with a contract, except it does not contain any public function. It is only intended to be imported by a contract or other libraries. It thus cannot be independently deployed and called. It is frequently used to group related constants and static functions. A single file can define multiple contracts. In this case, the last contract acts as the main contract and is what gets compiled. Other contracts are dependencies. Alternatively, the contract above can be broken into three files. The ``Pay2PubKeyHash`` contact ``import``\s other two contracts as dependencies. This allows reusing contracts written by others and forms the basis of contract libraries. As an example, contract ``CheckLockTimeVerify`` ensures coins are timelocked and cannot be spent before ``matureTime`` is reached, similar to `OP_CLTV`_. Constructor parameters Contract Contract ``OP_PUSH_TX`` Full List HashPuzzleX [#]_ HashedMap<K, V> HashedSet<V> In the following example, a standard P2PKH contract is rewritten using two other contracts: a hash puzzle contract that checks the public key matches the public key hash, and a Pay-to-PubKey (P2PK) contract that verifies signature matches public key. Library Library ``HashedMap`` Library ``HashedSet`` More details can be found in this article `OP_PUSH_TX`_. To customize ECDSA signing, such as choosing ephemeral key, there is a more general version called ``Tx.checkPreimageAdvanced()``. see `Advanced OP_PUSH_TX`_. Multiple Contracts None One grave misconception regarding bitcoin script is that its access is only limited to the data provided in the locking script and corresponding unlocking script. Thus, its scope and capability are greatly underestimated. P2PK P2PKH PubKey pubKey Public function Ripemd160 pubKeyHash Standard Contracts The `HashedMap` library provides a map/hashtable-like data structure. Unique keys and their corresponding values are hashed before being stored. Most functions of `HashedMap` require not only a key, but also its index, ranked by key hash in ascending order. The `HashedSet` library provides a set-like data structure. It can be regarded as a special `HashedMap` where a value is the same with its key and is thus omitted. Unique values are hashed before being stored. Most functions of `HashedSet` require an index, ranked by the value's sha256 hash in ascending order. The following example shows usage of the standard contract ``P2PKH`` that corresponds to Pay-to-PubKey-Hash contract. Tx Y [#]_ hash ``HashedMap(bytes data)`` Create an instance of ``HashedMap`` with some initial data. ``HashedSet(bytes data)`` Create an instance of ``HashedSet`` with some initial data. ``X`` is hashing function and can be Ripemd160/Sha1/Sha256/Hash160 ``Y`` is hashing function return type and can be Ripemd160/Sha1/Sha256/Ripemd160 ``add(E entry, int index) : bool`` Add `entry` to set with the key index given by `index`. Returns `true` if successful; otherwise returns `false`. ``canGet(K key, V val, int keyIndex): bool`` Check whether we can get a (`key`, `val`) pair with the key index given by `keyIndex`. Returns `true` if successful; otherwise returns `false`. ``clear() : bool`` Delete all entries of the map. ``clear() : bool`` Delete all entries of the set. ``data() : bytes`` Returns the internal data representation of the map. ``data() : bytes`` Returns the internal data representation of the set. ``delete(E entry, int index) : bool`` Delete the entry with given `entry` and the index is `index`. Returns `true` if successful; otherwise returns `false`. ``delete(K key, int keyIndex) : bool`` Delete the entry with given `key` and the key index is `keyIndex`. Returns `true` if successful; otherwise returns `false`. ``has(E entry, int index) : bool`` Check whether `entry` exists in the set and its index is `index`. Returns `true` if both conditions are met; otherwise returns `false`. ``has(K key, int keyIndex) : bool`` Check whether `key` exists in the map and its index is `keyIndex`. Returns `true` if both conditions are met; otherwise returns `false`. ``set(K key, V val, int keyIndex) : bool`` Insert or update a (`key`, `val`) pair with the key index given by `keyIndex`. Returns `true` if successful; otherwise returns `false`. ``size() : int`` Returns the size of map, i.e. the number of the keys it contains. ``size() : int`` Returns the size of set, i.e. the number of the entries it contains. add(V val, int index) bytes data canGet(K key, V val, int keyIndex) checkPreimage(bytes sighashPreimage) clear() data() delete(K key, int keyIndex) delete(V val, int index) has(K key, int keyIndex) has(V val, int index) hashOutputs (32-byte hash) hashPrevouts (32-byte hash) hashSequence (32-byte hash) import nLocktime of the transaction (4-byte little endian) nSequence of the input (4-byte little endian) nVersion of the transaction (4-byte little endian) outpoint (32-byte hash + 4-byte little endian) sCrypt comes with a powerful contract called ``Tx`` that allows inspection of the **ENTIRE TRANSACTION** containing the contract itself, besides the locking script and unlocking script. It can be regarded as a pseudo opcode ``OP_PUSH_TX`` that pushes the current transaction into the stack, which can be inspected at runtime. More precisely, it enables inspection of the preimage used in signature verification defined in `BIP143`_. The format of the preimage is as follows: sCrypt comes with standard libraries that define many commonly used contracts. They are included by default and do not require explicit ``import`` to be used. scriptCode of the input (serialized as scripts inside CTxOuts) set(K key, V val, int keyIndex) sighash type of the signature (4-byte little endian) size() spend(Sig sig) spend(Sig sig, PubKey pubKey) spend(bytes preimage) value of the output spent by this input (8-byte little endian) Project-Id-Version:  sCrypt
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2021-11-29 09:04+0800
PO-Revision-Date: 2021-10-07 06:10+0000
Last-Translator: qtom zheng <zhfnjust@qq.com>, 2021
Language: zh_CN
Language-Team: Chinese (China) (https://www.transifex.com/scrypt-1/teams/121283/zh_CN/)
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.9.1
 **æé å½æ°** **å®ä¾æ¹æ³** åçº¦å¯ä»¥éè¿ ``new`` æ¥å®ä¾åã``require`` å½æ°çåæ°æ¯æ¡ä»¶è¡¨è¾¾å¼ï¼ è°ç¨åçº¦ç ``public`` å½æ°å¯ä»¥ä½ä¸ºæ¡ä»¶è¡¨è¾¾å¼ä¼ å¥ã åºä¸åçº¦ç¸åï¼åªæ¯å®ä¸åå«ä»»ä½å¬å±å½æ°ãå®ä»ç¨äºç±åçº¦æå¶ä»åºå¯¼å¥ãå æ­¤å®ä¸è½è¢«ç¬ç«é¨ç½²åè°ç¨ãå®ç»å¸¸ç¨äºå¯¹ç¸å³å¸¸éåéæå½æ°è¿è¡åç»ã ä¸ä¸ªæä»¶å¯ä»¥å®ä¹å¤ä¸ªåçº¦ãå¨è¿ç§æåµä¸ï¼æåä¸ä¸ªåçº¦ä½ä¸ºä¸»åçº¦å¹¶ä¸è¢«ç¼è¯ãå¶ä»åçº¦æ¯ä¾èµé¡¹ã æèï¼å¯ä»¥å°ä¸è¿°åçº¦åå°ä¸ä¸ªæä»¶ä¸­ã ``Pay2PubKeyHash`` åçº¦ ``import`` å¶ä»ä¸¤ä¸ªåçº¦ä½ä¸ºä¾èµãè¿å°±å¯ä»¥éç¨å¶ä»äººåçåçº¦ï¼æä¸ºæå»ºåçº¦åºçåºç¡ã ä¾å¦ï¼åçº¦ ``CheckLockTimeVerify`` ç¡®ä¿åçº¦ä¸­çå¸æ¯æ¶é´éå®çï¼å¹¶ä¸ä¸è½å¨æ¶é´è¾¾å° ``matureTime`` ä¹åè±è´¹ï¼ç±»ä¼¼äº `OP_CLTV`_ã æé å½æ°åæ° åçº¦ ``OP_PUSH_TX`` åçº¦ å®æ´åè¡¨ HashPuzzleX [#]_ HashedMap<K, V> HashedSet<V> å¨ä¸é¢è¿ä¸ªä¾å­ä¸­ï¼æ åçP2PKHåçº¦è¢«æ¹åä¸ºä¸¤ä¸ªå¶ä»åçº¦ï¼ä¸ä¸ªç¨æ¥æ£æ¥å¬é¥åå¬é¥åå¸æ¯å¦å¹éçåå¸è°é¢ï¼hash puzzleï¼åçº¦ï¼è¿æä¸ä¸ªæ£æ¥ç­¾ååå¬é¥æ¯å¦å¹éçPay-to-PubKeyï¼P2PKï¼åçº¦ã Library åº ``HashedMap`` åº ``HashedSet`` åº æ´å¤ç»èå¯ä»¥å¨è¿ç¯æç«  `OP_PUSH_TX ææ¯`_ ä¸­æ¾å°ãè¦èªå®ä¹ ECDSA ç­¾åï¼ä¾å¦éæ©ä¸´æ¶å¯é¥ï¼æä¸ä¸ªæ´éç¨ççæ¬ï¼ç§°ä¸º ``Tx.checkPreimageAdvanced()`` ãè¯·åé `é«çº§ OP_PUSH_TX ææ¯`_ã å¤ä¸ªåçº¦ None å¯¹æ¯ç¹å¸èæ¬çä¸ä¸ªä¸¥éè¯¯è§£æ¯ï¼èæ¬åªè½è®¿é®éå®èæ¬ä»¥åå¯¹åºçè§£éèæ¬ä¸­æä¾çæ°æ®ãå æ­¤ï¼èæ¬çèå´åè½åè¢«å¤§å¤§ä½ä¼°äºã P2PK P2PKH PubKey pubKey å¬å±å½æ° Ripemd160 pubKeyHash æ ååçº¦ `HashedMap` åºæä¾äºä¸ç§ç±»ä¼¼äºåå¸è¡¨çæ°æ®ç»æãå¯ä¸é®åå®ä»¬å¯¹åºçå¼å¨å­å¨ä¹åè¢«æ£åã `HashedMap` çå¤§å¤æ°å½æ°ä¸ä»éè¦ä¸ä¸ªé®ï¼è¿éè¦å®çç´¢å¼ï¼æé®çåå¸ååºæåã `HashedSet` åºæä¾äºä¸ä¸ªç±»ä¼¼éåçæ°æ®ç»æãå®å¯ä»¥è¢«è§ä¸ºä¸ä¸ªç¹æ®ç `HashedMap`ï¼å³é®å¼å¯¹çå¼ä¸å¶é®ç¸åï¼å æ­¤è¢«çç¥ãå¯ä¸å¼å¨å­å¨ä¹åè¢«æ£åã `HashedSet` çå¤§å¤æ°å½æ°é½éè¦ä¸ä¸ªç´¢å¼ï¼æå¼ç sha256 åå¸å¼ååºæåã å¦ä¸ä¾å­å±ç¤ºäºå¯¹æ ååçº¦ ``P2PKH`` çä½¿ç¨ã Tx Y [#]_ hash ``HashedMap(bytes data)`` ä½¿ç¨ä¸äºåå§æ°æ®åå»ºä¸ä¸ª ``HashedMap`` å®ä¾ã ``HashedSet(bytes data)`` ä½¿ç¨åå§æ°æ® data åå»ºä¸ä¸ª ``HashedSet`` å®ä¾ã ``X`` æ¯æ£åå½æ°ï¼å¯ä»¥æ¯ ``Ripemd160/Sha1/Sha256/Hash160`` ``Y`` æ¯åå¸å½æ°è¿åç±»åï¼å¯ä»¥æ¯ ``Ripemd160/Sha1/Sha256/Ripemd160`` ``add(E entry, int index) : bool`` æ·»å å·æç»å® `entry` é¡¹ä¸ç´¢å¼ä¸º `index` çæ¡ç®ãå¦ææååè¿åâtrueâï¼å¦åè¿å `false`ã ``canGet(K key, V val, int keyIndex): bool``  éè¿é®ç´¢å¼ `keyIndex` æ£æ¥æä»¬æ¯å¦å¯ä»¥å¾å°ä¸ä¸ª (`key`, `val`) å¯¹ãå¦ææååè¿å `true` ï¼å¦åè¿å `false`ã ``clear() : bool`` å é¤mapçæææ¡ç®ã ``clear() : bool`` å é¤éåçæææ¡ç®ã ``data() : bytes`` è¿å HashedMap çåºååæ°æ®è¡¨ç¤ºã ``data() : bytes`` è¿åéåçåé¨åºååæ°æ®ã ``delete(E entry, int index) : bool`` å é¤å·æç»å® `entry` é¡¹ä¸ç´¢å¼ä¸º `index` çæ¡ç®ãå¦ææååè¿å `true`ï¼å¦åè¿å `false`ã ``delete(K key, int keyIndex) : bool`` å é¤ç»å® `key` çæ¡ç®ï¼å¹¶ä¸é®ç´¢å¼æ¯ `keyIndex` ãå¦ææååè¿å`true`ï¼å¦åè¿å `false`ã ``has(E entry, int index) : bool`` æ£æ¥éåä¸­æ¯å¦å­å¨å·æç»å® `entry` é¡¹ä¸ç´¢å¼ä¸º `index` çæ¡ç®ãå¦æä¸¤ä¸ªæ¡ä»¶é½æ»¡è¶³ï¼åè¿å `true`ï¼å¦åè¿å`false`ã ``has(K key, int keyIndex) : bool`` æ£æ¥ HashedMap ä¸­æ¯å¦å­å¨ `key`ï¼å¶ç´¢å¼ä¸º `keyIndex`ãå¦æä¸¤ä¸ªæ¡ä»¶é½æ»¡è¶³ï¼åè¿å `true`ï¼å¦åè¿å `false`ã ``set(K key, V val, int keyIndex) : bool`` ä½¿ç¨ç»åºçé®ç´¢å¼ `keyIndex` æå¥ææ´æ° (`key`, `val`) å¯¹ãå¦ææååè¿å  `true` ï¼å¦åè¿å `false` ã ``size() : int`` è¿å HashedMap çå¤§å°ï¼æ¯å¦å®åå«çé®çæ°éã ``size() : int`` è¿åéåçå¤§å°ï¼å³å®åå«çæ¡ç®æ°ã add(V val, int index) bytes data canGet(K key, V val, int keyIndex) checkPreimage(bytes sighashPreimage) clear() data() delete(K key, int keyIndex) delete(V val, int index) has(K key, int keyIndex) has(V val, int index) hashOutputs (è¾åºçåå¸ 32å­èåå¸å¼) hashPrevouts (è¾å¥çè¾åºç¹åå¸ 32å­èåå¸å¼) hashSequence (åºåå·åå¸ 32å­èåå¸å¼) å¯¼å¥ï¼importï¼ nLocktime of the transaction (äº¤æçnLocktime 4å­èå°ç«¯) nSequence of the input (æ­¤è¾å¥çåºåå· 4å­èå°ç«¯)  nVersion of the transaction  (äº¤æççæ¬å·,  4å­èå°ç«¯) outpoint (æ­¤è¾å¥çè¾åºç¹ 32å­èåå¸å¼ + 4å­èå°ç«¯ï¼ sCryptæä¾äºä¸ä¸ªå¼ºå¤§çåçº¦å«å ``Tx``ã å®åè®¸åçº¦è®¿é®åçº¦æå¨ç æ´ä¸ªäº¤æ ï¼åæ¬éå®èæ¬åè§£éèæ¬ãæä»¬æè¿ç§æ¹æ³å½æä¸ä¸ªä¼ªæä½ç  ``OP_PUSH_TX`` ï¼å®å¯ä»¥æå½åäº¤æåå°æ éï¼è¿æ ·å°±å¯ä»¥å¨è¿è¡æ¶è®¿é®äºã æ´åç¡®å°è¯´ï¼å¯ä»¥è®¿é®çæ¯å¨ç­¾åæ ¡éªæ¶ç¨å°çåå preimage ï¼ å¨ `BIP143`_. ä¸­æååçè¯¦ç»å®ä¹ãååçæ°æ®æ ¼å¼å¦ä¸ï¼ sCryptèªå¸¦æ ååºï¼éé¢å®ä¹äºè®¸å¤å¸¸ç¨çåçº¦ãæ ååºæ¯é»è®¤å°±å¯¼å¥çï¼ä¸éè¦å ``import`` è¯­å¥ã scriptCode of the input (è¾å¥å¯¹åºçUTXOçéå®èæ¬) set(K key, V val, int keyIndex) sighash type of the signature (ç­¾åç±»å 4å­èå°ç«¯) size() spend(Sig sig) spend(Sig sig, PubKey pubKey) spend(bytes preimage) value of the output spent by this input (æ­¤è¾å¥å¯¹åºçè¾åºä¸­åå«çèªæ° 8å­èå°ç«¯) 