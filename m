From: alex@zadara.com (Alex Lyakas)
Date: Wed, 3 Jul 2019 12:28:55 +0300
Subject: NULL pointer dereference in nvmet_rdma_queue_disconnect during
 bond failover
In-Reply-To: <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
References: <F7E28AA1609E4FC495B5E8D4250E7DEF@alyakaslap>
 <90599926-b7ec-8431-a7aa-c44fde08b5c4@grimberg.me>
 <ec4fb8df-98c4-fffc-7581-5245c397d16c@mellanox.com>
Message-ID: <66ACE500178B47D6B39F23FE98D22363@alyakaslap>

Hi Max,

Has any patch been sent to resolve the kernel panic in nvmet that we are 
seeing?

Thanks,
Alex.


-----Original Message----- 
From: Max Gurtovoy
Sent: Thursday, June 06, 2019 10:31 AM
To: linux-nvme at lists.infradead.org
Subject: Re: NULL pointer dereference in nvmet_rdma_queue_disconnect during 
bond failover


On 6/6/2019 3:05 AM, Sagi Grimberg wrote:
>
>> Greetings NVMe community,
>>
>> I am running kernel 5.1.6, which is the latest stable kernel.
>>
>> I am testing a nvmf kernel target, configured on top of a bond interface, 
>> for high availability. The bond interface is created on top of two 
>> ConnectX-3 interfaces, which represent two ports of one ConnectX-3 VF 
>> (with this hardware a VF is dual-ported, i.e., a single VF yields two 
>> network interfaces). The bond is configured in active-backup mode. Exact 
>> bonding configuration is given in [1]. The nvmet target configuration 
>> doesn't have anything special and is given in [2].
>>
>> I create a nvmf connection from a different machine to the nvmet target. 
>> Then I initiate bond failover, by disconnecting a cable that corresponds 
>> to the active bond slave. As a result, I get the following kernel panic:
>
> Max sent a fix exactly for this. You can test that it works for you
> when he sends v2.
>
> Max, care to CC Alex when you send it?

Sure, No problem.


>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7C9879366f21df4e7f4ce608d6ea12c41f%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636953763648159480&amp;sdata=UtkpvcEM9%2BBBdj68Kx6bobMWkeGSp1Jz3yJXxH8MLgY%3D&amp;reserved=0

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme 
