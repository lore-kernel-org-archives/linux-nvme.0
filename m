From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 Oct 2018 08:00:49 +0200
Subject: [PATCH 4/4] nvme-core: support traffic based keep-alive based
 on controller support
In-Reply-To: <2e1cba3c-a391-8c45-5987-0ba5317a6a19@grimberg.me>
References: <20180928011537.30069-1-sagi@grimberg.me>
 <20180928011537.30069-5-sagi@grimberg.me> <20181017070545.GA23049@lst.de>
 <2e1cba3c-a391-8c45-5987-0ba5317a6a19@grimberg.me>
Message-ID: <20181019060049.GA27902@lst.de>

On Thu, Oct 18, 2018@05:38:29PM -0700, Sagi Grimberg wrote:
>
>>> +	nvme_req(req)->ctrl->comp_seen = true;
>>
>> shouldn't we only do this for controllers with keep a live support?
>
> What is the harm setting it anyways? Would it be better to condition it
> on keep alive support instead?

This writes to a cache line in the controller on every I/O completion.
And while it isn't an atomic it isn't exactly going to help scalability,
so I'd rather have a branch before it, which will be predicted not taken
for controllers that don't have the feature (aka at least every PCIe
controller on the planet)
