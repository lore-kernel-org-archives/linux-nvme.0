From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 25 Oct 2016 20:04:50 +0300
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <20161025170238.GE9732@lst.de>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
 <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>
 <20161025170238.GE9732@lst.de>
Message-ID: <97a0459f-6a4f-67d5-d9bc-f704f6ccf281@grimberg.me>


> On Tue, Oct 25, 2016@07:36:25PM +0300, Sagi Grimberg wrote:
>> I think it'd be better to move them to include/linux/nvme-rdma.h
>> and use them for logging on the target side too.
>
> Hmm, that would mean they get compiled into every source file.

"every source file" is exactly two...

> Also on the target side we can have free-form messages for whatever
> the exact rejection reason was, no need to limit us to the enum.

Thought it'd be nice to use the same verbosity on both ends, just a
suggestion though...
