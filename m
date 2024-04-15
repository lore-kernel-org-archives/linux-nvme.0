Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05401C04FF8
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 12:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XH5W2RPXIfpqPAl1vqG4VvbwARd9ivC5YIrBekBlQ5E=; b=MO546Oen+uoKdVij/SJTQaguh9
	/ld4WMGFHYYVie/lhV8AUrPQkv3rwG05ibLjhDBuwQRgtziBKDeXStVnY36opgSzeOI9kaZAWvOQn
	XchNEmFWSKb/SOVcgScbNWhjAjoM1mRsK672gnUI6rtnyxKLrtykLC727ePfulRYY6YgDPQO253At
	WXP9xX4WJoUg2Vb5xFPkM+zga2Q6nllhauEkNBLVSkJfvKCbsn3jVlfx2HtkhourxuFERmZWDfpgT
	AJ7hAlnmFzreNXGdfugSvVTNPpW01ou3GP4T/qh690SBIXTHKpEBpWe+byx7Fo1qDu2WuxOvENZGH
	uGHXPdkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfX-00000008En8-14in;
	Mon, 15 Apr 2024 12:42:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfI-00000008EeK-0GHu
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 12:42:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BB805CF8B;
	Mon, 15 Apr 2024 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XH5W2RPXIfpqPAl1vqG4VvbwARd9ivC5YIrBekBlQ5E=;
	b=rhhVCCPtPbQ1Y9UO+16F2pkn5BrWAXPgHjpYtCtK9OscMlRZeb5qWmaw/YWkG3UG8/Ruhh
	GLdOgUc3d0k5E5vI+J0EI6qy3sGWUIfXJNJGyF0A3EyYbHy1TGfSjNEwTTybjIQPysBbTa
	gGMthF2KhANoDbmn1+WToNRhnLmFTfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XH5W2RPXIfpqPAl1vqG4VvbwARd9ivC5YIrBekBlQ5E=;
	b=WIqGLSgoPpGHyWffIpQzjljSQWZSAtEkZVyxWaZv5mDrYrmHxgJpae0BFd7sBEotEGH5Gu
	d2Kfbwq/j66xMmDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XH5W2RPXIfpqPAl1vqG4VvbwARd9ivC5YIrBekBlQ5E=;
	b=rhhVCCPtPbQ1Y9UO+16F2pkn5BrWAXPgHjpYtCtK9OscMlRZeb5qWmaw/YWkG3UG8/Ruhh
	GLdOgUc3d0k5E5vI+J0EI6qy3sGWUIfXJNJGyF0A3EyYbHy1TGfSjNEwTTybjIQPysBbTa
	gGMthF2KhANoDbmn1+WToNRhnLmFTfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XH5W2RPXIfpqPAl1vqG4VvbwARd9ivC5YIrBekBlQ5E=;
	b=WIqGLSgoPpGHyWffIpQzjljSQWZSAtEkZVyxWaZv5mDrYrmHxgJpae0BFd7sBEotEGH5Gu
	d2Kfbwq/j66xMmDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BF81386E;
	Mon, 15 Apr 2024 12:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCaOELIgHWY2AwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 5/5] nvme-fabrics: handle transient auth failures
Date: Mon, 15 Apr 2024 14:42:20 +0200
Message-ID: <20240415124220.5433-6-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415124220.5433-1-dwagner@suse.de>
References: <20240415124220.5433-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_054228_696723_6A511217 
X-CRM114-Status: GOOD (  20.09  )
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

Retry authentication a couple of times to avoid error out on transient
errors. E.g. if a new key is deployed on the host and the target. At the
same time the connection drops. The host might use the wrong key to
reconnect.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/auth.c    |  4 ++--
 drivers/nvme/host/fabrics.c | 10 +++++++++-
 drivers/nvme/host/fc.c      |  2 ++
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    |  1 +
 drivers/nvme/host/tcp.c     |  1 +
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a264b3ae078b..368dcc6ee11b 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -797,7 +797,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
 	if (ret) {
 		chap->status = ret;
-		chap->error = -ECONNREFUSED;
+		chap->error = -EKEYREJECTED;
 		return;
 	}
 
@@ -818,7 +818,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
 		/* Controller authentication failed */
-		chap->error = -ECONNREFUSED;
+		chap->error = -EKEYREJECTED;
 		goto fail2;
 	}
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d9a73b1b41c4..6dfa45dce232 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -573,8 +573,16 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
  */
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
 {
-	if (status < 0)
+	if (status < 0) {
+		/*
+		 * authentication errors can be transient, thus retry a couple
+		 * of times before giving up.
+		 */
+		if (status == -EKEYREJECTED &&
+		    ++ctrl->nr_auth_retries < 3)
+			return true;
 		return false;
+	}
 	else if (status > 0 && (status & NVME_SC_DNR))
 		return false;
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f0b081332749..a22d2af18553 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3176,6 +3176,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 
 	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->ctrl.nr_auth_retries = 0;
 
 	if (changed)
 		nvme_start_ctrl(&ctrl->ctrl);
@@ -3491,6 +3492,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->ctrl.nr_auth_retries = 0;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b8904a476b8..a9af20f25405 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -382,6 +382,7 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	int nr_auth_retries;
 	unsigned long flags;
 	struct nvmf_ctrl_options *opts;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 821ab3e0fd3b..f5b3201a11b5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1117,6 +1117,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 			ctrl->ctrl.nr_reconnects);
 
 	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->ctrl.nr_auth_retries = 0;
 
 	return;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e0c33323320..45270c626c87 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2266,6 +2266,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 			ctrl->nr_reconnects);
 
 	ctrl->nr_reconnects = 0;
+	ctrl->nr_auth_retries = 0;
 
 	return;
 
-- 
2.44.0


