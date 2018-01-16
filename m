From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Jan 2018 18:51:00 -0700
Subject: [PATCH 1/2] nvme-pci: clean up CMB initialization
In-Reply-To: <20180115153348.13105-2-hch@lst.de>
References: <20180115153348.13105-1-hch@lst.de>
 <20180115153348.13105-2-hch@lst.de>
Message-ID: <20180116015059.GE32369@localhost.localdomain>

On Mon, Jan 15, 2018@04:33:47PM +0100, Christoph Hellwig wrote:
> Refactor the call to nvme_map_cmb, and change the conditions for probing
> for the CMB.  First remove the version check as NVMe TPs always apply
> to earlier versions of the spec as well.  Second check for the whole CMBSZ
> register for support of the CMB feature instead of just the size field
> inside of it to simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
