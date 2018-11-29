From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2018 13:22:47 -0700
Subject: [PATCH 03/13] nvme-pci: cleanup SQ allocation a bit
In-Reply-To: <20181129191310.9795-4-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-4-hch@lst.de>
Message-ID: <20181129202247.GD9377@localhost.localdomain>

On Thu, Nov 29, 2018@08:13:00PM +0100, Christoph Hellwig wrote:
> Use a bit flag to mark if the SQ was allocated from the CMB, and clean
> up the surrounding code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
