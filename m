From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:21:02 -0800
Subject: [PATCHv2-4.5 07/10] NVMe: Simplify device reset failure
In-Reply-To: <1455221147-24228-8-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-8-git-send-email-keith.busch@intel.com>
Message-ID: <20160213092102.GA31848@infradead.org>

On Thu, Feb 11, 2016@01:05:44PM -0700, Keith Busch wrote:
> A reset failure schedules the device to unbind from the driver through
> the pci driver's 'remove'. This already cleans up all intialization
> from a partial or completed state, so there is no need to duplicate the
> cleanup that could potentially race with a pci hot removal.
> 
> To help understand why a reset failed, the status is logged with the
> existing warning message.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
