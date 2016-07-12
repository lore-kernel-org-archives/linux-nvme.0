From: mlin@kernel.org (Ming Lin)
Date: Tue, 12 Jul 2016 13:40:54 -0700
Subject: crash on device removal
In-Reply-To: <00cb01d1dc5b$51c05970$f5410c50$@opengridcomputing.com>
References: <00cb01d1dc5b$51c05970$f5410c50$@opengridcomputing.com>
Message-ID: <1468356054.5426.1.camel@ssi>

On Tue, 2016-07-12@11:34 -0500, Steve Wise wrote:
> Hey Christoph, 
> 
> I see a crash when shutting down a nvme host node via 'reboot' that has 1 target
> device attached.  The shutdown causes iw_cxgb4 to be removed which triggers the
> device removal logic in the nvmf rdma transport.  The crash is here:
> 
> (gdb) list *nvme_rdma_free_qe+0x18
> 0x1e8 is in nvme_rdma_free_qe (drivers/nvme/host/rdma.c:196).
> 191     }
> 192
> 193     static void nvme_rdma_free_qe(struct ib_device *ibdev, struct
> nvme_rdma_qe *qe,
> 194                     size_t capsule_size, enum dma_data_direction dir)
> 195     {
> 196             ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
> 197             kfree(qe->data);
> 198     }
> 199
> 200     static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct
> nvme_rdma_qe *qe,
> 
> Apparently qe is NULL.
> 
> Looking at the device removal path, the logic appears correct (see
> nvme_rdma_device_unplug() and the nice function comment :) ).  I'm wondering if
> concurrently to the host device removal path cleaning up queues, the target is
> disconnecting all of its queues due to the first disconnect event from the host
> causing some cleanup race on the host side?  Although since the removal path
> executing in the cma event handler upcall, I don't think another thread would be
> handling a disconnect event.  Maybe the qp async event handler flow?
> 
> Thoughts?

We actually missed a kref_get in nvme_get_ns_from_disk().

This should fix it. Could you help to verify?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4babdf0..b146f52 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -183,6 +183,8 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	}
 	spin_unlock(&dev_list_lock);
 
+	kref_get(&ns->ctrl->kref);
+
 	return ns;
 
 fail_put_ns:
