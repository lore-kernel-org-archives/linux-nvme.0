From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 18 Jan 2019 11:55:43 -0800
Subject: NVMEoF regression on i40iw for 5.0-rc
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5A0B747@fmsmsx124.amr.corp.intel.com>
References: <9DD61F30A802C4429A01CA4200E302A7A5A0B747@fmsmsx124.amr.corp.intel.com>
Message-ID: <d2c6ca08-8c47-401d-3768-b5c0c51bc4a2@grimberg.me>


> Hi Sagi,
> 
> There is a regression introduced in 5.0.0-rcx with this commit b65bb777ef22 (" nvme-rdma: support separate queue maps for read and write")
> on the initiator side while running NVMEoF on i40iw device.
> 
> The crash is at https://elixir.bootlin.com/linux/v5.0-rc2/source/drivers/nvme/host/rdma.c#L303
> 
> It appears it's because the nvme rdma queue data struct being referenced in
> nvme_rdma_init_request() has not been setup yet via nvme_rdma_alloc_queue().
> Any idea why this might be the case?

Hi Shiraz,

What is the exact nvme-cli command you are running?

It appears that you are trying to create 16 I/O queues but end up
creating only a single I/O queue? I guess that is due to the fact
that your device supports only a single queue. However it seems
that we initialize requests for a second hctx that wasn't allocated
(as we have a single I/O queue).

I think this should make this go away:
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 079d59c04a0e..1962ce95e393 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1781,7 +1781,7 @@ static int nvme_rdma_map_queues(struct 
blk_mq_tag_set *set)
         struct nvme_rdma_ctrl *ctrl = set->driver_data;

         set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
-       set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
+       set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.queue_count - 1;
         if (ctrl->ctrl.opts->nr_write_queues) {
                 /* separate read/write queues */
                 set->map[HCTX_TYPE_DEFAULT].nr_queues =
@@ -1791,7 +1791,7 @@ static int nvme_rdma_map_queues(struct 
blk_mq_tag_set *set)
         } else {
                 /* mixed read/write queues */
                 set->map[HCTX_TYPE_DEFAULT].nr_queues =
-                               ctrl->ctrl.opts->nr_io_queues;
+                               ctrl->ctrl.queue_count - 1;
                 set->map[HCTX_TYPE_READ].queue_offset = 0;
         }
         blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
--

However I think we also need to account for this when assigning
write_queues and poll_queues as well...
