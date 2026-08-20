Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF11CC5DF82
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 08:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wuk/ok0Lrf0FihiMk3ElwPh6gTvSMLX5JskS22+aaRY=; b=u6wLyk0YjUFR5qfILcDxCofjD8
	+d/GPu9aeHDEDqcrut4i6FypVEUnrCUXPVy2cOjQ44qo1ot01MNZK4VM/mz7nQGeyby+UGgTgdGs6
	A6c67zr27IWim1wOXYCC0x1S6fjmgJ3W/faTM2CURJrDnhif/C6ujkeMLsW71aRk0ZaFT73L3mREw
	4hROyq1wlCheKtzwo/F91+zMgnVykQ1keUyFwI98Y4aBkBWF4CRDCfjLwaxSnRHZ4dawDiLcvsOv2
	PMS4Yd3/eZNRU38Xoi0o2KRQ7nmT+weD62swoLe5OcS1wx7dv5+Pcwt+PR7oR1PzEGRZqjpv9MzR1
	/HzDdV1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwyGh-0000000BAnT-0TfN;
	Thu, 20 Aug 2026 08:36:59 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwyGd-0000000BAmm-3FHP
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 08:36:57 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso2214967a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2026 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1787215014; x=1787819814; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wuk/ok0Lrf0FihiMk3ElwPh6gTvSMLX5JskS22+aaRY=;
        b=WqAn2ydZsInSy6I9DTx0V4SwVpQKcAl5SvpaRd5wIGkUJ+gTTdvU8b/ub1SXwX8WsW
         S/eQEA9SxSR0fU2kwH8pWhjSELQ9bzYC7XgHAUEPTOSo6jOfqoqduF8UR7WXkpYXWslN
         6cVVqc7jq8oB4H/B7MKPvaf1i5XXJ8obVa3eCFvoCbz+E39KpTy6XVSNfIbZxO5dcUsJ
         XgjEpYacUUVMqr39qRvASM8isqlTcW+5/W/TuDmpL/RCsW64g6BFtgtF5XYV07cMDg4B
         bLShj12UAHYYDzyVdvMMmAusMxK/82pWRqZmNyRy9L7aDfUucmd3KiNTrppxmOPkyGNP
         Xp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787215014; x=1787819814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wuk/ok0Lrf0FihiMk3ElwPh6gTvSMLX5JskS22+aaRY=;
        b=ooz/tBKYYyce+4QCxocZJ5MPzQ4gCA5biklsFYopctvXTCzCBwo5PIzYeYsbyf9Ra/
         JDnvSHNRAq/8Oc0lmPWb5j6QnNo7sOUnCk85ZejzGMEXEwmFp5jMBqfrSLcxus84EGGF
         acJB6KzfLHbHvd3qYEuqwKcvCzp3rZ5ifjxlMSOSUrCzb3HY25X2wVxhP4FjoTIgcjoR
         y3UJ/R+ubJ1EcbU6X4SHQelO2DzttDdGG4lCeab+MxxiQrZs+CKHkPZbFA7/+BNrH70t
         Uog5gQe4gQ/sDUeZ6/ggN6zBW7srsNUtNs+J7w6WyoskTZc5tiX2g1UH7MUQin7DIxID
         Urcg==
X-Gm-Message-State: AFuF++lca0ddKxyMhMFKvzeOwf5dTlpcibsaS9e4rdxhVreKWyUa1JWS
	tjpQA6rcviQx4qMQZ42jyBN1XlMUDEqC4GXQAeIfXXWfuMqQNcJepyPGABWru8wMOhMhBE5h4+l
	ZcB0QHRg=
X-Gm-Gg: AR+sD11pF3905RaVMK0yqq7biaZgf7nRsydx0T/kEixbVYRerip2POKJqSn/7U6GtWy
	i9KbveuvtDrMvVvSgwuw64tYodC2Qilt/3d2KFEzZ2MfPJOo5tVoYlQxetg3QPpQE5CP7DWM0QU
	ZxJtD6k2aYU4Ru6Xud6q7skMN78cNxZ2b8msY6oJUo0u2JiAs+9/u8co+k0IGTGjnJ/CMvMZWpx
	n5cLXb27a/MxoYNLfrS48D+4F4Rkmghm/7bYIp9L265s3LMabR9pQD75+gzE3lqg0MCvQAblT1B
	QlKrcmnnwoT+4+vj33NEke8SzXlDMlHVw3jn8xEQ2oAZ+k5EoQjqV+bQBx97etIrPFjfCiqD/bB
	t4IBreBKgWHyDJSg/10WmzP0ONGXTaYjetjLMppRpRS5yaflTz1HJGecGjBjCWheZbCjWftD3QK
	iRU9bj+c9/yQS9mjAs9Hz5HsUAWZRMe6nIbsdw5U8PcaTG3MZNfyrvFbQjjr5+bDEj2ndetF9Xy
	oCxfzjbe/g6E7rd+5KKjh6cFVnPeuKtKgT0x5XTTH5xNpEhfGtCZw==
