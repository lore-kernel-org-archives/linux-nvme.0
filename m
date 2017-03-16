From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Mar 2017 18:51:16 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <7496c68a-15f3-d8cb-b17f-20f5a59a24d2@redhat.com>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
 <20170310165214.GC14379@mtr-leonro.local>
 <56e8ccd3-8116-89a1-2f65-eb61a91c5f84@mellanox.com>
 <860db62d-ae93-d94c-e5fb-88e7b643f737@redhat.com>
 <0a825b18-df06-9a6d-38c9-402f4ee121f7@mellanox.com>
 <7496c68a-15f3-d8cb-b17f-20f5a59a24d2@redhat.com>
Message-ID: <31678a43-f76c-a921-e40c-470b0de1a86c@grimberg.me>


>>>>> Sagi,
>>>>> The release function is placed in global workqueue. I'm not familiar
>>>>> with NVMe design and I don't know all the details, but maybe the
>>>>> proper way will
>>>>> be to create special workqueue with MEM_RECLAIM flag to ensure the
>>>>> progress?

Leon, the release work makes progress, but it is inherently slower
than the establishment work and when we are bombarded with
establishments we have no backpressure...

> I tried with 4.11.0-rc2, and still can reproduced it with less than 2000
> times.

Yi,

Can you try the below (untested) patch:

I'm not at all convinced this is the way to go because it will
slow down all the connect requests, but I'm curious to know
if it'll make the issue go away.

--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ecc4fe862561..f15fa6e6b640 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1199,6 +1199,9 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,
         }
         queue->port = cm_id->context;

+       /* Let inflight queue teardown complete */
+       flush_scheduled_work();
+
         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
         if (ret)
                 goto release_queue;
--

Any other good ideas are welcome...
