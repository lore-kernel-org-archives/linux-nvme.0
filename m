Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5951DC531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=11zLolhSa3fdytXbUnRNZfwjZtCDYnbWBft6GR0bl/0=; b=4BMu0f9REc1qmCuyFNFzFvx8ge
	9Ibdw0CdPL0skRb5EUVrQ823h2ZUHcSGstniXe2rW2uDkHMlEKMoX0XRZXiQlhAUWo++lY/5PqRJ3
	SWFyQD6tX8wr3aQNMWkb6dYa0A1aZ11C33ljdBjSPsSy6bldgdczkjbHUHVBEm68JiVw+q6YEWM69
	/FfNsRZzzGCfkX5Swbd9yRk22yBCNa5/oDDNgsKzGYxaqjHNuzt6hy21bY1K28hI9feQK8mzkk8Y/
	Rg/R37IgktNrw4pjd10SG+/3uYlnemwedoyHHV0jdqZUehRZtrjlNU6aFz5rDEAcE7J57QGNyntkw
	jTa+iXOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBla-0000000FtXW-0jpX;
	Fri, 24 Jul 2026 09:00:26 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnBlU-0000000FtVM-2JA0
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 09:00:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784883616; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=11zLolhSa3fdytXbUnRNZfwjZtCDYnbWBft6GR0bl/0=;
	b=sCk+IK/wdkXvHnVZFBAez45egLK+GGPMEkwNNqUT1aVcNyn9rHcgCvb0cgIGwImECh6M1WBeJxu0fr/VA1Qm4M48Ab0V/1LxA1Ssc9aSJDmHC3N8b85exsP5DD8U3QqVIFFArcAzdrwpAXIs9iroHgy/OgGLevvifriTE8ZAp0s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X7ipLTF_1784883613;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X7ipLTF_1784883613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 17:00:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/2] nvme-multipath: expose path_state via sysfs
Date: Fri, 24 Jul 2026 17:00:03 +0800
Message-ID: <20260724090004.1146014-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260724090004.1146014-1-kanie@linux.alibaba.com>
References: <20260724090004.1146014-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_020021_371691_8D1776AC 
X-CRM114-Status: GOOD (  15.72  )
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

Add a read-only "path_state" sysfs attribute to each NVMe path namespace
device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
current path state, including whether the path is enabled or disabled
with a specific reason.

Factor the path disable checks from nvme_path_is_disabled() into a new
nvme_path_get_state() helper that returns an enum nvme_path_state. This
keeps the path selection logic and sysfs reporting in sync, so any future
updates to the path disable criteria are automatically reflected in the
sysfs output.

Possible values:
  - "enabled"      : path is usable for I/O
  - "ctrl-down"    : controller is not live
  - "ana-pending"  : ANA state change pending
  - "ns-not-ready" : namespace is not ready

This gives userspace visibility into the multipath path selection state
without requiring users to piece together controller state and namespace
flags manually.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/multipath.c | 47 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  4 ++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..84230ac02a48 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -288,7 +288,14 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 }
 
-static bool nvme_path_is_disabled(struct nvme_ns *ns)
+enum nvme_path_state {
+	NVME_PATH_ENABLED,
+	NVME_PATH_DISABLED_CTRL_DOWN,
+	NVME_PATH_DISABLED_ANA_PENDING,
+	NVME_PATH_DISABLED_NS_NOT_READY,
+};
+
+static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
 
@@ -298,11 +305,17 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	 * Otherwise it will fail immediately and return to the requeue list.
 	 */
 	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
-		return true;
-	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
-	    !test_bit(NVME_NS_READY, &ns->flags))
-		return true;
-	return false;
+		return NVME_PATH_DISABLED_CTRL_DOWN;
+	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		return NVME_PATH_DISABLED_ANA_PENDING;
+	if (!test_bit(NVME_NS_READY, &ns->flags))
+		return NVME_PATH_DISABLED_NS_NOT_READY;
+	return NVME_PATH_ENABLED;
+}
+
+static bool nvme_path_is_disabled(struct nvme_ns *ns)
+{
+	return nvme_path_get_state(ns) != NVME_PATH_ENABLED;
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
@@ -1105,6 +1118,28 @@ static ssize_t queue_depth_show(struct device *dev,
 }
 DEVICE_ATTR_RO(queue_depth);
 
+static const char * const nvme_path_state_names[] = {
+	[NVME_PATH_ENABLED]			= "enabled",
+	[NVME_PATH_DISABLED_CTRL_DOWN]		= "ctrl-down",
+	[NVME_PATH_DISABLED_ANA_PENDING]	= "ana-pending",
+	[NVME_PATH_DISABLED_NS_NOT_READY]	= "ns-not-ready",
+};
+
+static ssize_t path_state_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	enum nvme_path_state state = nvme_path_get_state(ns);
+	const char *name = "unknown";
+
+	if (state < ARRAY_SIZE(nvme_path_state_names) &&
+	    nvme_path_state_names[state])
+		name = nvme_path_state_names[state];
+
+	return sysfs_emit(buf, "%s\n", name);
+}
+DEVICE_ATTR_RO(path_state);
+
 static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..9a9af2a24136 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1075,6 +1075,7 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_path_state;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 75b2d69b5957..c457a2c67c0b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -261,6 +261,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_path_state.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
@@ -294,7 +295,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
-	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr) {
+	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr ||
+	    a == &dev_attr_path_state.attr) {
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-- 
2.43.7


