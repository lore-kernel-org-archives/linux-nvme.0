Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D5FC10F1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9U0ktc1+PQm+mJDx0oI9czaxqbSHOrfazELOsW+HFSY=; b=CBn1Ua0UX8WEK/eYPr6GECQWDi
	kluFuSa1O0P4wGHYQdy191LC9w5LA7j4sXJ+AI+jJVDcrZ5VwZLmqo4+mkDEwWWJMjeSQlJy0sL0R
	qdBYLelrrAWSUITxlMKhkB6KGxKnxb3yUhH2MmXjlst9ZqhvvG9Lw1HRd+Eay9HMdrp/XoHDI2ZHK
	YG/kPGTpqg098NJG4T5JBLQc0/Lbd9nihamH7bh21Ej9iKTa02fWFyPycV/wvTniil87hpk64Hbpc
	P6h2vfqtEWisdzpZiY8q7e+dR6taDUY/RCD7uZB4k9YzTWFPg+YAlwkKLrTW66siOUSDYOslE2ULV
	jfRkNV6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twg-0000000DADR-0fqx;
	Tue, 07 May 2024 23:10:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4Twb-0000000DA8g-3hTu
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 23:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 656E6619FF;
	Tue,  7 May 2024 23:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675FEC4AF68;
	Tue,  7 May 2024 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123397;
	bh=fRY0xZl+owN0RJj7s3kJC8X0Ka726n2x8we9v9HqDD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7TrBH1cRl/ZV2/sSLhLMrjeOkM4LbbDBA2oKGJeUH1PQJJ7uEBdPuc1QMyB1V08v
	 kjTR2skzfROhyLaaq9oVHcxLvnycftv/MG+pSFO3hsDCJWuK/unFKM1JI4tD6UlffO
	 BBOb3+2vLvnkNXVJy08cQ1H7fDpSlUh2CiBBfCjhvESPvaTVhEsV1sGT33Ly2ZawaU
	 cXKiOvvvnLIYymNSp7Kr6FItJjUcq22dOj9Iqf2NoV9NeP2g/50sW89stw9wDYdzRC
	 KZbcJEdpxwLq0U5HRDX5VZEsn5SjlJ3y2Cc8V+7JWUEMHUJQfbq6M7PNvh/QtO63ra
	 giH4UpE+cI0Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 48/52] nvme: cancel pending I/O if nvme controller is in terminal state
Date: Tue,  7 May 2024 19:07:14 -0400
Message-ID: <20240507230800.392128-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_160958_058223_3A327D1D 
X-CRM114-Status: GOOD (  14.89  )
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

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 25bb3534ee21e39eb9301c4edd7182eb83cb0d07 ]

While I/O is running, if the pci bus error occurs then
in-flight I/O can not complete. Worst, if at this time,
user (logically) hot-unplug the nvme disk then the
nvme_remove() code path can't forward progress until
in-flight I/O is cancelled. So these sequence of events
may potentially hang hot-unplug code path indefinitely.
This patch helps cancel the pending/in-flight I/O from the
nvme request timeout handler in case the nvme controller
is in the terminal (DEAD/DELETING/DELETING_NOIO) state and
that helps nvme_remove() code path forward progress and
finish successfully.

Link: https://lore.kernel.org/all/199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 21 ---------------------
 drivers/nvme/host/nvme.h | 21 +++++++++++++++++++++
 drivers/nvme/host/pci.c  |  8 +++++++-
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe3627c5bdc99..01702bc1baf1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -619,27 +619,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
-/*
- * Returns true for sink states that can't ever transition back to live.
- */
-static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
-{
-	switch (nvme_ctrl_state(ctrl)) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	case NVME_CTRL_DEAD:
-		return true;
-	default:
-		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
-		return true;
-	}
-}
-
 /*
  * Waits for the controller state to be resetting, or returns false if it is
  * not possible to ever transition to that state.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a6..5a09879cb1a5f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -740,6 +740,27 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+/*
+ * Returns true for sink states that can't ever transition back to live.
+ */
+static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
+{
+	switch (nvme_ctrl_state(ctrl)) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+	case NVME_CTRL_DEAD:
+		return true;
+	default:
+		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
+		return true;
+	}
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685d..e393f6947ce49 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
+	if (nvme_state_terminal(&dev->ctrl))
+		goto disable;
+
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
@@ -1390,8 +1393,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	return BLK_EH_RESET_TIMER;
 
 disable:
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		if (nvme_state_terminal(&dev->ctrl))
+			nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
+	}
 
 	nvme_dev_disable(dev, false);
 	if (nvme_try_sched_reset(&dev->ctrl))
-- 
2.43.0


