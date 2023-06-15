Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6F1EB64DB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mZXGVDy7NrN3aij1vIxeuv9Sp9HUIfolXkpk9DhWX4=; b=o2S+GtdfDMA+Vk7zUSqPYRhyYM
	yt5ow4XAdpXjPDs+pxmPSryRxCoAXMBOL52BJhzJzXQH2qvt9d3SP+ONLCdAVLBSxWYSHqaBXrsqJ
	QXSur1gprPsgXTgsC+JoQ+L/hQKPecadkH1MUzDfBPQnRgtsHzriavZiAesOQ/pphRk0Fp6+hPwa4
	46UFo7Vs6azHdX/6geAOYaECBTsxDq9ai+mydAzXtJA6YU+i5K1/+HjcPX/hOEmeeQHyQnZmRtNDB
	5YyIh38YzAfdK3JfvSf0GUEDiRzEbl7AjYEvti0gGL204bO5tJAImRT5gpNW+fqRRmg+sXCswyTf/
	wfeN+FmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jWR-00ELPL-3D;
	Thu, 15 Jun 2023 09:44:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9jWP-00ELO3-0K
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 09:44:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35DD11FDDA;
	Thu, 15 Jun 2023 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686822243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mZXGVDy7NrN3aij1vIxeuv9Sp9HUIfolXkpk9DhWX4=;
	b=b+y5foYoqvXUdSjUpwU93sTqKASFJKgL8m8K2JndWDSYrBrpRpxf0esMpGfhwZJiWXEV6s
	1TCDb9t9oo+027hsMgblTh4yOAI0uQVO1BprFm7EswnODB4XnVtHFnNy8qaEJeM1JA6RVh
	/w7atwZqnFnHDTvYpS+Li5b458i7GE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686822243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8mZXGVDy7NrN3aij1vIxeuv9Sp9HUIfolXkpk9DhWX4=;
	b=VucCVkAf0fAnXI367JMpxwO4xeWpbXQ/dSxLfHOAG7WKuqvY0O2rdLikm7yo9kQth/XZTH
	Q6pVV8g4iFeNFBDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 281B313A47;
	Thu, 15 Jun 2023 09:44:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EFiZCWPdimRQWgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 15 Jun 2023 09:44:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 1/2] nvme-fc: Do not wait in vain when unloading module
Date: Thu, 15 Jun 2023 11:43:55 +0200
Message-Id: <20230615094356.14878-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615094356.14878-1-dwagner@suse.de>
References: <20230615094356.14878-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_024405_281391_6E66E39A 
X-CRM114-Status: GOOD (  13.34  )
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

The module unload code will wait for a controller to be delete even when
there is no controller and we wait for completion forever to happen.
Thus only wait for the completion when there is a controller which
needs to be removed.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2ed75923507d..472ed285fd45 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3932,10 +3932,11 @@ static int __init nvme_fc_init_module(void)
 	return ret;
 }
 
-static void
+static bool
 nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 {
 	struct nvme_fc_ctrl *ctrl;
+	bool cleanup = false;
 
 	spin_lock(&rport->lock);
 	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
@@ -3943,21 +3944,28 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
 		nvme_delete_ctrl(&ctrl->ctrl);
+		cleanup = true;
 	}
 	spin_unlock(&rport->lock);
+
+	return cleanup;
 }
 
-static void
+static bool
 nvme_fc_cleanup_for_unload(void)
 {
 	struct nvme_fc_lport *lport;
 	struct nvme_fc_rport *rport;
+	bool cleanup = false;
 
 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
-			nvme_fc_delete_controllers(rport);
+			if (nvme_fc_delete_controllers(rport))
+				cleanup = true;
 		}
 	}
+
+	return cleanup;
 }
 
 static void __exit nvme_fc_exit_module(void)
@@ -3967,10 +3975,8 @@ static void __exit nvme_fc_exit_module(void)
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	nvme_fc_waiting_to_unload = true;
-	if (!list_empty(&nvme_fc_lport_list)) {
-		need_cleanup = true;
-		nvme_fc_cleanup_for_unload();
-	}
+	if (!list_empty(&nvme_fc_lport_list))
+		need_cleanup = nvme_fc_cleanup_for_unload();
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 	if (need_cleanup) {
 		pr_info("%s: waiting for ctlr deletes\n", __func__);
-- 
2.40.1


