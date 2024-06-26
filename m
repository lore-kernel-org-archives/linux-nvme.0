Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C97C3065A
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hs8BV1M3eJ5kZEJsjS1exr3Owg+Pq+Y4uL8PXx44RJs=; b=4A3Xy3+UrtySU/ZKiDQzbo9BHp
	6uL0xh/i8z9QaFiP4sTegszzQ6Ui2vRqxwN9omhUl6OUgeHKnXoBUZ4otmp+a0dwn0kvHKo4K/KmT
	sgJDfMlHcmrerwpWiRRgj0cqaxKblzokdc9grhyfumvNU+ngPNgy7qqO7av3xyhhzUUJl1zqlN7kk
	+t3NSCgtlT/s00vrjckpVTVcsTfmZ+HHeUhpVtS1zYJb6Sj5y/O5n1kU/Iqrd2VpFpKEg+sgSTt8E
	4xHqInBvvynsVKsjowY/k4Grq0pTEzf2fzYQS/6k1036NMbmBlKeHFf27z2b/vGhxf68os2I/+nVE
	9OV1VqGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXK-00000006hVj-33Md;
	Wed, 26 Jun 2024 12:14:06 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMRXE-00000006hTL-2bim
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 12:14:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id BC857CE21AE;
	Wed, 26 Jun 2024 12:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD7C4AF0A;
	Wed, 26 Jun 2024 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404038;
	bh=+skw9G/KjLX4auat/W7Oy3MrzR0sV21Ck0Ud/lsZyrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LxgvDSt9WxHU3K4vBoZIxY4yiV206zeMf2kIQoDbKH/aNpaespvRtrDylsOEVBq5o
	 ndMLvEkspnDghVuP6nY3xa07Pp9qc59YdTfazeaNTfKeveVek6ipQGGnZOzewaEH6E
	 5HYaY//zlUt0skZgwHfILCQhtuwHC8sB8GUBSZPh6S/38cp8ts3zEHHONVPu/5fD5U
	 rDTb9tv6NpDQ5KgjBMXue7jls3u4DZsHaex5KVOnR+Wmw8z+VIGXK46h3S6SZmUeFJ
	 sKDK22TgyCYRmdidlTnhUoHWFHryc9JEQIZ5Fj5UgZUNNgkWxN0ATG165S42SdxfBG
	 f3bV2z1Tp/yRw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/7] nvme-tcp: distribute queue affinity
Date: Wed, 26 Jun 2024 14:13:42 +0200
Message-Id: <20240626121347.1116-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240626121347.1116-1-hare@kernel.org>
References: <20240626121347.1116-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_051401_235678_C9005CE5 
X-CRM114-Status: GOOD (  15.98  )
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

Introduce a per-cpu counter to distribute the number of queues
over all cpus in a blk-mq hwctx cpu set. The current algorithm
leads to identical cpu affinity maps for all controllers, piling
work on the same cpu for all queues with the same qid.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 78fbce13a9e6..faab55ff86fe 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -26,6 +26,8 @@
 
 struct nvme_tcp_queue;
 
+static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
+
 /* Define the socket priority to use for connections were it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
@@ -1569,16 +1571,26 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	if (wq_unbound)
 		queue->io_cpu = WORK_CPU_UNBOUND;
 	else {
-		int i;
+		int i, min_queues = WORK_CPU_UNBOUND, io_cpu = WORK_CPU_UNBOUND;
 
 		if (WARN_ON(!mq_map))
 			return;
-		for_each_cpu(i, cpu_online_mask) {
-			if (mq_map[i] == qid) {
-				queue->io_cpu = i;
-				break;
+		for_each_online_cpu(i) {
+			int num_queues;
+
+			if (mq_map[i] != qid)
+				continue;
+
+			num_queues = atomic_read(&nvme_tcp_cpu_queues[i]);
+			if (num_queues < min_queues) {
+				min_queues = num_queues;
+				io_cpu = i;
 			}
 		}
+		if (io_cpu != WORK_CPU_UNBOUND) {
+			queue->io_cpu = io_cpu;
+			atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
+		}
 		dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
 			qid, queue->io_cpu);
 	}
@@ -1834,6 +1846,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (queue->io_cpu != WORK_CPU_UNBOUND) {
+		atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
+		queue->io_cpu = WORK_CPU_UNBOUND;
+	}
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -2845,7 +2861,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 
 static int __init nvme_tcp_init_module(void)
 {
-	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
+	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS, i;
 
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
 	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
@@ -2863,6 +2879,9 @@ static int __init nvme_tcp_init_module(void)
 	if (!nvme_tcp_wq)
 		return -ENOMEM;
 
+	for_each_possible_cpu(i)
+		atomic_set(&nvme_tcp_cpu_queues[i], 0);
+
 	nvmf_register_transport(&nvme_tcp_transport);
 	return 0;
 }
-- 
2.35.3


