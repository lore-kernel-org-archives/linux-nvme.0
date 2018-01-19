From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 19 Jan 2018 17:49:31 +0800
Subject: [PATCH V5 1/2] nvme-pci: introduce RECONNECTING state to mark
 initializing procedure
In-Reply-To: <4be66899-0246-9d03-eb03-76488e7e629e@mellanox.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516270202-8051-2-git-send-email-jianchao.w.wang@oracle.com>
 <4be66899-0246-9d03-eb03-76488e7e629e@mellanox.com>
Message-ID: <4fc5bb3c-9947-35eb-42b5-7d9f5190ee9a@oracle.com>

Hi Max

Thanks for your kindly comment and response.

On 01/18/2018 06:17 PM, Max Gurtovoy wrote:
> 
> On 1/18/2018 12:10 PM, Jianchao Wang wrote:
>> After Sagi's commit (nvme-rdma: fix concurrent reset and reconnect),
>> both nvme-fc/rdma have following pattern:
>> RESETTING??? - quiesce blk-mq queues, teardown and delete queues/
>> ??????????????? connections, clear out outstanding IO requests...
>> RECONNECTING - establish new queues/connections and some other
>> ??????????????? initializing things.
> 
> I guess we can call it NVME_CTRL_CONNECTING in later patch (more suitable name for this state now).

I think we can change the name in another patchset in which just talk about the more suitable names of the states.
:)
Thanks
Jianchao
