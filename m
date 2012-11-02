From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Fri, 2 Nov 2012 16:51:47 +0000
Subject: Intel NVMe reset issue
In-Reply-To: <511F17E9-6921-4AF3-92F5-9A6448C03B90@sandisk.com>
References: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDADE@corpmail1.na.ads.idt.com>
 <511F17E9-6921-4AF3-92F5-9A6448C03B90@sandisk.com>
Message-ID: <05CD7821AE397547A01AC160FBC231474BC452E9@corpmail1.na.ads.idt.com>

It is a typo in the description to "wait for "Enable" bit to clear". It should have been "wait for CSTS.RDY bit to clear".  His code is to wait for the CSTS.RDY bit.

i.e.

+       while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {


He should also use NVME_CAP_TIMEOUT as the timeout and not 5 seconds per Matthew's last message.


-Kwok




From: Gurpreet Anand [mailto:Gurpreet.Anand@sandisk.com] 
Sent: Thursday, November 01, 2012 7:12 PM
To: Panah, Khosrow
Cc: linux-nvme at lists.infradead.org; Kong, Kwok
Subject: Re: Intel NVMe reset issue

Our interpretation of the spec suggests that driver should not poll on CC.EN but on CSTS.RDY after setting CC.EN which we see being done correctly. Can you explain why the controller needs to clear CC.EN? From the controller perspective it is a read-only bit.

Keith's response does make sense where the driver still writes to CC.EN.

Panah, what is the issue you are trying to solve here?

Thanks,
Gurpreet?


On Nov 1, 2012,@11:38 AM, "Panah, Khosrow" <Khosrow.Panah@idt.com> wrote:
All,

While testing Intel NVMe driver on Linux, I noticed there are instances controller fails to initialize IDT controller. The problem is related to Intel Linux driver does not wait for "Enable" bit to clear when attempting to setup admin queue. ?I am suggesting the following changes to "nvme_configure_admin_queue" routine:

***************
*** 1039,1044 ****
--- 1058,1078 ----
???????dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

???????writel(0, &dev->bar->cc);
+ ??????timeout = (5 * HZ) + jiffies;
+ ??????while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
+ ??????????????msleep(100);
+ ??????????????if (fatal_signal_pending(current))
+ ??????????????????????result = -EINTR;
+ ??????????????if (time_after(jiffies, timeout)) {
+ ??????????????????????dev_err(&dev->pci_dev->dev,
+ ??????????????????????????????"Device busy; aborting initialisation\n");
+ ??????????????????????result = -ENODEV;
+ ??????????????}
+ ??????}
+ ??????if (result) {
+ ??????????????nvme_free_queue_mem(nvmeq);
+ ??????????????return result;
+ ??????}
???????writel(aqa, &dev->bar->aqa);
???????writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
???????writeq(nvmeq->cq_dma_addr, &dev->bar->acq);

Khosrow


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme

________________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
