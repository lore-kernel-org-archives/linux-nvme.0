From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Jun 2016 15:54:01 -0400
Subject: generic NVMe over Fabrics library support V2
In-Reply-To: <1465829128-22993-1-git-send-email-hch@lst.de>
References: <1465829128-22993-1-git-send-email-hch@lst.de>
Message-ID: <20160615195401.GA7637@localhost.localdomain>

On Mon, Jun 13, 2016@04:45:20PM +0200, Christoph Hellwig wrote:
> This patch set adds the necessary infrastructure for the NVMe over
> Fabrics functionality and the NVMe over Fabrics library itself.
> 
> First we add some needed parameters to NVMe request allocation such as flags
> (for reserved commands - connect and keep-alive), also support tag
> allocation of a given queue ID (for connect to be executed per-queue)
> and allow request to be queued at the head of the request queue (so
> reconnects can pass in flight I/O).
> 
> Second, we add support for additional sysfs attributes that are needed
> or useful for the Fabrics driver.
> 
> Third we add the NVMe over Fabrics related header definitions and the
> Fabrics library itself which is transport independent and handles
> Fabrics specific commands and variables.
> 
> Last, we add support for periodic keep-alive mechanism which is mandatory
> for Fabrics.
> 
> Changes from V1:
>  - don't directly free host->opts on connect failure (Sagi)
>  - blk_mq_alloc_request_hctx improvements (Ming and me)
>  - keep alive should not use blk_mq_alloc_request_hctx (me)

I only had the one comment, and Sagi says you guys already considered
it but was more complicated than it was worth. Looking at the patches
that follow, I tend to agree.

The rest looks great, and passes all the sanity tests I can run. This
time with correct email spelling:

Reviewed-by: Keith Busch <keith.busch at intel.com>
