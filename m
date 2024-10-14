Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD743D18130
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 16:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=huTL1p1lylQkrUjKPxyHyX4Jz2GtH+ixoFcQ5RWCJjo=; b=Qi1yc+IPIo5oDig3n9nSRw2WC9
	HdaCKddzetJwu6ttzbNxVprDbL2k0tu6e2TXoVW3MU1FrFVAMCbqBkHG5RdagRpgQIanLIYxF5ePx
	ST9T1uKU04QSJsa7ryQvUEtw0bEi50bwDJiLiuPKBukPvlWZU6pXw5JlieAS1mQIlaYgr5YkxGser
	I+APKqSQc1Gj+r4tTcZvyattuRu0pwMzlYC7m+tTEvg+UwDLJmdp7YVtZiHnkVWllLZvuDSqM4h/R
	fgMFhisrfOzhAIG9t4/1Q60TvyS/hNHjWEOgP6N9RoVDT5bu57rXl5EeSXWGknDIzyU/9HllDUu5w
	v8nNZ/sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0OLN-00000005wHS-0jYw;
	Mon, 14 Oct 2024 16:54:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0OK6-00000005w6P-1FVd
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 16:53:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80AF121C11;
	Mon, 14 Oct 2024 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728924812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=huTL1p1lylQkrUjKPxyHyX4Jz2GtH+ixoFcQ5RWCJjo=;
	b=S3M8SV3z1cTkpX8pJHYeQUhm0+devmFP6ij3U9bmdOIphjQ8/ezJcOlvt6eMCIgh/JAEU6
	AgrqEiCWNJmTydaEl4F5jGAYiHLBB3RAHNZIOvXoK+x3ANxkBRPrC88JEfYhezlhedJ+Ix
	mJxFuYHXfCcP/FEjIOt9sBu2umjGlvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728924812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=huTL1p1lylQkrUjKPxyHyX4Jz2GtH+ixoFcQ5RWCJjo=;
	b=Udefscl/5SBd2zN19alKIz1EgqO9kdAPuDCaeNdmNg5mggihfjFoxZOAwldxnH4tV122oy
	xqGd4+B03dTWHpCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728924812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=huTL1p1lylQkrUjKPxyHyX4Jz2GtH+ixoFcQ5RWCJjo=;
	b=S3M8SV3z1cTkpX8pJHYeQUhm0+devmFP6ij3U9bmdOIphjQ8/ezJcOlvt6eMCIgh/JAEU6
	AgrqEiCWNJmTydaEl4F5jGAYiHLBB3RAHNZIOvXoK+x3ANxkBRPrC88JEfYhezlhedJ+Ix
	mJxFuYHXfCcP/FEjIOt9sBu2umjGlvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728924812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=huTL1p1lylQkrUjKPxyHyX4Jz2GtH+ixoFcQ5RWCJjo=;
	b=Udefscl/5SBd2zN19alKIz1EgqO9kdAPuDCaeNdmNg5mggihfjFoxZOAwldxnH4tV122oy
	xqGd4+B03dTWHpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6679313A42;
	Mon, 14 Oct 2024 16:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ZalFoxMDWe/FQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 16:53:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1] nvme-tcp: forward context to teardown admin queue function
Date: Mon, 14 Oct 2024 18:53:29 +0200
Message-ID: <20241014165329.639998-1-dwagner@suse.de>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_095334_509727_3872EFA9 
X-CRM114-Status: GOOD (  13.54  )
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

nvme_tcp_setup_ctrl is called from different contexts. If the function
is called as part of the initial controller creation, the argument 'new'
is set to true. This tells the function to free all resources when an
error occurs.

Thus nvme_tcp_teardown_admin_queue should also be called with 'new' and
not always with 'false'.

Fixes: fd1418de10b9 ("nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 89c44413c593..c31434b4da73 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2278,7 +2278,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
+	nvme_tcp_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.47.0


