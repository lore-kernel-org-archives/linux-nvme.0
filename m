From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 21 Oct 2015 13:28:49 -0700
Subject: [PATCH 05/18] nvme: use offset instead of a struct for registers
In-Reply-To: <1444975128-8768-6-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-6-git-send-email-hch@lst.de>
Message-ID: <1445459329.3307.46.camel@linux.intel.com>

On Fri, 2015-10-16@07:58 +0200, Christoph Hellwig wrote:
> This makes life easier for future non-PCI drivers where access to the
> registers might be more complicated.  Note that Linux drivers are
> pretty evenly split between the two versions, and in fact the NVMe
> driver already uses offsets for the doorbells.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/nvme.h |  2 +-
>  drivers/nvme/host/pci.c  | 58 +++++++++++++++++++++++++-------------
> ----------
>  drivers/nvme/host/scsi.c |  6 ++---
>  include/linux/nvme.h     | 27 +++++++++++-----------
>  4 files changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 706f678..370aa5b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -46,7 +46,7 @@ struct nvme_dev {
>  	u32 db_stride;
>  	u32 ctrl_config;
>  	struct msix_entry *entry;
> -	struct nvme_bar __iomem *bar;
> +	void __iomem *bar;
>  	struct list_head namespaces;
>  	struct kref kref;
>  	struct device *device;
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cd731f5..6b0dcb6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1307,7 +1307,7 @@ static void nvme_disable_queue(struct nvme_dev 
> *dev, int qid)
>  
>  	/* Don't tell the adapter to delete the admin queue.
>  	 * Don't tell a removed adapter to delete IO queues. */
> -	if (qid && readl(&dev->bar->csts) != -1) {
> +	if (qid && readl(dev->bar + NVME_REG_CSTS) != -1) {
>  		adapter_delete_sq(dev, qid);
>  		adapter_delete_cq(dev, qid);
>  	}
> @@ -1460,7 +1460,7 @@ static int nvme_wait_ready(struct nvme_dev 
> *dev, u64 cap, bool enabled)
>  
>  	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
>  
> -	while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
> +	while ((readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_RDY) != 
> bit) {
>  		msleep(100);
>  		if (fatal_signal_pending(current))
>  			return -EINTR;
> @@ -1485,7 +1485,7 @@ static int nvme_disable_ctrl(struct nvme_dev 
> *dev, u64 cap)
>  {
>  	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
>  	dev->ctrl_config &= ~NVME_CC_ENABLE;
> -	writel(dev->ctrl_config, &dev->bar->cc);
> +	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
>  
>  	return nvme_wait_ready(dev, cap, false);
>  }
> @@ -1494,7 +1494,7 @@ static int nvme_enable_ctrl(struct nvme_dev 
> *dev, u64 cap)
>  {
>  	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
>  	dev->ctrl_config |= NVME_CC_ENABLE;
> -	writel(dev->ctrl_config, &dev->bar->cc);
> +	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
>  
>  	return nvme_wait_ready(dev, cap, true);
>  }
> @@ -1506,10 +1506,10 @@ static int nvme_shutdown_ctrl(struct nvme_dev 
> *dev)
>  	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
>  	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
>  
> -	writel(dev->ctrl_config, &dev->bar->cc);
> +	writel(dev->ctrl_config, dev->bar + NVME_REG_CC);
>  
>  	timeout = SHUTDOWN_TIMEOUT + jiffies;
> -	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
> +	while ((readl(dev->bar + NVME_REG_CSTS) & 
> NVME_CSTS_SHST_MASK) !=
>  							NVME_CSTS_SH
> ST_CMPLT) {
>  		msleep(100);
>  		if (fatal_signal_pending(current))
> @@ -1584,7 +1584,7 @@ static int nvme_configure_admin_queue(struct 
> nvme_dev *dev)
>  {
>  	int result;
>  	u32 aqa;
> -	u64 cap = readq(&dev->bar->cap);
> +	u64 cap = readq(dev->bar + NVME_REG_CAP);
>  	struct nvme_queue *nvmeq;
>  	unsigned page_shift = PAGE_SHIFT;
>  	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
> @@ -1605,11 +1605,12 @@ static int nvme_configure_admin_queue(struct 
> nvme_dev *dev)
>  		page_shift = dev_page_max;
>  	}
>  
> -	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
> +	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 
> 1) ?
>  						NVME_CAP_NSSRC(cap) 
> : 0;
>  
> -	if (dev->subsystem && (readl(&dev->bar->csts) & 
> NVME_CSTS_NSSRO))
> -		writel(NVME_CSTS_NSSRO, &dev->bar->csts);
> +	if (dev->subsystem &&
> +	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
> +		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
>  
>  	result = nvme_disable_ctrl(dev, cap);
>  	if (result < 0)
> @@ -1632,9 +1633,9 @@ static int nvme_configure_admin_queue(struct 
> nvme_dev *dev)
>  	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
>  	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>  
> -	writel(aqa, &dev->bar->aqa);
> -	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
> -	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
> +	writel(aqa, dev->bar + NVME_REG_AQA);
> +	writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
> +	writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
>  
>  	result = nvme_enable_ctrl(dev, cap);
>  	if (result)
> @@ -1776,7 +1777,7 @@ static int nvme_subsys_reset(struct nvme_dev 
> *dev)
>  	if (!dev->subsystem)
>  		return -ENOTTY;
>  
> -	writel(0x4E564D65, &dev->bar->nssr); /* "NVMe" */
> +	writel(0x4E564D65, dev->bar + NVME_REG_NSSR); /* "NVMe" */

It would be nice if this value was a macro in a .h file as this is not
necessarily specific to PCIe.
