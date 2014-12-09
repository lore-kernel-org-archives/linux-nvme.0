From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Tue, 09 Dec 2014 20:14:59 +0530
Subject: [PATCHv2] NVMe: Fix partition detection issue(hot remove followed
 by hot add)
In-Reply-To: <alpine.LRH.2.03.1409230733000.4696@AMR>
References: <1411467843-3003-1-git-send-email-indraneel.m@samsung.com>
 <alpine.LRH.2.03.1409230733000.4696@AMR>
Message-ID: <027101d013be$b7731170$26593450$@samsung.com>

Keith,
Resurrecting an old thread.
Verified the partition detection issue(hot remove followed by Hot-Add) with
the latest linux-nvme git tip after applying
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/block
/genhd.c?id=2da78092dda13f1efd26edbbf99a567776913750
and
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/block
/partition-generic.c?id=2da78092dda13f1efd26edbbf99a567776913750

But when the device is again hot-added and the new node (/dev/nvme0n1p1)
appears again, mounting it fails with the following error:
mount: mount /dev/nvme0n1p1 on /mnt failed: File exists

The old nodes' FS entries still exist and hence kernel can't re-create
procfs and sysfs entries with the same name.

# ls /sys/fs/ext4/
features  nvme0n1p1
--> already exists

This can be fixed with:

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2735,7 +2735,6 @@ static void nvme_free_dev(struct kref *kref)

        pci_dev_put(dev->pci_dev);
        nvme_free_namespaces(dev);
-       nvme_release_instance(dev);
        free_percpu(dev->io_queue);
        kfree(dev->queues);
        kfree(dev->entry);
@@ -2996,6 +2995,7 @@ static void nvme_remove(struct pci_dev *pdev)
        nvme_dev_shutdown(dev);
        nvme_free_queues(dev, 0);
        nvme_dev_remove(dev);
+       nvme_release_instance(dev);
        nvme_release_prp_pools(dev);
        kref_put(&dev->kref, nvme_free_dev);
 }

This ensures that the new node gets a different name (in case there is a
stale node).

If the fix is okay, I can send this separately as a patch.


-Indro


> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Keith Busch
> Sent: Tuesday, September 23, 2014 7:16 PM
> To: Indraneel Mukherjee
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCHv2] NVMe: Fix partition detection issue(hot remove
followed
> by hot add)
> 
> On Tue, 23 Sep 2014, Indraneel Mukherjee wrote:
> > Finally managing to re-send this patch to address the review comments
> > after Firewall issues were resolved at our end. Though not sure how
> > valid this patch is now after Keith's attempts to fix this in the
> > block layer. Keith, any thoughts on what will be the final form of this
fix?
> 
> Hi Indraneel,
> 
> Is there anything we need to do in the driver anymore? We should get the
> desired behavior with the dev_t minor allocation fix:
> 
>
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/block
/gen
> hd.c?id=2da78092dda13f1efd26edbbf99a567776913750
> 
> If anything, maybe the nvme_dev's instance could be released in
> nvme_free_dev(), but even that seems unnecessary. The test seems to work
on
> my machine, but please let me know if something else is amiss.
> 
> Thanks,
> Keith
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
