From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Tue, 28 May 2019 16:32:45 -0600
Subject: [PATCH] nvme: Ignore timeouts while PCI config access is blocked
In-Reply-To: <99e76784-ce68-c053-9fde-d035d77f11d3@grimberg.me>
References: <20190523231429.21235-1-kenneth.heitke@intel.com>
 <99e76784-ce68-c053-9fde-d035d77f11d3@grimberg.me>
Message-ID: <18209f57-0c8a-dfa8-af31-7f33ec3cfc0c@intel.com>



On 5/24/2019 12:35 AM, Sagi Grimberg wrote:
> 
>> ? static void nvme_reset_done(struct pci_dev *pdev)
>> ? {
>> ????? struct nvme_dev *dev = pci_get_drvdata(pdev);
>> -??? nvme_reset_ctrl_sync(&dev->ctrl);
>> +??? nvme_reset_ctrl(&dev->ctrl);
> 
> This change is not explained in the change log. This opens a window
> for nvme_reset_work to run concurrently from different contexts which
> is not a good idea...

I think Keith recommended the asynchronous reset

"Definitely need the nvme_reset_ctrl change as blk_cfg_access is still
set here so need to reset asynchronously to unblock new timeouts"

Keith, does this still hold true or do I need some other mechanism to 
avoid the issues that Sagi is concerned about?
