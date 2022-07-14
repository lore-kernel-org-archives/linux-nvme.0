Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98023CCA47B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofhW+sBqh9f0zXB9u2bQuoAZpojPwE11Sfq/jbHPrkg=; b=fQ3b4SnL6vbXg6rGAWJ9CDeSnQ
	VQp+fsEn11qxLSTY909uuMzvCDrCY2wJqqLzl/vULW7IUWOP4FyWtpkGLAp1xVLBup82BlNQvSg1T
	Wp/vmOwUb5sqOh4v9DI2A42hlj2IN9Qg1Jlp6MVoZzTNEgSERIKBLuYeXczOte4FA/prfUE7UZ2hX
	4wPqqyw/wdVnNbM4JAEnaFV7TPoQkGzbZZTEsDyMRwcL+GrTFCpYd9GY8NcDc7pPslCo7CC/IJchs
	ZVhg3pvGwzXIL371nEG3FIYfehhCOukzs1rcwW29dOa79kgvZpI/fgypt8PVMC/SxgrTrKvmsX9M+
	edaeZawA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByDR-00ELtC-FS; Thu, 14 Jul 2022 12:45:13 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByA1-00EJaV-ML
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 12:41:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5F5F01F8FB;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657802499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofhW+sBqh9f0zXB9u2bQuoAZpojPwE11Sfq/jbHPrkg=;
	b=clq8sOgdgBHfDJNTtf19lOqIwsn1k0x4nxzAwLE4ZzizCh9w5c5FznYOetbyv6CQ4a3sQW
	GOhYrrAzQaWtYfpRNIY2f47OwCirtlXxh0+H6WfYs6IjMscOtrTAClDYE/oJ1Bu2wczKEJ
	jNxX6MLixAaM7Ov7ToVAA3OH3tNs0xU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657802499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofhW+sBqh9f0zXB9u2bQuoAZpojPwE11Sfq/jbHPrkg=;
	b=YsYif+obs/D30kC8yvt0krIbjEIU5v140TKGbe6FjIgdEyqOpkhlAsE2udd546bZi5x6sL
	p5sCqlt+NLJxEfCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 573B12C142;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4811451988D2; Thu, 14 Jul 2022 14:41:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme-tcp: short-circuit connect retries
Date: Thu, 14 Jul 2022 14:41:32 +0200
Message-Id: <20220714124133.68598-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220714124133.68598-1-hare@suse.de>
References: <20220714124133.68598-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_054141_915137_FFFE460A 
X-CRM114-Status: GOOD (  13.67  )
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

When a reconnect attempt fails with a non-retryable status
(eg when the subsystem has been unprovisioned) there hardly
is any reason to retry the reconnect attempt.
So pass the actual error status to nvme_tcp_reconnect_or_remove()
and short-circuit retries if the DNR bit is set.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 70096a2e8762..4220c1ad6b29 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2065,8 +2065,10 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl, int status)
 {
+	bool recon = true;
+
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
@@ -2074,7 +2076,12 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(ctrl)) {
+	if (status > 0 && (status & NVME_SC_DNR)) {
+		dev_info(ctrl->device, "reconnect failure %d\n", status);
+		recon = false;
+	}
+
+	if (recon && nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
@@ -2162,10 +2169,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 			struct nvme_tcp_ctrl, connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
 
 	++ctrl->nr_reconnects;
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
@@ -2178,7 +2187,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2203,7 +2212,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2229,6 +2238,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2240,14 +2250,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
-- 
2.29.2


