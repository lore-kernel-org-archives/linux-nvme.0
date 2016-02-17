From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 18:37:54 +0000
Subject: [PATCH 1/3] nvme: use a work item to submit async event requests
In-Reply-To: <1455732194-30790-2-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-2-git-send-email-hch@lst.de>
Message-ID: <20160217183754.GC30059@localhost.localdomain>

On Wed, Feb 17, 2016@07:03:12PM +0100, Christoph Hellwig wrote:
> Use a dedicated work item to submit async event requests instead of the
> global kthread.  This simplifies the code and reduces the latencies to
> resubmit a request once an even notification happened.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
