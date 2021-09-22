Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F1C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:40:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9EB611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC9EB611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5gFQIXc+Ar2GAmJyOQo9sWNxzz1Axg+fheI5f6Aa7Uw=; b=RgU4Y5VY6Cy9IQ
	WgzLIh2PyMKjQzRhOl9sIK8at0ywYEI4dhQc+E17e59ZkSvNl4g+B/cVoToo6yYVau2xS9ggLmgVW
	ONtlLIpluzTQaISpOz44E8lKrXdpGVtDswT+hF+WHLMx3xe1ae5ThoB7QBmtS34yya/LCusEancgk
	yZIxcx5USiujqp46+kmF4OXU2fyyhkEaG6mHqrQb3NSqNxzv144vafRojlpGfNSP0dtDTSSjHFLPf
	Rt2iZr5HPDKrZCHr+JZrumaIXrp8p6H7r3QGzFuR3lSu7PhxJFHcSjsJV5LVB+GRhugS3TdA/SKHW
	ZG2FmH3nupCFhbw6stKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvvE-0076rJ-Ng; Wed, 22 Sep 2021 06:40:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075b3-TS
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:33 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 52BEA221BE;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwJzoX4l9+k6jVCMuDSiWFBOaFwW4oQsZYAyymEhAhY=;
 b=S5uKIzafbT5RsV9ZURUHU7jIqJdqL9ugmfdkOH+YdmIvRE9MqVMNt5m5SOswFL6Wor4Q9k
 ig/+yWT9unsGMtD3hrpe0WQL2NI+noHCeUZvOnuM7H2SxWXSY6XZTu84w7c8rofRty0M5z
 I/HNS7YI+u/JdjGBC4joJgmNsl6NtU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwJzoX4l9+k6jVCMuDSiWFBOaFwW4oQsZYAyymEhAhY=;
 b=qz/YGK1h1+TJO19ynTCvpRnDd+SCQIrI/cMhnm8eZkfBZPbDb0XWI7j65nZ582xa/hEdH3
 bhtCUZyKua+/FrBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id ED973A3B9B;
 Wed, 22 Sep 2021 06:35:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id E03C8518EAEE; Wed, 22 Sep 2021 08:35:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/7] nvmet: make discovery NQN configurable
Date: Wed, 22 Sep 2021 08:35:19 +0200
Message-Id: <20210922063525.143045-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_289398_20009A1E 
X-CRM114-Status: GOOD (  13.94  )
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
 drivers/nvme/target/configfs.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  3 ++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index be5d82421e3a..4873564384a3 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1233,6 +1233,44 @@ static ssize_t nvmet_subsys_attr_model_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_model);
 
+static ssize_t nvmet_subsys_attr_discovery_nqn_show(struct config_item *item,
+			char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			nvmet_disc_subsys->subsysnqn);
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
+	 * The discovery NQN must be different from subsystem NQN.
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
@@ -1262,6 +1300,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_min,
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
+	&nvmet_subsys_attr_attr_discovery_nqn,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b8425fa34300..88ed746c675f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1491,7 +1491,8 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
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
