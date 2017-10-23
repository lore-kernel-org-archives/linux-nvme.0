From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 23 Oct 2017 18:25:42 +0300
Subject: [PATCH 2/5] nvme-rdma: rework create_ctrl error flow
In-Reply-To: <20171023143255.GB25448@lst.de>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-3-git-send-email-sagi@grimberg.me>
 <20171023143255.GB25448@lst.de>
Message-ID: <9023b292-f403-f9fd-40cf-daa82fa60942@grimberg.me>


>> Now that we have nvme_init/uninit_ctrl doing the right thing, we
>> can fix this by making the error sequence sane and simple (just
>> undo what we did until the error).
>>
>> Also, allocate ctrl->queues before calling nvme_init_ctrl, just
>> to separate the driver private resource allocation and the core
>> resource allocations.
> 
> Once we did the init we'll have to do a put and not just free it.
> That will become even more important when using a struct device for
> refcounting the controller.

:(

I want to get to a point where the transports allocate everything they
need in their private struct, and then do nvme common things. This
asymmetric behavior is going hard to keep correct once got right.
