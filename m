From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Jan 2018 18:53:16 -0700
Subject: [PATCH 2/2] nvme-pci: clean up SMBSZ bit definitions
In-Reply-To: <20180115153348.13105-3-hch@lst.de>
References: <20180115153348.13105-1-hch@lst.de>
 <20180115153348.13105-3-hch@lst.de>
Message-ID: <20180116015315.GF32369@localhost.localdomain>

On Mon, Jan 15, 2018@04:33:48PM +0100, Christoph Hellwig wrote:
> Define the bit positions instead of macros using the magic values,
> and move the expanded helpers to calculate the size and size unit into
> the implementation C file.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
