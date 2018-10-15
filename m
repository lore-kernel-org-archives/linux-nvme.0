From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Oct 2018 00:38:31 -0700
Subject: Help needed: nvmet configuration
In-Reply-To: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>
References: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>
Message-ID: <75a10e13-29fd-df82-0289-b4f6948365c0@grimberg.me>


> /ports/1> set addr adrfam=ipv4
> 
> Parameter adrfam is now 'ipv4'.
> 
> /ports/1> set addr trtype=rdma
> 
> Parameter trtype is now 'rdma'.
> 
> /ports/1> set addr trsvcid=4420
> 
> Parameter trsvcid is now '4420'.
> 
> /ports/1> set addr traddr=12.12.12.38
> 
> Parameter traddr is now '12.12.12.38'.

So you set this but

....

> enp216s0f0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9000
> 
>          inet 12.12.14.38  netmask 255.255.255.0  broadcast 12.12.14.255

This is the device IP address. You are trying to have an rdma listener
on an IP addressed that is not resolved to any device, which explains
the ENODEV error you are seeing...
