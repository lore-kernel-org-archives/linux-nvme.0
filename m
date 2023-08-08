Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE0AC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8OaRQJK0fiVzD7XXv66+E/l55x31keo9d+QnidEn6JI=; b=ICivU+sHZf1dTbmyxutf/J/EdW
	swYadtE09OVzq0ayI6etE0RVTBnFrTiHjVUYZPgONfOQznHNIlMDiAvE39MgBOGVOPpLuiGn4cwTw
	4pSfkAYwszOZKiGEfz7VAHQSvpgwdG0hBrAEcWNzNhBCJm4LB57+PNFuaW8Vf4BYyCieYsPwUF8lg
	CUoxhAgrn1RYOeVsJvlBfboZRSDiDk0kS1DGT2p4r46YKxMja1x/S+uHS/1FpYIn1g4Z2e5E5aHFe
	bBpiM8VXHR/+pA+inRzSaNHLn73AORSKpxDAuv7cC1PLqwn0uTkXyqYCU3RhB4ZqGLNP2mBaWh6iI
	V4Yjh79w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnJ-002eCW-0E;
	Tue, 08 Aug 2023 13:30:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTMnF-002eBN-2H
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 13:30:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 978AF224A2;
	Tue,  8 Aug 2023 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691501435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OaRQJK0fiVzD7XXv66+E/l55x31keo9d+QnidEn6JI=;
	b=1FfuPC13HTv39DH+o/QCrcQOKPAc8GGQO78o5zt7QKPGXsz3DgG1SFkdaAPOogORY9M60Q
	VWzXDnpyurS+aEGI5ioHVd+GN5iPILlWQldihu888vjzY4M/8WRJ09l0YaWyZUEKZU/5VD
	kJvIUSM/dJFOID4A6B39G9WxSYg4GaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691501435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8OaRQJK0fiVzD7XXv66+E/l55x31keo9d+QnidEn6JI=;
	b=7ft96Wwjd92ivrypGBQC4y6MVe7XRjIAetLb0+2ZHOoOtsbuoJzEJ4/+5vriqG8qfcxdgf
	x7zKkmKxZe84xNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A40A139D1;
	Tue,  8 Aug 2023 13:30:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jMqSIXtD0mSwGAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 08 Aug 2023 13:30:35 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH libnvme v4 2/2] fabrics: Do not pass disable_sqflow if not supported
Date: Tue,  8 Aug 2023 15:30:28 +0200
Message-ID: <20230808133028.14643-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808133028.14643-1-dwagner@suse.de>
References: <20230808133028.14643-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_063037_891018_5E5115DA 
X-CRM114-Status: GOOD (  13.93  )
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

Do not try to use disable_sqflow if the kernel actually supports this
option.

Reported-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/nvme/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 9725eeb3cda8..11d99580072a 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -1031,8 +1031,11 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
 		return NULL;
 	}
 
-	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
+	    nvmf_check_option(h->r, disable_sqflow))
 		c->cfg.disable_sqflow = true;
+	else
+		c->cfg.disable_sqflow = false;
 
 	if (e->trtype == NVMF_TRTYPE_TCP &&
 	    (e->treq & NVMF_TREQ_REQUIRED ||
-- 
2.41.0


