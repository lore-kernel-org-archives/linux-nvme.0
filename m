From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Feb 2017 14:51:35 +0100
Subject: [PATCH 1/5] nvme/pci: Disable on removal when disconnected
In-Reply-To: <1486768553-13738-2-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-2-git-send-email-keith.busch@intel.com>
Message-ID: <20170213135135.GA23832@lst.de>

On Fri, Feb 10, 2017@06:15:49PM -0500, Keith Busch wrote:
> If the device is not present, the driver should disable the queues
> immediately. Prior to this, the driver was relying on the watchdog timer
> to kill the queues if requests were outstanding to the device, and that
> just delays removal up to one second.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
