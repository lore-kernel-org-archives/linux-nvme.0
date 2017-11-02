From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 2 Nov 2017 11:18:42 -0500
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <20171102151254.GE18874@ziepe.ca>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <20171101165036.GD1030@ziepe.ca>
 <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>
 <20171101175819.GG1030@ziepe.ca>
 <5810bb05-fffd-a0f2-3509-9d9b89a2ef32@grimberg.me>
 <20171102151254.GE18874@ziepe.ca>
Message-ID: <022e01d353f6$3fcbafd0$bf630f70$@opengridcomputing.com>



> -----Original Message-----
> From: linux-rdma-owner at vger.kernel.org [mailto:linux-rdma-
> owner at vger.kernel.org] On Behalf Of Jason Gunthorpe
> Sent: Thursday, November 02, 2017 10:13 AM
> To: Sagi Grimberg
> Cc: idanb; Max Gurtovoy; linux-rdma at vger.kernel.org; linux-
> nvme at lists.infradead.org; Christoph Hellwig
> Subject: Re: [PATCH 0/3] Fix request completion holes
> 
> On Thu, Nov 02, 2017@10:06:30AM +0200, Sagi Grimberg wrote:
> >
> > >>the default mode utilize remote invalidation, so no, its not valid.
> > >
> > >Well, usually the ULP design should allow some things to be reaped
> > >async, and latency senstive things to be sync.
> > >
> > >Eg if you have a SEND using a local buffer with a RKEY, then you'd
> > >declare the RKEY data completed when SEND_WITH_INVALIDATE is returned.
> > >
> > >Recycling the lkey command buffer is an async process and can wait
> > >unsignaled until something signalled comes to push its completion
> > >through.
> >
> > Not when using inline data with the send, which is the main issue
> > here. if we inline data to the command, we will use the local
> > dma lkey, which does not even have a local invalidate following it.
> 
> Does nvme use inline data send and RKEY transfer in the same SEND?
> Then it would need to signal the SEND if remote invalidate is used,
> otherwise it only needs to signal the local invalidate for the RKEY..
> 
> > >Local invalidate is defined to always be ordered by the spec, so it
> > >is required to guarentee that the SEND is completed.
> 
> > So local invalidate completion is guaranteed to come after all the
> > completions prior to it in the send queue?
> 
> IBA spec says so..
> 

iWARP spec too.   This is in regard to completion ordering though.  The local
invalidate send WR must have the IB_SEND_FENCE flag set if you want it to only
be executed after all prior send WRs are executed.    Either way, the
completions are always inserted into the cq in-sq-submission-order and a
signaled completion implies completions of all prior unsignaled WRs.

Steve.
