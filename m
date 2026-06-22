Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0850CD98F2
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=60nlWTe7L0pbY3ILrnKRNEGZGF1g76Jz8bfCQz4D9xo=; b=a12MEYJ9iO/QY7K2JivCpZZf47
	Ono/NlNbbOaZHhwSeFOnizdG7Ca5oGJrqLNLwx4PDnJfHI4PoKpUK5M1wBPcTCO4YQDK4eqQclZXm
	1z5qWPe/wNtt9huRgv9buxqoM2vyEjXUE8XXB0vAfOr50nIHlNeSnwYqqYdNl25fPQuWQ8BMqGMeX
	IwO90nLuTry5JdN23GuYDpR/pr2iVHQD/XRUMhwUedQA7WSo+RdCiIgsP2a6h0tDG90GbFMt6nwAH
	KADG/rSuK+P0ZmEIvlDcT5KhjVqja8JUhgyJehA6PDXkuuYpjSCXzwRH4s9jfg8L5Iy46tCMRmhsr
	+xA596nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbeJK-00000004zYE-1yeZ;
	Mon, 22 Jun 2026 13:03:34 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbeJH-00000004zXs-0q9w
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 13:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782133408; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=60nlWTe7L0pbY3ILrnKRNEGZGF1g76Jz8bfCQz4D9xo=;
	b=ktKRw2LCaHX40+DO5zcmKikFhKIdMXI0Ez3x3ViWN53Xa0fhwGBzdj7YZL606H/MGM9UfCS54gf57hLonFyOzvHktz0yr242p0FHM6B1K4pfTySWnNaZIaWwSImed9d2+XSxFiutatI2gcYHLijHt/HPmZjBkwQ/Z3EQ+QJniWY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5NoecN_1782133402;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5NoecN_1782133402 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 21:03:23 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-multipath: expose path_state via sysfs
Date: Mon, 22 Jun 2026 21:03:18 +0800
Message-ID: <20260622130318.2346995-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_060331_458946_EAC4929C 
X-CRM114-Status: GOOD (  14.19  )
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
device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
the path is currently enabled or disabled with a specific reason.

The attribute reflects the result of nvme_path_is_disabled() checks:
  - "enabled"                   : path is available for I/O
  - "disabled (ctrl_down)"      : controller is not live/deleting
  - "disabled (ana_pending)"    : ANA state change pending
  - "disabled (ns_not_ready)"   : namespace is not ready

This gives userspace visibility into the multipath path selection state
without requiring users to piece together controller state and namespace
flags manually.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
v1->v2:
- Show specific disabled reason instead of just "disabled":
  "disabled (ctrl_down)", "disabled (ana_pending)",
  "disabled (ns_not_ready)". (Nilay Shroff)

 drivers/nvme/host/multipath.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  4 +++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 81fff2f20d23..5e3847fd6632 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1210,6 +1210,22 @@ static ssize_t in_flight_bytes_show(struct device *dev,
 }
 DEVICE_ATTR_RO(in_flight_bytes);
 
+static ssize_t path_state_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
+
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
+		return sysfs_emit(buf, "disabled (ctrl_down)\n");
+	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		return sysfs_emit(buf, "disabled (ana_pending)\n");
+	if (!test_bit(NVME_NS_READY, &ns->flags))
+		return sysfs_emit(buf, "disabled (ns_not_ready)\n");
+	return sysfs_emit(buf, "enabled\n");
+}
+DEVICE_ATTR_RO(path_state);
+
 static ssize_t relative_throughput_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2b2627e0d3ce..bb9b8cdf973a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1066,6 +1066,7 @@ extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_in_flight_bytes;
 extern struct device_attribute dev_attr_relative_throughput;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_path_state;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6309af224c93..5110a3bf5279 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -262,6 +262,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_in_flight_bytes.attr,
 	&dev_attr_relative_throughput.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_path_state.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
@@ -296,7 +297,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 			return 0;
 	}
 	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_in_flight_bytes.attr ||
-	    a == &dev_attr_relative_throughput.attr || a == &dev_attr_numa_nodes.attr) {
+	    a == &dev_attr_relative_throughput.attr || a == &dev_attr_numa_nodes.attr ||
+	    a == &dev_attr_path_state.attr) {
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-- 
2.43.7


