=================
Stateful Contract
=================

Bitcoin/sCrypt contract uses Unspent Transaction Output (UTXO) model: a contract is inside a UTXO, dictating how the bitcoins in the UTXO can be spent.
When a UTXO is spent (i.e., an sCrypt contract public function is called successfully), the contract is terminated.
For a contract to keep state and able to be called multiple times while carrying the mutable state, these steps have to be followed.

State Decorator
===============
Declare any property that is part of the state with a decorator ``@state``.
The state property can be used the same way as a regular property.

.. code-block:: solidity

    contract Counter {
        @state
        int counter;
        
        constructor(int counter) {
            this.counter = counter;
        }
        
    }

Update the State
================
A contract can keep state across chained transactions by storing it in the locking script.
In the following example, a contract goes from ``state0`` to ``state1``, and then to ``state2``.
Input in transaction 1 ``tx1`` is spending UTXO in ``tx0``, and ``tx2`` spending ``tx1``.

.. image::  _static/images/state.png
    :width: 400px
    :alt: keep state
    :align: center

When you are ready to pass the new state into the next UTXO, simply call built-in function ``this.updateState()`` with two arguments:
- `txPreimage`: it is the :ref:`preimage<pushtx-label>` of the current spending transaction. It must only have one output and have the new state in it.
- `amount`: the number of satoshis in that single output.

The function is automatically generated for every stateful contract, i.e., a contract that has at least one property decorated with ``@state``.
Use ``updateStateSigHashType`` if you need a customed sighash type, different from the default of ``SigHash.ALL | SigHash.FORKID``.

The following is an example contract that records the number of times ``increment()`` have been called.

.. code-block:: solidity

    contract Counter {
        @state
        int counter;
        
        public function increment(SigHashPreimage txPreimage, int amount) {
            // mutate state
            this.counter++;

            require(this.updateState(txPreimage, amount));

            // customed sighash type
            // require(this.updateStateSigHashType(txPreimage, amount, SigHash.SINGLE | SigHash.FORKID));
        }
    }


Advanced
========

If you ever need to have more fine-grained control of the state, e.g., having multiple outputs in the spending transaction, 
you call another built-in function ``this.getStateScript()`` to get the locking script containing the latest stateful properties. 

Next, you use :ref:`OP_PUSH_TX<pushtx-label>` to ensure the output[s] containing the state go into the current spending transaction.
It is equivalent to the contract above using ``this.updateState()``.

.. code-block:: solidity

    contract Counter {
        @state
        int counter;
        
        public function increment(SigHashPreimage txPreimage, int amount) {    
            // mutate state
            this.counter++;

            require(Tx.checkPreimage(txPreimage));

            // get the locking script containing the latest stateful properties
            bytes outputScript = this.getStateScript();

            // construct an output from its locking script and satoshi amount
            bytes output = Utils.buildOutput(outputScript, amount);
            // only 1 input here
            require(hash256(output) == SigHash.hashOutputs(txPreimage));
        }
    }

Restrictions
============
For any public function to access a stateful property, it must include a ``SighashPreimage`` parameter that is validated with ``Tx.checkPreimage()``, i.e., with :ref:`OP_PUSH_TX<pushtx-label>` .
This does not apply to any non-public function, including constructors.

.. code-block:: solidity

    contract Counter {
        @state
        int counter;

        constructor(int counter) {
            // OK: not a public function
            this.counter = counter;
        }
        
        public function increment(SigHashPreimage txPreimage, int amount) {    
            // OK
            this.counter++;

            require(Tx.checkPreimage(txPreimage));
        }

        public function foo(SigHashPreimage txPreimage, int amount) {
            require(Tx.checkPreimageOpt(txPreimage));
    
            // OK
            this.counter++;

            require(true);
        }

        public function bar(SigHashPreimage txPreimage) {
            // Not OK: missing Tx.checkPreimage*()
            this.counter++;

            require(true);
        }

        public function baz(int i) {
            // Not OK: missing SigHashPreimage
            this.counter++;

            require(true);
        }

        function baz() : int {
            // OK: not a public function
            return this.counter;
        }
    }
