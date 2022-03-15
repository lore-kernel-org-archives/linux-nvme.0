Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D624C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ez8V/1oGMeSfBNU2oeKVp4NihTFQ0cT0CGPEeq1Ev1k=; b=eLkx1n251pgohp2+z19/VTur8P
	kJHTWi2I59KDcX9YO7Kp8Fe5JyMMz1utph5lmlfOuHd7nOkOdWd8XRppG7iKM6ygK/R5BTt+EwaNy
	L+pHkX9W1z8NuUG6ZkiP5yRkI8Ter7HaCPEH8ARUM4s58gW4fF+I6G7wlx2kjRexRBSe1s4WHJC1r
	TMe2XyKXwoGI9hOTiCYRIeKwKJmWBsxhBNDiPYY1RTs2TqJzk22ZJNJ0GnocHEzkBVQ2WDEjYk+gg
	iE+Pl2yMaXaVYLkhxLyAHXMCkoRfLlALh1c697Xq+FjG9pgXXeJyVkP8lYKBSlcGW951uV+k+wwS1
	ZMUgi4ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU3GN-008Tsm-1U; Tue, 15 Mar 2022 09:14:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU3GJ-008Tr1-H0
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 09:14:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 34FA82190C;
 Tue, 15 Mar 2022 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647335678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ez8V/1oGMeSfBNU2oeKVp4NihTFQ0cT0CGPEeq1Ev1k=;
 b=zmq7CRuMKOEd5YUPJMF70IiZYK1oRd6+u+O23L2hujNBcUd+C2fQKfE7EOaSxNRB5EtHL+
 0kw+QKzvJfM9Zl8v4pEjhdlaq/FRcwmbKc3EL++26Pey1aJFn2KUdbxe4j4dMpvQvKNkXb
 owEBVhPVuPLgow0W+Ecl+R44Xmbr9fU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647335678;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ez8V/1oGMeSfBNU2oeKVp4NihTFQ0cT0CGPEeq1Ev1k=;
 b=FMoaBQ/a3l/ZyYuXxEWFje9S++2M9tSWnPR9Ttj/rg3xaFkjJLqmtslXSJLWn60go+F/UU
 PZVNJ7p8Qo+XazCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 088FBA3B83;
 Tue, 15 Mar 2022 09:14:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id EF6EE51936DD; Tue, 15 Mar 2022 10:14:37 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi@suse.de, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvmet: revert "nvmet: make discovery NQN configurable"
Date: Tue, 15 Mar 2022 10:14:36 +0100
Message-Id: <20220315091436.30813-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_021439_748682_1B3632BD 
X-CRM114-Status: GOOD (  11.08  )
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

Revert commit 626851e9225d ("nvmet: make discovery NQN configurable");
interface was deemed incorrect and will be replaced with a different
one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 39 ----------------------------------
 drivers/nvme/target/core.c     |  3 +--
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..496d775c6770 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1233,44 +1233,6 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 
-static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
-			char *page)
-{
-	return snprintf(page, PAGE_SIZE, "%s\n",
-			nvmet_disc_subsys->subsysnqn);
-}
-
-static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
-			const char *page, size_t count)
-{
-	struct nvmet_subsys *subsys = to_subsys(item);
-	char *subsysnqn;
-	int len;
-
-	len = strcspn(page, "\n");
-	if (!len)
-		return -EINVAL;
-
-	subsysnqn = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!subsysnqn)
-		return -ENOMEM;
-
-	/*
-	 * The discovery NQN must be different from subsystem NQN.
-	 */
-	if (!strcmp(subsysnqn, subsys->subsysnqn)) {
-		kfree(subsysnqn);
-		return -EBUSY;
-	}
-	down_write(&nvmet_config_sem);
-	kfree(nvmet_disc_subsys->subsysnqn);
-	nvmet_disc_subsys->subsysnqn = subsysnqn;
-	up_write(&nvmet_config_sem);
-
-	return count;
-}
-CONFIGFS_ATTR(nvmet_subsys_, attr_discovery_nqn);
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
 						char *page)
@@ -1300,7 +1262,6 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
-	&nvmet_subsys_attr_attr_discovery_nqn,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..626caf6f1e4b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1493,8 +1493,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) ||
-	    !strcmp(nvmet_disc_subsys->subsysnqn, subsysnqn)) {
+	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
 		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
 			return NULL;
 		return nvmet_disc_subsys;
-- 
2.29.2


