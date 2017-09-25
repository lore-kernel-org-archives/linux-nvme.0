From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Sep 2017 10:08:12 -0600
Subject: [PATCH 6/9] nvme: introduce a nvme_ns_ids structure
In-Reply-To: <20170925134031.10548-7-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-7-hch@lst.de>
Message-ID: <20170925160812.GB8463@localhost.localdomain>

On Mon, Sep 25, 2017@03:40:28PM +0200, Christoph Hellwig wrote:
> This allows us to manage the various uniqueue namespace identifiers
> together instead needing various variables and arguments.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
