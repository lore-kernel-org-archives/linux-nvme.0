Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F48C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F6c5zWNrb/OIMujAxqT6Py+sYzK2I6t4CKB8vaB5DKM=; b=YqUJEisoS0tv36VNEIuqte/hBC
	4xoX3ujWpD6madtlgTQ2cfYXGfkxX4dJA1rxI6j4/Z4ORwiw/4QiZN9sBvES09BJLI3zQuSi14boA
	gKnISCeDIRPoZLwyyVIh6wKFqDo4dJY8Tkfn/7QdrWLs4gLD4cMRguovZOR4AW/Jy60tNc4yU1SAH
	RIulQO7y+vGi7snlu6MJ7xeIqSzSYvGjBfLlVPJC7/J4wbWun5YspU881lsACVWUpbj/7OwZgWbm3
	BYBl5S+QT2Yr3vKRzKm4xNRUaFZbaJV4csbpZDOdZWZDsqhOaR8R2nfhD+gUC1GlkNVX7ZfQb6L1S
	dOLga8pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpVc-002ELh-Cw; Fri, 22 Jul 2022 10:03:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpVZ-002EIc-IV
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 10:03:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C31821FD77;
	Fri, 22 Jul 2022 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658484220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F6c5zWNrb/OIMujAxqT6Py+sYzK2I6t4CKB8vaB5DKM=;
	b=t5Noor09RqQUXOrmof71TdCsCSWCbTJvKby0SARY1IuQhfYauJ91sCMhAgMXPh1a6Qc9lf
	antz5Q5iYtJmOrYgAJ5Wa/NHEhT95UdEXQVEIpoNjM/z+9NdnVuIfzqmSWA+lB0Tek5IvS
	Cfr9YksUWgUUxRHJDnd0l4j2hADt7aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658484220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F6c5zWNrb/OIMujAxqT6Py+sYzK2I6t4CKB8vaB5DKM=;
	b=Q5SEjblOcrPBgnCcK5EWP7ZastecMDTmqthlB3yJYowCiLhGjbVrDxB4nFGybNCjE+nyK2
	I6gwBy59Uuut0GDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF13413AB3;
	Fri, 22 Jul 2022 10:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id LRv0Kfx12mIGdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 22 Jul 2022 10:03:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-fabrics: restrict host_iface options match criteria
Date: Fri, 22 Jul 2022 12:03:35 +0200
Message-Id: <20220722100335.1708-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_030345_777033_94658381 
X-CRM114-Status: GOOD (  10.54  )
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

Enforce consistent use of host_iface in setups where the hosts has
several networking interface and the target just one. That means the
user needs to set the host_iface for all connections in such
scenarios.

This keeps the match logic simple and also avoids passing in invalid
pointers to strcmp.

Fixes: 4e9499337d40 ("nvme-fabrics: consider also host_iface when checking ip options")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 01e96322e363..fb054929553c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -962,7 +962,9 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
 	    strcmp(opts->trsvcid, ctrl->opts->trsvcid) ||
-	    strcmp(opts->host_iface, ctrl->opts->host_iface))
+	    (((opts->mask & NVMF_OPT_HOST_IFACE) &&
+	      (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)) &&
+	       strcmp(opts->host_iface, ctrl->opts->host_iface)))
 		return false;
 
 	/*
-- 
2.37.1


