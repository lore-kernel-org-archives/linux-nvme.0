Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89326C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kHuZ0DDHSIPFjpB94qJZpVkKgyPiQEkg0Af+hvjw3M=; b=hm+Ss8/MLZp3aQWkE71EE8Bjje
	Dfj75LqBN50ug9D47UldM7vQkGPbm1L7O0SmFlct+Rg7nCW1O0dVuJgkSVdBpBRNnwq60Ar+Bez/y
	wcE792DpcPiNrnXZQm8ZaLwJgSLVKKlQssXXnTGCWopc7mTLnjkwCmu3JEDq1sNLqkXcCul9j8uuC
	tt9vp9fZ4oIPNnCwAIjxXWm9yMTziejcL+EBVmpmpX+2pEc1HsfppUS30+puivQ4Z0f3EUqkl8B4e
	a/whIQolLEpL+LUz4tp/DKf7qUXVfekANOd0fonlb1XAizefEOLyLAQgQk0NbW2dL1ZR7MUhaW7Nj
	jYnaFlDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfO-00000008Ehw-0D2C;
	Mon, 15 Apr 2024 12:42:34 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwLfH-00000008Edj-1fbL
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 12:42:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F75E21AF2;
	Mon, 15 Apr 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D36B1386E;
	Mon, 15 Apr 2024 12:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KxQFa8gHWYtAwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 1/5] nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
Date: Mon, 15 Apr 2024 14:42:16 +0200
Message-ID: <20240415124220.5433-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415124220.5433-1-dwagner@suse.de>
References: <20240415124220.5433-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6F75E21AF2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_054227_633869_C86060F3 
X-CRM114-Status: GOOD (  14.59  )
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

From: Hannes Reinecke <hare@kernel.org>

When the DH-HMAC-CHAP key is accessed via configfs we need to take the
config semaphore as a reconnect might be running at the same time.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/auth.c     |  2 ++
 drivers/nvme/target/configfs.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..9afc28f1ffac 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -44,6 +44,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	dhchap_secret = kstrdup(secret, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
+	down_write(&nvmet_config_sem);
 	if (set_ctrl) {
 		kfree(host->dhchap_ctrl_secret);
 		host->dhchap_ctrl_secret = strim(dhchap_secret);
@@ -53,6 +54,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		host->dhchap_secret = strim(dhchap_secret);
 		host->dhchap_key_hash = key_hash;
 	}
+	up_write(&nvmet_config_sem);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 77a6e817b315..7c28b9c0ee57 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1990,11 +1990,17 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret = to_host(item)->dhchap_secret;
+	u8 *dhchap_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
@@ -2018,10 +2024,16 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
 	u8 *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
-- 
2.44.0


