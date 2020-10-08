Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA56C433E7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:38:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526C5207DE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pbILeHwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526C5207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QpIehyHuUIrOT7hhwGJsw9dX04TpWfsePnASc/M7wqM=; b=pbILeHwpyDyfu7thf8iPwyCRWq
	raQOahQZKc/BaTlh2AzY70L6zYRTkFXaqMl5OVipbRgeVYRMpbr3he8VVzCea+5XZBEM6xYhJpxcA
	Pyj1ka5QiY7xQ8JvCHK6yfjwRJ0V+I/G4/oMGqOCRmWIboWFv+YSbm6A0KeVatXlLPx1VJ77iQmeo
	DjXo5TaMDMeWdaEyHd2PToQfj5IJHR+pGPMZN8jfk8dCDKo3mYD3VjpRLYzkA0NTWoezsqM0RtM9Y
	sdWR54sFqLQK0cjsiLdPCJb3zHAxQxbILIckYDp/N/5DMec6X1eyd3d9fhn5iQkxlE9N8W7n7g0QX
	FLUQW0Kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQdbx-0006WH-TZ; Thu, 08 Oct 2020 21:38:05 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQdbv-0006V7-19
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 21:38:03 +0000
Received: by mail-wr1-f68.google.com with SMTP id j2so8148932wrx.7
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1yeFlTcreSlGkiCgTiA+N43zzqnDkmGGiL0r+MFHngE=;
 b=qzYts5JN+aCDQCh9zkTJ46DEIoCdJXa9mGeCg2tcoy9xIfKMA2MunzPW9NbyHeV76y
 9IzZ9pn8eKyR6jLrz8548IYiFq1GVnoNKIFk+8Bld4Z0rCGshH2RL5oRIsyvAtfhImk0
 9MwJ6vCWguRyllMiIs6wqvS3RSs5fX8uwc0suHeM1IIdmmNZwWT7Dmdw0QBG0v+t3c3A
 qGe3BOQgEN7x27GxsVNGbepZBijC1ng/gEuz5XQWgCUdXnohwTd7sryLj01KFystiwkf
 JnmAskyiB7fkgJ2h31lncQ+cozN93hcMIGV6sneV/gmMEyBnJu+hXMfcSys1aFc0iEdt
 YvvA==
X-Gm-Message-State: AOAM531Ww725YGFAq+u9RzXEHb9RaM0czK8pfWmXpj241pLUGVB3/uWr
 kS11kCfyI6V/tpxCAg0IHFtFwU3lAYY=
X-Google-Smtp-Source: ABdhPJxjtmnkWPtb+aZEYtdphdkDtgnQjVqWUsbqDT22lqTeh5YIyOLuZgsxRXYWvY7s/GMwm51VVg==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr11278684wrq.321.1602193081489; 
 Thu, 08 Oct 2020 14:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id q2sm8977106wrw.40.2020.10.08.14.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 14:38:00 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: re-introduce blk_mq_complete_request_sync
