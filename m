Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF9BEE57EC
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4HQqahBjsyHo7TFnS0AZv3yxRJQJW5i+puldDDXdS8=; b=pN5fxCVt46Q2XpDxo3oeovX5gV
	86TOB5rbOLpjAfywfKRbgnH9fZhwjP62fuXiLMiZR5L58U+1KyBq4sCrBgqnAMakjAlqCwLs+GXwH
	qLfncIR3dkePFo47DVf7hMTmFXXFgrEM+TNUVqyvmuYuCANHq955m2MmDiIbEwZU7dHM3V4LgGyZC
	lRe/Q9c+oeFfHv9NamCar6zvDtgiDy32vPX78H37J1qP8j/FCWx6wt5wvhmaeGhfXaF3cSuCJDhAV
	uSLqMpHXoWEsdZVkTxPoyqDyBmmaSYOSgn/96Pr4huSEzOPabik0E9sF/OHH45zjOd35Ed8aiMvCz
	vb5vC95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIO-00DRJX-2d;
	Fri, 08 Sep 2023 10:01:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeYIL-00DRIM-26
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 10:00:59 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id EDE001F8D4;
	Fri,  8 Sep 2023 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694167253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4HQqahBjsyHo7TFnS0AZv3yxRJQJW5i+puldDDXdS8=;
	b=XBWpehEQpOpp7b2FOu7rj1Uz9mUHbDLbxiQK2WePqIed1dm1ZgO7ux3AwDR8WyMQ0pSD2T
	zaOk4qps8aZMY6Mh7RcixiYYRObQQ5gkQr7ST4emXKX0teb/Pi+hIJijjTOl6vFzGfCg48
	SQD0BV652VOk0Zjs4dzOItXa8uDJpkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694167253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4HQqahBjsyHo7TFnS0AZv3yxRJQJW5i+puldDDXdS8=;
	b=D18nJlCtT96h7ghhDo/ObxO+Pj6wYsUWtxZiKQE7d0xUpJSvVSOaJ2on52OSzc/s+XsK+F
	7QVQASi9Jo3OQfAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E3B842C149;
	Fri,  8 Sep 2023 10:00:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DF77B51CC681; Fri,  8 Sep 2023 12:00:52 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvme-tcp: delay error recovery until the next KATO interval
Date: Fri,  8 Sep 2023 12:00:49 +0200
Message-Id: <20230908100049.80809-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908100049.80809-1-hare@suse.de>
References: <20230908100049.80809-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_030057_871338_0D1BD423 
X-CRM114-Status: GOOD (  13.65  )
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

Section 3.9 of the NVMe base spec states that:

 If a Keep Alive Timer expires:
 a) the controller shall ...
 and
 b) the host assumes all outstanding commands are not completed
   and re-issues commands as appropriate.

which means that we should _not_ retry any commands until KATO
expired (or the equivalent of the default KATO timeout if KATO
is not active).
And there are some target which reported a data corruption if
we retry commands immediately after reporting a command timeout
or link loss.
So always delay error recovery until the next KATO interval
to give controllers enough time to detect a KATO failure.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/tcp.c  | 12 ++++++++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..2d546612b20a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1175,7 +1175,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
-static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 {
 	unsigned long delay = ctrl->kato * HZ / 2;
 
@@ -1189,6 +1189,7 @@ static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
 		delay /= 2;
 	return delay;
 }
+EXPORT_SYMBOL_GPL(nvme_keep_alive_work_period);
 
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..38845e5fa5a3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -777,6 +777,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 990bd863ae34..7bfdb05b2f17 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -533,13 +533,21 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->ddgst_remaining = 0;
 }
 
+/*
+ * Error recovery needs to be started after KATO expired,
+ * always delay until the next KATO interval before
+ * starting error recovery.
+ */
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, 0);
+	dev_warn(ctrl->device, "starting error recovery in %lu seconds\n",
+		 delay / HZ);
+	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, delay);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
-- 
2.35.3


