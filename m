From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Dec 2018 12:11:46 +0100
Subject: [PATCH v3 2/2] trace nvme submit queue status
In-Reply-To: <11554384-e0a9-0bde-97e9-228b29e6b641@suse.de>
References: <20181217080605.16867-1-yupeng0921@gmail.com>
 <20181217080605.16867-2-yupeng0921@gmail.com>
 <11554384-e0a9-0bde-97e9-228b29e6b641@suse.de>
Message-ID: <20181217111146.GA6126@lst.de>

On Mon, Dec 17, 2018@09:33:24AM +0100, Johannes Thumshirn wrote:
> Is the addition of a trace_pci.h really needed? Why can't you just put
> it in trace.h?

Agreed.  Especially as the concepts actually are generic, so we could
actually add the trace point to the rdma and fc transports as well
(not that they would be all that useful, so we probably shouldn't).
