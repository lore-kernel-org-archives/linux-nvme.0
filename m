From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Sep 2014 07:45:46 -0600 (MDT)
Subject: [PATCHv2] NVMe: Fix partition detection issue(hot remove followed
 by hot add)
In-Reply-To: <1411467843-3003-1-git-send-email-indraneel.m@samsung.com>
References: <1411467843-3003-1-git-send-email-indraneel.m@samsung.com>
Message-ID: <alpine.LRH.2.03.1409230733000.4696@AMR>

On Tue, 23 Sep 2014, Indraneel Mukherjee wrote:
> Finally managing to re-send this patch to address the review comments
> after Firewall issues were resolved at our end. Though not sure how
> valid this patch is now after Keith's attempts to fix this in the block
> layer. Keith, any thoughts on what will be the final form of this fix?

Hi Indraneel,

Is there anything we need to do in the driver anymore? We should get
the desired behavior with the dev_t minor allocation fix:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/block/genhd.c?id=2da78092dda13f1efd26edbbf99a567776913750

If anything, maybe the nvme_dev's instance could be released in
nvme_free_dev(), but even that seems unnecessary. The test seems to work
on my machine, but please let me know if something else is amiss.

Thanks,
Keith
