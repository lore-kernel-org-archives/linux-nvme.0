Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95621C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3C660F6D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B3C660F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6SV9/2QwFP6JJACLEfRzc2LothwLHHs5jcxngF6jmN4=; b=lowcGWWhruFThJ
	Ir6Od+fS5CfRp2q/+a+P3eGOky7VA/EF4mDD4D64ctorZ2Iaw2orrp9EHOSEZTHGwnEUGBYyIfBQ1
	eeKeh506kMbWQ2yyZGxcE6+9DXXROhCfCu9X024KN7Xl8JNEhhU0ydfr1ytEKnD1ftl4DS2Y4Ko9T
	qIIboznOuNcQXe5lKam3EuGg0Dw7cB7XUXWXp6qilTVodc/fEHIpo3gMbycEZfDwpqYlZyj5Um4bu
	5pu0/Rlw6gOCsO8Z8QXdfGGUTXqeJlGjjzYaVK8KSR66oY+Nbm9IYQ7ObnVFuB1z7dX7EKxZv8f1A
	lrB0CgawPfzXnP3fihxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mShVW-004rHD-Fe; Tue, 21 Sep 2021 15:16:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mShUn-004r6S-AH
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 15:15:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 74C3D1FEE9;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632237341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qIqT3c2UXtXEPAh6WG10mcmkZ9PrKF5+A/mmK+GyqE=;
 b=EdoPUSOOlS0yKpCAlp8qgMx3aw9bIziJfVTBrV2mfMR66d8sErhVFnfqibptcDpxG9u1Rv
 K4A8WJ2/Ak3yqxAQRZ3Nwerjy4a8997jw/5oyuELrU4T6VAqffjyYUOXmofS+vSHcYUar6
 fPhBU0V1K0IriCGulJMu9m+VtyZb0ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632237341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qIqT3c2UXtXEPAh6WG10mcmkZ9PrKF5+A/mmK+GyqE=;
 b=2Vjb1rsoHeQoEK56wzH9fernyETZzfmH1WCbGv4/HocZIxNnd4/7Sszt98XpR9u3MpiX8W
 pjQpfBV9PFv/MnCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 49CC5A3BA5;
 Tue, 21 Sep 2021 15:15:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7FD38518EA91; Tue, 21 Sep 2021 17:15:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute 'subtype'
Date: Tue, 21 Sep 2021 17:15:27 +0200
Message-Id: <20210921151529.29419-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921151529.29419-1-hare@suse.de>
References: <20210921151529.29419-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_081545_569021_AD8E4A1F 
X-CRM114-Status: GOOD (  15.02  )
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
