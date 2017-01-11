From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 11 Jan 2017 13:32:34 -0200
Subject: [PATCH] nvme/quirk: apply DELAY_BEFORE_CHK_RDY quirk at probe
 time too
In-Reply-To: <CY4PR04MB067867FDBE90838EADDEDC4CEA670@CY4PR04MB0678.namprd04.prod.outlook.com>
References: <1482970395-14867-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <CY4PR04MB067867FDBE90838EADDEDC4CEA670@CY4PR04MB0678.namprd04.prod.outlook.com>
Message-ID: <58765012.9090105@linux.vnet.ibm.com>

On 01/10/2017 12:15 PM, Jeffrey Lien wrote:
> I have reviewed this change and approve of it.  

Thanks Jeff!

Keith/Jens/Christoph/Sagi: is it feasible to get this on 4.10, since
it's a minor fix? This would allow us to start request backport for distros.

Thanks in advance,


Guilherme


> 
> Jeff Lien
> 
> -----Original Message-----
> From: Guilherme G. Piccoli [mailto:gpiccoli at linux.vnet.ibm.com] 
> Sent: Wednesday, December 28, 2016 6:13 PM
> To: linux-nvme at lists.infradead.org
> Cc: keith.busch at intel.com; axboe at fb.com; hch at lst.de; byrneadw at ie.ibm.com; jahgomez at mx1.ibm.com; zdmyers at us.ibm.com; gpiccoli at linux.vnet.ibm.com; mniyer at us.ibm.com; dougmill at linux.vnet.ibm.com; Jeffrey Lien; David Darrington
> Subject: [PATCH] nvme/quirk: apply DELAY_BEFORE_CHK_RDY quirk at probe time too
> 
> Commit 54adc01055b7 ("nvme/quirk: Add a delay before checking for adapter
> readiness") introduced a quirk to adapters that cannot read the bit NVME_CSTS_RDY right after register NVME_REG_CC is set; these adapters need a delay or else the action of reading the bit NVME_CSTS_RDY could somehow corrupt adapter's registers state and it never recovers.
> 
> When this quirk was added, we checked ctrl->tagset in order to avoid quirking in probe time, supposing we would never require such delay during probe. Well, it was too optimistic; we in fact need this quirk at probe time in some cases, like after a kexec.
> 
> In some experiments, after abnormal shutdown of machine (aka power cord unplug), we booted into our bootloader in Power, which is a Linux kernel, and kexec'ed into another distro. If this kexec is too quick, we end up reaching the probe of NVMe adapter in that distro when adapter is in bad state (not fully initialized on our bootloader). What happens next is that nvme_wait_ready() is unable to complete, except if the quirk is enabled.
> 
> So, this patch removes the original ctrl->tagset verification in order to enable the quirk even on probe time.
> 
> Fixes: 54adc01055b7 ("nvme/quirk: Add a delay before checking for adapter readiness")
> Reported-by: Andrew Byrne <byrneadw at ie.ibm.com>
> Reported-by: Jaime A. H. Gomez <jahgomez at mx1.ibm.com>
> Reported-by: Zachary D. Myers <zdmyers at us.ibm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
> ---
>  drivers/nvme/host/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index b40cfb0..96b6f6a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1106,12 +1106,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>  	if (ret)
>  		return ret;
>  
> -	/* Checking for ctrl->tagset is a trick to avoid sleeping on module
> -	 * load, since we only need the quirk on reset_controller. Notice
> -	 * that the HGST device needs this delay only in firmware activation
> -	 * procedure; unfortunately we have no (easy) way to verify this.
> -	 */
> -	if ((ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY) && ctrl->tagset)
> +	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
>  		msleep(NVME_QUIRK_DELAY_AMOUNT);
>  
>  	return nvme_wait_ready(ctrl, cap, false);
> --
> 2.1.0
> 
> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:
> 
> This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
> 
