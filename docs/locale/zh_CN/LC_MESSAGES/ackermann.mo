��          D               l   �   m          *  �   -  �  �  �   �     =  �   Z  �   -   A(m, n) =
\begin{cases}
n+1 & \mbox{if } m = 0 \\
A(m-1, 1) & \mbox{if } m > 0 \mbox{ and } n = 0 \\
A(m-1, A(m, n-1)) & \mbox{if } m > 0 \mbox{ and } n > 0.
\end{cases} Ackermann Function The Ackermann function is a classic example of a recursive function, notable especially because it is not a primitive recursive function. It grows very quickly in value, as does the size of its call tree. The Ackermann function is usually defined as follows: sCrypt has devised a way to calculate the value of the Ackermann function using `native scripts`_. But it is definitely non-trivial. Below we present a much simpler version. Project-Id-Version:  sCrypt
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2021-10-08 12:13+0800
PO-Revision-Date: 2021-10-07 14:19+0000
Last-Translator: qtom zheng <zhfnjust@qq.com>, 2021
Language: zh_CN
Language-Team: Chinese (China) (https://www.transifex.com/scrypt-1/teams/121283/zh_CN/)
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.9.1
 A(m, n) =
\begin{cases}
n+1 & \mbox{if } m = 0 \\
A(m-1, 1) & \mbox{if } m > 0 \mbox{ and } n = 0 \\
A(m-1, A(m, n-1)) & \mbox{if } m > 0 \mbox{ and } n > 0.
\end{cases} 阿克曼 (Ackermann) 函数 阿克曼函数是递归函数的经典示例，特别值得注意的是它并不是一个原始递归函数。它的值增长得非常快，调用树也增长得非常快。阿克曼函数通常定义如下： sCrypt 设计了一种使用 `原生脚本`_ 计算阿克曼函数值的方法。该方法是非常复杂的。下面我们提供一个更简单的版本。 