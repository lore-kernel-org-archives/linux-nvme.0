From: keith.busch@intel.com (Keith Busch)
Date: Wed, 21 Nov 2018 12:19:13 -0700
Subject: Should I submit bugs against RC kernels?
In-Reply-To: <af0de79e5ac94be7ad4594fdace103d7@ausx13mps321.AMER.DELL.COM>
References: <af0de79e5ac94be7ad4594fdace103d7@ausx13mps321.AMER.DELL.COM>
Message-ID: <20181121191913.GJ26707@localhost.localdomain>

On Wed, Nov 21, 2018@06:21:49PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> Hi,
> 
> I'm not sure if submitting bugs against RC is a good idea. I am seeing 
> more issues with SURPRISE!!! removal of drives under v4.20-rc3.
> 
> Alex

Hi Alex,

Yes, you can (and should!) report sightings for issues on rc kernels to
the appropriate subsystems.

The following should resolve the issue you're seeing. I won't be able to
test it till next Monday, though.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4f504e8f0669..b1ce747411de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1495,6 +1495,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
+		dev->ctrl.admin_q = NULL;
 	}
 }
 
--
