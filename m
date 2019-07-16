From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 14:25:08 +0200
Subject: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
In-Reply-To: <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-2-benh@kernel.crashing.org>
 <20190716060430.GB29414@lst.de>
 <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
 <20190716093301.GA32562@lst.de>
 <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org>
 <20190716120547.GA2388@lst.de>
 <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>
Message-ID: <20190716122508.GA3304@lst.de>

On Tue, Jul 16, 2019@10:17:56PM +1000, Benjamin Herrenschmidt wrote:
> If we're going to do that, then I can move it back to pci.c and leave
> core.c alone then I suppose. Up to you. I'm just doing that for fun, no
> beef in that game :-) let me know how you want it.

Sounds safest to me.
