Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA032C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=; b=MpTOqnYbMpuY9EpACYqrnAlrfJ
	IDOPNQkrLBcU+9n2L+/9dHVxIm9tGKxLrj0Ak1/ax+ZG/aZGmRqc8eWjdamJWSX3APWTS8y4KrF86
	csfQd52tLI0jrmnO7brGNJw6HYsHNdUwy/Q9sa1BAvanuRhG6lV9vuBx4gBOk5/GJcIu3hCm3cVsb
	rq4ezbUX8ckbODy/SgiSk+TXtmCfOIwn/e9yGRkKUpIAOOQJQv4p+LzBRf68USSQRbpmCC0c0c8mx
	Ig0Vx0k34MsbU/5o5gtlDAF2EVgaclchWvMi9gXarxI74wZ5WjlxP6i2PRr/FCbMD47g/dnyi9ZTg
	s4vCjbLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmACi-00H0nE-30;
	Tue, 11 Apr 2023 09:22:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmACg-00H0lI-1L
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 09:22:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 78E511FE0B;
	Tue, 11 Apr 2023 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681204933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
	b=aRju6PIFPD3pKpR8tDbD5zDwBZFsBMOLD46J7nUJ83WcKTvPzhX+FRxqLDqBfdkdCw7g1C
	BZZwYti1Q+tIFdUQCA0T/DworpqkvztHLXTOi+vuH+D/T+CP08xL0h0MRqZfdLNlYnLjt7
	PvUIqeZJcRsaZ1LpmwnpZzNleaC2hwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681204933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NfxBQ+YwCQT4C500tsTvYDqFoF6jclwkqD6YJhX2o+Y=;
	b=SFje4ilRGflBpNnPl4rhLMeUVaOidFApoeujep2m/O+pCxCYiLs65d7nOEVXdsLvh58Ghd
	1+eekIchjOkpVVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A97D13519;
	Tue, 11 Apr 2023 09:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EsEGGsUmNWQQJgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 09:22:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] rvmet-fcloop: Remove remote port from list when unlinking
Date: Tue, 11 Apr 2023 11:22:09 +0200
Message-Id: <20230411092209.12719-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_022218_626206_0C82D97F 
X-CRM114-Status: GOOD (  10.91  )
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

The remote port is never removed from fcloop_nports list. During module
unloading it's possible to end up an busy loop in fcloop_exit, because
the remote port is found in the list and thus we will never progress.

The kernel log will be spammed with

  nvme_fcloop: fcloop_exit: Failed deleting remote port
  nvme_fcloop: fcloop_exit: Failed deleting target port

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fcloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 5c16372f3b53..1e53c8fe4b95 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1352,6 +1352,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
+	list_del(&nport->nport_list);
+
 	return rport;
 }
 
-- 
2.40.0


