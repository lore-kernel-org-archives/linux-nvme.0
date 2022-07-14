Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EC5C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 12:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kx/JIhaykqwpqomD7TD3+tH085TglLTDNleuWbASIuo=; b=p/aew1Xy/TBY62FFtHgnvo2MWr
	zNwvnwV4nLBYHF376NSisK3S1LxzugJ8bz8gHzN/JVZtzlf2UI/+DD08AJmXGS/mTTFW7+4baHtND
	W5YMM4QYD4Luq5aE6HxnbuBC9mebyFvwjG3a1Lg8hs7YoHyC6H9IRSrccplb6Gck/ic9+kWuSsaM6
	g+dsfVzB9u/FQKZUH9bmqIaV7DLT6Y9WJdRU5vuqD1H694lQQEL/Rov8OII6gaI28sTF4vvQZW/qR
	C7DwrfWJg4brxFaRGWhU1Jn0qX5UxFgNYGToud4PsXg5tBTfV1AMYg/f7JA3vBtmzpfi091koJpdz
	Y4FitWoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByE2-00EMNW-B9; Thu, 14 Jul 2022 12:45:50 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByA1-00EJaW-MK
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 12:41:44 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6423233744;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657802499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx/JIhaykqwpqomD7TD3+tH085TglLTDNleuWbASIuo=;
	b=F8QZLiXmkFU87ag5WQc0jA9GOA5yH1YUGn7x3PLiHNa7jikC7lXFhX4UvKBSYtHYPlXjEv
	RoBxSNuEQfCR6XFWgmu5Ets5wE7FwFEyIm+t8EUEA2rxGh1PSJ3dmpRv4uX3NIYXfEPzAz
	ImGC1OjK05K6Sf9/Jdj4SHaoIQLMdtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657802499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx/JIhaykqwpqomD7TD3+tH085TglLTDNleuWbASIuo=;
	b=6eQjLoOnaDLnF+vKdup1L0xN4n4cmqgIojuTccbtpFLd+qlYmV6D8Z8Mn1ZbX9e+YDCUJf
	lfgdtkrUONuF+sDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5C6662C143;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4CC3E51988D4; Thu, 14 Jul 2022 14:41:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-rdma: short-circuit connect retries
Date: Thu, 14 Jul 2022 14:41:33 +0200
Message-Id: <20220714124133.68598-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220714124133.68598-1-hare@suse.de>
References: <20220714124133.68598-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_054141_965708_C9956DAB 
X-CRM114-Status: GOOD (  13.91  )
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
 drivers/nvme/host/rdma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 84ce3347d158..bcc84f181dcd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1065,8 +1065,10 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl, int status)
 {
+	bool recon = true;
+
 	/* If we are resetting/deleting then do nothing */
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
 		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
@@ -1074,7 +1076,12 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
+	if (status > 0 && (status & NVME_SC_DNR)) {
+		dev_info(ctrl->ctrl.device, "reconnect failure %d\n", status);
+		recon = false;
+	}
+
+	if (recon && nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
@@ -1173,10 +1180,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_rdma_ctrl, reconnect_work);
+	int ret;
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
@@ -1189,7 +1198,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
@@ -1212,7 +1221,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -2274,6 +2283,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -2284,14 +2294,15 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.29.2


