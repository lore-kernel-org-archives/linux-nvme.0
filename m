Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D377EEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W2dcMlco4IaX1eYG+QaSwRA5SCo5zMhvqpPQKpXYteE=; b=IClNmExbdxd9z11YeXAIxlaPs0
	EQzOBAVD7B9k2Lmsy+V8wEprZmi1ifnw1Fsxtz1f+Zq/CJWawZni5hGIrRWLuZlr8iB1rEsT2NCbP
	euoGb7OlDFWhypp/nVxyABsNJrXKTbv5EOLOkbfJRyFBVLIcvEhzGtjAZC8ViCREDAGQXts2z+1JV
	m8OhXnWeeO84Gu7SXBgIhLgKP5S+658udLKiXXkYTRn1QkgxieK4A1cPLY25bMWXbhvKBk8pvpdQn
	vD1YKBmGG9wTlNFJMlwtEtKgJWF9UkxIexFxz7IIRP2mxLiLg4nmgFC3pzT8oFM38amlAPCoUFZMW
	6dWlsY9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbY1-00BPNH-0D;
	Tue, 20 Jun 2023 13:37:29 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbXv-00BPI6-0R
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:37:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E005C1F88F;
	Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687268241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dcMlco4IaX1eYG+QaSwRA5SCo5zMhvqpPQKpXYteE=;
	b=G3zNI7xIRS4BGhdLruB4zto97XoVHG4t1yJ94Ic72x1llG3iXjlJNYS1Cl4P64FTeOnkP1
	ba5PtHYsZL+o2My5IJ0xUsCq06E81go5qx4vB+HiRl3KDWxi/aCBIejWBHTgMX8l/y/z/N
	kj1SzfeYkb5jqFLobujjdCNlQbr5DIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687268241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2dcMlco4IaX1eYG+QaSwRA5SCo5zMhvqpPQKpXYteE=;
	b=QPyaU8DDuLSEf3IezpMohcmGhrB/Vqfa3ck8yQeA3TXeuhIkkmZazyA9Gu3LGLPS6nhgEj
	PQq9qfg1vqVl2dDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1FC8133A9;
	Tue, 20 Jun 2023 13:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GA0+M5GrkWTKPQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 13:37:21 +0000
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
Subject: [PATCH v2 5/5] nvme-fc: do no free ctrl opts
Date: Tue, 20 Jun 2023 15:37:11 +0200
Message-ID: <20230620133711.22840-6-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620133711.22840-1-dwagner@suse.de>
References: <20230620133711.22840-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_063723_321097_E8F5CEE3 
X-CRM114-Status: GOOD (  13.09  )
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

Since the initial additional of the FC transport
e399441de911 ("nvme-fabrics: Add host support for FC transport"), the
transport also freed the options. Since nvme_free_ctrl() is freeing the
options too commit de41447aac03 ("nvme-fc: avoid memory corruption
caused by calling nvmf_free_options() twice") was added to avoid double
frees.

With the change to make the initial connection attempt synchronous
again, the life time of all object is known also in the error case. All
resources will be freed in the same context.

The FC transport should not free the options as the generic auth code is
relying to be able to read the options even in the shutdown path (see
nvme_auth_free is calling ctrl_max_dhchaps which relies on opts being a
valid pointer).

TCP and RDMA also avoid freeing the options, so make the FC transport
behave the same.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa2911f07c6c..6f5cfa47fee5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2413,8 +2413,6 @@ nvme_fc_ctrl_free(struct kref *ref)
 	nvme_fc_rport_put(ctrl->rport);
 
 	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
-	if (ctrl->ctrl.opts)
-		nvmf_free_options(ctrl->ctrl.opts);
 	kfree(ctrl);
 }
 
@@ -3568,8 +3566,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
-	ctrl->ctrl.opts = NULL;
-
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
-- 
2.41.0


