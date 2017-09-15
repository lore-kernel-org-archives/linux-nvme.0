From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Sep 2017 19:45:09 +0200
Subject: [PATCHv2] nvme/pci: Print invalid SGL only once
In-Reply-To: <1505495138-11325-1-git-send-email-keith.busch@intel.com>
References: <1505495138-11325-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170915174509.GA8578@lst.de>

On Fri, Sep 15, 2017@01:05:38PM -0400, Keith Busch wrote:
> The WARN_ONCE macro returns true if the condition is true, not if the
> warn was raised, so we're printing the scatter list every time it's
> invalid. This is excessive and makes debugging harder, so this patch
> prints it just once.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
