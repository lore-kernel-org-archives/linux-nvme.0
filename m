From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 May 2019 08:27:29 +0200
Subject: [PATCH 2/6] nvme-pci: Don't disable on timeout in reset state
In-Reply-To: <20190515163625.21776-2-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-2-keith.busch@intel.com>
Message-ID: <20190516062729.GD29930@lst.de>

On Wed, May 15, 2019@10:36:21AM -0600, Keith Busch wrote:
> The driver doesn't dispatch commands that it needs to wait for in the reset
> state anymore. If a timeout occurs in this state, the reset work is
> already disabling the controller, so just reset the request's timer.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
