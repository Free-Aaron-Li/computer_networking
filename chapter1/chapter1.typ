#import "../typst/template/reference.typ": POINT,NOTE,TIP,cn_fake-italic,indent,example,line_cs,line_end,line_dc,THEOREM
#import "../typst/template/page/basic.typ":basic
#import "@preview/tablem:0.1.0": tablem

#let center_title = [
    LEARNING \ Computer Networking \
    #text(size: 15pt)[A Top-Down Approach]
 ]
#show:doc=>basic(
  title: center_title, // 标题
  authors: ((
    name: "aaron.li",
    affiliation: "pzhu",
    email: "communicate_aaron@outlook.com",
  ),),
  doc,
  chapter: 1,
)

= 计算机网络和因特网

#image("./asset/image/计算机网络与因特网.png")

目的：不仅能够理解今天的网络，也能理解明天的网络。

== 什么是因特网

我们主要用*公共因特网*作为讨论的主要载体。

对因特网，主要从两个方面描述：

1.因特网的具体构成：基本硬件和软件组建

2.根据分布式应用提供服务的联网基础设施

=== 具体构成描述

*主机*（host，*端系统*（end system））,例如：PC、手机、平板等。

端系统通过*通信链路*（communication link）和*分组交换机*（packet switch）的网络连接在一起。

通信链路由不同物理媒介（同轴电缆、铜线、光纤和无线电频谱）组成。不同链路具有不同的*传输速率*（transmission rate，以比特/秒（bit/s，或bps）度量）。

两台端系统发送数据时，会将数据分段并在每段首部加上字节。由此形成的信息包称为*分组*（packet）。

常见的分组交换机有*路由器*（router）和*链路层交换机*（link-layer switch）。链路交换机通常用于接入网中，路由器通常用于网络核心中。

从发送端系统到接收端系统，一个分组所经历的一系列通信链路和分组交换机成为通过该网络的*路径*（route或path）。

类比：分组类似于卡车，通信链路类似于高速公路和公路，分组交换机类似于交叉口，端系统类似于建筑物。

端系统通过*因特网服务提供商*（Internet Service Provider，ISP）接入因特网。每个ISP自身就是一个网络（由多台分组交换机和多段通信链路组成），每个ISP网络独立管理，并运行IP协议，遵从一定的命名和地址规则。

端系统、分组交换机和其他因特网部件运行多个*协议*（protocol），由协议控制因特网中信息的接收和发送。

*TCP*（Transmission Control Protocol，传输控制协议）和*IP*（Internet Protocol，网际协议）是因特网中最重要的两个协议。IP协议定义了路由器和端系统之间发送和接收的分组格式。因特网的主要协议统称为*TCP/IP*。

*因特网标准*（Internet standard）由因特网工程任务组（Internet Engineering Task Force，IETF）研发。IETF的标准文档称为*请求评论*（Request For Comment，RFC）。RFC文档往往技术性很强并且相当详细。

=== 服务描述

从#text(font: ("Noto Sans CJK SC"),size: 11pt)[应用程序程序提供服务的基础设施]的角度描述因特网，对于因特网应用（运行在端系统之上）来说，由于它们需要涉及多个相互交换数据的端系统，所以被称为*分布式应用*（distributed application）。

那么产生描述因特网的另一种方式：用于应用的平台。不同端系统上的应用该如何进行数据交换？，对此的解决方案是：与因特网相连的端系统提供了一套*套接字接口*（socket interface），该接口规定了一系列发送程序必须遵循的规则集合。

同样，因特网上也存在一个套接字接口用于向接收数据的程序交付数据。


