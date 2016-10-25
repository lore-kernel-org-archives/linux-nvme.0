From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Oct 2016 19:02:38 +0200
Subject: [PATCH v3 4/6] nvme-rdma: use rdma connection reject helper
 functions
In-Reply-To: <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>
References: <cover.1477336045.git.swise@opengridcomputing.com>
 <55638a1d2a9f79af8b9a19eb444c5d0a41691352.1477336045.git.swise@opengridcomputing.com>
 <7191d136-aef4-9fed-223e-f2a9c1d958e5@grimberg.me>
Message-ID: <20161025170238.GE9732@lst.de>

On Tue, Oct 25, 2016@07:36:25PM +0300, Sagi Grimberg wrote:
> I think it'd be better to move them to include/linux/nvme-rdma.h
> and use them for logging on the target side too.

Hmm, that would mean they get compiled into every source file.
Also on the target side we can have free-form messages for whatever
the exact rejection reason was, no need to limit us to the enum.
