From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 May 2017 06:21:17 -0400
Subject: [PATCH 2/3] nvme: replace is_flags field in nvme_ctrl_ops with a
 flags field
In-Reply-To: <20170520131445.16078-2-hch@lst.de>
References: <20170520131445.16078-1-hch@lst.de>
 <20170520131445.16078-2-hch@lst.de>
Message-ID: <20170525102117.GB24894@localhost.localdomain>

On Sat, May 20, 2017@03:14:44PM +0200, Christoph Hellwig wrote:
> So that we can have more flags for transport-specific behavior.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