Date: Thu,  8 Oct 2020 14:37:50 -0700
Message-Id: <20201008213750.899462-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_173803_082924_D154EBB8 
X-CRM114-Status: GOOD (  15.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme-tcp and nvme-rdma, the timeout handler in certain conditions
needs to complete an aborted request. The timeout handler serializes
against an error recovery sequence that iterates over the inflight
requests and cancels them.

However, the fact that blk_mq_complete_request may defer to a different
core that serialization breaks.

Hence re-introduce blk_mq_complete_request_sync and use that in the
timeout handler to make sure that we don't get a use-after-free
condition.

This was uncovered by the blktests:
--
$ nvme_trtype=tcp ./check nvme/012

[ 2152.546343] run blktests nvme/012 at 2020-10-08 05:59:03
[ 2152.799640] loop: module loaded
[ 2152.835222] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 2152.860697] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 2152.937889] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e544149126a24145abeeb6129b0ec52c.
[ 2152.952085] nvme nvme0: creating 12 I/O queues.
[ 2152.958042] nvme nvme0: mapped 12/0/0 default/read/poll queues.
[ 2152.969948] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[ 2154.927953] XFS (nvme0n1): Mounting V5 Filesystem
[ 2154.942432] XFS (nvme0n1): Ending clean mount
[ 2154.948183] xfs filesystem being mounted at /mnt/blktests supports timestamps until 2038 (0x7fffffff)
[ 2215.193645] nvme nvme0: queue 7: timeout request 0x11 type 4
[ 2215.199331] nvme nvme0: starting error recovery
[ 2215.203890] nvme nvme0: queue 7: timeout request 0x12 type 4
[ 2215.204483] block nvme0n1: no usable path - requeuing I/O
[ 2215.214976] block nvme0n1: no usable path - requeuing I/O
[ 2215.215495] nvme nvme0: Reconnecting in 10 seconds...
[ 2215.215502] ------------[ cut here ]------------
[ 2215.215505] refcount_t: underflow; use-after-free.
[ 2215.215617] WARNING: CPU: 6 PID: 45 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
[ 2215.215745] RSP: 0018:ffffb71b80837dc8 EFLAGS: 00010292
[ 2215.215750] RAX: 0000000000000026 RBX: 0000000000000000 RCX: ffff93f37dcd8d08
[ 2215.215753] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff93f37dcd8d00
[ 2215.215755] RBP: ffff93f37a812400 R08: 00000203c5221fce R09: ffffffffa7fffbc4
[ 2215.215758] R10: 0000000000000477 R11: 000000000002835c R12: ffff93f37a8124e8
[ 2215.215761] R13: ffff93f37a2b0000 R14: ffffb71b80837e70 R15: ffff93f37a2b0000
[ 2215.215765] FS:  0000000000000000(0000) GS:ffff93f37dcc0000(0000) knlGS:0000000000000000
[ 2215.215768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2215.215771] CR2: 00005637b4137028 CR3: 000000007c1be000 CR4: 00000000000006e0
[ 2215.215773] Call Trace:
[ 2215.215784]  blk_mq_check_expired+0x109/0x1b0
[ 2215.215797]  blk_mq_queue_tag_busy_iter+0x1b8/0x330
[ 2215.215801]  ? blk_poll+0x300/0x300
[ 2215.215806]  blk_mq_timeout_work+0x44/0xe0
[ 2215.215814]  process_one_work+0x1b4/0x370
[ 2215.215820]  worker_thread+0x53/0x3e0
[ 2215.215825]  ? process_one_work+0x370/0x370
[ 2215.215829]  kthread+0x11b/0x140
[ 2215.215834]  ? __kthread_bind_mask+0x60/0x60
[ 2215.215841]  ret_from_fork+0x22/0x30
[ 2215.215847] ---[ end trace 7d137e36e23c0d19 ]---
--

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 236187c4ed19 ("nvme-tcp: fix timeout handler")
Fixes: 0475a8dcbcee ("nvme-rdma: fix timeout handler")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Yi, would appreciate your Tested-by tag

 block/blk-mq.c           | 7 +++++++
 drivers/nvme/host/rdma.c | 2 +-
 drivers/nvme/host/tcp.c  | 2 +-
 include/linux/blk-mq.h   | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f8e1e759c905..2d154722ef39 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -729,6 +729,13 @@ bool blk_mq_complete_request_remote(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_complete_request_remote);
 
+void blk_mq_complete_request_sync(struct request *rq)
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	rq->q->mq_ops->complete(rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_complete_request_sync);
+
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..45fc605349da 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1975,7 +1975,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	nvme_rdma_stop_queue(queue);
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
+		blk_mq_complete_request_sync(rq);
 	}
 	mutex_unlock(&ctrl->teardown_lock);
 }
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8f4f29f18b8c..629b025685d1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2177,7 +2177,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	if (!blk_mq_request_completed(rq)) {
 		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
-		blk_mq_complete_request(rq);
+		blk_mq_complete_request_sync(rq);
 	}
 	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 90da3582b91d..f90c258b5075 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -491,6 +491,7 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request_sync(struct request *rq);
 bool blk_mq_complete_request_remote(struct request *rq);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
