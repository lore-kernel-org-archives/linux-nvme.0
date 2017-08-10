From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Aug 2017 12:32:50 -0400
Subject: [PATCH v2] nvme: Fix nvme reset command timeout handling
In-Reply-To: <20170810092331.11159-1-jthumshirn@suse.de>
References: <20170810092331.11159-1-jthumshirn@suse.de>
Message-ID: <20170810163250.GA14634@localhost.localdomain>

On Thu, Aug 10, 2017@11:23:31AM +0200, Johannes Thumshirn wrote:
> From: Keith Busch <keith.busch at intel.com>
> 
> We need to return an error if a timeout occurs on any NVMe command during
> initialization. Without this, the nvme reset work will be stuck. A timeout
> will have a negative error code, meaning we need to stop initializing
> the controller. All postitive returns mean the controller is still usable.
> 
> bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196325
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Cc: Martin Peres <martin.peres at intel.com>
> [jth consolidated cleanup path ]
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

This looks great, thanks for fixing that up!

I noticed the HMB setting in pci.c can also potentially timeout. We can
deal with that later.
