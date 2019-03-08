From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Fri, 8 Mar 2019 12:59:43 -0800
Subject: nvme-tcp: SUCCESS Flag in C2HData PDU
In-Reply-To: <cad669f2-028c-a4fe-0b9d-cd7ad479b6fb@oracle.com>
References: <005ac848-0c71-8852-ff60-7e91418f83cc@oracle.com>
 <5db9fdb7-bbbe-f805-94b6-fa5c2f31e9a8@grimberg.me>
 <cad669f2-028c-a4fe-0b9d-cd7ad479b6fb@oracle.com>
Message-ID: <5e7839a9-f3ba-31b5-29cf-cb9662e06991@cisco.com>

On 3/7/2019 5:06 PM, Sagi Grimberg wrote:
>> It is optional, the target may set the success flag. The host needs to
>> be able to support it though. So it should be fairly simple to add.

Sagi - is the following patch in the right direction? If it is,
I will write some controller code to test it and send an actual
patch email. I just wanted to get your feedback before continuing
down this path. Do we need to submit an actual CQE to the NVMe
layer, or does just the nvme_end_request suffice? My understanding
is the below patch handles both the case of data digest and not
data digest, but please let me know if I am missing something. So far
this patch is untested, but it does compile on the nvme-5.1 branch.


diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 208ee51..50de81c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -618,6 +618,41 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
         return ret;
  }

+/*
+ * if this is the last PDU and the SUCCESS flag is set,
+ * the controller won't send a Response Capsule. We need
+ * to synthesize a cqe with both the status field and
+ * and submit it to the NVMe layer.
+ *
+ * if this is not the last PDU and we receive the SUCCESS
+ * flag, we treat this as a fatal transport error.
+ */
+static int nvme_tcp_process_success_flag(struct nvme_tcp_queue *queue)
+{
+       struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
+       struct request *rq;
+       union nvme_result res = {};
+
+       rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+       if (!rq) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag %#x not found\n",
+                       nvme_tcp_queue_id(queue), pdu->command_id);
+               return -ENOENT;
+       }
+
+       if (!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST)) {
+               dev_err(queue->ctrl->ctrl.device,
+                       "queue %d tag 0x%x SUCCESS flag set but not last 
PDU\n",
+                       nvme_tcp_queue_id(queue), rq->tag);
+               return -EINVAL;
+       }
+
+       nvme_end_request(rq, cpu_to_le16(NVME_SC_SUCCESS), res);
+
+       return 0;
+}
+
  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct 
sk_buff *skb,
                               unsigned int *offset, size_t *len)
  {
@@ -685,7 +720,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
                         nvme_tcp_ddgst_final(queue->rcv_hash, 
&queue->exp_ddgst);
                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
                 } else {
-                       nvme_tcp_init_recv_ctx(queue);
+                       if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS)
+                               return nvme_tcp_process_success_flag(queue);
+
+                       nvme_tcp_init_recv_ctx(queue);
                 }
         }

@@ -695,6 +733,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue 
*queue, struct sk_buff *skb,
  static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
                 struct sk_buff *skb, unsigned int *offset, size_t *len)
  {
+       struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
         char *ddgst = (char *)&queue->recv_ddgst;
         size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
         off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
@@ -718,6 +757,10 @@ static int nvme_tcp_recv_ddgst(struct 
nvme_tcp_queue *queue,
                 return -EIO;
         }

+       if (!queue->data_remaining &&
+           pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS)
+               return nvme_tcp_process_success_flag(queue);
+
         nvme_tcp_init_recv_ctx(queue);
         return 0;
  }
