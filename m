Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817B5C678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dcEzjrqidIYoo1i5/UqxEkIUKD+qJ0FQ+pqREZoqWwI=; b=odQTj/uqEGaOCgRNYmvAVc7DqJ
	3L1vcLxeSso6I2UUWZ3Nbz/pitzSuX+TxfClXsX0h4KV8Sxtj629wKvwWSP8m+1Zcn6HugKMOWYw7
	ycQFHbUi34ym6+4H/Uq/vKETh1HbKMQo5IIiI9aMcCiEZd4gUI6ZTLrKADFUjj2LBOcp8b9lygwji
	8txMwQRBlfCWdSJr3zgz02wTqUyBraD5XnulPQpnhR71/Oa97CE48wmAJYUAZ3gzttcf/g0s6iO1+
	Qkq6uLqFs61TKfHw15rcZSi7gp6zWHVksEz9TFgOk/3hSrDO//knEjAertKe7/rcSE8WM13Eg1bVc
	BoRcKEEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DZ-00C6BF-6i; Mon, 06 Mar 2023 09:33:17 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D9-00C62c-8P
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D2C921A79;
	Mon,  6 Mar 2023 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcEzjrqidIYoo1i5/UqxEkIUKD+qJ0FQ+pqREZoqWwI=;
	b=KiEofTnl7cIxaGKzy12Ha1tNkFVZ+JNEXHNNbo+UIlg0UAiCgb2STkljftj7bGY3Neq6DL
	OmwtjBlBbiJ+PTnTU/wCD33wTNZhcOrHLDcY37E5kRHdyXmRp3HXSJ1tYp7EfztX9LD2pk
	zd+rXkHKgevtjvEhfW5SVkmkwGCRl64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcEzjrqidIYoo1i5/UqxEkIUKD+qJ0FQ+pqREZoqWwI=;
	b=wkljMW96xtPzwpoLItJcaPxQuqHFed7rxXmlUdAS8+HPvUH/Leg9y1vDbZ8928avDHF+bV
	YY7oOGlJKBGDa3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F78113513;
	Mon,  6 Mar 2023 09:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id L7UZBECzBWR0YAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:48 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 2/6] nvme-rdma: factor rdma specific queue init code out
Date: Mon,  6 Mar 2023 10:32:40 +0100
Message-Id: <20230306093244.20775-3-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013251_509791_4444C13D 
X-CRM114-Status: GOOD (  14.72  )
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

In preparation to move common code from the fabrics driver to fabrics.c,
move the rmda queue specific initialization code into a separate
function.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 65 ++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c26c04c67684..d070d84b204e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -831,15 +831,16 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool new)
+static int nvme_rdma_init_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
-	if (error)
-		return error;
+	if (qid != 0)
+		/* only admin queue needs additional work. */
+		return 0;
+
 
 	ctrl->device = ctrl->queues[0].device;
 	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
@@ -859,6 +860,43 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	 */
 	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
+	if (error)
+		return error;
+
+	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
+	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
+	if (pi_capable)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
+	else
+		ctrl->ctrl.max_integrity_segments = 0;
+
+	return 0;
+}
+
+static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	if (qid != 0)
+		return;
+
+	if (ctrl->async_event_sqe.data) {
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+			sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
+}
+
+static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
+		bool new)
+{
+	int error;
+
+	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
+	if (error)
+		return error;
+
+	error = nvme_rdma_init_queue(&ctrl->ctrl, 0);
 	if (error)
 		goto out_free_queue;
 
@@ -868,7 +906,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 				sizeof(struct nvme_rdma_request) +
 				NVME_RDMA_DATA_SGL_SIZE);
 		if (error)
-			goto out_free_async_qe;
+			goto out_deinit_admin_queue;
 
 	}
 
@@ -880,13 +918,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_stop_queue;
 
-	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
-	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
-	if (pi_capable)
-		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
-	else
-		ctrl->ctrl.max_integrity_segments = 0;
-
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
@@ -904,12 +935,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_remove_admin_tag_set:
 	if (new)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
-out_free_async_qe:
-	if (ctrl->async_event_sqe.data) {
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
-		ctrl->async_event_sqe.data = NULL;
-	}
+out_deinit_admin_queue:
+	nvme_rdma_deinit_queue(&ctrl->ctrl, 0);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 	return error;
-- 
2.39.2


