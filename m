From: keith.busch@intel.com (Keith Busch)
Date: Wed, 29 May 2013 14:44:31 -0600 (MDT)
Subject: Tree updated 2013-05-29
In-Reply-To: <20130529210419.GE8211@linux.intel.com>
References: <20130517133517.GO6057@linux.intel.com>
 <20130529210419.GE8211@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1305291342320.12919@localhost.localdom>

On Wed, 29 May 2013, Matthew Wilcox wrote:
> Chayan Biswas (1):
>      Return the result from user admin command IOCTL even in case of failure
>
> Matthew Wilcox (1):
>      NVMe: Use dma_set_mask() correctly
>
> Ramachandra Rao Gajula (1):
>      NVMe: Add MSI support
>
> I'll ask Linus to pull on Friday.  Please test.

In the MSI patch, there's a missing 'break' after the 'result == 0' case.
Otherwise everything looks good to me.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 584586f..ce79a59 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1681,6 +1681,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  			if (result == 0) {
  				for (i = 0; i < nr_io_queues; i++)
  					dev->entry[i].vector = i + pdev->irq;
+                               break;
  			} else if (result > 0) {
  				nr_io_queues = result;
  				continue;
