Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7882DC88E72
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U54GrV6tfeeuoW58jIS1gKLXAmziisaAbUtJKoV5Tmg=; b=z58v+9ASifKw9ds4TSZU6ME19H
	SiZA21XhE9VAJa4GDQxqYrH+fBW5uHjSRtQYhugEyq8DvIWZxxGbD4n+i+ZQnAPN2RHrZDdTG8fsT
	94CqOEVu76XEH2GW17UEHeRhbpzqei5nLcT0MONLwt7ItsReLD4NobtSbgWtyxaBI3dLxMYKn1AGm
	hDq97SxRreyMRNagFLQ+7c/wkcuYKkrFZLpYm0FzxCXr1qwivw+MRaI1SHK5lzwdITtd8RkMq7FhO
	48aNojBGWerVyMVYrEsS6W4scSS8L+qOCF3BAoX22UFcPm3tA8CAYGxfJ5cSJuBD9F0l4ivNWOtVP
	8c3oBcTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LLa-0000000Cm7K-0DmO;
	Thu, 17 Sep 2026 23:16:54 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7LLX-0000000Cm6x-2aj0
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 23:16:52 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2db18fe433fso1094685ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 17 Sep 2026 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1789687010; x=1790291810; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U54GrV6tfeeuoW58jIS1gKLXAmziisaAbUtJKoV5Tmg=;
        b=W02HxTHGpXLx1Jn5HPSVAXICuX4YGWjGACJlGxzYN8yGT9ixJMdhoOSpfMfHBK0RCF
         qKBmH+QaCMVxZSlxWlu5BR4EHJcOShQlgHFeeMAuLkgTSbr104pH4jzdRd+SXbCsEeKp
         qNvAf2Kfe8xdnK6W2Q0QOX1L7QpJVnQ1W5dTuwnOsNHOwwFSU6aPcyPIH7yb1TU+GS2o
         1mOh6LAZJZmoe7Gm1FD0mCE1W/ocDoinPgjtdNOh4LdsaHBFSeE4kaPwoIQDlRJGYiNe
         6RzYP4F1UQplr2YLxZqp708slAW6dzvRcjW8XZwc2asjIOGr3n2xGWKu8kLjvRYsJPld
         P/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687010; x=1790291810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U54GrV6tfeeuoW58jIS1gKLXAmziisaAbUtJKoV5Tmg=;
        b=OOxFMLk9GpTD7gcGa5/0aX49aBcbIXVPDCyTSwMMORbp4GAzwawc5ffPIPr9As2Jsm
         orJlXVXZjyiclpI9iqVI3F9d183Q6RLtTTY4lIRlJtKNBeWyyqWxsU9HdJKiwlu+msNS
         kRdAn8jMy74VkbPGHlHsJKlmy/GeZUcNjFJsQTcUWQaF9HDnnDlghuwiHreJrrebOhd/
         bNWgFqbI/N8WyRJAXvd1mayTPDeoDb3CnKID+mSFijyVycfv1bzGT06WW7XaY9DArFTA
         zkpc8m2i7Ds3omrS2uo8V0xT2gOczG7P1jX90SCGNp+zqVKyIZ+QFgJm7nPiYLHzwjXh
         98lg==
X-Gm-Message-State: AFuF++lNSYSGcfLnMe79cCypoZKQjVCMN2x09LmZkpHEgqud+zWIPITQ
	eXxj0lQ7x4wCKRhf/uplRmd0aTVNptEnBk3NRYCJ/5V33ntxf95YNQDtviHU/oG5IVEXerdVn1c
	f9UXnL1QBNg==
