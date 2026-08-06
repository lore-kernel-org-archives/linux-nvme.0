Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0E1C55ABA
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 02:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rrnbZo5m/vorntLLsKb/28XiJcabwy2i4minOlLpbkA=; b=lSKf1/ofctKcC5rgn05cZyb0bP
	ZIrlL22FT0dYCjK8FjSGVSjJoAStqaHxfKRpy5izIXbcHy90i+XOl3+U0rdlk8m2DIRTAQUoKCo+g
	FFvcC0UQr9fLllb6e+rJ//ohHE3vuAch7Rd56ZGngm7RzgIpoR4Uzhhb99k+YMXIDAsXIO+lzkcTj
	tl3AvWHtqPk+5uFS3QHmNFuD9KzWxdPpiYNxwBm8ECR41qcjvvQKJ1UBW7Ku+bXcg73R7FBVhzKu9
	pd6QpbrShqmNApWCo+Yy2DYmp3bcZkqmCNOjmy3sbNUzIUt2mWucnhvk/l4AlodyOkKGQwBlJLv2+
	pljGeNAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro6y-00000004pn3-2x9d;
	Thu, 06 Aug 2026 02:45:36 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro6v-00000004plk-2zKH
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 02:45:34 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1722867a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2026 19:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1785984332; x=1786589132; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rrnbZo5m/vorntLLsKb/28XiJcabwy2i4minOlLpbkA=;
        b=I8Swfes8yWbkVi8FwFgcLRYqfNR7NDYiUQIsKyhGms2slkiwU0vyiV94RLv9l52Z16
         m6U3dGqWUGjY/8XOhq/6LgtYotfVwFJaKlxLoRGXpXFM5QqCqFhmI3c6Ai8j5FYwx3pm
         B5KlMjmC+ozbrwu+J7cwmaD0Z6GNUAKykF4lbbSITwqEDB7cSwzv1S82ceVU6oNdg5Fz
         zcHM+uamQvmeAE4zODWEWUq13vjFqlXFaVhzGFYdhelemhvukTXD1sNIuN1G8vZwHMWo
         wmtFJv6jeZvNVb09N2gqx+sCXutxCHyrivhPthDrhAImEXrCVD+Jz1kKEZ4I/VV3tEv9
         fLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785984332; x=1786589132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rrnbZo5m/vorntLLsKb/28XiJcabwy2i4minOlLpbkA=;
        b=ITZ0fGfp6bo000tPXI4p4DceIYFLFKvl6av9jG4yzRfP5h0BVgFA2Iw1+NML39H3Jb
         ye09B7RFBhpHnztBWhGoIorfKBPR1rpT5y7aSMyQ6CQojlRLpXeMEE4axZPd5hIgmXdc
         yOib6p5r1ftMLgwEfhqA+klvi1QNIo9OmnszWWWUGUYWolPQt4zuno3TURY313CnhKAQ
         PwZ1rV3CMsgmeFyLmtQnQIJ+HIOL1aWbx0R63iWLuEzLKpVLIrCwyqEaGW0NFZxWcrnA
         rHr7KC2x9EAvu6R5/RYR9PhccD/TqXc7hvGXseHQc5Upjwo5Q+QCrxbRtUwKkEyFmd+C
         bqbg==
X-Gm-Message-State: AOJu0Yx4YNJ0x2u2eP55airbQNEFGfGMQk4nTibWvuoj3MgovmyTZf44
	Zt6R+XvpQUcwscr3CKbgMQVRtz6tjG6BP4DijSc5+s4v9ytTUV5vPykHP3W4GUp5kCHnzb0JM4F
	PY5GLJkko/A==
X-Gm-Gg: AR+sD131CDV4zv6oQLCUJ8lXP4kULLYRNtRNd+CoYbAXbCUWUjzffNGUHYEyHjdF4Wa
	xGXa2Zxuuu9/ooM0ce6xAk/inqiPj2TUyxWRwVlmS5FVxqi0pam5+Y0BhkdynWZCy8brdiWlhBp
	KzHmG5nC6LGv7G2o+q3bL7AHHnF1FcTMuuqZ4uUqxyFRMuwIcZTLQ59KW2QvlEqKbqXOloAAVtm
	GDLUNjWfEPDg2u1YqqW1P/BsyTox0p1lX30snc14pHyPRX0kvCRSCbqHpRR0gWGIhIrQUM8iD8X
	JMEeo+14f1MAaZMjWd2weiqb+AATqsp47ZBPw0xzYSRSvPSM/sl31s5TySptOZOd8Kkxr0SuVOF
	JwaWX04lq8xsBIMiB0rV2pODNO/9D0yGQstQileTDo61oUaQNtKtlA2i/THjtf2UqlLRSIMj4q/
	6j3qE35XLo5gBE9JOJUw+tw23KpvEOfAY31dUHH5pxqbUYzf29ImAL75PQQg/YXdIZRzCdFSq4+
	CaNmvR8JCEFT1vV6WS0mIMIGI+S26SBhA==
X-Received: by 2002:a17:90b:5112:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3903c5919c4mr11891440a91.12.1785984332151;
        Wed, 05 Aug 2026 19:45:32 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315a8179ee5sm2122066eec.18.2026.08.05.19.45.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 19:45:31 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: Saravanan D <saravanand@crusoe.ai>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: pin io_cpu to submitter cpu
