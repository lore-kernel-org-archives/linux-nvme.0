From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Apr 2019 09:51:28 -0600
Subject: [PATCH 1/2] nvme: move command size checks to the core
In-Reply-To: <20190430153833.9011-1-hch@lst.de>
References: <20190430153833.9011-1-hch@lst.de>
Message-ID: <20190430155127.GA25231@localhost.localdomain>

On Tue, Apr 30, 2019@08:38:32AM -0700, Christoph Hellwig wrote:
> Most command aren't PCIe specific, so move the size checking for them
> to core.c
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
