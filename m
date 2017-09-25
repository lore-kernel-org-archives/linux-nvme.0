From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Sep 2017 18:19:39 +0200
Subject: [PATCH 7/9] nvme: track shared namespaces
In-Reply-To: <20170925161155.GC8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-8-hch@lst.de>
 <20170925161155.GC8463@localhost.localdomain>
Message-ID: <20170925161939.GA12952@lst.de>

On Mon, Sep 25, 2017@10:11:55AM -0600, Keith Busch wrote:
> Looks good; I can live with 'nvme_ns_head'.

I hate it :)  But so far no one has come up with a good name.
