From: keith.busch@gmail.com (Keith Busch)
Date: Wed, 29 May 2019 09:08:33 -0600
Subject: [PATCH] nvme: Ignore timeouts while PCI config access is blocked
In-Reply-To: <18209f57-0c8a-dfa8-af31-7f33ec3cfc0c@intel.com>
References: <20190523231429.21235-1-kenneth.heitke@intel.com>
 <99e76784-ce68-c053-9fde-d035d77f11d3@grimberg.me>
 <18209f57-0c8a-dfa8-af31-7f33ec3cfc0c@intel.com>
Message-ID: <CAOSXXT4FVyyG1gc9hfe8TdH-TDxU=gVCT-0g8tqkgZVUr5eGeA@mail.gmail.com>

On Tue, May 28, 2019, 4:32 PM Heitke, Kenneth <kenneth.heitke@intel.com> wrote:
> On 5/24/2019 12:35 AM, Sagi Grimberg wrote:
> >
> >>   static void nvme_reset_done(struct pci_dev *pdev)
> >>   {
> >>       struct nvme_dev *dev = pci_get_drvdata(pdev);
> >> -    nvme_reset_ctrl_sync(&dev->ctrl);
> >> +    nvme_reset_ctrl(&dev->ctrl);
> >
> > This change is not explained in the change log. This opens a window
> > for nvme_reset_work to run concurrently from different contexts which
> > is not a good idea...
>
> I think Keith recommended the asynchronous reset
>
> "Definitely need the nvme_reset_ctrl change as blk_cfg_access is still
> set here so need to reset asynchronously to unblock new timeouts"
>
> Keith, does this still hold true or do I need some other mechanism to
> avoid the issues that Sagi is concerned about?

Can't use the pci's block_cfg_access in timeout if doing synchronous
resets in reset_done. We wouldn't be able to handle IO timeouts during
reset using that, so would need to use something else, maybe introduce
a new flag like your original patch.
