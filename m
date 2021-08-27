Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DDC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F72E60F6C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F72E60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HRKcvzA3gfIgPgHDBv8VngBOvKBb+VQ/uZt2AqbM01I=; b=KLN24DBCmNHQVZ
	y9As4VNtifZsHKnpa+qwaknAykmxsFpCv1Jy/00fOzrgz/jdnueef0Yuopwc7gHvZWE5B6X9rB0LA
	KVlI5vT56lFNrbYt7AP+LUwDiIHRgBuiwYraUDHluWiRS9vwEcMto8FGmkRVHOirIg2gxXgIAW+k5
	zja4dOtkvh33GEAdoU7+PXzKvShkKNaIDrMm9g5/v8dr0Hzh/Z+4ChSHSNPt3UyMOo6r67cVsiJ20
	RBhSHXs/x6NNcSnbTYQ0lL8L4t75jTPwpNtuTyrAKM+/bRSuKkbgZ3Txn0C0tOgEhFOy1Tqq4riCr
	Rq48xpAGwdwrmztBYg1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJagl-00COSQ-Ty; Fri, 27 Aug 2021 12:10:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJafv-00COHx-I8
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 12:09:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7F84620214;
 Fri, 27 Aug 2021 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630066173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8I9FZ/Z+0Fv7MK+RQeMiM4p2UslUNORf7kIZUFdKcM=;
 b=u+DjLVvyAr//Zm12ZSMtklFAjPUy7LFHbGJ9ypFffXmneGZHGeHUjHiuaLjg4KWMcvI9VP
 JUZGm/b/frAgeFXyhjrJOtXInzEDE6MYa41urooKdktkOZ/ZV7u6a5TsvjigdSA921D71Q
 kwoBiyjWBhvm1v3TYne/EZWWfw/aXyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630066173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8I9FZ/Z+0Fv7MK+RQeMiM4p2UslUNORf7kIZUFdKcM=;
 b=ujvPSb0btDFPOuU/uZPFeZPfsHH80UaZORuQ6z6Wm/JVx3YBCUYkSjMbP36Vcbf7iMzNTj
 wm0jlMyI1vYE4aBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4E118A3BA5;
 Fri, 27 Aug 2021 12:09:32 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 778B6518DB42; Fri, 27 Aug 2021 14:09:32 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] nvmet: make discovery NQN configurable
Date: Fri, 27 Aug 2021 14:09:21 +0200
Message-Id: <20210827120926.104398-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827120926.104398-1-hare@suse.de>
References: <20210827120926.104398-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_050935_954289_BEF21C5D 
X-CRM114-Status: GOOD (  13.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TPAR8013 allows for unique discovery NQNs, so make the discovery
controller NQN configurable by exposing a subsys attribute
'discovery_nqn'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 42 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  3 ++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 325f7dc37a72..008be02fbac9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1290,6 +1290,47 @@ static ssize_t nvmet_subsys_attr_oui_show(struct config_item *item,
 }
 CONFIGFS_ATTR_RO(nvmet_subsys_, attr_oui);
 
+static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
+			char *page)
+{
+	struct nvmet_subsys *subsys = nvmet_disc_subsys;
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			subsys->subsysnqn);
+}
+
+static ssize_t nvmet_subsys_attr_discovery_nqn_store(struct config_item *item,
+			const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	char *subsysnqn;
+	int len;
+
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+
+	subsysnqn = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!subsysnqn)
+		return -ENOMEM;
+
+	/*
+	 * The discovery NQN must be different from
+	 * subsystem NQN.
+	 */
+	if (!strcmp(subsysnqn, subsys->subsysnqn)) {
+		kfree(subsysnqn);
+		return -EBUSY;
+	}
+	down_write(&nvmet_config_sem);
+	kfree(nvmet_disc_subsys->subsysnqn);
+	nvmet_disc_subsys->subsysnqn = subsysnqn;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_discovery_nqn);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_subsys_attr_pi_enable_show(struct config_item *item,
 						char *page)
@@ -1319,6 +1360,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_discovery_nqn,
 	&nvmet_subsys_attr_attr_oui,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ac7210a3ea1c..2ac12516abd1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1488,7 +1488,8 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
+	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn) ||
+	    !strcmp(nvmet_disc_subsys->subsysnqn, subsysnqn)) {
 		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
 			return NULL;
 		return nvmet_disc_subsys;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
