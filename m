From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 2 Aug 2016 09:39:48 +0300
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <20160801155054.GD22771@lst.de>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
 <20160801111530.GB16474@lst.de>
 <307087d1-88af-5244-38e8-5b9786285488@grimberg.me>
 <20160801155054.GD22771@lst.de>
Message-ID: <dc6286c3-a5c0-48a8-284d-f53b6830da22@grimberg.me>


>>> How is ->remove_port synchronized vs the RDMA/CM even handler?
>>
>> Easy, it isn't :)
>>
>> So we have three choices here:
>> 1. Add a lock in nvmet_port that only rdma will use for now (don't like
>> it)
>> or
>> 2. Add nvmet_rdma_port as nvmet_port->priv with a lock (don't like it)
>> or
>> 3. take the global nvmet_config_sem (hate it)
>>
>> Any preferences?
>
> (4) use cmpxchg?

I'm not exactly sure what you mean. Do you mean placing
cmpxchg in nvmet_rdma_device_removal()? To what we cmp
when we want to xchg?

Care to explain in a bit more detail?
