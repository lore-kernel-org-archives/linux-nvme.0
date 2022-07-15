Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2A4CCA47C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9rFis8k65ZTDNNgXLTvztT8EgDSnFd7WCyHqdi9E5uQ=; b=1rATxt01NLe+IDPXgA451MVzEL
	gTshNz5J6xrdNqrGxxTil+OmbRD2gazLzWx3pntVLQrL0GYf7j+3H8dFOvFBKeJ4YUW+aB7dOru16
	qfyA4zidQ1pOTcOU65HWULfFr5HuE1Zqfqln3VNou/jAohDBceKLTsK+3VR4c57JegoLBSkAo0Z89
	onVU/7bbOBgWVc5uEG2uBimgyGQUbIeJ4a3b5WIEXO+zeuSFCKZcgKQBT03mMLvu/Nfi12jr2f/X1
	YVEwtNq3VOzYK35nHVJKAqK0gB+VBvC5VfCHrCkW/2Y56RHCaj2ZNEN5jcfMLVZsXoUDAXjAV84nj
	qWrBp21w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEts-004dNv-CV; Fri, 15 Jul 2022 06:34:08 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEtm-004dLP-4q
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 06:34:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 67E2B1F855;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657866837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rFis8k65ZTDNNgXLTvztT8EgDSnFd7WCyHqdi9E5uQ=;
	b=MBsE6DtTTo/iy0uv2WvECIMpl+RLaUS5EfmCwdrljrjpufPKMznXUM+Z768I4Om4Q+n5vW
	X0ydoirIOBT4Io2tdFN0wsaJU/Gw+h/y2bse80INNbCoFzXHSdpzGRjrTVKlTvIrj0yHs7
	YF6nSeIhW8q7oTEkdHxl+6mzj43LW2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657866837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rFis8k65ZTDNNgXLTvztT8EgDSnFd7WCyHqdi9E5uQ=;
	b=eemejXtrMwu8LAWCUUKHpNP1glGgACQ1CpqoCNYQabGrIEyGGBNekefQ0OAM6QbKFNvwjT
	qj/U36SCqcUoy9AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 607C52C141;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4CC7151988EF; Fri, 15 Jul 2022 08:33:57 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme-tcp: short-circuit connect retries
Date: Fri, 15 Jul 2022 08:33:55 +0200
Message-Id: <20220715063356.134124-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220715063356.134124-1-hare@suse.de>
References: <20220715063356.134124-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_233402_352441_BF9B9A30 
X-CRM114-Status: GOOD (  13.33  )
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
So check the actual error status from nvme_tcp_setup_ctrl(), and
call nvme_delete_ctrl() instead of calling nvme_tcp_reconnect_or_remove()
if the DNR bit is set.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c854e69defb0..a15e3ed02b64 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2157,10 +2157,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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
@@ -2173,6 +2175,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
+	if (ret > 0 && (ret & NVME_SC_DNR)) {
+		dev_info(ctrl->device,
+			 "Removing ctrl...\n");
+		nvme_delete_ctrl(ctrl);
+		return;
+	}
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
@@ -2224,6 +2232,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2235,9 +2244,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret) {
+		if (ret > 0 && (ret & NVME_SC_DNR)) {
+			dev_info(ctrl->device, "Removing ctrl...\n");
+			nvme_delete_ctrl(ctrl);
+			return;
+		}
 		goto out_fail;
-
+	}
 	return;
 
 out_fail:
-- 
2.29.2


