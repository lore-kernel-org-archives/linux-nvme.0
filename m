From: hch@lst.de ('Christoph Hellwig')
Date: Mon, 24 Oct 2016 17:09:12 +0200
Subject: [PATCH RFC v2 3/3] nvme-rdma: use rdma_reject_msg() to log
 connection rejects
In-Reply-To: <011d01d22e06$fd606480$f8212d80$@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <60243a2ce17e08cdc93600b9998698dbd7f83306.1477003235.git.swise@opengridcomputing.com>
 <20161021122318.GB17325@lst.de>
 <005701d22c7f$0c883ed0$2598bc70$@opengridcomputing.com>
 <011d01d22e06$fd606480$f8212d80$@opengridcomputing.com>
Message-ID: <20161024150912.GA6866@lst.de>

On Mon, Oct 24, 2016@09:57:50AM -0500, Steve Wise wrote:
> > rdma_reject_msg() - protocol reject reason string

This one sounds useful on it's own.

> > rdma_is_consumer_reject() - true if the peer consumer/ulp rejected
> > rdma_consumer_reject_data() - ptr to any private data

I see why these are conceptually different, but why do we care
if something is a consumer reject except for printing what reject
we got (solved by rdma_reject_msg) or for getting consumer reject
data if there is any (solved by rdma_consumer_reject_data).

So all three helpers are fine with me, but rdma_is_consumer_reject
would be more of a low-level helper that drivers wouldn't use
directly, only through rdma_consumer_reject_data.
