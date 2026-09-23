Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85676C982FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 00:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R5jpAPIMZLFGTrbvDXQwJHP1pOAi8XkuInl/G/CkKXE=; b=Fe+cyZIpvmjsD6Joszht7ORZAw
	75Li8k28L00XIRkdIhwIMd7yOqGQsWgzU8kk7H9XOKmf78294IlumdYd3nLzT25iz6qQd1lHitFYs
	sdnHcW5NHzpav+HVbu2FbN30X5UWgrEaK7cOdGwBzifu6SWPwnMf2sTNDYMkhq4ewSw7mKHUlb98u
	lB4nttgb1i3h7YOMWhI75PBFlHDUuJ35oE0vFbJ8xK0fu4ecU4poU1MIeEvzVbqECCa/G0idkv01H
	XV16RVpsTNCw0HJCvuyfenpJN9k1usHtVgBHHkHCbhpqighh1jFx1vuZURv8aK+ZQYTHVRR7TvQAK
	jdxd7gOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9BBW-00000006ojb-2oqm;
	Wed, 23 Sep 2026 00:50:06 +0000
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9BBS-00000006ojG-3sTU
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 00:50:04 +0000
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-3286624d194so274715eec.3
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 17:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1790124602; x=1790729402; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R5jpAPIMZLFGTrbvDXQwJHP1pOAi8XkuInl/G/CkKXE=;
        b=MOpeCIt0bGP4uMXMN4Fdk4G7E1AM3/Youx7nmYtzkh03RZGOakQINO3E4WOO4nMVWV
         Bn9zj841URVw3Ti1MRTQvuy6Exn5fRsNUvTwdRmZVMbYk3Sk3lneNDYf4bn57/g86xum
         X0Cn/EFXz8LvPpAgNSuNs9UZl4xknTmZUs0NH2hY+g6Fnq73CY6cDHaTg6CreNa3d9OT
         4NQmIOadMA1CjlTnenWQzvHoRDeTdmDU5kPp3Z+q+JBhr3NTWyj5xi1Lc3PUVcfYMdJI
         RizTsIXx2HcFEJXbDhHg0dshnPY7CaUNrp361veAX49dMasYBuSALxEyxN6j5ZsCO/WD
         +nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790124602; x=1790729402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R5jpAPIMZLFGTrbvDXQwJHP1pOAi8XkuInl/G/CkKXE=;
        b=Za2MFTWNXINu9RTPG9RX/DmfxVOlVaCyVivf2N5biCJhy+Z6b3xTwXTv+huvgU/z63
         FSMOvJC4V5eqc8J5KULb4Vb3Jz9g8zsJNIWBMXY1Oe8nWuMWiN2XwqXlpSyetnH1FE2w
         Eg/Fod2p5i3mYTKLbmaKZ0UFNdgk4Y1KOFNoTfBdPNeumISrJ0woPp0MP+5oolVwLpEd
         HufcvaVFpaQIjUy6ui9Y9ILuGZWJzIJR6hEd45Si53RuSDfAqHAHj81OB31irt8tULZU
         3xiiBOb2N/wYWdeOGkmwfGMr3phR4rUkIkfYaPtoxt3w7BHssJMzf7jp9KCerwFzaSQf
         sD+w==
X-Gm-Message-State: AFuF++kCJ8tLPG3QnUZwZIl5hz2OZv0zZ8UBJJDcGQOJN7d4mAH5uM0z
	N0XmafmngvlKCroqdFwcnAUcNUY4txw8uVrnNeCosCOxOEmqYOPO3t57VW5J8srgvcA=
X-Gm-Gg: AYBFou1P3tMDZWmkPVpI8yQ6EPkwj3B087c0f1HKNrbDSTRcDeM/Wy14avUaU3q+ne6
	D1bVRrT6f5cR5x6BV48ioxddvXgfimjjlN7OY5Azc117VhWgvnCN/aSYOHJ6o7Ag58dsxJNf2fX
	Hp/lUIBDEPfOT4gGugBYZK/igwtEw4NJEeJ+eIAsDVG/u7pc3DctEhJ+pXFq5SXSrc52B9ZnhiO
	u5JD1sPqB7T4S7Ts4DIwJbiHjePKyolDfI8VR3sAb3KrcpbAMy312mBxs5/XLN07BwRrV8/VTGx
	Da8V1nGe3aSvU4l6JvkyJqgRcKQ/aDhMhW9GjSaGpitUiWkOLBb3061d7xMfXRC6fTnYB2A5oYn
	ztDxmjFQjSwuFZBKYG72NJAem2EwuSFQIMTFWCKyhOWEb8iRYUT5akGZ8IXZPhwyANjDcIq8xFC
	IpZStWIsuKDBucc0C5rJaDoUjUTmBhkR5cG2u3fsSpd+zKGpriRTUFUIGrYWWcePdonLhfNWDO5
	kP1U4XBKxBeUU7P6IYJZbHcTWSSKBk5sg==
X-Received: by 2002:a05:693c:638c:20b0:33e:3f5b:3ff6 with SMTP id 5a478bee46e88-33e8ca260d7mr1084183eec.18.1790124601462;
        Tue, 22 Sep 2026 17:50:01 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e498f0sm1693098eec.27.2026.09.22.17.50.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 17:50:01 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nilay@linux.ibm.com,
	sjpark@crusoe.ai,
	saravanand@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH v3] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Tue, 22 Sep 2026 17:49:59 -0700
Message-ID: <20260923004959.88440-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_175002_984879_DF680261 
X-CRM114-Status: GOOD (  24.33  )
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