X-Received: by 2002:a17:90b:2b8e:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-395810c60ffmr22022815a91.13.1787215013774;
        Thu, 20 Aug 2026 01:36:53 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4380:3400:c90a:ce07:3842:3642])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416aea2429sm13877076c88.15.2026.08.20.01.36.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 01:36:52 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	Saravanan D <saravanand@crusoe.ai>
Subject: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
Date: Thu, 20 Aug 2026 01:36:34 -0700
Message-ID: <20260820083634.71689-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_013655_832026_3709FC18 
X-CRM114-Status: GOOD (  28.15  )
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

Adopt the submitting CPU as io_cpu for every command except the
fabrics Connect. The submitter is a member of the map group by
construction, and the nvme_tcp_cpu_queues accounting moves with each
adoption. Connect is the only command on an I/O queue that does not
represent the data path, since it is injected on an arbitrary CPU by
blk_mq_alloc_request_hctx(), so it is skipped and the first real read
or write decides. User passthrough is submitted from a real task on
the submitting CPU and adopts like any other command.

Queues outlive the workloads that submit through them, so adoption
re-arms after 30 seconds of queue quiet. An idle queue is reclaimed by
its next submitter, while a busy queue keeps a stable io_cpu and
cannot ping pong between two live submitters. Concurrent writers on
different CPUs serialize on a cmpxchg on io_cpu.

The behavior is opt in per controller via the io_cpu_adopt fabrics
option at connect time. wq_unbound takes precedence when set.

Signed-off-by: Saravanan D <saravanand@crusoe.ai>
---
Changes since v1 [1]:
- Special case the fabrics Connect command instead of skipping all
  passthrough commands, so user passthrough I/O adopts too.
- Make it a per-controller io_cpu_adopt fabrics option instead of a
  global wq_adopt module parameter, set once at connect time rather
  than flipped under a live connection.

Both per Christoph Hellwig's review.

[1] https://lore.kernel.org/linux-nvme/20260806023947.94680-2-saravanand@crusoe.ai/

 drivers/nvme/host/fabrics.c |  4 ++
 drivers/nvme/host/fabrics.h |  2 +
 drivers/nvme/host/tcp.c     | 75 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index fd5abd04e080..26f8703744de 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_IO_CPU_ADOPT,	"io_cpu_adopt"		},
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
@@ -951,6 +952,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DATA_DIGEST:
 			opts->data_digest = true;
 			break;
+		case NVMF_OPT_IO_CPU_ADOPT:
+			opts->io_cpu_adopt = true;
+			break;
 		case NVMF_OPT_NR_WRITE_QUEUES:
 			if (match_int(args, &token)) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833..3ecac041a628 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_IO_CPU_ADOPT	= 1 << 29,
 };
 
 /**
@@ -140,6 +141,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			io_cpu_adopt;
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 87d8067f3283..530e38695257 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -92,6 +92,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_IO_CPU_ADOPTED = 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -105,6 +106,7 @@ struct nvme_tcp_queue {
 	struct socket		*sock;
 	struct work_struct	io_work;
 	int			io_cpu;
+	unsigned long		last_data;
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
@@ -2783,6 +2785,74 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
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
+ * The fabrics Connect command targets a specific queue via
+ * blk_mq_alloc_request_hctx() and so runs on an arbitrary CPU that does
+ * not represent the data path, so it is skipped and the first real read
+ * or write decides. All other commands, including user passthrough,
+ * carry a real submitting CPU and adopt.
+ *
+ * Adoption is opt in per controller via the io_cpu_adopt connect option
+ * and is bypassed when wq_unbound is set.
+ */
+static void nvme_tcp_adopt_io_cpu(struct nvme_tcp_queue *queue,
+		struct request *rq)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	int old, new;
+
+	if (!queue->ctrl->ctrl.opts->io_cpu_adopt || wq_unbound)
+		return;
+	if (!nvme_tcp_queue_id(queue))
+		return;
+	if (nvme_is_fabrics(cmd) &&
+	    cmd->fabrics.fctype == nvme_fabrics_type_connect)
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
@@ -2802,6 +2872,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
+	nvme_tcp_adopt_io_cpu(queue, rq);
+
 	nvme_tcp_queue_request(req, bd->last);
 
 	return BLK_STS_OK;
@@ -3047,7 +3119,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT |
+			  NVMF_OPT_IO_CPU_ADOPT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 

base-commit: bf881dd20062db5e951a0d0703cb476df8c9fdee
-- 
2.53.0


