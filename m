Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE46C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 07:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bkZ+oTSXTZDY84lJmh+NUQelyukHuT6Jz7jbXrpA0M=; b=L8YfSg6sgITVWJ8JrQJed+uc3b
	m16lwIZTnJh7Rp3S9+KL2P6qwXufL93cAgydFpAfGBktwITZu+wBPH7GMhw4RntUH/vOu/7c0zleS
	MwC6OFET0h0mFkGpuHG1kGBoBS9V4YUcIZ4WePpKgONLBbO3jCBb/Joo1hX2vhXCfyBQ3pyBqhBxw
	deE/4lAEGjIupET0e3H50KP2uRfZ7LX3+XhIkaYuqAQPKbpPE8JSw0+6+NV50KiZFCLd4153zMiqN
	iVqSihpi6qb4oafTQ1D4cg9/NOaY1Bh+upxOCS/7wyHDV/KkB31aEPrN0oiYfo1aMrNoA4O5FENNE
	W2cDdCsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrxj1-003v8W-CS; Tue, 30 Nov 2021 07:38:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrxil-003v3k-UI
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 07:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638257915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bkZ+oTSXTZDY84lJmh+NUQelyukHuT6Jz7jbXrpA0M=;
 b=Iwa2H7k14Jl8/qYg3oyMBL97dEkd8CWLEnSoNPq56sLklSIo7IbZEw/OOA6f5MTBi9XlH4
 CvTm74t2jCo4OUn/Q4tN8Jp1KjK3/oPL0r63zN2vYuQgsNrpwUq7Ln5mB4Dsy/FlLNRPAj
 Y1mc1BilfhyfPRudmtdTcexUnK79Nmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-xiKcwCS7O-OLh_irlKFMeg-1; Tue, 30 Nov 2021 02:38:30 -0500
X-MC-Unique: xiKcwCS7O-OLh_irlKFMeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C51291006AA7;
 Tue, 30 Nov 2021 07:38:28 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 431A719724;
 Tue, 30 Nov 2021 07:38:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/5] blk-mq: add helper of blk_mq_shared_quiesce_wait()
Date: Tue, 30 Nov 2021 15:37:50 +0800
Message-Id: <20211130073752.3005936-4-ming.lei@redhat.com>
In-Reply-To: <20211130073752.3005936-1-ming.lei@redhat.com>
References: <20211130073752.3005936-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_233836_098857_3332076C 
X-CRM114-Status: GOOD (  13.86  )
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

Add helper of blk_mq_shared_quiesce_wait() for supporting to quiesce
queues in parallel, then we can just wait once if global quiesce wait
is allowed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 42fe97adb807..6f3ccd604d72 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -788,6 +788,19 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 	return true;
 }
 
+/*
+ * If the queue has allocated & used srcu to quiesce queue, quiesce wait is
+ * done via the synchronize_srcu(q->rcu), otherwise it can be done via
+ * shared synchronize_rcu() from other request queues in same host wide.
+ *
+ * This helper can help us to support quiescing queue in parallel, so just
+ * one quiesce wait is enough if shared quiesce wait is allowed.
+ */
+static inline bool blk_mq_shared_quiesce_wait(struct request_queue *q)
+{
+	return !blk_queue_has_srcu(q);
+}
+
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
-- 
2.31.1


