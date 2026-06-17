Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76948CD98F6
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TTQ+m4XsVVQsTK8+Cjk16Qu8IrcGQqOyNyxvujKPeaQ=; b=Pxca7vrj8XpGh2r/6JAoA+h5kz
	gdIUmXmuCsMrpZxpAF86C2WsNTy4g5FSKXKxFhSzcSj404TaSTf+xj0mZ9D6TZshQSz2JuQxqIhsa
	uOlblC2oo+pP7cKKpsHsv14ReYCyWF83zz8VnXS47cQo1BHFyQJpj0J/jslO0CBjlAvBdQryWYKby
	XARQg2tkeKqM07kg/q2mhHebt29Jmqaf6VVgE7Zg22L9RCiWzOgTvHtxQIt+EA/5ATJ4LXfEnq/Gr
	+/mHedXMX8xpe0OKOTwC5fY23+lwVZO4zTfUmHNVyoMfwNG2ESh/RaKJuj54wuqWOBFIxENa3dst5
	XvdVhBPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZpBV-0000000HJjx-05Lq;
	Wed, 17 Jun 2026 12:15:57 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZpBQ-0000000HJjC-3ywI
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 12:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781698550; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TTQ+m4XsVVQsTK8+Cjk16Qu8IrcGQqOyNyxvujKPeaQ=;
	b=ojoaxxXfbkmEznDEGbK2LQALAFsA6KOjp3GisJsIivvhp7jrwW8NPzfjCAEcXtjr5yTTCwPXtTB2Oo9TCzkn/sEmw46jSp5hQdFZd0jT0h1PcoRlpHNfDyUGS313dub2YN7adrkIJph5z2L7c3R07Smrj7vx3A1b9mbItn4S9fA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X53e7E6_1781698543;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X53e7E6_1781698543 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 20:15:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: expose path_state via sysfs
Date: Wed, 17 Jun 2026 20:15:43 +0800
Message-ID: <20260617121543.2291455-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_051553_703117_5FFEF1A5 
X-CRM114-Status: GOOD (  13.80  )
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
the path is currently enabled or disabled.

The attribute reflects the result of nvme_path_is_disabled(), showing
"disabled" when the controller is not live/deleting, the namespace has
an ANA state change pending, or the namespace is not ready. Otherwise
it shows "enabled".

This gives userspace visibility into the multipath path selection state
without requiring users to piece together controller state and namespace
flags manually.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 81fff2f20d23..65bd3dd188ee 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1210,6 +1210,16 @@ static ssize_t in_flight_bytes_show(struct device *dev,
 }
 DEVICE_ATTR_RO(in_flight_bytes);
 
+static ssize_t path_state_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	return sysfs_emit(buf, "%s\n",
+			  nvme_path_is_disabled(ns) ? "disabled" : "enabled");
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