X-Gm-Gg: AYBFou2qv3+PuAWPO6sPOxInYgSG9bjnQD2KmQn/jro/2MX744VJbl2KNC6AAa1Oxx8
	uBkCqTWv6nHbKIj2MEEKM04gI6kAksNjVNxkimUgB436gQJKEd7C1zLE2GqmQA2GerX0HRN/GG0
	gKglPjXt9V74pyqgRBmsJTBDvYBkGSHCwCwCVsampF/FOaYYOkjkwygCfTjXJuKkk+XlwYz79h4
	Hu8SrOspqNd3lXd86JdBzlXG2fH3WRNkSTZdGofzcQ/rwaR5O8G1S72mRraRp6GgMRWm5I4t0Bq
	+n6Y6sToT46rH3dm7QugQmjl3oQDhoqjjqlKyRm/FTX5Djy0wI8TWPJYF9TNwu86w71rYnEc3uH
	LlFAEuJeY8h40jAWbIet6MTzuj2diKQxxq9e7l+pkaTJ3jlDGmSHks1DAknXDY1gN9LLI1At+IB
	bQJgxmKF/ewVbw59u5E4jEqp95qONVWqHrjLGLGdHMe16PYiwEH/x+Z5q66fDAuobLAbPNMsQmi
	4xcD1Il3ubOTMMIkocZs2aiAO+gDMLQtw==
X-Received: by 2002:a17:90b:5281:b0:39e:4c7f:8b17 with SMTP id 98e67ed59e1d1-39e54cf8bc1mr1423054a91.28.1789687010086;
        Thu, 17 Sep 2026 16:16:50 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([4.7.95.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c13f09408sm7146854eec.7.2026.09.17.16.16.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 16:16:49 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	SeongJae Park <sj@kernel.org>,
	Saravanan D <saravanand@crusoe.ai>,
	linux-kernel@vger.kernel.org,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH v2] nvme-multipath: add fail_if_no_path sysfs attribute
Date: Thu, 17 Sep 2026 16:16:47 -0700
Message-ID: <20260917231647.79956-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_161651_695651_D18CB3B9 
X-CRM114-Status: GOOD (  21.09  )
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
Changes since v1 [1]:
- rename fail_io_now -> fail_if_no_path; persistent policy, no
  self-clear when a path returns (Nilay)
- enforce inside the nvme_available_path() loop: only CONNECTING and
  ANA-unusable LIVE paths stop counting; resets and ANA transitions
  queue as before (Nilay)
- override delayed_removal_secs when no controllers remain
- keep visibility transport-agnostic (Nilay)
- rebase onto nvme-7.3 (Nilay)
- add Documentation/ABI entry

[1] https://lore.kernel.org/linux-nvme/20260904032605.65758-1-kiyer@crusoe.ai/
 Documentation/ABI/stable/sysfs-nvme | 13 +++++++
 drivers/nvme/host/multipath.c       | 57 ++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h            |  2 +
 drivers/nvme/host/sysfs.c           |  4 +-
 4 files changed, 74 insertions(+), 2 deletions(-)

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
index 3d46c4f28a47..23aeb1737ab5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -499,6 +499,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 static bool nvme_available_path(struct nvme_ns_head *head)
 	__must_hold_shared(&head->srcu)
 {
+	bool fail_if_no_path = test_bit(NVME_NSHEAD_FAIL_IF_NO_PATH,
+					&head->flags);
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
@@ -510,14 +512,25 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 			continue;
 		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
+			if (fail_if_no_path &&
+			    (ns->ana_state == NVME_ANA_INACCESSIBLE ||
+			     ns->ana_state == NVME_ANA_PERSISTENT_LOSS))
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
@@ -1181,6 +1194,48 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
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
+	if (enable)
+		set_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
+	else
+		clear_bit(NVME_NSHEAD_FAIL_IF_NO_PATH, &head->flags);
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
index e0260f4d24fd..ff886673d7ca 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -589,6 +589,7 @@ struct nvme_ns_head {
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
+#define NVME_NSHEAD_FAIL_IF_NO_PATH	3
 	struct nvme_ns __rcu_guarded	*current_path[];
 #endif
 };
@@ -1096,6 +1097,7 @@ extern struct device_attribute dev_attr_ana_state;
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


