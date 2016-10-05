From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:40:13 +0200
Subject: [PATCH rfc 3/6] nvme-pci: Use irq-poll for completion processing
In-Reply-To: <1475660534-16681-4-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-4-git-send-email-sagi@grimberg.me>
Message-ID: <20161005134013.jkgc6jfbya7x7ou3@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:11PM +0300, Sagi Grimberg wrote:
> irq-poll interface allows us to implement correct
> cq polling in terms of completion context processing
> (helps drivers to _not_ abuse irq context) and maintain
> fairness between multiple completion queues that share
> the same MSI/MSIX assignments. It is done by mainataining
> per-cpu completion processing contexts queues and dispatching
> the completion processing routines a budget that they
> need to obay.
> 
> Also, select IRQ_POLL in Kconfig as we rely on it now.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/Kconfig |  1 +
>  drivers/nvme/host/pci.c   | 28 +++++++++++++++++++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index db39d53cdfb9..1523fdaff537 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -5,6 +5,7 @@ config BLK_DEV_NVME
>  	tristate "NVM Express block device"
>  	depends on PCI && BLOCK
>  	select NVME_CORE
> +	select IRQ_POLL
>  	---help---
>  	  The NVM Express driver is for solid state drives directly
>  	  connected to the PCI or PCI Express bus.  If you know you
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 85bfd76fbee9..f37fad10007f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -42,6 +42,7 @@
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <asm/unaligned.h>
> +#include <linux/irq_poll.h>
>  
>  #include "nvme.h"
>  
> @@ -49,6 +50,7 @@
>  #define NVME_AQ_DEPTH		256
>  #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
>  #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
> +#define NVME_POLL_BUDGET_IRQ	256

Is there a reason for the 256 or is it just a nicely suited value? Especially
as you've been using INT_MAX as a budget for CQ processing before (which I
think is kinda high).

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
