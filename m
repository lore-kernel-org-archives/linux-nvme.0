Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E75D65C5B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=50JYuQoyZWYlTtLxYbSNXEYpz+gzqwTYJxm4o26DrXc=; b=ZkPGAeuM3u8Bz7jhhTjSsaJmKw
	6AM22gIJtFT2MTLc7SLahQC8vGRRQ+iyJ4YvzpafF6rmiZD2JOAy+TBvVZibpSCMQfRZ/KUJMKDkI
	JSA0hDErp95wUpV+DnnY949AVqgyJloBUd0pb2DX1aLzU28t4N+2SpzGeL6oV9648+IWoOJnaH3E1
	mtycK90zhHxlbtIDPrziPAGsuoZk0F56R025/6FgXEoj0QA7DaXiFSx293rJLH3pyLN4l6t/2uuXv
	KHH6rwv4dzpujDkukmL6qVuoaaeEDIu5qKUAdL+tucx5k6MlQa5dkk6jlKylt1B57eiDCcpBnvIBI
	Z+cau9zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVYV-00000009Fof-2UFC;
	Thu, 14 Nov 2024 08:50:23 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVYS-00000009FnN-2ahO
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 08:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731574218; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=50JYuQoyZWYlTtLxYbSNXEYpz+gzqwTYJxm4o26DrXc=;
	b=HoN/qJeMVg6ts+2FVJi95MiZCYse1FpR1LdImFBmAapqTIgLgakYuVcRoS6b1mDCHNZ1m3goNjvS9fwaBIjxAnkFm/mYdLxjne5P512o0S9pXdeVHJXEMphedwvUskoMYRWTedAUQCKJejaYA7e51Olf1N3qIclZzaFkc8ByOpc=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJO9Hmj_1731574207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 16:50:11 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND v3 2/2] docs, nvme: add a nvme-multipath document
Date: Thu, 14 Nov 2024 16:49:57 +0800
Message-ID: <20241114084957.41787-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114084957.41787-1-kanie@linux.alibaba.com>
References: <20241114084957.41787-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_005020_834050_38DEC15C 
X-CRM114-Status: GOOD (  15.73  )
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
 Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/nvme/nvme-multipath.rst

diff --git a/Documentation/nvme/nvme-multipath.rst b/Documentation/nvme/nvme-multipath.rst
new file mode 100644
index 000000000000..bb9ef6fc3e9d
--- /dev/null
+++ b/Documentation/nvme/nvme-multipath.rst
@@ -0,0 +1,83 @@
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
+one. Current the NVMe multipath policies include numa(default), round-robin,
+queue-depth and service-time.
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
+
+
+Service-Time
+------------
+
+The service-time policy distributes I/O requests based on the total size of
+in-flight I/Os, selecting the path with the least total size.
+
+When to use the service-time policy:
+  1. Highly Variable Workloads: Adapts to unpredictable and varying I/O patterns
+     by directing requests to the most responsive paths.
-- 
2.43.0


