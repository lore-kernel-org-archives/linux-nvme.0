Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F1C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 16:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n11OfF1QXEDTY8UUINBbHh622YQ31BcFGsGZL13OMCo=; b=jTzh8BhSaLuP7rFBjr3VR/pJkF
	xCsWy82tdl2lvfrqRzEXs3E6QokQhJ1cWmC38IRn/aZ/dkd8rv9iuuIKZ53VBJH2IBZ1qbLQFL/FI
	89QpU5MnhBn4LOVyPmszMtVAwRSyeuIG0U+p1UT/bCDNNGkqJ0jD0KiU71/gN8+L8wtNPiHkwEb6B
	qzXb4Ce3mVkM7rZ8Ty0+r2f9HX5gL0K07uWWqU1kvWLCZVEgssQqseQmaLVp8A9IKXBytaho+LFOq
	wDpd9M/r9a/jmisrEBjP3BulJcDLTRQQ4TJ54uiWTfdKyDZneTDurWq020vpsmI4ImeclZJZK+PxQ
	qVT7nMDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFG7B-00BMLU-1C;
	Mon, 18 Dec 2023 16:05:09 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFG78-00BMKi-2s
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 16:05:08 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C8831F445;
	Mon, 18 Dec 2023 16:05:05 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AE7C13BD5;
	Mon, 18 Dec 2023 16:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LMq+FLFtgGUtBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 16:05:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 14/16] nvmet-fc: free hostport after release reference to tgtport
Date: Mon, 18 Dec 2023 16:31:02 +0100
Message-ID: <20231218153105.12717-15-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6C8831F445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_080507_080419_75F2328C 
X-CRM114-Status: GOOD (  10.76  )
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

Give the ref back before destroying the hostport object to prevent a
potential UAF.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 663c51c9fe53..23d8779dc221 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -986,8 +986,8 @@ nvmet_fc_hostport_free(struct kref *ref)
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	if (tgtport->ops->host_release && hostport->invalid)
 		tgtport->ops->host_release(hostport->hosthandle);
-	kfree(hostport);
 	nvmet_fc_tgtport_put(tgtport);
+	kfree(hostport);
 }
 
 static void
-- 
2.43.0


