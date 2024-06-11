Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4675C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 19:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nTg7EHHJKtJSL0bKo1ldYUnj2JTlqGcleyKe5yLGg0k=; b=Aw23th1bwWfwjcXyhX0un4fpN0
	T7fmPVYzgw4MuZOFwfDTi0wyL+Ix57zPK5fTML8zntaK5eXyt4iLrL7A0YF0Ndkfu6kRrJTaJ/y2K
	tMx0gCCUzUv5JN9hW/D9lqGeS2c+7Pz8oADJ0BA2equ2UgS3/O9BU1B1k59CRshktvpElBsiBxYda
	p0z5nOLV7XJjDte5PNAyWS1uOeeLGnTrp9BnA0a8GiYaNRAh31RrtnyiKCsrNsKXgY6LALEMKYyvP
	qb6nYFhXkq0cGFGeZ+UuaRSJn8r4hXdYNtjPyxAh8EYRmZ+hmPkzrK4AC1UAxiT/5ahWHimU+3g15
	+WYzA0Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6wd-00000009xl2-0e4d;
	Tue, 11 Jun 2024 19:14:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH6wX-00000009xiM-0PZk
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 19:14:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D4FF224A0;
	Tue, 11 Jun 2024 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718133243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTg7EHHJKtJSL0bKo1ldYUnj2JTlqGcleyKe5yLGg0k=;
	b=2Vt+t6GqKB0NGVHvbC8q8ZtnZAdc+gvNzHb9M3KCvE677yZNrOvatBvFWjpcKmESyDBNyO
	GsHazWeyvBZuULk/dFZbWdAIzRv+zsYAG2O7lfnbX9wNSJBO8Bxex8jmxU60IjfYqfukTe
	vrrCn5tRCLiva03slox/YLmGozmhdmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718133243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTg7EHHJKtJSL0bKo1ldYUnj2JTlqGcleyKe5yLGg0k=;
	b=CtSFV8bD2E5KsXkrPVg6srW0KFJS9vzeiLWMyeeY83m4Jy90dwWD88x1MIc9PI3RRtnoTL
	GagmtBEHtK+WJXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718133243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTg7EHHJKtJSL0bKo1ldYUnj2JTlqGcleyKe5yLGg0k=;
	b=2Vt+t6GqKB0NGVHvbC8q8ZtnZAdc+gvNzHb9M3KCvE677yZNrOvatBvFWjpcKmESyDBNyO
	GsHazWeyvBZuULk/dFZbWdAIzRv+zsYAG2O7lfnbX9wNSJBO8Bxex8jmxU60IjfYqfukTe
	vrrCn5tRCLiva03slox/YLmGozmhdmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718133243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTg7EHHJKtJSL0bKo1ldYUnj2JTlqGcleyKe5yLGg0k=;
	b=CtSFV8bD2E5KsXkrPVg6srW0KFJS9vzeiLWMyeeY83m4Jy90dwWD88x1MIc9PI3RRtnoTL
	GagmtBEHtK+WJXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D68C137DF;
	Tue, 11 Jun 2024 19:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PRVjBvuhaGaDHgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 11 Jun 2024 19:14:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with nvme_fc_create_association
Date: Tue, 11 Jun 2024 21:06:47 +0200
Message-ID: <20240611190647.11856-3-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611190647.11856-1-dwagner@suse.de>
References: <20240611190647.11856-1-dwagner@suse.de>
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_121405_313437_0B680D74 
X-CRM114-Status: GOOD (  17.83  )
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

We are racing with nvme_fc_create_association here. We wouldn't have to
do anything in nvme_fc_ctrl_connectivity_loss IF
nvme_fc_create_association would reliable detect that the setup failed.
In reality, nvme_fc_create_association is able to return success even
though some of the operation fail during the setup (and this is even on
purpose):

 nvme nvme10: NVME-FC{10}: create association : ...
 nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
 nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
 nvme nvme10: Could not set queue count (880)
 nvme nvme10: Failed to configure AEN (cfg 900)
 nvme nvme10: NVME-FC{10}: controller connect complete

Thus we transition to the CONNECTED state and don't start the reconnect
loop. Thus we should unconditionally schedule a reset.

If a reset has already been schedule it's either a no-op or we observe
back to back reset. But we can't really distinguish between host side
double scheduled reset work or a connectivity loss event right after a
reset. Thus we have to live with this corner case. The system will enter
the correct state eventually.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6ff28d59b169..10dc456928a2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -169,6 +169,7 @@ struct nvme_fc_ctrl {
 
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
+	struct work_struct	fc_reset_work;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -779,6 +780,14 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
 	return 0;
 }
 
+static void nvme_fc_defer_reset_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *ctrl =
+		container_of(work, struct nvme_fc_ctrl, fc_reset_work);
+
+	nvme_reset_ctrl(&ctrl->ctrl);
+}
+
 static void
 nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 {
@@ -806,12 +815,20 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 
 	case NVME_CTRL_CONNECTING:
 		/*
-		 * The association has already been terminated and the
-		 * controller is attempting reconnects.  No need to do anything
-		 * futher.  Reconnects will be attempted until either the
+		 * We are racing with nvme_fc_create_association here. Ensure we
+		 * never lose the connectivity loss event and unconditionally
+		 * schedule a reset.
+		 *
+		 * The reconnects will be attempted until either the
 		 * ctlr_loss_tmo (max_retries * connect_delay) expires or the
 		 * remoteport's dev_loss_tmo expires.
+		 *
+		 * We can't sleep in this context (e.g flush_delayed_work) but
+		 * we should execute reset after the connect work item has
+		 * finished. Thus defer the reset trigger to the nvme_wq where
+		 * the connect is executed.
 		 */
+		queue_work(nvme_wq, &ctrl->fc_reset_work);
 		break;
 
 	case NVME_CTRL_RESETTING:
@@ -3505,6 +3522,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
+	INIT_WORK(&ctrl->fc_reset_work, nvme_fc_defer_reset_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
-- 
2.45.2


