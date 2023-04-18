Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A398C77B7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=; b=XwiKqXPOYO+MfboTKRMWzhl2tA
	EII4g9SRMShrdJvqyLmAPErRt8/gCLPo7JX1j/oEu30j21kpHfczMJPLjmVCcpLSepyQOf7BXmN00
	nrHYiNATFp5zvdWccCgluN3FF8PQ/KDZfJiXCKaevXk5BzCGbUls1a7ydxOjMq8fQ3xrFi4ARMo52
	//brTLm7oZPATiVgeustQaNCxt0kxU2clHye7NSUKt39qStRHUUq12r+0hgwwfJOM1cNqOmplKa3t
	4Tpp5jKWlp1RloiMy4LAB26pkFuEHK/7qH5mpMukX4jHdOKRjME1M/10CW393Mbo5Y4gzOLdsL8A6
	deAdiE3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyR-002DKm-1K;
	Tue, 18 Apr 2023 13:02:19 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pokyM-002DHg-0b
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 13:02:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDDE421A2D;
	Tue, 18 Apr 2023 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681822931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=;
	b=isCoNgSeX9+Ig6d3AdavrjnibyFc1etqEv8AnTGoPWNJMlloj88Dln8YSChYd4/X7eUjN2
	1qSxiF4vUM2Pwle34krmy8bVMqgDvkizeZ4woDXcyyhjwDbwMuFyQbBPo+PAHkBOnzpDir
	KTcopCyo7LKuOPwJZih2xb0j9IpkzmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681822931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj98SlaTXv/d9epXIQknuybCui1NnFvBmrWtCwostC0=;
	b=OckJsSpdt8IvRazGJAJ/qYfYa20L4GLkjMkB7tnEDDW7PHg6fUyBLyg4wX+OB+d1puFJ3G
	OZRd7Jt4/4aURACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF831139CC;
	Tue, 18 Apr 2023 13:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KxvXKtOUPmSQJwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:02:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 3/4] nvmet-fc: Do not wait in vain when unloading module
Date: Tue, 18 Apr 2023 15:01:58 +0200
Message-Id: <20230418130159.11075-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_060214_387974_BEE673DC 
X-CRM114-Status: GOOD (  12.40  )
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


