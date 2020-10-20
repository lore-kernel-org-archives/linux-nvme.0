Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6796C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2517E20936
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k6hTiCW0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1bgfJkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2517E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qHUaPSCNRXEwG062ooRRN7rSroqEymOLwgtTYb1XjMA=; b=k6hTiCW0YdB5cAvzG8mY3yWtt
	dXa2kBbsjHYcOsdQG2fQmAds/1D2xLmuegYt7fmf24FccAMTXOTWXrA4TRa4rKZ9FpP0KUqqdxQ/W
	TeYUbwoxjoPMc3FAmml4RtNAVS2AXU3zTy1tV22SaKIE0ijNAQrXefc7lb0cPs2k/c7rWuoeGYIz8
	wuV3v3IgBmywJzce9DfVeP1u+4RFFp7Lfe2/pi7mFlHmNGJEfoc6xLvqDNYl0CIAHKiJqkaZrKRWv
	KEnx1dTkrJsh/QhBGRYEyOEymFZ9nhjN1v0FA+1x4rSg8uqs2/hfTvHdMdxkJg58nv7xpdeyy8pGX
	8S5RnpMVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUnOv-00036I-1v; Tue, 20 Oct 2020 08:53:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUnOs-000352-Fh
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:53:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E1oYg59Y7b7fc16uKEqEGgDAvrf1UoV+NOdPA4wpeoQ=;
 b=S1bgfJkFWWzP3N2L22lkpCojTwsr7TYqe7YVcyW7JQje1J9B93aGMGqdT56FDmcG2S4Kyi
 cZmohQQ5gQ+etqAqgCKBBFu9yu5W2DPXJpr8wKZhutrzBjrE6L08Z3SkvJW4qWkO+lVP1U
 5D4GbaYX8VD6tPtWwgRVqNE5TM0KFHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-abpMBjSpN5C-XmftuRec_Q-1; Tue, 20 Oct 2020 04:53:44 -0400
X-MC-Unique: abpMBjSpN5C-XmftuRec_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE15835B49;
 Tue, 20 Oct 2020 08:53:42 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B7735B4AD;
 Tue, 20 Oct 2020 08:53:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2 3/4] nvme: tcp: complete non-IO requests atomically
Date: Tue, 20 Oct 2020 16:53:00 +0800
Message-Id: <20201020085301.1553959-4-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_045346_576572_1E2E1307 
X-CRM114-Status: GOOD (  16.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

During controller's CONNECTING state, admin/fabric/connect requests
are submitted for recovery controller, and we allow to abort this request
directly in time out handler for not blocking setup procedure.

So timout vs. normal completion race exists on these requests since
admin/fabirc/connect queues won't be shutdown before handling timeout
during CONNECTING state.

Add atomic completion for requests from connect/fabric/admin queue for
avoiding the race.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..7e85bd4a8d1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -30,6 +30,8 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
 
+#define REQ_STATE_COMPLETE     0
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -56,6 +58,8 @@ struct nvme_tcp_request {
 	size_t			offset;
 	size_t			data_sent;
 	enum nvme_tcp_send_state state;
+
+	unsigned long		comp_state;
 };
 
 enum nvme_tcp_queue_flags {
@@ -469,6 +473,33 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+/*
+ * requests originated from admin, fabrics and connect_q have to be
+ * completed atomically because we don't cover the race between timeout
+ * and normal completion for these queues.
+ */
+static inline bool nvme_tcp_need_atomic_complete(struct request *rq)
+{
+	return !rq->rq_disk;
+}
+
+static inline void nvme_tcp_clear_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		clear_bit(REQ_STATE_COMPLETE, &req->comp_state);
+}
+
+static inline bool nvme_tcp_mark_rq_complete(struct request *rq)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	if (unlikely(nvme_tcp_need_atomic_complete(rq)))
+		return !test_and_set_bit(REQ_STATE_COMPLETE, &req->comp_state);
+	return true;
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -483,7 +514,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -674,7 +706,8 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 {
 	union nvme_result res = {};
 
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
+	if (nvme_tcp_mark_rq_complete(rq) &&
+			!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
 		nvme_complete_rq(rq);
 }
 
@@ -2174,7 +2207,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	/* fence other contexts that may complete the command */
 	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
-	if (!blk_mq_request_completed(rq)) {
+	if (nvme_tcp_mark_rq_complete(rq) && !blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
 		blk_mq_complete_request(rq);
 	}
@@ -2315,6 +2348,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
+	nvme_tcp_clear_rq_complete(rq);
 	blk_mq_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
