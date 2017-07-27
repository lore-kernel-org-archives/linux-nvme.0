From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Jul 2017 16:05:47 +0300
Subject: nvmet panics during high load
In-Reply-To: <CAF9HSikTcqojqWOx7cjBsv9fLCvbkU_f6-1CgQ16Wpb1f5oQ4g@mail.gmail.com>
References: <CAF9HSikTcqojqWOx7cjBsv9fLCvbkU_f6-1CgQ16Wpb1f5oQ4g@mail.gmail.com>
Message-ID: <ee61dc25-bb67-8466-6cc9-d20b4ff0104f@grimberg.me>

> Hi All,

Hey Alon,

> This is my first post on this mailing list. Let me know if this is the
> wrong place or format to post bugs in.

This is the correct place.

> We're running nvmef using RDMA on kernel 4.11.8.
> We found a zero-dereference bug in nvmet during high load and
> identified the root cause:
> The location according to current linux master (fd2b2c57) is
> drivers/nvme/target/rdma.c at function nvmet_rdma_get_rsp line 170.
> list_first_entry is called on the list of free responses (free_rsps)
> which is empty and obviously unexpected. I added an assert to validate
> that and also tested a hack that enlarges the queue times 10 and it
> seemed to solve it.
> It's probably not a leak but a miscalculation of the size of the queue
> (queue->recv_queue_size * 2). Can anyone explain the rationale behind
> this calculation? Is the queue assumed to never be empty?

Well, you are correct that the code assumes that it always has a free
rsp to use, and yes, its a wrong assumptions. The reason is that
rsps are freed upon the send completion of a nvme command (cqe).

If for example one or more acks from the host on this send were dropped
(which can very well happen on a high load switched fabric environment),
then we might end up needing more resources than we originally thought.

Does your cluster involve one or more switches cascade? That would
explain how we're getting there.

We use heuristics of 2x the queue_size so that we can't pipeline
queue-depth and also have a queue-depth to spare as completions might
take time.

I think that allocating 10x is an overkill, but maybe something that
grows lazily can fit better (not sure if we want to shrink as well).

Can you tryout this (untested) patch:
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 56a4cba690b5..3510ae4b20aa 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -91,8 +91,8 @@ struct nvmet_rdma_queue {
         struct nvmet_cq         nvme_cq;
         struct nvmet_sq         nvme_sq;

-       struct nvmet_rdma_rsp   *rsps;
         struct list_head        free_rsps;
+       unsigned int            nr_rsps;
         spinlock_t              rsps_lock;
         struct nvmet_rdma_cmd   *cmds;

@@ -136,6 +136,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, 
struct ib_wc *wc);
  static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc);
  static void nvmet_rdma_qp_event(struct ib_event *event, void *priv);
  static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
+static struct nvmet_rdma_rsp *
+nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev);

  static struct nvmet_fabrics_ops nvmet_rdma_ops;

@@ -167,10 +169,19 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
         unsigned long flags;

         spin_lock_irqsave(&queue->rsps_lock, flags);
-       rsp = list_first_entry(&queue->free_rsps,
+       rsp = list_first_entry_or_null(&queue->free_rsps,
                                 struct nvmet_rdma_rsp, free_list);
-       list_del(&rsp->free_list);
-       spin_unlock_irqrestore(&queue->rsps_lock, flags);
+       if (unlikely(!rsp)) {
+               /* looks like we need more, grow the rsps pool lazily */
+               spin_unlock_irqrestore(&queue->rsps_lock, flags);
+               rsp = nvmet_rdma_alloc_rsp(queue->dev);
+               if (!rsp)
+                       return NULL;
+               queue->nr_rsps++;
+       } else {
+               list_del(&rsp->free_list);
+               spin_unlock_irqrestore(&queue->rsps_lock, flags);
+       }

         return rsp;
  }
@@ -342,13 +353,19 @@ static void nvmet_rdma_free_cmds(struct 
nvmet_rdma_device *ndev,
         kfree(cmds);
  }

