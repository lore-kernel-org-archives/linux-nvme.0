Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C45E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 07:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jKKx6zvLfG9PFusl2jYrYAgVeuc73Za0yVj7m1K0F+I=; b=yy6+8ODLOFQ6YuTRE+rJjAXoDY
	CQHFpXxspuZYRA1mmcyJ8PsgOQtvWi0hYy2UN3uCsZXcxFxxQBZxfE36MytKjQXiNtTeyJHYaXmZY
	rGzAMeq4uyUtQzsJbEfVL4Jyckl0hgjS20jBP6XDED2GOUxL0UCHSUxQVbAgImL90Y5v9tmcYrn3O
	F1a6cFPFA3XMf2FK0ijki0R6NE5mPWpXpXDSNKFuggbJ+l2XX8sSf/PugAANEYhDdLqWBGcNpfjWb
	Yga57UWfZbsFBurnY9MVy/PQo8VVayQ08q3GK/qJUW0PRcScR+edYPlTdvcShQE89N/IvltVDSRA9
	w77TzDxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKXvj-00000006fNg-28bg;
	Mon, 09 Dec 2024 07:11:43 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKXvf-00000006fKy-42Fa
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 07:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733728296; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jKKx6zvLfG9PFusl2jYrYAgVeuc73Za0yVj7m1K0F+I=;
	b=TUpqOzUmtqKDKG2h5HDClh0cp03dgdwbvfd6sUyxgDA7+Ap3lkWUqhAsIV1gK8m3EgHyiywC6roZytO8nuE7Ws1WlkV8v//VO+KvgscKYdsZYpCI5hFJdgrJfzC/ZWD+mmHCcowzsVxSRl7MvNoMSt6ndnOIaPyvNHPesTDajog=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WL3sk2u_1733728287 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 15:11:34 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH separate v3] docs, nvme: introduce nvme-multipath document
Date: Mon,  9 Dec 2024 15:11:27 +0800
Message-ID: <20241209071127.22922-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_231140_485276_D0C8B71A 
X-CRM114-Status: GOOD (  17.39  )
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

This adds a document about nvme-multipath and policies supported
by the Linux NVMe host driver, and also each policy's best scenario.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Hi,
  We found that we should take care of the throughput of each path in
service-time policy, so separate the doc patch. And continue working
on service-time policy patch.

Changes from v2 to v3:
- Move this new rst file to admin-guide dir, and add it to index.rst(Jonathan).

Changes from v1 to v2:
- Remove service-tome policy.

 Documentation/admin-guide/index.rst          |  1 +
 Documentation/admin-guide/nvme-multipath.rst | 72 ++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/admin-guide/nvme-multipath.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index e85b1adf5908..15a522a96e76 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -136,6 +136,7 @@ configure specific aspects of kernel behavior to your liking.
    vga-softcursor
    video-output
    xfs
+   nvme-multipath
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
new file mode 100644
index 000000000000..97ca1ccef459
--- /dev/null
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Linux NVMe multipath
+====================
+
+This document describes NVMe multipath and its path selection policies supported
+by the Linux NVMe host driver.
+
+
+Introduction
+============
+
+The NVMe multipath feature in Linux integrates namespaces with the same
+identifier into a single block device. Using multipath enhances the reliability
+and stability of I/O access while improving bandwidth performance. When a user
+sends I/O to this merged block device, the multipath mechanism selects one of
+the underlying block devices (paths) according to the configured policy.
+Different policies result in different path selections.
+
+
+Policies
+========
+
+All policies follow the ANA (Asymmetric Namespace Access) mechanism, meaning
+that when an optimized path is available, it will be chosen over a non-optimized
+one. Current the NVMe multipath policies include numa(default), round-robin and
+queue-depth.
+
+To set the desired policy (e.g., round-robin), use one of the following methods:
+   1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
+   2. or add the "nvme_core.iopolicy=round-robin" to cmdline.
+
+
+NUMA
+----
+
+The NUMA policy selects the path closest to the NUMA node of the current CPU for
+I/O distribution. This policy maintains the nearest paths to each NUMA node
+based on network interface connections.
+
+When to use the NUMA policy:
+  1. Multi-core Systems: Optimizes memory access in multi-core and
+     multi-processor systems, especially under NUMA architecture.
+  2. High Affinity Workloads: Binds I/O processing to the CPU to reduce
+     communication and data transfer delays across nodes.
+
+
+Round-Robin
+-----------
+
+The round-robin policy distributes I/O requests evenly across all paths to
+enhance throughput and resource utilization. Each I/O operation is sent to the
+next path in sequence.
+
+When to use the round-robin policy:
+  1. Balanced Workloads: Effective for balanced and predictable workloads with
+     similar I/O size and type.
+  2. Homogeneous Path Performance: Utilizes all paths efficiently when
+     performance characteristics (e.g., latency, bandwidth) are similar.
+
+
+Queue-Depth
+-----------
+
+The queue-depth policy manages I/O requests based on the current queue depth
+of each path, selecting the path with the least number of in-flight I/Os.
+
+When to use the queue-depth policy:
+  1. High load with small I/Os: Effectively balances load across paths when
+     the load is high, and I/O operations consist of small, relatively
+     fixed-sized requests.
-- 
2.43.0


