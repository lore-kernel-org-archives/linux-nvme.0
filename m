Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1AC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJu76l8pjaIVYpz/yVfukBdOGJkOy12i1CmZ5cF+YHs=; b=jj73SiSJvj+KlB6PFGVbAMRnCv
	vdp6pEOXHMLVCovH7Mhi27nC4RNdLwCy7DELPs/E+la1/8RXqQ9CNHdijFe3dmJde1jSpgSTDaDbx
	s4mdE4X1igbXDUYYGAXEhlaglwIGOdFanDhjCIoZSZu2tK6aiUf124IX04tRM1CqI7UqqfmsDCXyr
	VN3gVFowFQ3LVUAnz4Cd68bhYueLYdA3gadGU7Xe2/jTVGmygSm11TTWZ1tQYbKU7kFLcfFXx251l
	Ja+nRlS5vuGFe5A3djfcg96LwK5cqVVLX5za/vLgsNWYOXd0/rFnrUJDztQjSzWpFVHZtX4b1yuGv
	Z79Ekm0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXJ-00000006hVI-2l0t;
	Wed, 26 Jun 2024 12:14:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXB-00000006hSt-0x4r
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A826760AB1;
	Wed, 26 Jun 2024 12:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1308FC4AF07;
	Wed, 26 Jun 2024 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404036;
	bh=COd+F5hVjm8Tt41n+tSyjOICwX7hLfUQtRQ5wuPNbzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sm4oXGYnujScN+kGj5bRVocJg+AJqH8ri5W8NZKU4gh042l6nPsHTdfjUTpn1QkTj
	 iNZxyrI6brNVq9q379GfiCY1JU0+7/6uNN8CeWdnlPG9CZdPmGmvN1eHM1Sfu07PMy
	 HswjbWbWulDizkXG4VEs+Nt/zjie1UQ4vvRoPUHl7crpVya1zcWqoukBePkR/50mAT
	 icYBOcTkZv/auyZX6Rbk0Zoj4JMqXzh7C3NqWjjYf9jxqFBo9zY8jnK2zexNdScljm
	 DgOf+DTJza3u5OJf059wxjobLQjPYEuagmbGoUq9jlAOp2yFM8c8QGg0FBPHZRR4P1
	 d8133Nbi3McyQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/7] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Wed, 26 Jun 2024 14:13:41 +0200
Message-Id: <20240626121347.1116-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051358_537042_BF90A537 
X-CRM114-Status: GOOD (  13.43  )
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

Select the first CPU from a given blk-mq hctx mapping
to queue the tcp workqueue item.
This avoids thread bouncing during I/O on machines with
an uneven cpu topology.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 43 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3be67c98c906..78fbce13a9e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1550,20 +1550,38 @@ static bool nvme_tcp_poll_queue(struct nvme_tcp_queue *queue)
 static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
-	int qid = nvme_tcp_queue_id(queue);
+	struct blk_mq_tag_set *set = &ctrl->tag_set;
+	int qid = nvme_tcp_queue_id(queue) - 1;
+	unsigned int *mq_map;
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
+				ctrl->io_queues[HCTX_TYPE_READ];
+	}
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
-	else
-		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
+	else {
+		int i;
+
+		if (WARN_ON(!mq_map))
+			return;
+		for_each_cpu(i, cpu_online_mask) {
+			if (mq_map[i] == qid) {
+				queue->io_cpu = i;
+				break;
+			}
+		}
+		dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
+			qid, queue->io_cpu);
+	}
 }
 
 static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
@@ -1704,7 +1722,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
 	queue->sock->sk->sk_use_task_frag = false;
-	nvme_tcp_set_queue_io_cpu(queue);
+	queue->io_cpu = WORK_CPU_UNBOUND;
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1858,9 +1876,10 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
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


