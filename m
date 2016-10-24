From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 24 Oct 2016 09:57:50 -0500
Subject: [PATCH RFC v2 3/3] nvme-rdma: use rdma_reject_msg() to
 log	connection rejects
In-Reply-To: <005701d22c7f$0c883ed0$2598bc70$@opengridcomputing.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <60243a2ce17e08cdc93600b9998698dbd7f83306.1477003235.git.swise@opengridcomputing.com>
 <20161021122318.GB17325@lst.de>
 <005701d22c7f$0c883ed0$2598bc70$@opengridcomputing.com>
Message-ID: <011d01d22e06$fd606480$f8212d80$@opengridcomputing.com>

> > Given the nasty casting issues in the current RDMA/CM API maybe we
> should
> > actually expand the scope of the rdma_consumer_reject helper to include
> > the above check, e.g. check that there is a private data len and then
> > return a pointer to the private data?
> 
> An application could reject and not provide private data, so I think we
> need 3 helpers (so far):
> 
> rdma_reject_msg() - protocol reject reason string
> rdma_is_consumer_reject() - true if the peer consumer/ulp rejected
> rdma_consumer_reject_data() - ptr to any private data
> 
> Sound good?

Or these 3 could be rolled into one uber function that returns true if the
consumer rejected, and sets 2 pointers passed in: one to the protocol reject
string, and one to the private data, if any.   If the something like like this:

bool rdma_reject_info(struct rdma_cm_id *id, int reason, char **protocol_msg,
char **consumer_data)

Kinda ugly, but only one call is needed vs 3 calls to get this info...
