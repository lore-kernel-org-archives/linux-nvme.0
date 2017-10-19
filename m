From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 09:55:46 +0300
Subject: nvmeof rdma regression issue on 4.14.0-rc1 (or maybe mlx4?)
In-Reply-To: <64135330-a62d-87b8-c805-6b52fd40bf81@redhat.com>
References: <1735134433.8514119.1505997532669.JavaMail.zimbra@redhat.com>
 <1215229914.8516804.1505998051674.JavaMail.zimbra@redhat.com>
 <20170921144421.GA15285@infradead.org>
 <47493aa0-4cad-721b-4ea2-c3b2293340aa@grimberg.me>
 <e8aa9f2e-14b1-23f0-f672-07a913842c9d@redhat.com>
 <20170924103426.GB25094@mtr-leonro.local>
 <4d0e27f2-99e4-ffc7-18a5-e5757c27dad4@redhat.com>
 <4faccebf-7fcf-58b9-1605-82ee9acc652b@grimberg.me>
 <e44f4640-44b2-4692-ca57-08f9ebf4da2c@redhat.com>
 <729c512f-55ff-25e4-6dd9-8b4dcc31bb8d@grimberg.me>
 <ff355fcf-5089-f297-d3fa-9b86d133236b@redhat.com>
 <6d639dd4-9366-2ecf-b49e-751c7a167528@grimberg.me>
 <64135330-a62d-87b8-c805-6b52fd40bf81@redhat.com>
Message-ID: <62eea88b-caa4-5799-3d8f-8d8789879aa8@grimberg.me>


>> Hi Yi,
>>
>> I was referring to the bug you reported on a simple create_ctrl failed:
>> https://pastebin.com/7z0XSGSd
>>
>> Does it reproduce?
>>
> yes, this issue was reproduced during "git bisect" with below patch

OK, if this does not reproduce with the latest code, lets put it aside
for now.

So as for the error you see, can you please try the following patch?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 405895b1dff2..916658e010ff 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -572,6 +572,11 @@ static void nvme_rdma_free_queue(struct 
nvme_rdma_queue *queue)
         if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
                 return;

+       if(nvme_rdma_queue_idx(queue) == 0)
+               nvme_rdma_free_qe(queue->device->dev,
+                       &queue->ctrl->async_event_sqe,
+                       sizeof(struct nvme_command), DMA_TO_DEVICE);
+
         nvme_rdma_destroy_queue_ib(queue);
         rdma_destroy_id(queue->cm_id);
  }
@@ -739,8 +744,6 @@ static struct blk_mq_tag_set 
*nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
  static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
                 bool remove)
  {
-       nvme_rdma_free_qe(ctrl->queues[0].device->dev, 
&ctrl->async_event_sqe,
-                       sizeof(struct nvme_command), DMA_TO_DEVICE);
         nvme_rdma_stop_queue(&ctrl->queues[0]);
         if (remove) {
                 blk_cleanup_queue(ctrl->ctrl.admin_q);
--
