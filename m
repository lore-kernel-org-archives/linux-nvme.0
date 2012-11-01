From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 1 Nov 2012 21:13:28 +0000
Subject: Intel NVMe reset issue
In-Reply-To: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDADE@corpmail1.na.ads.idt.com>
References: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDADE@corpmail1.na.ads.idt.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B9162BA5CC@FMSMSX105.amr.corp.intel.com>

I think this looks good. Just curious, where does the 5 second timeout come from? That sounds reasonable to me, but I don't see that ECN033 specifies what the timeout should be for CSTS.RDY to transition from 1 to 0 after setting CC.EN to 0.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> -----Original Message-----
> From: linux-nvme-bounces at lists.infradead.org [mailto:linux-nvme-
> bounces at lists.infradead.org] On Behalf Of Panah, Khosrow
> Sent: Thursday, November 01, 2012 12:37 PM
> To: linux-nvme at lists.infradead.org
> Cc: Kong, Kwok
> Subject: Intel NVMe reset issue
> 
> All,
> 
> While testing Intel NVMe driver on Linux, I noticed there are instances
> controller fails to initialize IDT controller. The problem is related
> to Intel Linux driver does not wait for "Enable" bit to clear when
> attempting to setup admin queue.  I am suggesting the following changes
> to "nvme_configure_admin_queue" routine:
> 
> ***************
> *** 1039,1044 ****
> --- 1058,1078 ----
>         dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
> 
>         writel(0, &dev->bar->cc);
> +       timeout = (5 * HZ) + jiffies;
> +       while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
> +               msleep(100);
> +               if (fatal_signal_pending(current))
> +                       result = -EINTR;
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(&dev->pci_dev->dev,
> +                               "Device busy; aborting
> initialisation\n");
> +                       result = -ENODEV;
> +               }
> +       }
> +       if (result) {
> +               nvme_free_queue_mem(nvmeq);
> +               return result;
> +       }
>         writel(aqa, &dev->bar->aqa);
>         writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
>         writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
> 
> Khosrow
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
