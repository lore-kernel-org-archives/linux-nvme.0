Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A50C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyZ4tty7dz88cLE6CH+T3FoVohIExvPjQpjxhtrBFC0=; b=LkN3+py7WTVAftqyJdXHy6wX5s
	jLzXOPs/EgGY84p3088qg4XotjgLZRLfePbPGRvtyYkNyF3wn18qzpxi8LsfWip3kTbaAQwteL4cu
	hEITBUpdg4dopifgD2ZaLYFU59XSYG3Ee17xKWZMZ9NsHepetcfXX5g7sy/XlrzAXNFNniHgVZmd4
	sX5cB/vUAC8n5guVHIQQj/7g2FbnVhGpkvFLnIAcRsK55J4AeScmtV8u/jJPrHlrb0sXb/caU7cG9
	cfKpcXPb0FteURPRGIrvOI9+fnXQqWy6uuJpUku3UEbJ2atidTf6/GSRUISpx56A0F1mBAHwUoX8c
	XrvknoJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcr-00Gm2z-1I;
	Tue, 23 Jan 2024 14:19:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHco-00Gm0M-0a
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:19:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B000661E0B;
	Tue, 23 Jan 2024 14:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C15C433C7;
	Tue, 23 Jan 2024 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019577;
	bh=mRExsfjadCLREpulxTbJVu4XasIN5LRmzbHxkUE2Ogo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPnz6GPKe9rSYPA/pstEkeJvx/BtqEwVJMWgHxYkKu7pBzDORZBclQx8DMp8Wu/mm
	 WO2WbYaI5ohzZGBBknPUhUjt1ztetqWRibcVN/FLkHXCcF162w/NJuGyvNO2KfUAaO
	 NSadvs0WESdzMRlUR0Vwsh+gGVUel1eAxwG8sUURDx2IUqej3sobMQtuvW0cXvgvcO
	 t8b1pkHa0ZStIUA53bQGzLm0FMsrBZZp1jtyeenrulGyOB37txBxQ8mlO0BOevnL+t
	 Fl7+HMjNcWlhdej91doQSYjmOvvv8hH5+e4+zjcJA/Bbm5aDfY+xQUC3PppqEFRsMO
	 v2sskZ5U8Jliw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/11] nvme: add nvme_noretry_error()
Date: Tue, 23 Jan 2024 15:19:07 +0100
Message-Id: <20240123141909.79061-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123141909.79061-1-hare@kernel.org>
References: <20240123141909.79061-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061938_263295_70CB793F 
X-CRM114-Status: GOOD (  15.17  )
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

From: Hannes Reinecke <hare@suse.de>

Add helper function to check if an error status should be retried
or not.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/fc.c   |  4 ++--
 drivers/nvme/host/nvme.h | 10 ++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 50818dbcfa1a..8212e55962e8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3776,7 +3776,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	 *
 	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret > 0 && (ret & NVME_SC_DNR))
+	if (nvme_noretry_error(ret))
 		nvme_ns_remove(ns);
 }
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 05c3159d42e9..8732ebc402a7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3326,7 +3326,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
-		if (status > 0 && (status & NVME_SC_DNR))
+		if (nvme_noretry_error(status))
 			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
@@ -3343,7 +3343,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
 	} else {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
-			if (status > 0 && (status & NVME_SC_DNR))
+			if (nvme_noretry_error(status))
 				dev_warn(ctrl->ctrl.device,
 					 "NVME-FC{%d}: reconnect failure\n",
 					 ctrl->cnum);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6092cc361837..378d5c6cc851 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -688,6 +688,16 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }
 
+/*
+ * Negative error codes are assumed to be transport errors
+ * and should be retried, positive error codes are NVMe
+ * status codes which should be retried if DNR is not set.
+ */
+static inline bool nvme_noretry_error(int error)
+{
+	return (error > 0 && (error & NVME_SC_DNR));
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
-- 
2.35.3


