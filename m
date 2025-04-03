Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAE9C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=neWkQ4srv4tyXvC72EHnmHVV9lKC1QmawYKKp1n5DMc=; b=aAOyThYehcoxuUU5JxHs1HRk7E
	+sVWi2s21BnIvpCt/5AWN3IL3Jl8y8QwPRhGf+t7kDBw8U8RNKhc9I1uIX88UqY+2QIXLAd0NIHe6
	dCDKXEvl0HMhSPBoDlrwOe6rOluUZa/j4qVHkKTRO5IG9WBKDzy8ctGF56Vgzoiysg3rXrw+B0j8G
	4gtquK34NYFCUZ755Mk5E2uQgDDvpG8rxSCZGKSXsk1tAjwXrYyvZMmOAOUVFQGLRRQf86xEHP0G1
	W7M+lHEt9ZHiX2eS7tr+5N6AeAoQoBWNbdzvQ4DgSGR4vuwy196Rq5HkEg0XUHxg1fybjYndNo0wJ
	4YzRVq3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Ea3-000000080wS-2yHd;
	Thu, 03 Apr 2025 07:01:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EUF-00000007zby-1CaF
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 06:55:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CE40744069;
	Thu,  3 Apr 2025 06:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016B6C4CEEA;
	Thu,  3 Apr 2025 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743663338;
	bh=A2/ip4AK6r5qsD1yjuv1QMKjMQGVpDYoi5zcELmMLHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad2lPZA+UczpFQ0CCfarumeR6IqOsDaAGZMS1KfWCJlIX6fbySVTPScX6XTuNatt3
	 mdhR1w7mXVfAcuA94AqwnC6aY+oYVrNXnUycngBcR9yUTjOJH7aRm9fS3dG/AewZoa
	 RJem/DXKMTNiHX3QeDdo+AH5ayXsEAoDkoVFWnaWPqYhMNCgW2ciXAR0ZrhyQA7wYS
	 lzCA3tuTEggxyrY+rHtTnjpS2uqrVwVmWbwXcCGgR6szi03TVmKJcsedczcLi2sMqo
	 tGtCV559u2WALwyApYmd8bN+GM+Me/7zJqYx/bNxoZXzF7fLknmkknzgzdY5tN1UJC
	 IJo3f4Y0Jvz2Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/3] nvme-tcp: open-code nvme_tcp_queue_request() for R2T
Date: Thu,  3 Apr 2025 08:55:20 +0200
Message-Id: <20250403065522.90807-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403065522.90807-1-hare@kernel.org>
References: <20250403065522.90807-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_235539_375436_A12EBB0A 
X-CRM114-Status: GOOD (  13.23  )
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

When handling an R2T PDU we short-circuit nvme_tcp_queue_request()
as we should not attempt to send consecutive PDUs. So open-code
nvme_tcp_queue_request() for R2T and drop the last argument.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327f3f2f5399..b2f2aef2e2f2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -404,7 +404,7 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 }
 
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
-		bool sync, bool last)
+		bool last)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	bool empty;
@@ -418,7 +418,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * are on the same cpu, so we don't introduce contention.
 	 */
 	if (queue->io_cpu == raw_smp_processor_id() &&
-	    sync && empty && mutex_trylock(&queue->send_mutex)) {
+	    empty && mutex_trylock(&queue->send_mutex)) {
 		nvme_tcp_send_all(queue);
 		mutex_unlock(&queue->send_mutex);
 	}
@@ -771,7 +771,9 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	req->ttag = pdu->ttag;
 
 	nvme_tcp_setup_h2c_data_pdu(req);
-	nvme_tcp_queue_request(req, false, true);
+
+	llist_add(&req->lentry, &queue->req_list);
+	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 
 	return 0;
 }
@@ -2557,7 +2559,7 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
 
-	nvme_tcp_queue_request(&ctrl->async_req, true, true);
+	nvme_tcp_queue_request(&ctrl->async_req, true);
 }
 
 static void nvme_tcp_complete_timed_out(struct request *rq)
@@ -2709,7 +2711,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
-	nvme_tcp_queue_request(req, true, bd->last);
+	nvme_tcp_queue_request(req, bd->last);
 
 	return BLK_STS_OK;
 }
-- 
2.35.3


