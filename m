Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC7C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4747C61057
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4747C61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4PvDkCS9Z723S8xXjBqF7xs8vKnKcM1LaZGGXPcrh5w=; b=VIUl4S4K9evjfdQWSvFNdTpZk
	PuPRvyNEgR0HZfYW72FZ+pYE2P/a6+jw+gX3oXPfBJuFwiu2QlAknop4ePZlQNxYe3eNkb+bCLc23
	V4o9PT5uDusapl8z2/7xyoXzyYdgE3KtgL2nPuGVJSJqGJuUNxMR5JGRLcO+rHrdz93Jw/Ukx3qar
	V1xD3tzI1iKv8/he4tzELg63h/A/N8yzqZwa1KaH/RpDY+93q5ORa3iDpepv+nX3WvADkPYXdvhPP
	CcPhBvG+PN/AuJmZ2NW1rnTfdZgnPR201axQvnlZ7rBQj0xqaVMtDp9E7R64+bAfbEQMGraHsq0H9
	1YrAAMPzA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRu2L-0098bP-N6; Thu, 01 Apr 2021 09:54:49 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRu1t-0098Wk-Bc
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 09:54:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9CC60AEF5;
 Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2 1/3] nvme: Use sysfs_emit instead of sprintf
Date: Thu,  1 Apr 2021 11:54:10 +0200
Message-Id: <20210401095412.84254-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_105421_560948_1A64E8FD 
X-CRM114-Status: GOOD (  12.97  )
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

sysfs_emit is the recommended API to use for formatting strings to be
returned to user space. It is equivalent to scnprintf and aware of the
PAGE_SIZE buffer size.

Suggested-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c      | 40 +++++++++++++++++------------------
 drivers/nvme/host/multipath.c |  8 +++----
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40215a0246e4..b94a30e7298d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2876,8 +2876,8 @@ static ssize_t subsys_##field##_show(struct device *dev,		\
 {									\
 	struct nvme_subsystem *subsys =					\
 		container_of(dev, struct nvme_subsystem, dev);		\
-	return sprintf(buf, "%.*s\n",					\
-		       (int)sizeof(subsys->field), subsys->field);	\
+	return sysfs_emit(buf, "%.*s\n",				\
+			   (int)sizeof(subsys->field), subsys->field);	\
 }									\
 static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
 
@@ -3407,13 +3407,13 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 	int model_len = sizeof(subsys->model);
 
 	if (!uuid_is_null(&ids->uuid))
-		return sprintf(buf, "uuid.%pU\n", &ids->uuid);
+		return sysfs_emit(buf, "uuid.%pU\n", &ids->uuid);
 
 	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-		return sprintf(buf, "eui.%16phN\n", ids->nguid);
+		return sysfs_emit(buf, "eui.%16phN\n", ids->nguid);
 
 	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-		return sprintf(buf, "eui.%8phN\n", ids->eui64);
+		return sysfs_emit(buf, "eui.%8phN\n", ids->eui64);
 
 	while (serial_len > 0 && (subsys->serial[serial_len - 1] == ' ' ||
 				  subsys->serial[serial_len - 1] == '\0'))
@@ -3422,7 +3422,7 @@ static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
 				 subsys->model[model_len - 1] == '\0'))
 		model_len--;
 
-	return sprintf(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
+	return sysfs_emit(buf, "nvme.%04x-%*phN-%*phN-%08x\n", subsys->vendor_id,
 		serial_len, subsys->serial, model_len, subsys->model,
 		head->ns_id);
 }
@@ -3431,7 +3431,7 @@ static DEVICE_ATTR_RO(wwid);
 static ssize_t nguid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
+	return sysfs_emit(buf, "%pU\n", dev_to_ns_head(dev)->ids.nguid);
 }
 static DEVICE_ATTR_RO(nguid);
 
@@ -3446,23 +3446,23 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	if (uuid_is_null(&ids->uuid)) {
 		printk_ratelimited(KERN_WARNING
 				   "No UUID available providing old NGUID\n");
-		return sprintf(buf, "%pU\n", ids->nguid);
+		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
-	return sprintf(buf, "%pU\n", &ids->uuid);
+	return sysfs_emit(buf, "%pU\n", &ids->uuid);
 }
 static DEVICE_ATTR_RO(uuid);
 
 static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
+	return sysfs_emit(buf, "%8ph\n", dev_to_ns_head(dev)->ids.eui64);
 }
 static DEVICE_ATTR_RO(eui);
 
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
 }
 static DEVICE_ATTR_RO(nsid);
 
@@ -3527,7 +3527,7 @@ static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%.*s\n",						\
+        return sysfs_emit(buf, "%.*s\n",					\
 		(int)sizeof(ctrl->subsys->field), ctrl->subsys->field);		\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
@@ -3541,7 +3541,7 @@ static ssize_t  field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)		\
 {										\
         struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
-        return sprintf(buf, "%d\n", ctrl->field);	\
+        return sysfs_emit(buf, "%d\n", ctrl->field);				\
 }										\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
@@ -3589,9 +3589,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 
 	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
 	    state_name[ctrl->state])
-		return sprintf(buf, "%s\n", state_name[ctrl->state]);
+		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
 
-	return sprintf(buf, "unknown state\n");
+	return sysfs_emit(buf, "unknown state\n");
 }
 
 static DEVICE_ATTR(state, S_IRUGO, nvme_sysfs_show_state, NULL);
@@ -3643,9 +3643,9 @@ static ssize_t nvme_ctrl_loss_tmo_show(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 
 	if (ctrl->opts->max_reconnects == -1)
-		return sprintf(buf, "off\n");
-	return sprintf(buf, "%d\n",
-			opts->max_reconnects * opts->reconnect_delay);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n",
+			  opts->max_reconnects * opts->reconnect_delay);
 }
 
 static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
@@ -3675,8 +3675,8 @@ static ssize_t nvme_ctrl_reconnect_delay_show(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (ctrl->opts->reconnect_delay == -1)
-		return sprintf(buf, "off\n");
-	return sprintf(buf, "%d\n", ctrl->opts->reconnect_delay);
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->reconnect_delay);
 }
 
 static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..e62369d3eae3 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -602,8 +602,8 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	return sprintf(buf, "%s\n",
-			nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
+	return sysfs_emit(buf, "%s\n",
+			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
@@ -628,7 +628,7 @@ SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sprintf(buf, "%d\n", nvme_get_ns_from_dev(dev)->ana_grpid);
+	return sysfs_emit(buf, "%d\n", nvme_get_ns_from_dev(dev)->ana_grpid);
 }
 DEVICE_ATTR_RO(ana_grpid);
 
@@ -637,7 +637,7 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 {
 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
-	return sprintf(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
+	return sysfs_emit(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
 }
 DEVICE_ATTR_RO(ana_state);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
