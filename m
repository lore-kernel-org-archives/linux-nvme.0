Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C8C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=; b=zvZHt6L/A+Nw0HDBjt0C2h78+U
	LFVm+aafb1xbUGMnk0O1Fg0S/kOB2F5D19MkLDborsShE0jVfHnakw+v7FjoeejsYY+aYek86Jh4q
	qr8Ak26zBiQ8h3cQfgyNqWlZpOCdB2fwSPCUm+IfqzeakfJk0psN6uzuyfIg00Oo1Yt6Ce0353aKI
	3fz72xkejYOOmrwhyeSZBW5ytY/H0O8nonI+Uzq33qm8RQpUKHgnUd3iKA/GPGHNzbCh2dVMIHzJr
	D62xTRsDprBqwu4gtL3hWrtIs3OEScmcbJ9Jb3MQBfvS/xPZA/ijpcEBgL3tUO+2U+BfEo6BNePhn
	Wbn+w/Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmf-00HVWh-1K;
	Tue, 11 Apr 2023 12:07:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmCmZ-00HVSd-1H
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 12:07:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4771021A57;
	Tue, 11 Apr 2023 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681214847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=;
	b=pU+/k6puJ9CXqLMxQwOWjGVot7yyvwTGO13IGi0suYh4uctbyvV0PrVhjza25PTbBVruXW
	CIj/Lkaar+o0vAa0u0uXHdtNhP0ELiZw1ZtmdsTUpZcRk974yTz/f/uahCS18t+GR6/Z+m
	R7QcnFGspuP/1xIhkkxpFo2/1RE1070=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681214847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=;
	b=XgbpKbWq5NHqKNKUYWM0tTgNTJO9U5zdgEzi7EcH0RU5a5d2N93wXFIVe2QXFo8K+/RI6J
	7FFMiuGKVNTBgjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31EBD13638;
	Tue, 11 Apr 2023 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id t84tDH9NNWR9BgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 12:07:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/4] nvmet-fc: Do not wait in vain when unloading module
Date: Tue, 11 Apr 2023 14:07:17 +0200
Message-Id: <20230411120718.14477-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
References: <20230411120718.14477-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_050731_582007_0A2C8288 
X-CRM114-Status: GOOD (  12.32  )
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

When there is no controller to be deleted the module unload path will
still wait on the nvme_fc_unload_proceed completion. Because this will
will never happen the caller will hang forever.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 456ee42a6133..df85cf93742b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3933,10 +3933,11 @@ static int __init nvme_fc_init_module(void)
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
@@ -3944,21 +3945,28 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
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
@@ -3968,10 +3976,8 @@ static void __exit nvme_fc_exit_module(void)
 
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
2.40.0


