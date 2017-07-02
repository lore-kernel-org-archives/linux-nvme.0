From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 2 Jul 2017 20:41:15 +0300
Subject: [PATCH rfc 0/3] Expose cpu mapping hints to a nvme target port
In-Reply-To: <b77be367-6cbc-c12c-8135-eddff0aec90e@mellanox.com>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <b77be367-6cbc-c12c-8135-eddff0aec90e@mellanox.com>
Message-ID: <e33f16a7-4e1d-7fd6-6d2c-5a5bac450c73@grimberg.me>


> Hi Sagi,
> Very interesting patchset. You give a lot of power to the user here, we 
> need to hope that he will use it right :).

I don't think so, its equivalent to running an application with a given
taskset, nothing fancy here...

The straight forward configuration this is targeting is a dual-socket system
where on each node you have one (or more) HCA and some NVMe devices
(say 4). All this is doing is allowing the user to contain nvme target 
port cpu cores
to its own numa socket so if on that port only expose the local NVMe devices
DMA traffic won't cross QPI.

While a subsystem is the collection of devices, the port is where I/O 
threads
really live as they feed of the device IRQ affinity. Especially with SRQ 
which I'll
be touching soon. The user does indeed need to be aware of all this, but 
if he
isn't, then he shouldn't touch this setting.

> Do you have some fio numbers to compare w/w.o this series ? also cpu 
> utilization measures are interesting too..

Not really, this is an RFC level code, lightly tested on my VM...

If this is interesting to you I can use some testing if you volunteer ;)
