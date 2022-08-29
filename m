Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB5EECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J636swYTuL0oPFTIsbKr2qt1UZMSAd7cNmMp2qolZcs=; b=zadyXn1KdjnElmbY3/vYkA0vdD
	JTiWmF40b8WM8+ktJhLfzAjzCBneQFt4rN6M+jFz1owOrLboHj/3cHqwZkwqnUcILPZ6Ip308HEvF
	RMvy3+GClCY1fGOltY44+PYFG6PHF6+QGFIy75jzzTn0FEZM9jE1h/5fIA6vxBj+a3e5JNNVS9/N2
	fXJN9xrQtgd2fh3WjISL22BraazJ4t8qsXc/zado+5zesItU473lcwS+ZlWqNCu3252SmM/UKsr9d
	vVbW8KtZ0UxDZZz2adw/5tEWqCJZN8ysfkEFmfIs/U7iCTcsEO7x4P7PVSKil7D5yIZCSyC75/jff
	UZlSvPvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4p-006jXU-SO; Mon, 29 Aug 2022 09:29:03 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4Y-006jO0-Kx
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:28:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F6AF33698;
	Mon, 29 Aug 2022 09:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661765325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J636swYTuL0oPFTIsbKr2qt1UZMSAd7cNmMp2qolZcs=;
	b=zcIMhS7cG12aqoqxJBLpq02tc8wEWVJa9rFH4PDX/IaC1RmboPTAZfsvwwSYvPsBnt9IfY
	OSWIgZe9QBFJNV9cRIG+kRT5Mo1bERLVeKXG+Vn0/wU0RbEKFwz8TVYNSmwt8hbqyrCPhg
	vABDzI0Ij29hgAjsgICtpxuYwOVoypo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661765325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J636swYTuL0oPFTIsbKr2qt1UZMSAd7cNmMp2qolZcs=;
	b=ZbFnEUAibSlykRML8lKq2BhIc2/9MKUqA1yCEbWGf4jT8bUJqOAEHfA00lQmdC8FbhGloG
	C34YoYIaOP4VxICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 555361352A;
	Mon, 29 Aug 2022 09:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id q4TRFM2GDGP3KQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 09:28:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 3/3] nvme-rdma: Handle number of queue changes
Date: Mon, 29 Aug 2022 11:28:41 +0200
Message-Id: <20220829092841.14244-4-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829092841.14244-1-dwagner@suse.de>
References: <20220829092841.14244-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022846_852725_14BD423A 
X-CRM114-Status: GOOD (  17.31  )
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

On reconnect, the number of queues might have changed.

In the case where we have more queues available than previously we try
to access queues which are not initialized yet.

The other case where we have less queues than previously, the
connection attempt will fail because the target doesn't support the
old number of queues and we end up in a reconnect loop.

Thus, only start queues which are currently present in the tagset
limited by the number of available queues. Then we update the tagset
and we can start any new queue.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3100643be299..0d1d29e644d9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -696,11 +696,12 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
+				     int first, int last)
 {
 	int i, ret = 0;
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
+	for (i = first; i < last; i++) {
 		ret = nvme_rdma_start_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
@@ -709,7 +710,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return 0;
 
 out_stop_queues:
-	for (i--; i >= 1; i--)
+	for (i--; i >= first; i--)
 		nvme_rdma_stop_queue(&ctrl->queues[i]);
 	return ret;
 }
@@ -964,7 +965,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
-	int ret;
+	int ret, nr_queues;
 
 	ret = nvme_rdma_alloc_io_queues(ctrl);
 	if (ret)
@@ -980,7 +981,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 	}
 
-	ret = nvme_rdma_start_io_queues(ctrl);
+	/*
+	 * Only start IO queues for which we have allocated the tagset
+	 * and limitted it to the available queues. On reconnects, the
+	 * queue number might have changed.
+	 */
+	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);
+	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
 
@@ -1000,6 +1007,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	/*
+	 * If the number of queues has increased (reconnect case)
+	 * start all new queues now.
+	 */
+	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
+					ctrl->tag_set.nr_hw_queues + 1);
+	if (ret)
+		goto out_wait_freeze_timed_out;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.37.2


