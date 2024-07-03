Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8007C31D97
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6Vc3CSteySsiwEtHO02XrcKcPUlj0El/e/MX1AQ8h0=; b=O4M+Cy69gAuqSSg3kKh/FBCb4R
	Rp0LxMw6PZqTSARvJRj+bc1MVJJHVZrKzUT94nxb0JqOQ1scab4rZCqfWkPapI1wLWY/86DUYFsV9
	4JhMGLC0zcx56R0ZW+mMS17SslR0sS1h2Ar7pNGV3w8q8Cn2//0vBE9DWWdn1AEAR/ICMiDryHG0b
	Mw8FwND0ESTzpdT0i5zHAGVLQuQT0qBr0FGy0zvHW2YnVYuL2ljCQKZmTUs0+cCmQ1dVmf6uOeqnY
	hVTDyR9eVRRRCDNML3KxTFyiEVNLMgHqwmDYrjPTb28tHZtEQlKZgL3XDzzohDODQ240/qGBW6ino
	qWD2tkuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NY-0000000AM4v-1JYl;
	Wed, 03 Jul 2024 13:50:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0NU-0000000AM2l-3Cex
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 13:50:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 14A2C62235;
	Wed,  3 Jul 2024 13:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C2DC3277B;
	Wed,  3 Jul 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720014631;
	bh=krnQv7iHsKIKObzdfFwVE47BT6gEFu1o5Mm8kyKPYE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNtFDVl2bqWV0U4VIaqxvWP/ptuUn30lh+HctraxzVqTmi6E/KCPjRp0UE3gfXnyA
	 bNgYsGPeLMRrXfaNN0JergwIzOrhw5mWtmutWD6lMcsRf/jEKuTmaRLUR8vuD7iRnl
	 pNL2q1jqXf4I838xxFneJh8ePK2Xmbu8oNV9M5Froa3upxEunVJTdtLAJIbCUEfhRl
	 5mOuL1o9Xe3QtpCTKxIlO77PNKNvNqGvc+YOhpYcy/jqnFwj+G2ZcRKkGEOshNnO87
	 PNsLRFA7gSRjMDKqQ7XuIc6aN970N80XzbCVaAKLUe9uvH4h3Qd71B9C5OvxNXYemZ
	 udAZKirhwjyHg==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Wed,  3 Jul 2024 15:50:19 +0200
Message-Id: <20240703135021.34143-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240703135021.34143-1-hare@kernel.org>
References: <20240703135021.34143-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_065033_059362_C16D32ED 
X-CRM114-Status: GOOD (  16.32  )
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

When 'wq_unbound' is selected we should select the
the first CPU from a given blk-mq hctx mapping to queue
the tcp workqueue item. With this we can instruct the
workqueue code to keep the I/O affinity and avoid
a performance penalty.

One should switch to 'cpu' workqueue affinity to
get full advantage of this by issuing:

echo cpu > /sys/devices/virtual/workqueue/nvme_tcp_wq_*/affinity_scope

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 44 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d43099c562fc..df184004a514 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1559,19 +1559,36 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map = NULL;;
 	int n = 0;
 
-	if (nvme_tcp_default_queue(queue))
-		n = qid - 1;
-	else if (nvme_tcp_read_queue(queue))
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
-	else if (nvme_tcp_poll_queue(queue))
+	if (nvme_tcp_default_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
+		n = qid;
+	} else if (nvme_tcp_read_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_READ].mq_map;
+		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else if (nvme_tcp_poll_queue(queue)) {
+		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
 		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ] - 1;
-	if (wq_unbound)
-		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
+				ctrl->io_queues[HCTX_TYPE_READ];
+	}
+	if (wq_unbound) {
+		int cpu;
+
+		if (WARN_ON(!mq_map))
+			return;
+		for_each_online_cpu(cpu) {
+			if (mq_map[cpu] == qid) {
+				queue->io_cpu = cpu;
+				break;
+			}
+		}
+		dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+			qid, queue->io_cpu);
+	} else
 		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
@@ -1716,7 +1733,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1872,9 +1889,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	nvme_tcp_init_recv_ctx(queue);
 	nvme_tcp_setup_sock_ops(queue);
 
-	if (idx)
+	if (idx) {
+		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
+	} else
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
-- 
2.35.3


