From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 18:15:17 +0000
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin
 queue
In-Reply-To: <56D7247C.4000208@dev.mellanox.co.il>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il>
Message-ID: <20160302181516.GA27636@localhost.localdomain>

On Wed, Mar 02, 2016@07:35:56PM +0200, Sagi Grimberg wrote:
> 
> >diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >index 680f578..19be56a 100644
> >--- a/drivers/nvme/host/pci.c
> >+++ b/drivers/nvme/host/pci.c
> >@@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
> >  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
> >  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> >  		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
> >+		dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;
> 
> I still don't understand what's the point?

I agree, this looks like a no-op. The admin request queue isn't for
block data, and the admin queue only uses cmd_type REQ_TYPE_DRV_PRIV. I
believe only requests of REQ_TYPE_FS type are mergable.
