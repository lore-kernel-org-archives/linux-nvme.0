From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:03:00 +0200
Subject: [PATCHv3 6/9] nvme-pci: Unquiesce dead controller queues
In-Reply-To: <20180524203500.14081-7-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-7-keith.busch@intel.com>
Message-ID: <20180525130300.GH23463@lst.de>

On Thu, May 24, 2018@02:34:57PM -0600, Keith Busch wrote:
> This patch ensures the nvme namsepace request queues are not quiesced
> on a surprise removal. It's possible the queues were previously killed
> in a failed reset, so the queues need to be unquiesced to ensure all
> requests are flushed to completion.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
