From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jun 2019 17:05:52 -0700
Subject: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
In-Reply-To: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
Message-ID: <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>


> Greetings NVMe community,
> 
> I am running kernel 5.1.6, which is the latest stable kernel.
> 
> I am testing a nvmf kernel target, configured on top of a bond 
> interface, for high availability. The bond interface is created on top 
> of two ConnectX-3 interfaces, which represent two ports of one 
> ConnectX-3 VF (with this hardware a VF is dual-ported, i.e., a single VF 
> yields two network interfaces). The bond is configured in active-backup 
> mode. Exact bonding configuration is given in [1]. The nvmet target 
> configuration doesn't have anything special and is given in [2].
> 
> I create a nvmf connection from a different machine to the nvmet target. 
> Then I initiate bond failover, by disconnecting a cable that corresponds 
> to the active bond slave. As a result, I get the following kernel panic:

Max sent a fix exactly for this. You can test that it works for you
when he sends v2.

Max, care to CC Alex when you send it?
