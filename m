From: hch@lst.de (Christoph Hellwig)
Date: Sun, 28 May 2017 11:41:52 +0200
Subject: [PATCH] nvme/pci: Remove watchdog timer
In-Reply-To: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
References: <1495800988-27311-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170528094152.GB14199@lst.de>

On Fri, May 26, 2017@08:16:28AM -0400, Keith Busch wrote:
> The controller status polling was added to preemptively reset a failed
> controller. This early detection would allow commands that would normally
> timeout a chance for a retry, or find broken links when the platform
> didn't support hotplug.
> 
> This once-per-second MMIO read, however, created more problems than
> it solves. This often races with PCIe Hotplug events that required
> complicated syncing between work queues, frequently triggered PCIe
> Completion Timeout errors that also lead to fatal machine checks, and
> unnecessarily disrupts low power modes by running on idle controllers.
> 
> This patch removes the watchdog timer, and instead checks controller
> health only on an IO timeout when we have a reason to believe something
> is wrong. If the controller is failed, the driver will disable immediately
> and request scheduling a reset.
> 
> Suggested-by: Andy Lutomirski <luto at amacapital.net>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 123 ++++++++++++++++++++++--------------------------
>  1 file changed, 56 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d52701df..eedb9b4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -94,7 +94,6 @@ struct nvme_dev {
>  	void __iomem *bar;
>  	struct work_struct reset_work;
>  	struct work_struct remove_work;
> -	struct timer_list watchdog_timer;
>  	struct mutex shutdown_lock;
>  	bool subsystem;
>  	void __iomem *cmb;
> @@ -950,6 +949,51 @@ static void abort_endio(struct request *req, int error)
>  	blk_mq_free_request(req);
>  }
>  
> +static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
> +{
> +
> +	/* If true, indicates loss of adapter communication, possibly by a
> +	 * NVMe Subsystem reset.
> +	 */
> +	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
> +
> +	/* If there is a reset ongoing, we shouldn't reset again. */
> +	if (work_busy(&dev->reset_work))
> +		return false;
> +
> +	/* We shouldn't reset unless the controller is on fatal error state
> +	 * _or_ if we lost the communication with it.
> +	 */
> +	if (!(csts & NVME_CSTS_CFS) && !nssro)
> +		return false;
> +
> +	/* If PCI error recovery process is happening, we cannot reset or
> +	 * the recovery mechanism will surely fail.
> +	 */
> +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
> +{
> +	/* Read a config register to help see what died. */
> +	u16 pci_status;
> +	int result;
> +
> +	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
> +				      &pci_status);
> +	if (result == PCIBIOS_SUCCESSFUL)
> +		dev_warn(dev->ctrl.device,
> +			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
> +			 csts, pci_status);
> +	else
> +		dev_warn(dev->ctrl.device,
> +			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
> +			 csts, result);
> +}
> +
>  static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> @@ -957,6 +1001,17 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	struct nvme_dev *dev = nvmeq->dev;
>  	struct request *abort_req;
>  	struct nvme_command cmd;
> +	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> +
> +	/*
> +	 * Reset immediately if the controller is failed

s/is/hash?

Otherwise this looks good to me, but I'd like to defer it until
we have the multiple reset issue sorted out, to avoid conflicts.
