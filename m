From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 16:21:10 +0100
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
In-Reply-To: <20180115130723.31469-1-keith.busch@intel.com>
References: <20180115130723.31469-1-keith.busch@intel.com>
Message-ID: <20180115152110.GA9121@lst.de>

Thanks, applied.  I'll rebase the changes to take the mapped
scatterlist length on top of this.