When no usable path exists, I/O on a multipath namespace is queued
until a path returns. With ctrl_loss_tmo=-1 that can be forever:
during a long fabric outage any process waiting on the I/O is stuck in
D state. We hit this on virtualization hosts, where a SIGKILLed VM
process cannot exit while draining I/O to an unreachable NVMe/TCP
target.

Nothing can fail this I/O without tearing something down: controller
deletion takes every namespace on the controller with it.

Add a fail_if_no_path attribute on the ns-head disk: a persistent
per-namespace policy to fail parked and newly arriving I/O instead of
queueing it when no usable path exists. It is enforced where a path is
known to be unusable: CONNECTING controllers and LIVE controllers with
the path ANA inaccessible or persistent-loss stop counting as
available, RESETTING and ANA change keep queueing, and with no
controllers left the policy overrides the delayed_removal_secs
queueing window. Controller state is untouched and reconnects
continue. Like dm's fail_if_no_path, the policy is transport agnostic.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
Changes since v2 [1]:
- use the nvme_state_is_live() helper for the ANA state check, keeping
  the explicit NVME_ANA_CHANGE carve-out so transient ANA transitions
  still queue (Nilay)
- return early when the stored value matches the current setting,
  skipping synchronize_srcu() and the requeue kick (Nilay)

Validated on hardware with a 6.17 backport of this v3: parked I/O on a
SIGKILLed VM process failed within a second of enabling the policy and
the process was reaped, new I/O failed fast during the outage, the
policy persisted across path recovery, and disabling it restored
queueing.

[1] https://lore.kernel.org/linux-nvme/20260917231647.79956-1-kiyer@crusoe.ai/
 Documentation/ABI/stable/sysfs-nvme | 13 +++++
 drivers/nvme/host/multipath.c       | 76 ++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h            |  2 +
 drivers/nvme/host/sysfs.c           |  4 +-
 4 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db4..57a827235995 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -337,6 +337,19 @@ Description:
 		is deferred. Only visible on multipath head devices.
 		Requires CONFIG_NVME_MULTIPATH.
 
+What:		/sys/block/nvmeXnY/fail_if_no_path
+Date:		September 2026
+KernelVersion:	7.3
+Contact:	Krishna Iyer <kiyer@crusoe.ai>
+Description:
+		Shows or sets the fail-if-no-path policy of the multipath
+		head device ("on" or "off", default "off"). When on, I/O
+		queued or arriving while no usable path exists is failed
+		immediately instead of being queued, including during the
+		delayed_removal_secs window. Reconnect attempts are not
+		affected. Only visible on multipath head devices.
+		Requires CONFIG_NVME_MULTIPATH.
+
 What:		/sys/block/nvmeXnY/csi
 What:		/sys/block/nvmeXnY/metadata_bytes
 What:		/sys/block/nvmeXnY/nuse
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 99ecc73393e5..3736ba709b6c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -496,9 +496,16 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	}
 }
 
+static inline bool nvme_state_is_live(enum nvme_ana_state state)
+{
+	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 	__must_hold_shared(&head->srcu)
 {
+	bool fail_if_no_path = test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+					&head->flags);
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
@@ -510,14 +517,29 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 			continue;
 		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
+			/*
+			 * ANA change is transient and bounded by ANATT, so
+			 * keep queueing while it resolves.
+			 */
+			if (fail_if_no_path &&
+			    !nvme_state_is_live(ns->ana_state) &&
+			    ns->ana_state != NVME_ANA_CHANGE)
+				continue;
+			return true;
 		case NVME_CTRL_RESETTING:
-		case NVME_CTRL_CONNECTING:
 			return true;
+		case NVME_CTRL_CONNECTING:
+			if (!fail_if_no_path)
+				return true;
+			continue;
 		default:
 			break;
 		}
 	}
 
+	if (fail_if_no_path)
+		return false;
+
 	/*
 	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
 	 * not immediately fail I/O. Instead, requeue the I/O for the configured
@@ -871,11 +893,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 	return 0;
 }
 
-static inline bool nvme_state_is_live(enum nvme_ana_state state)
-{
-	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
-}
-
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
@@ -1180,6 +1197,53 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t fail_if_no_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+			&head->flags) ? "on\n" : "off\n");
+}
+
+static ssize_t fail_if_no_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	/* No-op if the stored value matches the current setting. */
+	if (enable) {
+		if (test_and_set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags))
+			return count;
+	} else {
+		if (!test_and_clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+					&head->flags))
+			return count;
+	}
+
+	/*
+	 * Ensure that update to NVME_NSHEAD_FAIL_IF_NO_PATH is seen
+	 * by its reader.
+	 */
+	synchronize_srcu(&head->srcu);
+
+	/* Make already-queued I/O re-evaluate path availability. */
+	if (enable)
+		kblockd_schedule_work(&head->requeue_work);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(fail_if_no_path);
+
 static ssize_t multipath_failover_count_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a643c4723a69..9773538101ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -590,6 +590,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
+#define NVME_NSHEAD_FAIL_IF_NO_PATH	3
 	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
@@ -1097,6 +1098,7 @@ extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_fail_if_no_path;
 extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
 extern struct device_attribute dev_attr_io_fail_no_available_path_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1e3dcfd084b..56e0ce1c9d8a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -264,6 +264,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_fail_if_no_path.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -300,7 +301,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-	if (a == &dev_attr_delayed_removal_secs.attr) {
+	if (a == &dev_attr_delayed_removal_secs.attr ||
+	    a == &dev_attr_fail_if_no_path.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
 		if (!nvme_disk_is_ns_head(disk))
-- 
2.54.0


