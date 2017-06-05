From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Mon, 5 Jun 2017 16:02:42 +0200 (CEST)
Subject: [PATCH] nvme-rdma: remove race conditions from IB signalling
In-Reply-To: <398638390.74484157.1496662780144.JavaMail.zimbra@kalray.eu>
References: <1785464880.73761005.1496655938570.JavaMail.zimbra@kalray.eu>
 <97a72992-3ac3-74d9-96dc-22c31bbb6694@grimberg.me>
 <398638390.74484157.1496662780144.JavaMail.zimbra@kalray.eu>
Message-ID: <778243979.75061117.1496671362418.JavaMail.zimbra@kalray.eu>



----- Mail original -----
> De: "Marta Rybczynska" <mrybczyn at kalray.eu>
> ?: "Sagi Grimberg" <sagi at grimberg.me>
> Cc: axboe at fb.com, "Leon Romanovsky" <leon at kernel.org>, linux-kernel at vger.kernel.org, linux-nvme at lists.infradead.org,
> "keith busch" <keith.busch at intel.com>, "Doug Ledford" <dledford at redhat.com>, "Bart Van Assche"
> <bart.vanassche at sandisk.com>, hch at lst.de, "Jason Gunthorpe" <jgunthorpe at obsidianresearch.com>
> Envoy?: Lundi 5 Juin 2017 13:39:40
> Objet: Re: [PATCH] nvme-rdma: remove race conditions from IB signalling

>>> -static inline int nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
>>> +static inline int nvme_rdma_init_sig_count(int queue_size)
>>>   {
>>> -       int sig_limit;
>>> -
>>> -       /*
>>> -        * We signal completion every queue depth/2 and also handle the
>>> -        * degenerated case of a  device with queue_depth=1, where we
>>> -        * would need to signal every message.
>>> +       /* We want to signal completion at least every queue depth/2.
>>> +        * This returns the largest power of two that is not above half
>>> +        * of (queue size + 1) to optimize (avoid divisions).
>>>           */
>>> -       sig_limit = max(queue->queue_size / 2, 1);
>>> -       return (++queue->sig_count % sig_limit) == 0;
>>> +       return 1 << ilog2((queue_size + 1) / 2);
>>> +}
>>> +
>>> +static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
>>> +{
>>> +       int count, limit;
>>> +
>>> +       limit = nvme_rdma_init_sig_count(queue->queue_size);
>> 
>> Why calling it init? you're not initializing anything...
>> 
>> I'd just call it nvme_rdma_sig_limit()
>> 
>>> +       count = atomic_inc_return(&queue->sig_count);
>>> +
>>> +       /* Signal if count is a multiple of limit */
>>> +       if ((count & (limit - 1)) == 0)
>>> +               return true;
>>> +       return false;
>>>   }
>> 
>> You can replace it with:
>>	return (atomic_inc_return(&queue->sig_count) & (limit - 1)) == 0;
>> 
>> And lose the local count variable.
> 
> The init part is a leftover from one of the previous versions and we do not need
> the value anywhere else. As the sig_limit() function is quite short now it I can
> also put the ilog part + comments in the same place too. Wouldn't it be easier
> to read?
> 

It looks like this. What do you think Sagi?

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 28bd255..4eb4846 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -88,7 +88,7 @@ enum nvme_rdma_queue_flags {
 
 struct nvme_rdma_queue {
        struct nvme_rdma_qe     *rsp_ring;
-       u8                      sig_count;
+       atomic_t                sig_count;
        int                     queue_size;
        size_t                  cmnd_capsule_len;
        struct nvme_rdma_ctrl   *ctrl;
@@ -554,6 +554,8 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 
        queue->queue_size = queue_size;
 
+       atomic_set(&queue->sig_count, 0);
+
        queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
                        RDMA_PS_TCP, IB_QPT_RC);
        if (IS_ERR(queue->cm_id)) {
@@ -1038,17 +1040,18 @@ static void nvme_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
                nvme_rdma_wr_error(cq, wc, "SEND");
 }
 
-static inline int nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
+static inline bool nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
 {
-       int sig_limit;
+       int limit;
 
-       /*
-        * We signal completion every queue depth/2 and also handle the
-        * degenerated case of a  device with queue_depth=1, where we
-        * would need to signal every message.
+       /* We want to signal completion at least every queue depth/2.
+        * This returns the largest power of two that is not above half
+        * of (queue size + 1) to optimize (avoid divisions).
         */
-       sig_limit = max(queue->queue_size / 2, 1);
-       return (++queue->sig_count % sig_limit) == 0;
+       limit = 1 << ilog2((queue->queue_size + 1) / 2);
+
+       /* Signal if sig_count is a multiple of limit */
+       return (atomic_inc_return(&queue->sig_count) & (limit - 1)) == 0;
 }
 
 static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
-- 
