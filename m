From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 20 Jun 2014 13:13:27 -0400
Subject: [PATCH] NVMe: Change nvme_enable_ctrl behavior and track CC
In-Reply-To: <1403192575-9704-1-git-send-email-daniel.mcleran@intel.com>
References: <1403192575-9704-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <20140620171327.GM12025@linux.intel.com>

On Thu, Jun 19, 2014@09:42:55AM -0600, Dan McLeran wrote:
> In the current implementation, nvme_enable_ctrl does not actually enable the controller.
> It waits for the controller, which has previously been enabled from nvme_configure_admin_queue,
> to become ready to receive commands. This patch moves the logic of enabling the controller into
> nvme_enable_ctrl. This patch also ensure that shutdown flags are not passed as part of enabling
> or disabling the controller. This patch also ensures the software representation of the CC
> register remains in sync with actual reads and writes to the hardware.

Please wrap your changelog entries to 75-ish characters.  You've also
got three consecutive sentences starting with 'This patch' which reads
a bit funny.

I don't understand why we'd want to clear the current settings of SHN
when we write CC.  Wouldn't the controller infer from that the shutdown
has been cancelled?  Leaving the bits the same seems like the right
course of action.

Looking at the meat of the patch causes me to wonder ... why are we
reading ->cc anywhere?  We program it; the controller isn't allowed
to modify any part of it.  This register should be write-only for us,
using the ctrl_config soft-copy.

> @@ -1465,7 +1478,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	aqa = nvmeq->q_depth - 1;
>  	aqa |= aqa << 16;
>  
> -	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
>  	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>  	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
>  	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

I don't think this is right.  You're reading in the register settings
in nvme_disable_ctrl(), but the point of this routine is to initialise
the settings in ctrl_config, not to preserve the old settings.  What
if the BIOS had, for example, configured IOCQES to a different size?
