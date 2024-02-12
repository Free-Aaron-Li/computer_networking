#import "../typst/template/reference.typ": POINT,NOTE,TIP,cn_fake-italic,indent,example,line_cs,line_end,line_dc,regular_script,THEOREM
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

通信链路由不同物理媒介（同轴电缆、铜线、光纤和无线电频谱）组成。不同链路具有不同的*传输速率*（transmission
rate，以比特/秒（bit/s，或bps）度量）。

两台端系统发送数据时，会将数据分段并在每段首部加上字节。由此形成的信息包称为*分组*（packet）。

常见的分组交换机有*路由器*（router）和*链路层交换机*（link-layer switch）。链路交换机通常用于接入网中，路由器通常用于网络核心中。

从发送端系统到接收端系统，一个分组所经历的一系列通信链路和分组交换机成为通过该网络的*路径*（route或path）。

类比：分组类似于卡车，通信链路类似于高速公路和公路，分组交换机类似于交叉口，端系统类似于建筑物。

端系统通过*因特网服务提供商*（Internet Service
Provider，ISP）接入因特网。每个ISP自身就是一个网络（由多台分组交换机和多段通信链路组成），每个ISP网络独立管理，并运行IP协议，遵从一定的命名和地址规则。

端系统、分组交换机和其他因特网部件运行多个*协议*（protocol），由协议控制因特网中信息的接收和发送。

*TCP*（Transmission Control Protocol，传输控制协议）和*IP*（Internet
Protocol，网际协议）是因特网中最重要的两个协议。IP协议定义了路由器和端系统之间发送和接收的分组格式。因特网的主要协议统称为*TCP/IP*。

*因特网标准*（Internet standard）由因特网工程任务组（Internet Engineering Task
Force，IETF）研发。IETF的标准文档称为*请求评论*（Request For Comment，RFC）。RFC文档往往技术性很强并且相当详细。

=== 服务描述

从#regular_script[应用程序程序提供服务的基础设施]的角度描述因特网，对于因特网应用（运行在端系统之上）来说，由于它们需要涉及多个相互交换数据的端系统，所以被称为*分布式应用*（distributed
application）。

那么产生描述因特网的另一种方式：用于应用的平台。不同端系统上的应用该如何进行数据交换？，对此的解决方案是：与因特网相连的端系统提供了一套*套接字接口*（socket
interface），该接口规定了一系列发送程序必须遵循的规则集合。

同样，因特网上也存在一个套接字接口用于向接收数据的程序交付数据。

=== 什么是协议

网络协议类似于人类协议，在因特网中，涉及两个及以上远程通信实体的所有活动都受协议的约束。

*协议*（protocol）定义了在两个或多个通信实体之间交换的报文的格式和顺序，以及报文的发送/接受或其他事件所采取的操作。

计算机网络*广泛*使用协议，掌握计算机网络知识的过程就是理解网络协议的构成、原理和工作方式的过程。

== 网络边缘

将与因特网连接的计算机或其他设备称为端系统（因为位于因特网的边缘）。

主机有时会被划分成*客户机*（client）和*服务器*（server）两部分。

=== 接入网

*接入网*，指将端系统物理连接到其*边缘路由器*（edge router）的网络。边缘路由器是端系统到任何其他远程端系统的路径上的第一台路由器。

==== 家庭接入：DSL、电缆、FTTH和5G固定式无线

在本书中，提到美国家庭与因特网连接（即宽带住宅接入）一般采用*数字用户线*（Digital Subscriber
Line）或电缆。用户一般通过本地电话公司（也就是其ISP）获得DSL因特网接入，该过程大致如下：
$
 "家庭PC" <==> "DSL调制解调器" <==> "分频器" <==> "中心局的复用器（DSLAM）" <==> "因特网"
$

#indent DSL调制解调器的作用是将数字数据转换为高频音，通过电话线传输给本地中心局。同时中心局得到的模拟信号在DSLAM处被转换回数字形式。因为普通的电话信道与数据传输信道的频段不同，使得单根DSL线路能够被共享使用。

#align(
  center,
)[
  #tablem(
    ignore-second-row: false,
    align: center,
  )[
    |信道|频段|传输速率| |普通双向电话信道|0\~4k Hz频段|| |中速上行信道|4k Hz \~ 50k Hz频段|3.5M bps和16M bps|
    |高速下行信道|50k Hz \~ 1M Hz频段|24M bps和52M bps|
  ]
]

