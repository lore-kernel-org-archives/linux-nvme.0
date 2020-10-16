Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CEC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:29:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88B320866
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TOn6cQeN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5ksV1xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88B320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fnCPy3sA3S43+Xh00Lu5cF6WvLEab0NpDymW3H2rwuo=; b=TOn6cQeND2+OH8L4vBGfhLNY9
	U12PLoYhKOaTLJg7JjhuYUx+o3JC7vfP5hiY8+JRdm8HeSdRyHpnZTOx71dscxseUBXD+VfJ36LSy
	ObkFBNiQ5M+4QvrsGlwyewLb5/XW9DyX4ZADMoPUNKkVLqq1kmDrLJywGnXIM2ZjOg7T0q3sBVK3o
	9LOJxBteExFk6v3N1JEwRrYLvpjaLhoE9p6aLjCc4OggSuwjaXvmgLnI2NYG8hCt6CCeYnKVzfH+5
	uW1C6sRl9rnTO4j/IsI+gDkqRAEpGnJb649vOWKnLZIOz/f4MEq9WkK7jgp1sWrv6AqXBA4RECS2/
	85P6+AY8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQj8-0006iR-93; Fri, 16 Oct 2020 14:29:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQj6-0006hS-BO
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 14:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602858539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dCETTUY0srMfYpMQV60y38uEv/90/o462XzHM99kUk=;
 b=Y5ksV1xhOF/ftQ8p0LCyppzd9DaXq0IVyzbVIWg4OcRL2Yjjrd92j0v0+xBl3s/0IK3Pkb
 csTawUCyuuTDiDfeuFplDgp7dpnRsE4ZxSAujOMH47gCwn2y1ZCCnPz1m4jF/Wa3fqZ7e3
 N8+iryRdkNEBq5OElSLhTWpvMvInq1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-uqwPH2clO-mYbcEszgjLkg-1; Fri, 16 Oct 2020 10:28:56 -0400
X-MC-Unique: uqwPH2clO-mYbcEszgjLkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 917F586ABD1;
 Fri, 16 Oct 2020 14:28:54 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 038AA5C1BD;
 Fri, 16 Oct 2020 14:28:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] nvme: tcp: complete non-IO requests atomically
Date: Fri, 16 Oct 2020 22:28:11 +0800
Message-Id: <20201016142811.1262214-5-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_102900_446433_8A50A49F 
X-CRM114-Status: GOOD (  16.39  )
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
are submitted for recovery, and we allow to abort this request directly
in time out handler for not blocking the setup step.

So timout vs. normal completion race may be triggered on these requests.

Add atomic completion for requests from connect/fabric/admin queue for
avoiding the race.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 56ac61a90c1b..654061abdc5a 100644
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
 
@@ -2173,7 +2206,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
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
