From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Sep 2017 16:55:53 +0200
Subject: [PATCH] nvme/pci: Print invalid SGL only once
In-Reply-To: <1505415974-13489-1-git-send-email-keith.busch@intel.com>
References: <1505415974-13489-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170915145553.GA1147@lst.de>

On Thu, Sep 14, 2017@03:06:14PM -0400, Keith Busch wrote:
> The WARN_ONCE macro returns true if the condition is true, not if the
> warn was raised, so we're printing the scatter list every time it's
> invalid. This is excessive and makes debugging harder, so this patch
> prints it just once.

Please use the printk_ratelimited() helper instead.
