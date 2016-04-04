From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Apr 2016 19:14:15 +0000
Subject: [PATCHv2] NVMe: Fix reset/remove race
In-Reply-To: <57014716.5050901@grimberg.me>
References: <1458683375-27496-1-git-send-email-keith.busch@intel.com>
 <57014716.5050901@grimberg.me>
Message-ID: <20160404191414.GA21477@localhost.localdomain>

On Sun, Apr 03, 2016@07:38:46PM +0300, sagig wrote:
> On 22/03/16 23:49, Keith Busch wrote:
> >  drivers/nvme/host/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >index 24ccda3..660ec84 100644
> >--- a/drivers/nvme/host/pci.c
> >+++ b/drivers/nvme/host/pci.c
> >@@ -1859,6 +1859,9 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
> >  		nvme_dev_disable(dev, false);
> >+	if (test_bit(NVME_CTRL_REMOVING, &dev->flags))
> >+		goto out;
> >+
> >  	set_bit(NVME_CTRL_RESETTING, &dev->flags);
> >  	result = nvme_pci_enable(dev);
> >@@ -2078,11 +2081,10 @@ static void nvme_remove(struct pci_dev *pdev)
> >  {
> >  	struct nvme_dev *dev = pci_get_drvdata(pdev);
> >-	del_timer_sync(&dev->watchdog_timer);
> >-
> >  	set_bit(NVME_CTRL_REMOVING, &dev->flags);
> >  	pci_set_drvdata(pdev, NULL);
> >  	flush_work(&dev->async_work);
> >+	flush_work(&dev->reset_work);
> 
> Do we need the same for scan_work? AFAICT it can still
> sneak in while we're removing...

It is flushed in the very next line not included in your reply. :)

scan_work isn't queued again when the "NVME_CTRL_REMOVING" flag is set,
so we're safe from seeing that queue again.
