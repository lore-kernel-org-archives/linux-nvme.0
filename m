From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Apr 2018 17:43:32 +0200
Subject: [PATCH v1 0/3] nvmet-rdma automatic port re-activation
In-Reply-To: <0f781a93-2cbf-8d60-2028-4581912bf07a@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
 <20180413170010.GA23178@lst.de>
 <0f781a93-2cbf-8d60-2028-4581912bf07a@grimberg.me>
Message-ID: <20180417154332.GA26352@lst.de>

On Sun, Apr 15, 2018@11:53:02AM +0300, Sagi Grimberg wrote:
>>> When a RDMA device goes away we must destroy all it's associated
>>> RDMA resources. RDMa device resets also manifest as device removal
>>> events and a short while after they come back. We want to re-activate
>>> a port listener on this RDMA device when it comes back in to the system.
>>
>> I really detest this series.  It just shows how messed up the whole
>> IB core interaction is.  The right way to fix this is to stop treating
>> a IB device reset as a device removal, and give it a different event.
>>
>> And also make sure we have a single unified event system instead of
>> three separate ones.
>
> I've raised this claim before, but got resistance from Doug:
> https://www.spinics.net/lists/linux-rdma/msg59815.html
>
> At that point, in the lack of change in the RDMA interface, this
> is pretty much what we can do to support device resets...

Meh.  I really hate all that rubbish boilerplate code.  Nothing
in here is protocol specific, so even without a proper reset
even it is something that should be done in common code.