#indent 由于DSL受到传输距离、双绞线规格和电气干扰程度的影响，一般而言住宅速率小于最大速率。如果住宅不是位于本地中心局的5\~10英里范围内，那么该住宅必须采用其他形式的因特网接入。（事实上，在我国住宅的因特网接入通常是选择光纤到户方式）。

DSL利用的是本地电话基础设施，那么另一项接入方式*电缆因特网接入*（cable Internet access）则是利用有线电视基础设施。大致过程如下：
$
 "500~5000个家庭" <==> "同轴电缆" <==> "光纤节点" <==> "光缆" <==> "电缆头端的CMTS" <==> "因特网"
$

#indent 光缆将电缆头端连接到地区枢纽，在该系统中既用到电缆又用到光缆，所以经常被称为*混合光纤同轴*（Hybrid Fiber Coax，HFC）系统。

电缆接入因特网需要*电缆调制解调器*（cable modem）和*电缆调制解调器端接系统*（Cable Modem Termination
System，CMTS）。与DSL一样，HFC网络也划分为上行下行两个不对称信道。

#align(
  center,
)[
  #tablem(
    ignore-second-row: false,
    align: center,
  )[
    |信道|DOCSIS 2.0标准|DOCSIS 3.0标准| |上行信道|30M bps|100M bps| |下行信道|40M bps|1.2G bps|
  ]
]

#indent 由于电缆因特网接入的一个重要特征是*共享广播媒体*，所以当几个用户同时经下行信道下载文件，每个用户接收文件的实际速率将大大低于电缆总计的下行信道（这与DSL的个人信道不同）。但另一方面，如果活跃用户较少，那么用户几乎能够以全部的下行速率接收文件。

因为在接入同一个电缆因特网的用户很少会同一时刻发送请求，所以上行信道也是共享的，但是还是需要一个#regular_script[分布式多路访问协议]来协调传输和避免碰撞。

相对来讲，上述的两种接入网方式都已经过时了，现在更多的是采用光纤入户和5G无线。

*光纤到户*（Fiber To The Home，FTTH）。一般来讲是提供一条从本地中心局直接到家庭的光纤路径，以此提供高速传输速率（大概能提供100M
bps至1G bps [2024]）。

光纤分布方案一般有以下三种：
#pad(x: 2em)[
  + 直接光纤。从本地中心局到每户设置一根光纤

  + 从本地中心局出来的光纤在邻近家庭间进行共享，在这种分配方式下，存在两种光纤分布体系结构
    - *有源光纤网络*（Active Optical Network，AON）
    - *无源光纤网络*（Passive Optical Network，PON）
  AON本质上就是交换以太网。
]

在PON分布体系结构下的FTTH，每个家庭都有一个*光纤网络端接器*（Optical Network
Terminator，ONT），在国内通常称为“光猫”。其通过专用光纤连接到邻近分配器（splitter），再由分配器将一些家庭连接到一根共享光纤上，由该光纤连接到本地中心局的*光纤线路端接器*（Optical
Line Terminator，OLT）上。大概过程如下：
$
  "众多家庭的ONT" <==> "光纤分配器" <==> "中心局的OLT" <==> "因特网"
$

OLT和ONT进行光信号和电信号之间的转换，以此传递因特网信息。

最后一种接入方式：*5G固定式无线*。使用波束成形技术，数据通过无线方式从供应商的基站发送到家中的调制解调器。

==== 企业（和家庭）接入：以太网和WiFi

现如今，更多的环境使用*局域网*（LAN）将端系统连接到边缘路由器上。通常采用的局域网技术是以太网，以太网用户使用双绞线与一台以太网交换机相连，再与因特网相连，实现100M
bps或1G
bps乃至更大的传输速率。

同样在无线LAN环境下，无线用户通过一个接入点传输数据，该接入点再与有线因特网连接。例如：基于IEEE 802.11技术的无线LAN接入（更通俗称为WiFi）。

==== 广域网无线接入：3G、LTE 4G和5G

通过使用蜂窝移动电话相同的无线基础设施，利用蜂窝网提供商运营的基站来发送和接收分组。在广域网下，用户可以位于基站数万米外通信。
