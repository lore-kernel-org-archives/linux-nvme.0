Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F86C19F32
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKCIMHlK8qqqcwS0fj+kePZBCTxd5H18Zqo6got0KCw=; b=nMZPrMX6mkDSBrvH+N+a2nndm8
	FJkSiJ9wCTYHTVDZZCbSp+1hAekqDSxSGnAf14PrwkndKTJGPkILoZ8AfgkTy81KORbf/lEFj++rA
	USlOwoBGTOXP/LBdBX7r1Zz+1iSxkQUGXVo7WAGPAcYiwZEZNBq/NkxhWPAA08/SnfAGcSX4aHfym
	YA6Fexm4Q+iMCIvn8fkWuJuoSUBarScSZWClnqZtFFJIPt9QWx0IBBJzBC6BiB2t0gYLTV3A712VS
	WFKeha4v4iAo7ZFQ95Jj5VEMjjF8u2UiV3u7UI51YEX2QbDZms+rslIw9NezxzqyfTaRi4AwknYf/
	9lSpbD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXle-0000000EKdH-32CZ;
	Fri, 07 Mar 2025 13:29:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXkM-0000000EKPb-2K55
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 13:28:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 144B25C5759;
	Fri,  7 Mar 2025 13:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC08C4CED1;
	Fri,  7 Mar 2025 13:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354093;
	bh=N4IGIUzFRSW8+r7dg4QlX/INjV84lJaP+wOsjXAFwss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJKbLVRmi81Wwc+B/esbWgZV542OTaGyPAuf5Bp/zx62tt+AM9F1odAZ7t6F4Lpih
	 RU6ANwzUxago5p/V6jf49J/dIj8qM8yUAyG7TIhreEXE1YwUmyN9/tdrK+QUkIljQG
	 OM/rKF00nWvvQdoNmxYGXoShSgWGESPmYF+4OMUBgl4rQ0YwnOiaIOuPwq+pXpGi7/
	 Y7p0cJdpmy6W5/SaSc0KZ/GND6ZPcLnYbRlSydlw5PCMl2zYyYJ+5zU7L4O0tLtVGf
	 JkOHWrno9IA1tV9KOK8WsqJ4qkmfJHB7Q5sKKTI1cgzybMN8hrYfJbqTAqlSMcXNYJ
	 LNO6tkWsrFvyA==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-tcp: avoid inline sending when handling R2T PDUs
Date: Fri,  7 Mar 2025 14:28:00 +0100
Message-Id: <20250307132802.111513-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250307132802.111513-1-hare@kernel.org>
References: <20250307132802.111513-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_052814_634925_CC3902B8 
X-CRM114-Status: GOOD (  14.35  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When handling an R2T PDU we should not attempt to send consecutive
PDUs as we are running from an softirq context, and sending PDUs
from the receive context will mess up latencies.
So just queue it and let the io_work workqueue function do the work.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8c14018201db..034edf852878 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -391,7 +391,7 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 }
 
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
-		bool sync, bool last)
+		bool last)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	bool empty;
@@ -405,7 +405,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * are on the same cpu, so we don't introduce contention.
 	 */
 	if (queue->io_cpu == raw_smp_processor_id() &&
-	    sync && empty && mutex_trylock(&queue->send_mutex)) {
+	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
 		mutex_unlock(&queue->send_mutex);
 	}
@@ -758,7 +758,9 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	req->ttag = pdu->ttag;
 
 	nvme_tcp_setup_h2c_data_pdu(req);
-	nvme_tcp_queue_request(req, false, true);
+
+	llist_add(&req->lentry, &queue->req_list);
+	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 
 	return 0;
 }
@@ -2531,7 +2533,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
 
-	nvme_tcp_queue_request(&ctrl->async_req, true, true);
+	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
 
 static void nvme_tcp_complete_timed_out(struct request *rq)
@@ -2683,7 +2685,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
-	nvme_tcp_queue_request(req, true, bd->last);
+	nvme_tcp_queue_request(req, bd->last);
 
 	return BLK_STS_OK;
 }
-- 
2.35.3


