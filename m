From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Sep 2017 10:07:56 -0600
Subject: [PATCH 5/9] nvme: track subsystems
In-Reply-To: <20170925134031.10548-6-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-6-hch@lst.de>
Message-ID: <20170925160756.GA8463@localhost.localdomain>

On Mon, Sep 25, 2017@03:40:27PM +0200, Christoph Hellwig wrote:
> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs unless
> the involved subsystems support multiple controllers.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
