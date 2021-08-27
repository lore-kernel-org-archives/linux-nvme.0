Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A3C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FFD60295
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21FFD60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mZmSmJTv35ybOrnCJO+7QCV8dEM2pGJ9mQqkj7o4LvI=; b=Pixk8Ybl68tpEX
	xNC+EkpnolgZxqErJ6esGvv9Dt2eJFnaTU9OQAI/nWVPnsQslCfqAspjc7n3KaXytBfyEVco8ZvNw
	KlRtis3gMfXdBl5SMresso646HMtH1dEOMsEZU508FbKefH8Bsr84kPMdM5HNsPQoP10XcByC47nV
	q9Z71oUb08fhq6BvkCtOtgOiyMPTHUYOtKqWGNjAZiGzQQUlBwJuPbHCHKrRnHmLDZWumSTaRc9Uk
	s3ENj425HyTBL1kqjbaJwS0DOzAYLJ41cZhDVV0e7ohL5FRyzi7RlPpCwlQRCfTp0JotlDwJa82xI
	s6+fmAzRvTKSPeYiQSuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJagx-00COWI-Gt; Fri, 27 Aug 2021 12:10:39 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJafv-00COHz-IE
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 12:09:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7E152223C9;
 Fri, 27 Aug 2021 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630066173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK/UMyv9/yNEvQ961nGvLZnS6cKt6RTcZd837Fs4Drk=;
 b=pVbOQllXWXiQlRvk8cTIzb2DRaDbfTski6P18W8HI0na37H4AifCpRwhV+knKnrPxEkjdo
 69HXL7dTwi+ZS8cTLj8dzAZCjr2WPE/MEIZNd9GikRIkeME12bfbn3F3PgofhIU0waG7bL
 D3Ry/BPFrJ8obDpKovNorAnpz96bmtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630066173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mK/UMyv9/yNEvQ961nGvLZnS6cKt6RTcZd837Fs4Drk=;
 b=UuoAbMzgMifIXr/qANx6rkcyfpbhdccDnn4ILWJYWwvn1NhjHPxZeLN48LQgMNV5e50tbH
 29+YRd+ffhVa1ADA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 57790A3BAE;
 Fri, 27 Aug 2021 12:09:32 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8371E518DB48; Fri, 27 Aug 2021 14:09:32 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute 'subtype'
Date: Fri, 27 Aug 2021 14:09:24 +0200
Message-Id: <20210827120926.104398-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827120926.104398-1-hare@suse.de>
References: <20210827120926.104398-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_050935_980425_1BE069A0 
X-CRM114-Status: GOOD (  14.52  )
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
---
 drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d64b406c1a42..3dc2645396df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2565,6 +2565,24 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
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
@@ -2585,6 +2603,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+	&subsys_attr_subtype.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 #endif
@@ -2655,6 +2674,14 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
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
index 26511794629b..b107ad005c3c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -377,6 +377,7 @@ struct nvme_subsystem {
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
