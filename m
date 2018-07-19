From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 15:42:03 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Message-ID: <20180719134203.GA15212@lst.de>

On Thu, Jul 19, 2018@03:28:34PM +0200, Johannes Thumshirn wrote:
> PCI currently is the only transport we have which is doing more than
> queueing a transport reset but trying to abort the command first.
> 
> This series brings the other transports we currently have up to the
> same level.

Without even looking at the code yet:  why?  The nvme abort isn't
very useful, and due to the lack of ordering between different
queues almost harmful on fabrics.  What problem do you try to
solve?
