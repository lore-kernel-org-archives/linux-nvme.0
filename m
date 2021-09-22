Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:37:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51F360EC0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 06:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C51F360EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8W+Sf0yNpIvQplo3gkqI5+dGEoEvss8tAC643cplrpI=; b=4biaeqNJyu8cLn
	urV3t/u2KCmLl7EkRKwgWNkY0mRoApeI6daSaHAXnNcLDJhEYg8tCBqihLVv9jzrhFLs5sMOomMXW
	waBOclhiOdkV8rMHWhL25/g7ZXaHgR5TebNbjQi9EHPFY+G4/769g3cBk18AaUilozzN5kK/QVECk
	MDaH7iPiqWt5PchwP0lVxPwgaB33/gJLjeWQqSVSkWw6VrxLP0c2ohwEIbc/4CFLA/Uk65+4Q2EYI
	cnnC+mHdLMM8HifdvtyOrtwzw4QUOiAyAO13ZQ3hbgLH5MpbYk4/caEXeIm+J9vtyXeS8h24ULF9s
	SW21e0mpHA05k585Mhog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSvsi-0076Ec-J7; Wed, 22 Sep 2021 06:37:24 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSvqq-0075b5-TT
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 06:35:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5C42D22264;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632292527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5j+0SObCJaOK1MkjV85841fraxg+GSfLIIjeYp0io8=;
 b=DJ1GwY0/W/F3O9yrASMTlThud99BhwMgW/Z6VtDohWleiCEVbQRehqweFrAv4/ts8NJBXh
 /ZH8QIJHoVZJG6naHW6jj/87KVwQWYNLSrplJHdwTb1PUq+G7TQ5cZRzOAMZBag2iybtUo
 AS9JIO25FJxaVnyJ4BU7xYg6Hxa1xAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632292527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5j+0SObCJaOK1MkjV85841fraxg+GSfLIIjeYp0io8=;
 b=R1nYaFoD8lZIDevJSBYwkOyjSkGah58lRBPakc3iAA5gl0/yFj2sqKhPQVRIp5AF7cJ6HT
 HJOzz2BRDDQGrMDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 51B48A3BA0;
 Wed, 22 Sep 2021 06:35:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 0313E518EAF6; Wed, 22 Sep 2021 08:35:27 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/7] nvme: expose subsystem type in sysfs attribute 'subtype'
Date: Wed, 22 Sep 2021 08:35:23 +0200
Message-Id: <20210922063525.143045-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922063525.143045-1-hare@suse.de>
References: <20210922063525.143045-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_233529_233552_74AF9826 
X-CRM114-Status: GOOD (  15.49  )
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

With unique discovery controller NQNs we cannot distinguish the
subsystem type by the NQN alone, but need to check the subsystem
type, too.
So expose the subsystem type in a new sysfs attribute 'subtype'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e486845d2c7e..1ed1b7be2812 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2598,6 +2598,24 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 }
 static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
 
+static ssize_t nvme_subsys_show_subtype(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	switch (subsys->subtype) {
+	case NVME_NQN_DISC:
+		return sysfs_emit(buf, "discovery\n");
+	case NVME_NQN_NVME:
+		return sysfs_emit(buf, "nvm\n");
+	default:
+		return sysfs_emit(buf, "reserved\n");
+	}
+}
+static SUBSYS_ATTR_RO(subtype, S_IRUGO, nvme_subsys_show_subtype);
+
 #define nvme_subsys_show_str_function(field)				\
 static ssize_t subsys_##field##_show(struct device *dev,		\
 			    struct device_attribute *attr, char *buf)	\
@@ -2618,6 +2636,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+	&subsys_attr_subtype.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 #endif
@@ -2688,6 +2707,14 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+
+	/* Versions prior to 1.4 don't necessarily report a valid type */
+	if (id->cntrltype == NVME_CTRL_DISC ||
+	    !strcmp(subsys->subnqn, NVME_DISC_SUBSYS_NAME))
+		subsys->subtype = NVME_NQN_DISC;
+	else
+		subsys->subtype = NVME_NQN_NVME;
+
 	subsys->awupf = le16_to_cpu(id->awupf);
 #ifdef CONFIG_NVME_MULTIPATH
 	subsys->iopolicy = NVME_IOPOLICY_NUMA;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9871c0c9374c..2c7a77f600f8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -366,6 +366,7 @@ struct nvme_subsystem {
 	char			model[40];
 	char			firmware_rev[8];
 	u8			cmic;
+	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
 	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
