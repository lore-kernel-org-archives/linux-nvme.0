Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827B0C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1YGi7obqCTeFF/TVHvub4h7kcJ86QPI0Z9v9plTOlOQ=; b=SzXM8T7Kh7TTe+X3RTZdihutta
	1Dcrw+IS78OMwP6i6AJatp0ZCgzF6dzZ8rr5+pnpT2lvB+RQmaAWBDScyvEfqbw0Fz+Uy2bX4rrvc
	BdfNn3lJwtE+s1A8GgZgE49O0JibRivPLe4OEGOcIZM0U/KparDYnRK7sAg7l7BGI9EQoWeIpwHDL
	fCo33ljp80SmEk8nzNaHg+hdryVEArH3idjrh9LHwUyrexvGZ8+qEU6GZp4EDi0hKV4ZKem4458G0
	BgnnjbK1GhGJHiyHpxNUqaAVjReV+/5tPJiY7tZF+Zc8wADcHo2xCq2XKEh/kU13NEYpdIbQFcFPJ
	p64zUxSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwjF-00000001gba-26kq;
	Wed, 19 Jun 2024 14:56:05 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwjC-00000001gZr-1gFM
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 14:56:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CFA7E61E5A;
	Wed, 19 Jun 2024 14:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D037C2BBFC;
	Wed, 19 Jun 2024 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718808960;
	bh=XWysN8Vmx4wGRGt0Lzcbhlx7O6gyjRRc/kV9jGi9LuM=;
	h=From:To:Cc:Subject:Date:From;
	b=n/K3ibMSmqfGpb88yy+HJWsKNRK1kyXLgu31Jo4n8pgMyo/q5Az2yGx8AB1ILIQ6C
	 y+J3pLbBTdLIoTVuHakgMRKOHJ3LE25Ex7hG09vOCWCtQ5cvV0/1trAAhWIvHkmnZM
	 xEjz+qjADIkCftLQQGxzYeigkEZvNZkXF9fN9+ujhCdSRbmnyP6CG6s7QeD3aDT9HG
	 fVr0hfE6cYUY6aGa+WJLZ1v2LoKuwrIVPhCm7rFRZqtAhNqzFg2/eAePQPkf/oPM96
	 7a2zV9KXGe7cD/O/s3whAQ/RyXJW5Ar/dzT3XhiL8I9l6azDR9dwbPpac+Rb8Ktp24
	 svsULoa38GVZg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Date: Wed, 19 Jun 2024 16:55:53 +0200
Message-Id: <20240619145553.89736-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_075602_601506_F17B19D1 
X-CRM114-Status: GOOD (  13.59  )
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
On an AMD EPYC system the performance increases from

Seq 4k write: 13.8 MB/s
Random 4k write: 11.3 MB/s
Seq 4k read: 13.9 MB/s
Random 4k read: 10.9 MB/s

to

Seq 4k write: 19.1 MB/s
Randowm 4k write: 18.1 MB/s
Seq 4k read: 15.8 MB/s
Random 4k read: 15.8 MB/s

Signed-off-by: Hannes Reinecke <hare@suse.de>
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


