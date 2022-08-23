Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E9C32774
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SERY8Y+TrKxexWQk9zRT3q7tF6Qs9GEku0pNJzklff0=; b=zlkDj3oCfB3A/jZv+KH5knQ7vA
	rnHtGOWKYh8ioD58KrgdpDJfGMYyuRGilKsP4Da4bTG0ZsMlWqdISpFPs8wyquUN/Pocu0bH+aOUu
	10/A484NfjVWBlEFZ7DL7o178kc/d3MEutcwkgJ9HRVvQ7UhBfP5Ot55XDkmveKEI9psbFhKDFN9J
	SBHN0aQkrrs9k9xBljX+wRFdJTd2MKbVQ1r+FEu8yt2VE0AwX3yco0SUJzffBIIdrGLIrM9FTHPEp
	BP7Iu0NfeFxxVebMsi1V/bPOkfkOkY68aMR8xC+Dxdjp0F9M29K6Ha/2UWJlx1bozBO4D4fygXmvo
	Wj/I/Wfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQObU-003ZmR-MG; Tue, 23 Aug 2022 07:45:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOar-003ZSc-Cv
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 07:45:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BEED34000;
	Tue, 23 Aug 2022 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661240697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SERY8Y+TrKxexWQk9zRT3q7tF6Qs9GEku0pNJzklff0=;
	b=kgEKaHtBQm2Dr9XfmTYWlsiti38WfOC/oIQo1uJhHZzwmQBdjl5p/0yVhZOUjrTH8PRirv
	LlupJ6h7tdZubT7knBER9RIqJn0OiZuTq0FEf5UEtXXUbASgRVUodFN9Te1vDdfVI7LPA+
	ZW+qbvABSfJbXuFX0NqRWDRPKjhHEbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661240697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SERY8Y+TrKxexWQk9zRT3q7tF6Qs9GEku0pNJzklff0=;
	b=OdvTu1GLfNWon5eFF+uOW2Lz2tVZef6MncErnrshk/UcWcokQvmWcpQcj9RKRPR6/2ciUF
	H2W/OKu8Q72c58Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6843A13AB7;
	Tue, 23 Aug 2022 07:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nNM6GXmFBGM5QwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:44:57 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
Date: Tue, 23 Aug 2022 09:44:51 +0200
Message-Id: <20220823074451.12170-4-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823074451.12170-1-dwagner@suse.de>
References: <20220823074451.12170-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_004501_703722_072DA182 
X-CRM114-Status: GOOD (  17.30  )
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
index 3100643be299..386674d7c0e6 100644
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
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.37.1


