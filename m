Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F72CCF2DB
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 07:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPoejeJmKAZ2DI6UT2mo3hMico0U4s0b/qbAJG+YvPw=; b=qIhZDFbHFfnJF0V5sBngeDZGOT
	O0HoEYJZpYnDTuNW3i9u36N1UiYXliz2Q24Lo8+hME77w+65W//9864LI9GzGqVdQbI8bUdTGYtN3
	xFzEgtmsnfZlhg7XAB1fOe2FvJSih3239KVEfC9naknRjY1xzCEhP7Wa2cX0xe+DHjnii+VsW5NcR
	ZDpWpPZZnuOr03wZclxe3/kZrjy6oeR8sA0IkVc2sSyxb/mZ1tUWkhDpLg5FrGqi3Gx/nd4ZO94xr
	suQ2ENeVVNOBgccxzBgTlLOVUoCHMqFbIkR9kzEFa12097DDAZTkNS8dlLdYjsKBI9NJgxTNz4KF6
	Z92AXaDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiEI-00000006njH-0e7X;
	Mon, 19 Oct 2026 07:56:22 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIiED-00000006ngT-401f
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 07:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792396575; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sPoejeJmKAZ2DI6UT2mo3hMico0U4s0b/qbAJG+YvPw=;
	b=c/T8AtcU0RTT4CbFv+q+38zHFssO9UP3vbTGJX3doSt83ViNrb6M3jWRTShZOFgfML+95bb0zqAfDyIa1Qv8l263cjXuztwgb0TS8tBG4l5NMloa9ixMK3zCXsm22u3icp234uQLkVFLSzDSnaSYbeYTZzNm6FlGuheZxAQClIQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XD2O8x-_1792396574;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XD2O8x-_1792396574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 15:56:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/3] nvme-multipath: document service-time iopolicy
Date: Mon, 19 Oct 2026 15:56:04 +0800
Message-ID: <20261019075607.808947-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261019075607.808947-1-kanie@linux.alibaba.com>
References: <20261019075607.808947-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_005618_140721_5B21A78E 
X-CRM114-Status: GOOD (  12.89  )
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

Add documentation for the service-time path selection policy: its
algorithm, the in_flight_bytes and relative_throughput sysfs
attributes, and guidance on when to prefer it over queue-depth.

Document that setting relative_throughput to 0 makes the path a
standby that is only selected when no path with a positive value is
available.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 31 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459b..2acfceaf3d652 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -24,8 +24,8 @@ Policies
 
 All policies follow the ANA (Asymmetric Namespace Access) mechanism, meaning
 that when an optimized path is available, it will be chosen over a non-optimized
-one. Current the NVMe multipath policies include numa(default), round-robin and
-queue-depth.
+one. Current the NVMe multipath policies include numa(default), round-robin,
+queue-depth and service-time.
 
 To set the desired policy (e.g., round-robin), use one of the following methods:
    1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
@@ -70,3 +70,30 @@ When to use the queue-depth policy:
   1. High load with small I/Os: Effectively balances load across paths when
      the load is high, and I/O operations consist of small, relatively
      fixed-sized requests.
+
+
+Service-Time
+------------
+
+The service-time policy selects the path with the lowest estimated service time.
+It calculates service time as ``in_flight_bytes / relative_throughput`` for each
+path, preferring the path that would complete I/O fastest. Unlike queue-depth
+which counts requests regardless of size, service-time tracks actual bytes in
+flight, making it aware of I/O sizes.
+
+Each path exposes two sysfs attributes under
+``/sys/class/nvme/nvmeX/nvmeXcYnZ/``:
+
+  - ``in_flight_bytes`` (read-only): Current bytes in flight on this path.
+  - ``relative_throughput`` (read-write): Relative throughput weight for this
+    path, default 1. The valid range is 0-100. Set higher values for faster
+    paths. If set to 0, the path is not selected while other paths with
+    positive values are available.
+
+When to use the service-time policy:
+  1. Asymmetric Link Speeds: When paths have different bandwidths, set
+     ``relative_throughput`` proportionally (e.g., 2 for a link twice as fast)
+     to steer more traffic to faster paths.
+  2. Mixed I/O Sizes: When workloads mix small and large I/Os (e.g., 4K and
+     128K), service-time distributes load more accurately than queue-depth
+     because it accounts for actual bytes rather than request count.
-- 
2.43.7


