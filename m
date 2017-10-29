From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 13:57:45 +0200
Subject: controller deletion consolidation
In-Reply-To: <20171029084431.8702-1-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
Message-ID: <c82f8c4f-052a-7233-d0df-59c7c6a7a1a6@grimberg.me>


> Hi all,
> 
> this series consolidates a lot of the boilerplate code in controller
> deletion.  I did this when applying the FC patches that finally made
> it look exactly like RDMA.
> 
> This will probably conflict a bit with Sagis consolidation series, but
> in the end should make it easier.

Definitely a step in the right direction. Looks good.

> Two notes:
> 
>   - do we need the cancellation of reset_work in FC?  If so we probably
>     want it in RDMA and loop as well.

We probably do.

>   - should RDMA really queue delete_work manually in
>     nvme_rdma_reconnect_or_remove instead of going through the state
>     machine?  That seems like a bug to me.
> 

I had this fix from the centralization patches, I can easily extract it
out and send it asap.
