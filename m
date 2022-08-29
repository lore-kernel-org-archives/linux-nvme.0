Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0DEECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/d0bhKZV4UvIfyOf0E3FyLfGJHJsRVJWll1Kiwlh4E=; b=Ernty9CxGFW3Pzj5bQU0aOujI4
	9d8LUxoQW0ihDoWRYH5hthyVrYs+pqQFLjn9SwBaPcuhu8jeqz7pG1TtXsO6mr+6G4Srt+sM+FipP
	Tbg0YXhQ/oFWHUCQweH4gmxY6RUomq+Xx5FR7FAUPB25OTKxaGM7WkVSy4wFGJ6eK4H5AcmrY+DuC
	cEXVhzjqXu0/XYLhAlkiNfZ6RwAf7t5oyJL/L8KAyNLz+Nucm0AZhpPNxVNA4d56rJdbFHYqRpdes
	8AzuETBkdQF4EcTDWAMKkttUjQa9reqL6AD7AAdhjDQ+fRYLq/sKLkSBG1WmIilhB2SNjEb2oshq2
	m4GuMBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaKp-006JeJ-Gp; Mon, 29 Aug 2022 08:41:31 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaIP-006Ho4-3K
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 08:39:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8AE11F96F;
	Mon, 29 Aug 2022 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661762339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/d0bhKZV4UvIfyOf0E3FyLfGJHJsRVJWll1Kiwlh4E=;
	b=ze1BQThcc09SB/SjPO8smVwGXzGz3KfzQC/Q+jRDQAao+g986jEV3WZnuHD8QT1H9SejKw
	yjwvVP5s3VKwUNCvWex0JUE30EE0oZgl31qmyMUJBLhnO0skfi3ifYupQ4v4m8oBFq9gWj
	V4DO2STPXXDWsjVElRyto+9moIoyHEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661762339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/d0bhKZV4UvIfyOf0E3FyLfGJHJsRVJWll1Kiwlh4E=;
	b=u3pWTYlgJ+I8myJT9QWyUC9V266C9kS16XfWF1/VOwwaNwzjom+49cfpdRLr9wV2t5pOg5
	sbAY8b6QRKoJwaDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 982E71352A;
	Mon, 29 Aug 2022 08:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Tt8lJSN7DGOREwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 08:38:59 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
Date: Mon, 29 Aug 2022 10:38:56 +0200
Message-Id: <20220829083856.1850-4-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829083856.1850-1-dwagner@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_013901_556473_E6911750 
X-CRM114-Status: GOOD (  17.32  )
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


