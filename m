Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB877C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fE93VEoy5zqV8YvVPAuPrnx9qh1Tr/Zmc0OwoHI+04Y=; b=ud8xce6yJ7012WLyf8u4ugner7
	6dhun3Rt9wEnCUuyePbHt8Kr2z1Fjkxc22pgaQ9sqnqekyq/ztB0uSw4AtEItKN2F4sfsTU1Vjrn3
	3MISIAGuW51nHd+NFBu6Ikc1b+786pV8o2AxU5WULYTGxp4AEOSV/HWfQ3/89xCKuj2+CXjocv+Hb
	gwoLHvPtHErKLWxyisGfdPAKPZn8tgls1L2DJRcjiY+mJyh77zbnPchBFGtyn2bMhRufh3sywhbfn
	fkV8ypwOmrXET267zmo1LguE9ySiStBWmoJ8Jx+PEPT9Dv3zpWonLoiQn+8HfKtKr4BL+YHU1be/i
	jLogRuVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEaDn-00AwAZ-Tj; Thu, 21 Jul 2022 17:44:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEaDl-00Aw5o-Ee
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 17:44:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE38349AF;
	Thu, 21 Jul 2022 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658425457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fE93VEoy5zqV8YvVPAuPrnx9qh1Tr/Zmc0OwoHI+04Y=;
	b=uzHu3BYS/4eefEpd7U7Asb2P2W/EVUA09XkAaovjCpftmxJJFAWXie7H2nJT2Sz+Kz5xQo
	KLIynm2n3xV+XiL/IrijvwMPJHApaLpDeFdlInqWpRu1iDV0iQIkyry2KJ1A1OrptDTssq
	BI8cKx+iztqSpDtgeR31IZ62OuH5NWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658425457;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fE93VEoy5zqV8YvVPAuPrnx9qh1Tr/Zmc0OwoHI+04Y=;
	b=TyFbRZkmi4oOUkY5urJ+lazPzE3zO38tRWJgn3Y7314ZVtgw9XWV6DNAoW7uy4Vo+ibw+g
	tYdJwiRNlyGZzIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4111313A89;
	Thu, 21 Jul 2022 17:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fgS2D3GQ2WKNFQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 21 Jul 2022 17:44:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme: consider also host_iface when checking ip options
Date: Thu, 21 Jul 2022 19:44:14 +0200
Message-Id: <20220721174414.28294-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_104421_679085_02306EF4 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

It's perfectly fine to use the same traddr and trsvcid more than once
as long we use different host interface. This is used in setups where
the host has more than one interface but the target exposes only one
traddr/trsvcid combination.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..10ef2e249d88 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -944,7 +944,8 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 {
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
-	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
+	    strcmp(opts->trsvcid, ctrl->opts->trsvcid) ||
+	    strcmp(opts->host_iface, ctrl->opts->host_iface))
 		return false;
 
 	/*
-- 
2.37.1


