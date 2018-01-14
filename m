From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jan 2018 18:41:11 +0900
Subject: [PATCH] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <d4a85f57-a499-a580-ba39-8eea6e5c9712@grimberg.me>
References: <1515914131-12725-1-git-send-email-minwoo.im.dev@gmail.com>
 <d4a85f57-a499-a580-ba39-8eea6e5c9712@grimberg.me>
Message-ID: <CAA7jztfVUq2hCoTbjjCw69f3Z77chwZmrADNU3+w2d4zBCcWfg@mail.gmail.com>

Sagi,

On Sun, Jan 14, 2018@6:18 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Minwoo,
>
>> If either create-sq or create-cq is failed with an NVMe status,
>> nvme_init_queue() is invoked which was not expected to be called in
>> nvme_create_queue().
>> To prevent this inconsistency of queue_count, free queue(s) already
>> allocated in nvme_create_io_queues() when it goes wrong in
>> nvme_create_queue().
>
>
> The fix looks good, but I think it would be better to cleanup the queue
> in the call site where nvme_alloc_queue is called, having it here is a
> bit awkward IMO.

Thanks for your kind review.

I agree with that allocation and freeing should be in the same place
because it looks much more consistent in code.

What about below code?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e..ecef45a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1456,11 +1456,11 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)

        nvmeq->cq_vector = qid - 1;
        result = adapter_alloc_cq(dev, qid, nvmeq);
-       if (result < 0)
+       if (result)
                return result;

        result = adapter_alloc_sq(dev, qid, nvmeq);
-       if (result < 0)
+       if (result)
                goto release_cq;

        nvme_init_queue(nvmeq, qid);
@@ -1476,7 +1476,6 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
        adapter_delete_cq(dev, qid);
        return result;
 }
-
 static const struct blk_mq_ops nvme_mq_admin_ops = {
        .queue_rq       = nvme_queue_rq,
        .complete       = nvme_pci_complete_rq,
@@ -1637,8 +1636,10 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
        max = min(dev->max_qid, dev->ctrl.queue_count - 1);
        for (i = dev->online_queues; i <= max; i++) {
                ret = nvme_create_queue(dev->queues[i], i);
-               if (ret)
+               if (ret) {
+                       nvme_free_queues(dev, dev->online_queues);
                        break;
+               }
        }

        /*