-static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
-               struct nvmet_rdma_rsp *r)
+static struct nvmet_rdma_rsp *
+nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev)
  {
+       struct nvmet_rdma_rsp *r;
+
+       r = kzalloc(sizeof(struct nvmet_rdma_rsp), GFP_KERNEL);
+       if (!r)
+               return NULL;
+
         /* NVMe CQE / RDMA SEND */
         r->req.rsp = kmalloc(sizeof(*r->req.rsp), GFP_KERNEL);
         if (!r->req.rsp)
-               goto out;
+               goto out_free;

         r->send_sge.addr = ib_dma_map_single(ndev->device, r->req.rsp,
                         sizeof(*r->req.rsp), DMA_TO_DEVICE);
@@ -367,12 +384,13 @@ static int nvmet_rdma_alloc_rsp(struct 
nvmet_rdma_device *ndev,

         /* Data In / RDMA READ */
         r->read_cqe.done = nvmet_rdma_read_data_done;
-       return 0;
+       return r;

+out_free:
+       kfree(r);
  out_free_rsp:
         kfree(r->req.rsp);
-out:
-       return -ENOMEM;
+       return NULL;
  }

  static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
@@ -381,25 +399,21 @@ static void nvmet_rdma_free_rsp(struct 
nvmet_rdma_device *ndev,
         ib_dma_unmap_single(ndev->device, r->send_sge.addr,
                                 sizeof(*r->req.rsp), DMA_TO_DEVICE);
         kfree(r->req.rsp);
+       kfree(r);
  }

  static int
  nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
  {
         struct nvmet_rdma_device *ndev = queue->dev;
-       int nr_rsps = queue->recv_queue_size * 2;
-       int ret = -EINVAL, i;
-
-       queue->rsps = kcalloc(nr_rsps, sizeof(struct nvmet_rdma_rsp),
-                       GFP_KERNEL);
-       if (!queue->rsps)
-               goto out;
+       struct nvmet_rdma_rsp *r, *rsp;
+       int i;

-       for (i = 0; i < nr_rsps; i++) {
-               struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
+       queue->nr_rsps = queue->recv_queue_size * 2;

-               ret = nvmet_rdma_alloc_rsp(ndev, rsp);
-               if (ret)
+       for (i = 0; i < queue->nr_rsps; i++) {
+               rsp = nvmet_rdma_alloc_rsp(ndev);
+               if (!rsp)
                         goto out_free;

                 list_add_tail(&rsp->free_list, &queue->free_rsps);
@@ -408,29 +422,27 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
         return 0;

  out_free:
-       while (--i >= 0) {
-               struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
-
+       list_for_each_entry_safe(rsp, r, &queue->free_rsps, free_list) {
                 list_del(&rsp->free_list);
                 nvmet_rdma_free_rsp(ndev, rsp);
         }
-       kfree(queue->rsps);
-out:
-       return ret;
+       return -ENOMEM;
  }

  static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
  {
         struct nvmet_rdma_device *ndev = queue->dev;
-       int i, nr_rsps = queue->recv_queue_size * 2;
-
-       for (i = 0; i < nr_rsps; i++) {
-               struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
+       struct nvmet_rdma_rsp *r, *rsp;
+       int i = 0;

+       list_for_each_entry_safe(rsp, r, &queue->free_rsps, free_list) {
                 list_del(&rsp->free_list);
                 nvmet_rdma_free_rsp(ndev, rsp);
+               i++;
         }
-       kfree(queue->rsps);
+
+       WARN_ONCE(i != queue->nr_rsps, "queue %d freed %d rsps out of %d\n",
+                       queue->idx, i, queue->nr_rsps);
  }

  static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
@@ -756,6 +768,10 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, 
struct ib_wc *wc)

         cmd->queue = queue;
         rsp = nvmet_rdma_get_rsp(queue);
+       if (unlikely(!rsp)) {
+               /* can't even allocate rsp to return a failure, just 
drop.. */
+               return;
+       }
         rsp->queue = queue;
         rsp->cmd = cmd;
         rsp->flags = 0;
--
