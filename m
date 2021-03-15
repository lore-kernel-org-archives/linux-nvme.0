Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4958BC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:31:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD1864E33
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 22:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD1864E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NDavsbRNXvQ3aVVMTC27slRRrTN96RKOBhy/wx5ILA0=; b=SQnC1ZZZKSj3zKGotZEmitKzK
	sshzxCsulqp3bOGTOwYUQg4/SC9lziiojZzkXzxs7LNYci/OEiqUqSRM2HUqtDDMtMJnsGYJQu/4r
	3wcWQWbBqkHVsMZgU17hZwraprdy3FFxG94KQObY6MkdaeC2+g486Yf5zgUw6eWEo8yWCaGcbNt/n
	RtTkihgrrGqpLZLsBcw3y4k7EqyTwyc0n39BAZGsZh7SxEYGxPkeNkf/sRuVC0YsqmJFr4Tog+5ft
	C3EEN+O93Hu73N7T3pITLRWQ/fjlHUqxI1bGDpYuIoUPspbL7LvTJNETahz9LmqTEuOMRrvC6vyY0
	bQsLs+hTg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLvjO-00H237-4i; Mon, 15 Mar 2021 22:30:34 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLvgG-00H1of-Hy
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 22:27:43 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 ga23-20020a17090b0397b02900c0b81bbcd4so333666pjb.0
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 15:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xF8p/fmZUZGvVUgdWg4oZkzRPMR27cFXPF9K08YOj5A=;
 b=daNxb5OaCQwy21BVNTt1vtENyK3k6DlYAqQqBzWl/GgHXYCXVhWv9EdfE7S9iaeepE
 Jz2lrPPh3XUWecrmo/L1oqH39RLEjUfkquZ95WLila/5NhOopsECEXwqmlYqGBWiOd6c
 NVGB2BzW5DpBqzQyGLfTtnnImifvyCU0d4MeFtDtRew/w655tRxoEYA4VlJlxEgqOvK5
 CMMIo7uKzQ5aV21Qluob3npwXYi3BjbD8IAkA4tIC1Fepafktm00cN/iIXH1OhQ4Euj+
 MWDCAn39hW1H2R5Y/K83k5w/tk0lRmgljAWTTO4fsFZZ5pdfkwsr9rtTIa3s9LuFGnPO
 JYjQ==
X-Gm-Message-State: AOAM531RBlMcvUiyKCkEOGlJE3CE460JX/HUlTZU+5KrOuEH9GnK/J/f
 5goKFp+uUbc8jd2dkB/XyPup61T07U8=
X-Google-Smtp-Source: ABdhPJwmJ//mqokeKo/VDg5puLCsoa5ttJBShZ9/MQz3fYRNyGYMnSZfe7LwqyWCHyyhZDGv+SA27A==
X-Received: by 2002:a17:90a:b115:: with SMTP id
 z21mr1383003pjq.162.1615847238971; 
 Mon, 15 Mar 2021 15:27:18 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id r16sm14614526pfq.211.2021.03.15.15.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 15:27:18 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 3/3] nvme-rdma: fix possible hang when trying to set a live
 path during I/O
Date: Mon, 15 Mar 2021 15:27:14 -0700
Message-Id: <20210315222714.378417-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315222714.378417-1-sagi@grimberg.me>
References: <20210315222714.378417-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_222728_220345_A0EF60E2 
X-CRM114-Status: GOOD (  18.40  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When we teardown a controller we first freeze the queue to prevent
request submissions, and quiesce the queue to prevent request queueing
and we only unfreeze/unquiesce when we successfully reconnect a
controller.

In case we attempt to set a live path (optimized/non-optimized) and
update the current_path reference, we first need to wait for any
ongoing dispatches (synchronize the head->srcu).

However bio submissions _can_ block as the underlying controller queue
is frozen. which creates the below deadlock [1]. So it is clear that
the namespaces request queue must be unfrozen and unquiesced asap when
we teardown the controller.

However, when we are not in a multipath environment (!multipath or cmic
indicates ns isn't shared) we don't want to fail-fast the I/O, hence we
must keep the namespaces request queue frozen and quiesced and only
expire them when the controller successfully reconnects (and FAILFAST
may fail the I/O sooner).

[1] (happened in nvme-tcp, but works the same in nvme-rdma):
Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
Call Trace:
 __schedule+0x293/0x730
 schedule+0x33/0xa0
 schedule_timeout+0x1d3/0x2f0
 wait_for_completion+0xba/0x140
 __synchronize_srcu.part.21+0x91/0xc0
 synchronize_srcu_expedited+0x27/0x30
 synchronize_srcu+0xce/0xe0
 nvme_mpath_set_live+0x64/0x130 [nvme_core]
 nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
 nvme_update_ana_state+0xcd/0xe0 [nvme_core]
 nvme_parse_ana_log+0xa1/0x180 [nvme_core]
 nvme_read_ana_log+0x76/0x100 [nvme_core]
 nvme_mpath_init+0x122/0x180 [nvme_core]
 nvme_init_identify+0x80e/0xe20 [nvme_core]
 nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
 nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]

Fix this by looking into the newly introduced nvme_ctrl_is_mpath and
unquiesce/unfreeze the namespaces request queues accordingly (in
the teardown for mpath and after a successful reconnect for non-mpath).

Also, we no longer need the explicit nvme_start_queues in the error
recovery work.

Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/rdma.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index be905d4fdb47..43e8608ad5b7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -989,19 +989,22 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
-		nvme_start_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
+		if (!nvme_ctrl_is_mpath(&ctrl->ctrl)) {
+			nvme_start_queues(&ctrl->ctrl);
+			if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+				/*
+				 * If we timed out waiting for freeze we are likely to
+				 * be stuck.  Fail the controller initialization just
+				 * to be safe.
+				 */
+				ret = -ENODEV;
+				goto out_wait_freeze_timed_out;
+			}
 		}
 		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
 			ctrl->ctrl.queue_count - 1);
-		nvme_unfreeze(&ctrl->ctrl);
+		if (!nvme_ctrl_is_mpath(&ctrl->ctrl))
+			nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	return 0;
@@ -1043,8 +1046,11 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
-		if (remove)
+		if (nvme_ctrl_is_mpath(&ctrl->ctrl)) {
 			nvme_start_queues(&ctrl->ctrl);
+			nvme_wait_freeze(&ctrl->ctrl);
+			nvme_unfreeze(&ctrl->ctrl);
+		}
 		nvme_rdma_destroy_io_queues(ctrl, remove);
 	}
 }
@@ -1191,7 +1197,6 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
