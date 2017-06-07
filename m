From: osandov@osandov.com (Omar Sandoval)
Date: Wed, 7 Jun 2017 15:04:11 -0700
Subject: [PATCH 7/8] blk-mq: create hctx for each present CPU
In-Reply-To: <20170603140403.27379-8-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-8-hch@lst.de>
Message-ID: <20170607220411.GF7481@vader.DHCP.thefacebook.com>

On Sat, Jun 03, 2017@04:04:02PM +0200, Christoph Hellwig wrote:
> Currently we only create hctx for online CPUs, which can lead to a lot
> of churn due to frequent soft offline / online operations.  Instead
> allocate one for each present CPU to avoid this and dramatically simplify
> the code.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Oh man, this cleanup is great. Did you run blktests on this? block/008
does a bunch of hotplugging while I/O is running.
