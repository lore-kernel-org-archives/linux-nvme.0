From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 27 Jun 2018 11:45:39 +0300
Subject: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-2-jthumshirn@suse.de>
 <20180626145532.GA6628@localhost.localdomain>
 <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>
Message-ID: <7958c766-c99e-ed07-3764-fdb82fd73c94@grimberg.me>


>>> @@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>>   	}
>>>   
>>>   	cmd->common.command_id = req->tag;
>>> +	nvme_req(req)->ctrl = ctrl;
>>>   	if (ns)
>>>   		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
>>>   	else
>>
>> I don't think we need to do this per-io. The request coming from the
>> controller's tagset, so we can do this just once at .init_request time,
>> right?
> 
> Agreed, but as it's Sagi's patch I'd like to hear his opinion on this
> before changing it.

That's a good idea!

seems to work... Johannes, can you respin with this version?
Please CC james and keith on it too.
--
     nvme: cache struct nvme_ctrl reference to struct nvme_request

     We will need to reference the controller in the setup and
     completion time for tracing and future traffic based keep alive
     support.

     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 41d45a1b5c62..9cc33752539a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1737,6 +1737,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, 
struct request *rq,
         int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
         struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];

+       nvme_req(rq)->ctrl = &ctrl->ctrl;
         return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
  }

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..f2249387b60d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
         u8                      retries;
         u8                      flags;
         u16                     status;
+       struct nvme_ctrl        *ctrl;
  };

  /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..d2bd60d8315a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -418,6 +418,7 @@ static int nvme_init_request(struct blk_mq_tag_set 
*set, struct request *req,

         BUG_ON(!nvmeq);
         iod->nvmeq = nvmeq;
+       nvme_req(req)->ctrl = &dev->ctrl;
         return 0;
  }

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 20db67d53ffa..e4087caf8754 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -292,6 +292,7 @@ static int nvme_rdma_init_request(struct 
blk_mq_tag_set *set,
                 return ret;

         req->queue = queue;
+       nvme_req(rq)->ctrl = &ctrl->ctrl;

         return 0;
  }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..af7fbf4132b0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -227,6 +227,7 @@ static int nvme_loop_init_request(struct 
blk_mq_tag_set *set,
  {
         struct nvme_loop_ctrl *ctrl = set->driver_data;

+       nvme_req(req)->ctrl = &ctrl->ctrl;
         return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
                         (set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
  }
--
