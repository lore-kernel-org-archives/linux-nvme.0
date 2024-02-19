Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD78DC48BC3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kw0plqfmld08ZN+nRUAJpaFPy2k7TYS+QVcDgtGzVJs=; b=dlxb2E58ndiFPxGNjPmshqrqal
	RFxO0e7l5CaHEHO0gO4hBKaVN8H2NqrJUrkQCirLNQvWzSrsx6SJBmO4X5UqTXdZk6ECKKp7YxFgP
	261abwOVBUakygcHnydv4OfYcj1LJ5cs8TrWUCnosEB92ch+Y/awS9eBQkavySw4gMfyc8kbIiVlT
	07qL+sdouOR0a/WSKWt953QLmh7xvxK3/cVLsdVqJ2uj8zg50Dm0bun2MIcv3DjChvglNf3JGaimm
	39tXKvckRwWq57Ro6UjUEh4O/24TN5sABxHwnL96pBS0Swr9Z0+OHsm1xL6byp6niTnPY6cDwiJ6I
	wDFIPJ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3V9-0000000AajN-0iP9;
	Mon, 19 Feb 2024 13:16:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3Ug-0000000AaQd-2a7Z
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 13:16:05 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C47C1FD13;
	Mon, 19 Feb 2024 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw0plqfmld08ZN+nRUAJpaFPy2k7TYS+QVcDgtGzVJs=;
	b=Nd9Oazgday0UO08JBR2ybLpAzJpQrsEhi8OiMeccEmfa+BMD1lqyEBkf+Ky5aFYOzwBxc4
	P89OlEbNfXONfQTLl0dyIt7NMs7QlxYEVXpDHbBt5tmQKMk6BHGkOHKZb5uOgDdR4h/cjB
	KAWBveB9N2r6iZ23joTU6fP0owYb1Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw0plqfmld08ZN+nRUAJpaFPy2k7TYS+QVcDgtGzVJs=;
	b=U+ArTpo2meRc1JPpK2wsDnYQKQUC+GryXFRr7MUq3pnMfOwSTKPWdaY6WiFPWxntnW2hJG
	4TZMlsfUaKhKjQDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw0plqfmld08ZN+nRUAJpaFPy2k7TYS+QVcDgtGzVJs=;
	b=Nd9Oazgday0UO08JBR2ybLpAzJpQrsEhi8OiMeccEmfa+BMD1lqyEBkf+Ky5aFYOzwBxc4
	P89OlEbNfXONfQTLl0dyIt7NMs7QlxYEVXpDHbBt5tmQKMk6BHGkOHKZb5uOgDdR4h/cjB
	KAWBveB9N2r6iZ23joTU6fP0owYb1Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw0plqfmld08ZN+nRUAJpaFPy2k7TYS+QVcDgtGzVJs=;
	b=U+ArTpo2meRc1JPpK2wsDnYQKQUC+GryXFRr7MUq3pnMfOwSTKPWdaY6WiFPWxntnW2hJG
	4TZMlsfUaKhKjQDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A4E0139C6;
	Mon, 19 Feb 2024 13:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CTrGDHlU02UTAwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:37 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 6/6] nvme-fc: wait for connect attempt to finish
Date: Mon, 19 Feb 2024 14:15:31 +0100
Message-ID: <20240219131531.15134-7-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240219131531.15134-1-dwagner@suse.de>
References: <20240219131531.15134-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.89 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[47.55%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_051538_851483_F545B5ED 
X-CRM114-Status: GOOD (  15.35  )
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

The FC transport offloads the connect attempt to a workqueue. Thus
userspace is not able to wait on the result.

Thus, allow userspace to wait on the connect result by honnering the
'connect_sync' connect option.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7627d10a5812..744f71a71823 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -169,6 +169,7 @@ struct nvme_fc_ctrl {
 
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
+	struct completion	connect_completion;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -803,6 +804,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Couldn't schedule reset.\n",
 				ctrl->cnum);
+			complete(&ctrl->connect_completion);
 			nvme_fc_ctrl_put(ctrl);
 		}
 		break;
@@ -871,6 +873,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
+			complete(&ctrl->connect_completion);
 			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
@@ -3326,6 +3329,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 }
@@ -3385,10 +3389,12 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
+	else {
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: controller connect complete\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
+	}
 }
 
 
@@ -3494,6 +3500,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	init_completion(&ctrl->connect_completion);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
@@ -3541,6 +3548,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	if (opts->connect_sync)
+		nvme_fc_ctrl_get(ctrl);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
@@ -3557,6 +3567,19 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	flush_delayed_work(&ctrl->connect_work);
 
+	if (opts->connect_sync) {
+		enum nvme_ctrl_state state;
+
+		wait_for_completion(&ctrl->connect_completion);
+		state = nvme_ctrl_state(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
+
+		if (state != NVME_CTRL_LIVE) {
+			/* Cleanup is handled by the connect state machine */
+			return ERR_PTR(-EIO);
+		}
+	}
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
 		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
@@ -3913,6 +3936,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
-- 
2.43.1


