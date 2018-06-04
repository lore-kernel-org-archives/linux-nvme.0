From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 4 Jun 2018 13:59:09 -0600
Subject: [PATCH 13/14] nvme: use the changed namespaces list log to clear
 ns data changed AENs
In-Reply-To: <20180526102735.31404-14-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-14-hch@lst.de>
Message-ID: <20180604195908.GC8205@localhost.localdomain>

On Sat, May 26, 2018@12:27:34PM +0200, Christoph Hellwig wrote:
> Per section 5.2 we need to issue the corresponding log page to clear an
> AEN, so for a namespace data changed AEN we need to read the changed
> namespace list log.  And once we read that log anyway we might as well
> use it to optimize the rescan.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

I'm a little concerned about this. Userspace might be reading the same
log page. Since the contents of the page may change each time its read,
it's possible the driver will see only a subset of changed namespaces
at the point it gets to read the log page, missing a chance to
revalidate others.
