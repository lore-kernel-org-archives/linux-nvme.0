Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234AC352A4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 00:02:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0282072C
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 00:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPCsA34b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmLA9BgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0282072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=RR1nHHM1qXyoEqLpHfJCONEICfNyUoO7KJqUq0bYI5M=; b=SPC
	sA34bU/5l3qL/IGMxKu7XiD33+VtVgIiPoGN0UBa/w6sTjw+WGP1P7keb4u9DFYe6lkkw8VnkmCPJ
	yrzb8PaOjavrGIKBffkszhr5QVvXBcdmeBAvZH6N0Lkm5Ri0Qgz9fMHMYYxRIma1hTjqpQtUq3Or9
	Ive/Z4nzWgw2VHusi4Id1F07zl3DGguvtrVRLcwU1RdiYfXHom8+jKngyxRnmJvGa7Xg12pr4uEVP
	GRrZDFC919hnIa4Sgj3ruTK0qfL7Lps0+m6cNxWDGa+1zP0dNJbJu9iuq6dAJ4Yd3NkdMG/HgEfVd
	zqP3WTNptLuPvgehGkTOj8qzq8Rdmkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1J07-0005fm-4i; Tue, 11 Feb 2020 00:02:03 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1J03-0005fP-7A
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 00:02:00 +0000
Received: by mail-wm1-x342.google.com with SMTP id t14so1291848wmi.5
 for <linux-nvme@lists.infradead.org>; Mon, 10 Feb 2020 16:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=MyxA++ZNRg9056rS8PfggbcUnb3Pgd/uDuW6UZXcfvQ=;
 b=FmLA9BgWOMsMHEqDsnS/hiBaxqU/ihf8TqlK74SYLS363goo+t6dOPcJiWbsH4UgI3
 /Ujloaf09HmLI/6aiajpe9fmCqPuqLBUArc7OZArMiFr1/FQDo78RBbn2VL7K8FVoUPP
 e7zcJPQllEGUlVsvcaUgZtKQZuhC6Zd7pX0GTCkheTV/5tn3O9kNldU5ANM9xsTIwDea
 R0V6xiDG3x8Wp5rgN8EEpujjZKj/krBGmKW1DVleF0bGg+HLfclhrRq+oaV2x9tYZ8CC
 d9fEgeGFB+jBTZEXT1q++yz5xFihJRpfZB8wT1MhcV2M5LZcqsiCD0fxLY7KVjHcEn87
 NAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=MyxA++ZNRg9056rS8PfggbcUnb3Pgd/uDuW6UZXcfvQ=;
 b=MLRFLsuYgxy9Yhu7+arvmbuVwKwnu17pUHhIIp2gT2Wxu3xC42zwWPnzdwti56RwIi
 D1SxpYoQMw6gkMLZS+KBSphx4b6+UHyy5FP8ib1kyfueyi/uXY3WuhqFBaXjTlAWflF7
 i9w+yWidFg4Jm9b6NNR77DNBlpLcE+0sOXLt8wb7VUXLkEkCisdSucx7RMZMCncgYYi4
 qUgdeIXACrj8bOhTvQAuA5Og8pXBSP3f58OpnDyXRuHrClvRB4xbKyxWK/MURyBVZlfH
 E2lxwDIbcCkrjirrD8oalUJ72FS42IVeVNYn2XU959iVbjYxi2RyPPKawN5So2M1mCja
 BMEg==
X-Gm-Message-State: APjAAAXB0b3CZW4dhgPzR31vs2KQKEGJ5vy92mI/Jxpa5J0Y93OXG73/
 jQoCMFhk1BAjzYS4w62mYnsG5pt7
X-Google-Smtp-Source: APXvYqzRDODva1kaNvnIwfkuRJ2Iyt//utb3cV+23j6Qz3JnlPZQG8z+ReFZxi/N/1DCiInP5XvNAQ==
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr1526545wmf.176.1581379315837; 
 Mon, 10 Feb 2020 16:01:55 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id b21sm1275109wmd.37.2020.02.10.16.01.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Feb 2020 16:01:55 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme: prevent warning triggered by nvme_stop_keep_alive
Date: Mon, 10 Feb 2020 16:01:45 -0800
Message-Id: <20200211000145.18246-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200210_160159_263345_B20E266D 
X-CRM114-Status: GOOD (  15.73  )
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
Cc: Nigel Kirkland <nigel.kirkland@broadcom.com>,
 James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Delayed keep alive work is queued on system workqueue and may be cancelled
via nvme_stop_keep_alive from nvme_reset_wq, nvme_fc_wq or nvme_wq.

Check_flush_dependency detects mismatched attributes between the work-queue
context used to cancel the keep alive work and system-wq. Specifically
system-wq does not have the WQ_MEM_RECLAIM flag, whereas the contexts used
to cancel keep alive work have WQ_MEM_RECLAIM flag.

Example warning:

  workqueue: WQ_MEM_RECLAIM nvme-reset-wq:nvme_fc_reset_ctrl_work [nvme_fc]
	is flushing !WQ_MEM_RECLAIM events:nvme_keep_alive_work [nvme_core]

To avoid the flags mismatch, delayed keep alive work is queued on nvme_wq.

However this creates a secondary concern where work and a request to cancel
that work may be in the same work queue - namely err_work in the rdma and
tcp transports, which will want to flush/cancel the keep alive work which
will now be on nvme_wq.

After reviewing the transports, it looks like err_work can be moved to
nvme_reset_wq. In fact that aligns them better with transition into
RESETTING and performing related reset work in nvme_reset_wq.

Change nvme-rdma and nvme-tcp to perform err_work in nvme_reset_wq.

Signed-off-by: Nigel Kirkland <nigel.kirkland@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
V2: combined the 2 patches into 1 to prevent regressions if one missed.
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/rdma.c |  2 +-
 drivers/nvme/host/tcp.c  |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6ec03507da68..303b308fde52 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -66,8 +66,8 @@ MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
  * nvme_reset_wq - hosts nvme reset works
  * nvme_delete_wq - hosts nvme delete works
  *
- * nvme_wq will host works such are scan, aen handling, fw activation,
- * keep-alive error recovery, periodic reconnects etc. nvme_reset_wq
+ * nvme_wq will host works such as scan, aen handling, fw activation,
+ * keep-alive, periodic reconnects etc. nvme_reset_wq
  * runs reset works which also flush works hosted on nvme_wq for
  * serialization purposes. nvme_delete_wq host controller deletion
  * works which flush reset works for serialization.
@@ -974,7 +974,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -1004,7 +1004,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
 		ctrl->comp_seen = false;
-		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 		return;
 	}
 
@@ -1021,7 +1021,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a47c6c5007e..3e85c5cacefd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1088,7 +1088,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &ctrl->err_work);
+	queue_work(nvme_reset_wq, &ctrl->err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6d43b23a0fc8..a28f9144954c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -422,7 +422,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
