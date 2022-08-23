Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D979C32774
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlcK2ApRX5BK59lgF/EPGY7RMCG1v6lekw9/g16o9o4=; b=Bhl6oX4XnCMp10QkqodLmVbywI
	lcsi3zhpMUgr2IOvnx/QqRbX/AxYF3Q3hzrSe/CIt3qYTb2hTiEAn2lRiS1Eh2bSAYtnLURyC3/Am
	obtHmB5Kvdoa7nI4psTM5MIKfDnkJKzd9KU7Rsw99x7K0Oekvg/aW/HZKbr5PWIAU24TZkDGWBWM2
	+hbu1LcRN8P+dM0/bNfox+aErwzhGKA+NB29Xm4yq1/DuFTm0CBot/tmMJQWg8Ssma9CmSEAJ8fXH
	yczle/5Ubiy5+h3qnADmNycj5Gnx1+bG/YqXKa5PEhIvnU5KyWSBIDSvAGVpqimRcsvDJw/z7GwW9
	DzYuv7Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQObP-003Zhq-17; Tue, 23 Aug 2022 07:45:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQOar-003ZSC-9O
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 07:45:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF8B333FF9;
	Tue, 23 Aug 2022 07:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661240696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlcK2ApRX5BK59lgF/EPGY7RMCG1v6lekw9/g16o9o4=;
	b=aEk9pcJa+hkDBmvTWBpet5Rg0aQFOxjd5HQIfV3+8uQZOrM2gJRExRu1Ps9egZfmOXQKiZ
	l7njlFYJxeidMjUnJS3+ugg5Tn2192/q1RKJq/rjT5wkRB+hBDXl25Q3GCOelmvi4m05Bq
	ibyW3psagCYz0LwKMoKTCwki4JWujII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661240696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlcK2ApRX5BK59lgF/EPGY7RMCG1v6lekw9/g16o9o4=;
	b=CP5cxbVPLnWqIAg7+rotJfE0FCuZijPRaqMtqAdcIj+9QfRHKD8X7o+vyF5KuLwvPL9c/p
	JSMHicUzbNBO3hDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C199713AB7;
	Tue, 23 Aug 2022 07:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lPcTL3iFBGM2QwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 23 Aug 2022 07:44:56 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/3] nvme-tcp: Handle number of queue changes
Date: Tue, 23 Aug 2022 09:44:50 +0200
Message-Id: <20220823074451.12170-3-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823074451.12170-1-dwagner@suse.de>
References: <20220823074451.12170-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_004501_557296_50E7776C 
X-CRM114-Status: GOOD (  18.87  )
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
 drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 044da18c06f5..93206215e381 100644
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
@@ -1899,31 +1900,38 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 	nvme_tcp_free_io_queues(ctrl);
 }
 
-static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+static int nvme_tcp_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
 {
-	int ret;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	int ret, nr_queues;
 
-	ret = nvme_tcp_alloc_io_queues(ctrl);
+	ret = nvme_tcp_alloc_io_queues(nctrl);
 	if (ret)
 		return ret;
 
 	if (new) {
-		ret = nvme_tcp_alloc_tag_set(ctrl);
+		ret = nvme_tcp_alloc_tag_set(nctrl);
 		if (ret)
 			goto out_free_io_queues;
 
-		ret = nvme_ctrl_init_connect_q(ctrl);
+		ret = nvme_ctrl_init_connect_q(nctrl);
 		if (ret)
 			goto out_free_tag_set;
 	}
 
-	ret = nvme_tcp_start_io_queues(ctrl);
+	/*
+	 * Only start IO queues for which we have allocated the tagset
+	 * and limitted it to the available queues. On reconnects, the
+	 * queue number might have changed.
+	 */
+	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);
+	ret = nvme_tcp_start_io_queues(nctrl, 1, nr_queues);
 	if (ret)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
-		nvme_start_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+		nvme_start_queues(nctrl);
+		if (!nvme_wait_freeze_timeout(nctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
 			 * be stuck.  Fail the controller initialization just
@@ -1932,26 +1940,35 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = -ENODEV;
 			goto out_wait_freeze_timed_out;
 		}
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
+		blk_mq_update_nr_hw_queues(nctrl->tagset,
+			nctrl->queue_count - 1);
+		nvme_unfreeze(nctrl);
 	}
 
+	/*
+	 * If the number of queues has increased (reconnect case)
+	 * start all new queues now.
+	 */
+	ret = nvme_tcp_start_io_queues(nctrl, nr_queues,
+				       ctrl->tag_set.nr_hw_queues + 1);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-	nvme_stop_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
+	nvme_stop_queues(nctrl);
+	nvme_sync_io_queues(nctrl);
+	nvme_tcp_stop_io_queues(nctrl);
 out_cleanup_connect_q:
-	nvme_cancel_tagset(ctrl);
+	nvme_cancel_tagset(nctrl);
 	if (new)
-		blk_mq_destroy_queue(ctrl->connect_q);
+		blk_mq_destroy_queue(nctrl->connect_q);
 out_free_tag_set:
 	if (new)
-		blk_mq_free_tag_set(ctrl->tagset);
+		blk_mq_free_tag_set(nctrl->tagset);
 out_free_io_queues:
-	nvme_tcp_free_io_queues(ctrl);
+	nvme_tcp_free_io_queues(nctrl);
 	return ret;
 }
 
-- 
2.37.1


