Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6675CECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JR7pOGK4SXpMAtNcirMMR/4OWrkmPm1l4NmZlA+MD6k=; b=P9ag7U+A3cmxHGV+RsvzrtKHvC
	pTxwrtulvlL74HC8g35mp3M2pEafo5YqLAwMSlbYqNx7DCronb5kqqwoxoK5N1l1veYJoRzzIZOok
	+ZuhXqKKA+FVaonkDsCHNXdEm+hflsgNgI6FChsPzZoDunQTP9BxazaIsJAcG8GtSKH709KsZyDFS
	NWkdpr6//2TdsAUmPJ3RX+cHw6tKxB0OD63i1Dhut8xVCyZ3d8oxyXysbVly8K3Xp5/tiLYf7vhMj
	xVg9sNdyiP4Fk0bWIPA9euQUjNRy+ioldPX4/FZtuEM3Feuh9s7gFBTqGoUJAKUj/iVwryHGpUWEw
	2yHhrXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4v-006jbD-Da; Mon, 29 Aug 2022 09:29:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSb4Y-006jNc-TQ
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:28:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7C691F98F;
	Mon, 29 Aug 2022 09:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661765324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR7pOGK4SXpMAtNcirMMR/4OWrkmPm1l4NmZlA+MD6k=;
	b=cbENMPinQaJvNuXn4jnkW9iFaMpyWuYUm87kwmFyhnMxVn5HS8dOhlvmS+0Rrbh5TeQXsL
	7/BGoN/RPV0N5ZnBPYAnA4cH933VkJWCRCfbaO9d1Y3Y8XaKeKwH9yEp5boWl8Z+6yHOLw
	yUOnznB6OAgqrZcxrUXwQUOpcYr5njE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661765324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR7pOGK4SXpMAtNcirMMR/4OWrkmPm1l4NmZlA+MD6k=;
	b=wXyH3YeS/KiFcBHXA5M/xXf3COEiXNvjlbZ3c9H6n1+pIYtAqgtEB/PMvoIAkWPpWbyG8f
	4bNMTalEHdX+3iDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B97EE1352A;
	Mon, 29 Aug 2022 09:28:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bNtKLcyGDGP1KQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 09:28:44 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chao Leng <lengchao@huawei.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 2/3] nvme-tcp: Handle number of queue changes
Date: Mon, 29 Aug 2022 11:28:40 +0200
Message-Id: <20220829092841.14244-3-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829092841.14244-1-dwagner@suse.de>
References: <20220829092841.14244-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022847_128903_F91266C7 
X-CRM114-Status: GOOD (  16.77  )
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
 drivers/nvme/host/tcp.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..d97b0b6369b5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1762,11 +1762,12 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
 		nvme_tcp_stop_queue(ctrl, i);
 }
 
-static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
+				    int first, int last)
 {
 	int i, ret;
 
-	for (i = 1; i < ctrl->queue_count; i++) {
+	for (i = first; i < last; i++) {
 		ret = nvme_tcp_start_queue(ctrl, i);
 		if (ret)
 			goto out_stop_queues;
@@ -1775,7 +1776,7 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
 	return 0;
 
 out_stop_queues:
-	for (i--; i >= 1; i--)
+	for (i--; i >= first; i--)
 		nvme_tcp_stop_queue(ctrl, i);
 	return ret;
 }
@@ -1901,7 +1902,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
-	int ret;
+	int ret, nr_queues;
 
 	ret = nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
@@ -1917,7 +1918,13 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			goto out_free_tag_set;
 	}
 
-	ret = nvme_tcp_start_io_queues(ctrl);
+	/*
+	 * Only start IO queues for which we have allocated the tagset
+	 * and limitted it to the available queues. On reconnects, the
+	 * queue number might have changed.
+	 */
+	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
+	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
 
@@ -1937,6 +1944,15 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		nvme_unfreeze(ctrl);
 	}
 
+	/*
+	 * If the number of queues has increased (reconnect case)
+	 * start all new queues now.
+	 */
+	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
+				       ctrl->tagset->nr_hw_queues + 1);
+	if (ret)
+		goto out_wait_freeze_timed_out;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.37.2


