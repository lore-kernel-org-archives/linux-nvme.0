From: keith.busch@intel.com (Keith Busch)
Date: Tue, 13 Jun 2017 10:55:10 -0400
Subject: [PATCH] nvme: move protection information check into nvme_setup_rw
In-Reply-To: <20170612163632.23009-1-hch@lst.de>
References: <20170612163632.23009-1-hch@lst.de>
Message-ID: <20170613145509.GB26073@localhost.localdomain>

On Mon, Jun 12, 2017@06:36:32PM +0200, Christoph Hellwig wrote:
> It only applies to read/write commands, and this way non-PCIe drivers
> get the check as well instead of having to duplicate it when adding
> metadata support.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
