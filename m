Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF23C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ANBuJOAuJ4xyq0t9E62lx/bCk7c5ecjZzm5EY4wzvNo=; b=RCJKqKanth6DKKtwMIGKQ04vXW
	z8jtVNwrj+f+xVOovgvLLyphWMpwarUHm7QPdWwmgBak2KOODn5sCNb2l7ybYjNS9Atpwo0y3gPU4
	owHhQaGh8GzFuOlP7CV000bXu8yLeCKSOgyfjMJgH6W4wowTtlk8OWi/M/+MTuvCu1Pdenr7YmXBM
	ys/ZYxC5700SJ4MyWVOC4vzC2R+2ggTnRFLprrpG4eDIivBtk5GhoNlbM9YDhMZ2ES6m84p/o8yHz
	6bVLOYK6laYO6XQda/YCQRwCKv7zCI/wNf9roS+ZKFwH2zwDpKcop4b31uBEwzFvthStwsymdS5kN
	fnOoyGSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOqq-00000001lTm-3x0B;
	Thu, 18 Apr 2024 10:18:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOqn-00000001lSn-1hKw
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 10:18:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8059FCE17D5;
	Thu, 18 Apr 2024 10:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD22C113CC;
	Thu, 18 Apr 2024 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713435518;
	bh=uU/MlramjCA5a/Zjvga+bjPcrBi6aVtLcv7SkR8YOig=;
	h=From:To:Cc:Subject:Date:From;
	b=aIl6ydq4NYVtoA4QnRtT6DZD5WF2vGiDGHvIstuLO1AOIC2l9/GQvuILZJFoeYbpP
	 HxLdYdAPNejUrFfakn5p/SIf+ssPvFCFtMWlyArp93CucIrhIfZxd4zyn26ztJ8rWh
	 3CLbHWPcd07Rj4MHVoofGk6+90fg3ohdonNKAmZV12mSjNfhBFDtE925LkwGJqhml0
	 COOilNlKW+VUURi1KjJaGUhc2S/oEMBzJ9EsdwmWR8VW5ra3zX/KPgJ8i5ddHRB/Ea
	 4EaelECYSiZNWrBO3HhIt9yqi4H9Dyo+ON5YV2s60J0uXFtIDr83yeGKkKy+YZBAio
	 ra7MrAvOvqQ7g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2] nvme-tcp: strict pdu pacing to avoid send stalls on TLS
Date: Thu, 18 Apr 2024 12:18:31 +0200
Message-Id: <20240418101831.41954-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_031841_686297_B564AE9C 
X-CRM114-Status: GOOD (  13.03  )
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

TLS requires a strict pdu pacing via MSG_EOR to signal the end
of a record and subsequent encryption. If we do not set MSG_EOR
at the end of a sequence the record won't be closed, encryption
doesn't start, and we end up with a send stall as the message
will never be passed on to the TCP layer.
So do not check for the queue status when TLS is enabled but
rather make the MSG_MORE setting dependent on the current
request only.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b821cbbdf1f..aef1bb8d2f2b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -369,12 +369,17 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 	} while (ret > 0);
 }
 
-static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
 		!llist_empty(&queue->req_list);
 }
 
+static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
+{
+	return !nvme_tcp_tls_enabled(queue) && nvme_tcp_queue_has_pending(queue);
+}
+
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		bool sync, bool last)
 {
@@ -395,7 +400,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 		mutex_unlock(&queue->send_mutex);
 	}
 
-	if (last && nvme_tcp_queue_more(queue))
+	if (last && nvme_tcp_queue_has_pending(queue))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
-- 
2.35.3


