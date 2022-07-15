Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E9AC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QRWomBP82RweA1t/zofDVZcF+aJUyZ35ggxApnLyew=; b=mZrCuMiqc6CmCNdovRNfvOuXqg
	9+A0G+BY0+iTWkrBc4GkApGvHrAJQF1eP6bkoVHw50MOQ0T2E9+PMuKUAJinlhM4WEZTkdKoAB10g
	pDWvhPunCFWgTgsSE3aLEjhCbOTKIB9bqNy46kUEik4hEHWwoGtMpIJreNJ2nkYsJfgyIAybc1Dmw
	1bOpQnYhsoUlDj8k6sF77OS8y7OaG7VSpYwvncLLZy5T1U1pjv6842VqOB9GVEimtBDsHGDT92jlo
	2O1gvo3oSHEyr4a301k4aJrjMGdNE9DvjtHCYtDfj0pzdUvHoBAQiossONgOCeW9qC+DlShUgK0U3
	Oi64vA3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEtw-004dPU-T2; Fri, 15 Jul 2022 06:34:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEtm-004dLX-M6
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 06:34:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 6A548339F5;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657866837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QRWomBP82RweA1t/zofDVZcF+aJUyZ35ggxApnLyew=;
	b=DInCh9RXVtQ74e661LwOjW1puA8hH2n3kjXSDfCE+4NbVkIWu/C/znJ4wu9lPbP3UTUomk
	96p82zkdOgf8OsULGRaO9eaC7umZzPr6nNwsAp0+plGRlnSOuhWhZDN+s1o+3yayfDy4m1
	ih5S/ZOlv4eedlXHNAf1OS0/WDVtXRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657866837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QRWomBP82RweA1t/zofDVZcF+aJUyZ35ggxApnLyew=;
	b=3JSrq4iWolRVdMB1ZqTdXosVSJJ6gEBx3fZ4AtHmww8EsxxnfC9SGp3yXHC8i+h22xXtnE
	3wIXimCGlL3v38AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 60FAF2C143;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 52B8B51988F1; Fri, 15 Jul 2022 08:33:57 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme-rdma: short-circuit connect retries
Date: Fri, 15 Jul 2022 08:33:56 +0200
Message-Id: <20220715063356.134124-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220715063356.134124-1-hare@suse.de>
References: <20220715063356.134124-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_233402_882125_2B82FBA5 
X-CRM114-Status: GOOD (  12.80  )
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
So check the actual error status from nvme_rdma_setup_ctrl(), and
call nvme_delete_ctrl() instead of calling nvme_rdma_reconnect_or_remove()
if the DNR bit is set.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7d01fb770284..a43e47c93140 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1170,10 +1170,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
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
@@ -1186,6 +1188,11 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.nr_reconnects);
+	if (ret > 0 && (ret & NVME_SC_DNR)) {
+		dev_info(ctrl->ctrl.device, "Removing ctrl...\n");
+		nvme_delete_ctrl(&ctrl->ctrl);
+		return;
+	}
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
@@ -2271,6 +2278,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl =
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
+	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
@@ -2281,9 +2289,15 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_rdma_setup_ctrl(ctrl, false))
+	ret = nvme_rdma_setup_ctrl(ctrl, false);
+	if (ret) {
+		if (ret > 0 && (ret & NVME_SC_DNR)) {
+			dev_info(ctrl->ctrl.device, "Removing ctrl...\n");
+			nvme_delete_ctrl(&ctrl->ctrl);
+			return;
+		}
 		goto out_fail;
-
+	}
 	return;
 
 out_fail:
-- 
2.29.2


