From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 5 Jun 2018 08:37:40 -0600
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to clear
 ns data changed AENs
In-Reply-To: <20180605044733.GA29448@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
 <20180604195908.GC8205@localhost.localdomain>
 <20180605044733.GA29448@lst.de>
Message-ID: <20180605143740.GA10501@localhost.localdomain>

On Tue, Jun 05, 2018@06:47:33AM +0200, Christoph Hellwig wrote:
> But let's assume we don't want to use the list due to this concern:
> we'd still have to read the log page, as per the NVMe spec the only
> think clearing a pending AEN is reading the associated log page.
> We'd then need to still do the full scan using identify.  Is this what
> we want?  If you think this is important for reliability we could
> just ignore the log page.

That sounds good. Let's have the driver read the log page to re-arm
the event as you've done, but don't rely on the contents for namespace
enumeration.

The rest of your series looks good to me.
