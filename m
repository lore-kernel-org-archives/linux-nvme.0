From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Apr 2019 12:23:07 +0200
Subject: [PATCH v2 2/2] nvme: add sysfs controls for io and admin timeouts
In-Reply-To: <20190403123506.122904-3-mheyne@amazon.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
 <20190403123506.122904-3-mheyne@amazon.de>
Message-ID: <20190409102307.GA7741@lst.de>

I really don't think the iteration over all queues of a tagset
makes a whole lot of sense.  We really need to replace the per-queue
limit with a per-tagset one (or at least add the per-tagset one)
and then allow tweaking that in the block layer instead of writing
this boiler plate code.
