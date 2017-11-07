From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Nov 2017 09:35:12 -0700
Subject: [PATCH] nvme: fix and clarify the check for missing metadata
In-Reply-To: <20171107162734.4600-1-hch@lst.de>
References: <20171107162734.4600-1-hch@lst.de>
Message-ID: <20171107163511.GD29942@localhost.localdomain>

On Tue, Nov 07, 2017@05:27:34PM +0100, Christoph Hellwig wrote:
> Update the check in nvme_setup_rw for missing metadata so that it is
> together with the other metadata handling, does not contain impossible
> to reach conditions and warns if we get an impossible requests for
> a (non-PI) metadata-enabled namespace when CONFIG_BLK_DEV_INTEGRITY
> is not set.
> 
> Also add a little helper that checks if a given metadata configuration
> contains protection information
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