Date: Wed,  5 Aug 2026 19:39:44 -0700
Message-ID: <20260806023947.94680-2-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_194533_802108_22322800 
X-CRM114-Status: GOOD (  22.26  )
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

nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time,
before any I/O exists, as the least loaded CPU in the queue's blk-mq
map group, and all socket work then runs there for the connection's
lifetime. On hosts that partition CPUs between pinned workloads a map
group can straddle a partition boundary, so the pick can land one
workload's socket processing on CPUs owned by another. On a 384 cpu
multi tenant host with one VM driving ~1.1 GB/s of writes, 9% of
nvme_tcp_io_work executions ran outside the submitting VM's cpuset,
all on io_cpus of boundary straddling map groups, observed by the
neighbor as steal time it did not cause.

Adopt the submitting CPU of non passthrough requests as io_cpu. The
submitter is a member of the map group by construction, and the
nvme_tcp_cpu_queues accounting moves with each adoption. Passthrough
commands do not participate since the io queue Connect arrives from an
arbitrary group CPU via blk_mq_alloc_request_hctx(), so the first real
read or write decides.

Queues outlive the workloads that submit through them, so adoption
re-arms after 30 seconds of queue quiet. An idle queue is reclaimed by
its next submitter, while a busy queue keeps a stable io_cpu and
cannot ping pong between two live submitters. Concurrent writers
on different CPUs serialize on a cmpxchg on io_cpu.

The behavior is opt in via the new wq_adopt module parameter, default
off and runtime writable. wq_unbound takes precedence when both are
set.

Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
 drivers/nvme/host/tcp.c | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 87d8067f3283..6509273f478c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,10 @@ static bool wq_unbound;
 module_param(wq_unbound, bool, 0644);
 MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (default false)");
 
+static bool wq_adopt;
+module_param(wq_adopt, bool, 0644);
+MODULE_PARM_DESC(wq_adopt, "Adopt the submitting cpu as queue io_cpu (default false)");
+
 /*
  * TLS handshake timeout
  */
@@ -92,6 +96,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_IO_CPU_ADOPTED = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -105,6 +110,7 @@ struct nvme_tcp_queue {
 	struct socket		*sock;
 	struct work_struct	io_work;
 	int			io_cpu;
+	unsigned long		last_data;
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
@@ -2783,6 +2789,69 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 }
 
+/* Re-adopt io_cpu on the first data request after this much queue idle time */
+#define NVME_TCP_READOPT_IDLE	(30 * HZ)
+
+/*
+ * Adopt the CPU of the current data submission as the queue's io_cpu.
+ *
+ * The connect time choice in nvme_tcp_set_queue_io_cpu() picks the least
+ * loaded CPU in the queue's mq_map group before any I/O exists, so it
+ * cannot know which side of the group the actual submitters live on. On
+ * hosts that partition CPUs between pinned workloads a group that
+ * straddles a partition boundary can get an io_cpu on CPUs the submitting
+ * workload does not own, and its network processing then preempts an
+ * unrelated workload. The submitting CPU is in the queue's mq_map group
+ * by construction, so adopting it preserves the spreading property while
+ * landing the work on the side that generates it.
+ *
+ * Queues belong to the controller connection and outlive the workloads
+ * that submit through them, so adoption re-arms after NVME_TCP_READOPT_IDLE
+ * of queue quiet. A successor workload reclaims an idle queue with its
+ * first data request, while a continuously busy queue keeps a stable
+ * io_cpu and cannot ping pong between two live submitters.
+ *
+ * Passthrough commands (the io queue Connect in particular) are submitted
+ * from an arbitrary group CPU by blk_mq_alloc_request_hctx() and do not
+ * represent the data path, so they are skipped and the first real read
+ * or write decides.
+ *
+ * Adoption is opt in via the wq_adopt module parameter and is bypassed
+ * when wq_unbound is set.
+ */
+static void nvme_tcp_adopt_io_cpu(struct nvme_tcp_queue *queue,
+		struct request *rq)
+{
+	int old, new;
+
+	if (!wq_adopt || wq_unbound || blk_rq_is_passthrough(rq))
+		return;
+	if (!nvme_tcp_queue_id(queue))
+		return;
+
+	if (test_bit(NVME_TCP_Q_IO_CPU_ADOPTED, &queue->flags) &&
+	    time_before(jiffies, READ_ONCE(queue->last_data) +
+				NVME_TCP_READOPT_IDLE)) {
+		WRITE_ONCE(queue->last_data, jiffies);
+		return;
+	}
+
+	WRITE_ONCE(queue->last_data, jiffies);
+	set_bit(NVME_TCP_Q_IO_CPU_ADOPTED, &queue->flags);
+
+	old = READ_ONCE(queue->io_cpu);
+	new = raw_smp_processor_id();
+	if (old == new || !try_cmpxchg(&queue->io_cpu, &old, new))
+		return;
+
+	if (test_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags)) {
+		atomic_dec(&nvme_tcp_cpu_queues[old]);
+		atomic_inc(&nvme_tcp_cpu_queues[new]);
+	}
+	dev_dbg(queue->ctrl->ctrl.device, "queue %d: adopted io_cpu %d\n",
+		nvme_tcp_queue_id(queue), new);
+}
+
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
@@ -2802,6 +2871,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
+	nvme_tcp_adopt_io_cpu(queue, rq);
+
 	nvme_tcp_queue_request(req, bd->last);
 
 	return BLK_STS_OK;

base-commit: bf881dd20062db5e951a0d0703cb476df8c9fdee
-- 
2.53.0


