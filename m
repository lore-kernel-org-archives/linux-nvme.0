From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 1 Nov 2017 11:58:19 -0600
Subject: [PATCH 0/3] Fix request completion holes
In-Reply-To: <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>
References: <1509440122-1190-1-git-send-email-sagi@grimberg.me>
 <8abcde91-9150-2982-3900-078619bcdac0@mellanox.com>
 <a950a671-22a1-432c-555e-8309c8a64a88@grimberg.me>
 <d9dcdb05-d001-53d8-7ed7-5fafc1709f4a@mellanox.com>
 <20171101165036.GD1030@ziepe.ca>
 <5f3955d2-9116-5f18-2299-cc697947d599@grimberg.me>
Message-ID: <20171101175819.GG1030@ziepe.ca>

On Wed, Nov 01, 2017@07:31:39PM +0200, Sagi Grimberg wrote:

> the default mode utilize remote invalidation, so no, its not valid.

Well, usually the ULP design should allow some things to be reaped
async, and latency senstive things to be sync.

Eg if you have a SEND using a local buffer with a RKEY, then you'd
declare the RKEY data completed when SEND_WITH_INVALIDATE is returned.

Recycling the lkey command buffer is an async process and can wait
unsignaled until something signalled comes to push its completion
through.

This approach reduces the # of CQEs required at the expense of
delaying reaping the lkey buffer.

> Without remote invalidate I'm not sure, don't remember the ordering
> rules from the top of my head. Idan, does a local invalidate completion
> guarantee a prior send completion (of a non-related buffer)? I vaguely
> remember that explicit fencing is required to guarantee that.

This was the case I thought Idan was testing..

Local invalidate is defined to always be ordered by the spec, so it
is required to guarentee that the SEND is completed.

> I guess we could not signal send completions if we are in a local
> invalidate mode, but I'm liking this less and less...

If the SEND reaping can be defered as above, then the local invalidate
completion becomes the signaled CQE that allows the SEND to be reaped.

Jason
