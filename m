Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F22C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F350764E57
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F350764E57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/O8pR5zZJ4XJHc8XLEXmCUsO+WQ1VArEj4n7Z7Yfeh4=; b=T0DRcvvehDb7sovZHcLQYi7N/
	KjsbAV+qQcB/k8Adn409kmGyqBzT6AIzoLqNPNJBvWwtNJQjPqA9/dUeVHey8ydU/mPmcbFC9dm7C
	hy9DYJ56nrW7botHNhnZOv21T+kCeiHKhxvbx99SICILiVpFST+viMk+xtuOvWzS1mQCa7Wv+Utxm
	lFYwVfZhRk9tTCzxJn2tHer0IErpQ7zs4qHG8T5nvlLxjirWzBr+dmeMy2yVRgMG+7EChk+VThL5t
	I+QLFl3YBlldy5Z9rK8vJ2CbsFXbYhmsX35KisGuyWVjB2qfIGZzS2QMdSTSGSskpr+hS/eX9pAlr
	d8itJm5Fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWLr-0007YP-9z; Tue, 23 Feb 2021 11:59:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWLj-0007Vr-Nt
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 11:59:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 643EAADE5;
 Tue, 23 Feb 2021 11:59:29 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nvme: add 'fail_if_no_path' sysfs attribute
Date: Tue, 23 Feb 2021 12:59:21 +0100
Message-Id: <20210223115922.104369-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223115922.104369-1-hare@suse.de>
References: <20210223115922.104369-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_065932_077520_4C065F1F 
X-CRM114-Status: GOOD (  21.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In some setups like RAID or cluster we need to return an I/O error
once all paths are unavailable to allow the upper layers to start
their own error recovery (like redirecting I/O to other mirrors).
This patch adds a sysfs attribute 'fail_if_no_path' to allow the
admin to enable that behaviour instead of the current 'queue until
a path becomes available' policy.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  5 ++++
 drivers/nvme/host/multipath.c | 43 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4de6a3a13575..2fb3ecc0c53b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3464,6 +3464,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_fail_if_no_path.attr,
 #endif
 	NULL,
 };
@@ -3494,6 +3495,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
+	if (a == &dev_attr_fail_if_no_path.attr) {
+		if (dev_to_disk(dev)->fops == &nvme_bdev_ops)
+			return 0;
+	}
 #endif
 	return a->mode;
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0696319adaf6..d5773ea105b1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -283,10 +283,18 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 			continue;
 		switch (ns->ctrl->state) {
 		case NVME_CTRL_LIVE:
+			if (!test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+				      &head->flags))
+				return true;
+			if (ns->ana_state != NVME_ANA_INACCESSIBLE &&
+			    ns->ana_state != NVME_ANA_PERSISTENT_LOSS)
+				return true;
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			/* fallthru */
-			return true;
+		case NVME_CTRL_CONNECTING:
+			if (!test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+				      &head->flags))
+				return true;
 		default:
 			break;
 		}
@@ -641,6 +649,37 @@ static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
 }
 DEVICE_ATTR_RO(ana_state);
 
+static ssize_t fail_if_no_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sprintf(buf, "%d\n",
+		       test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags) ?
+		       1 : 0);
+}
+
+static ssize_t fail_if_no_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int fail_if_no_path, err;
+
+	err = kstrtoint(buf, 10, &fail_if_no_path);
+	if (err)
+		return -EINVAL;
+
+	if (fail_if_no_path <= 0)
+		clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
+	else
+		set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
+	return count;
+}
+DEVICE_ATTR(fail_if_no_path, S_IRUGO | S_IWUSR,
+	fail_if_no_path_show, fail_if_no_path_store);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..3d2513f8194d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -418,6 +418,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
+#define NVME_NSHEAD_FAIL_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -694,6 +695,7 @@ static inline void nvme_trace_bio_complete(struct request *req)
 
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
+extern struct device_attribute dev_attr_fail_if_no_path;
 extern struct device_attribute subsys_attr_iopolicy;
 
 #else
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
