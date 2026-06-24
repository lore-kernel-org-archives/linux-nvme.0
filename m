Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B2BCDB470
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 05:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WER5Vr/7Tndvx0WI/TCtT2wSBfgZJBBDVxLfMR4NJ6o=; b=W7qH3CeX+X8HW9BgYv3q1Bnj7Y
	mjaZTiqgYjYCwCrMND+R6pnNiGpLUUmiMYEMPvRyYF80yJCvrLKoELk+8tsuJxMKruGm7BPsLvMGd
	53HZuj+mM9aoZAcx44KqW48yKzOEAKJwoEEhL3FKuENIW4eXznjgPzW6FdqWZJtlgUQgFEgzNn9Z/
	nGVmOKRr+YtmQ8eEwDr4Pc3KfsTFUa8IOUZRhltHWzmuChkuF36cn+BDQq4mMu/cOH3kJ6wNisCC9
	m4PjCJD0Jf0Wb6r1wKiFRi3RFjITYnLJhzJrnLttgesFQaJNt6ZXQCD3Im320pk9yu2jOekAbL3F5
	+flMepgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcGTu-00000007B21-0coj;
	Wed, 24 Jun 2026 05:49:02 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcGTp-00000007B1M-02x3
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 05:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782280132; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WER5Vr/7Tndvx0WI/TCtT2wSBfgZJBBDVxLfMR4NJ6o=;
	b=hm9zmNjjRkpr/ymaL8iy5qBbrySa0PdrG34dkss4DKuSS0Vy1plwLnl1XO/3W36ssEmzTotbuD/pbSK5m8TbnFBR4Rwvi5+c1VQKK5ZH/k85bjqFNlfSgllWbFM4lStKsIdS6K8Y8aNzdRwe9arwLwuOEwnFkYvCWISt8vVbe+c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5Wzkzu_1782280127;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5Wzkzu_1782280127 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 13:48:48 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3] nvme-multipath: expose path_state via sysfs
Date: Wed, 24 Jun 2026 13:48:43 +0800
Message-ID: <20260624054843.1132083-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_224858_682385_89FF5001 
X-CRM114-Status: GOOD (  15.19  )
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
  - "enabled (optimized)"     : ANA state is optimized
  - "enabled (non-optimized)" : ANA state is not optimized
  - "disabled (ctrl_down)"    : controller is not live
  - "disabled (ana_pending)"  : ANA state change pending
  - "disabled (ns_not_ready)" : namespace is not ready

This gives userspace visibility into the multipath path selection state
without requiring users to piece together controller state and namespace
flags manually.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
v2->v3:
- Factor path disable checks into nvme_path_get_state()
  helper returning enum nvme_path_state, and rebuild
  nvme_path_is_disabled() on top of it to keep path
  selection logic and sysfs reporting in sync.
  (Nilay Shroff)
- Distinguish "enabled (optimized)" vs
  "enabled (non-optimized)" based on ANA state.
  (Keith Busch)

v1->v2:
- Show specific disabled reason instead of just
  "disabled": "disabled (ctrl_down)",
  "disabled (ana_pending)",
  "disabled (ns_not_ready)". (Nilay Shroff)
---
 drivers/nvme/host/multipath.c | 47 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  4 ++-
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e033ede953cc..2da5e9da1866 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -288,7 +288,15 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 }
 
-static bool nvme_path_is_disabled(struct nvme_ns *ns)
+enum nvme_path_state {
+	NVME_PATH_ENABLED_OPTIMIZED,
+	NVME_PATH_ENABLED_NONOPTIMIZED,
+	NVME_PATH_DISABLED_CTRL_DOWN,
+	NVME_PATH_DISABLED_ANA_PENDING,
+	NVME_PATH_DISABLED_NS_NOT_READY,
+};
+
+static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
 
@@ -298,11 +306,20 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
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
+	if (nvme_ctrl_use_ana(ns->ctrl) &&
+	    ns->ana_state != NVME_ANA_OPTIMIZED)
+		return NVME_PATH_ENABLED_NONOPTIMIZED;
+	return NVME_PATH_ENABLED_OPTIMIZED;
+}
+
+static bool nvme_path_is_disabled(struct nvme_ns *ns)
+{
+	return nvme_path_get_state(ns) > NVME_PATH_ENABLED_NONOPTIMIZED;
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
@@ -1101,6 +1118,24 @@ static ssize_t queue_depth_show(struct device *dev,
 }
 DEVICE_ATTR_RO(queue_depth);
 
+static const char * const nvme_path_state_names[] = {
+	[NVME_PATH_ENABLED_OPTIMIZED]		= "enabled (optimized)",
+	[NVME_PATH_ENABLED_NONOPTIMIZED]	= "enabled (non-optimized)",
+	[NVME_PATH_DISABLED_CTRL_DOWN]		= "disabled (ctrl_down)",
+	[NVME_PATH_DISABLED_ANA_PENDING]	= "disabled (ana_pending)",
+	[NVME_PATH_DISABLED_NS_NOT_READY]	= "disabled (ns_not_ready)",
+};
+
+static ssize_t path_state_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%s\n",
+			  nvme_path_state_names[nvme_path_get_state(ns)]);
+}
+DEVICE_ATTR_RO(path_state);
+
 static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b367c67dcb37..da59364d4774 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1072,6 +1072,7 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_path_state;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 933a5adfb7af..500d773300e7 100644
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


