From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Dec 2017 11:29:18 -0700
Subject: [BUG] NULL pointer dereference in nvme_setup_streams_ns
In-Reply-To: <20171214125617.GA10616@lst.de>
References: <CGME20171214125019epcas2p3bde40201e0ba4833214c64637d67b24d@epcas2p3.samsung.com>
 <b70776c2-5781-9f65-9ab7-ebb81a86d46d@samsung.com>
 <20171214125617.GA10616@lst.de>
Message-ID: <20171214182917.GC26752@localhost.localdomain>

On Thu, Dec 14, 2017@01:56:17PM +0100, Christoph Hellwig wrote:
> Try moving the call to nvme_setup_streams_ns until after the call to
> nvme_init_ns_head.  I'll prepare a formal patch in a bit when I'm not on the
> run.

Ah, didn't see you were already fixing this. If you've already got it,
just skip my "Setup streams" patch.

Arnav,
Please use plain text for the mailing list in the future.

Thanks,
Keith
