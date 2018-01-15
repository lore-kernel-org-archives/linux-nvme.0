From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 17:01:48 +0100
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
In-Reply-To: <20180115130723.31469-1-keith.busch@intel.com>
References: <20180115130723.31469-1-keith.busch@intel.com>
Message-ID: <20180115160148.GA9749@lst.de>

Actually this needs to go into nvme-4.15.  The offending commit is
only in 4.15-rc, and not in nvme-4.16 or Jens' for-4.16 tree.
