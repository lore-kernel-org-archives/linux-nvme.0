From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 15 Apr 2018 16:50:58 +0300
Subject: [PATCH 2/2 v3] nvme-rdma: Fix command completion race at error
 recovery
In-Reply-To: <20180412133730.GB5791@lst.de>
References: <1523462824-25643-1-git-send-email-israelr@mellanox.com>
 <1523462824-25643-3-git-send-email-israelr@mellanox.com>
 <20180412133730.GB5791@lst.de>
Message-ID: <cba7bf85-464d-adfe-55d1-75bede49e36c@mellanox.com>



On 4/12/2018 4:37 PM, Christoph Hellwig wrote:
> We really need to keep this code in sync with the various transports,
> chances are any race you see in RDMA will happen elsewhere as well.
> 

I saw that the pci driver calls nvme_pci_disable so it will not get any 
interrupts/completion from the drive. so the nvme_cancel_request loop is 
safe.
Regarding FC we need James here.

If you're talking about pushing it to common code in the core layer, 
then I guess it's a good idea with/without this patchset.
