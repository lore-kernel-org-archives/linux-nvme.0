Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A25ECD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thSN4qiuwD7kJRMtpqlhr/2Ldd7hTJyaIcnEUOs28zg=; b=jKIasdcr5jr6lNd7jz6hZjvy5g
	FnKqNDNGruLGMnGqCbm90ABG4codPMENqS1M1SxTyTiy5YNzEUqnlbdkjlIeeRO41tsZVkki15XNY
	ioELt3EI7RULYmfm7GOmjQD9zQ/EeErHT9YWMUGt+Qa1CHMvFmoQAUcwZUwCD/NpvVw25jDGUql1k
	O4540A7Lae3CtthP6H86E9opjb0+89sIrHERyRuZfoERN9SwydTTmKsUI5BRo/qkWJE4BtSVE2MD8
	pB5tbl7kegnBOK3HozwgyI/0BVC5ptREYKTUh2GodkF15gmyF0QTcd3B2Es5xZCerHiQzAsKOXKZz
	pNMdA2/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoiv-0000000HFze-0NEk;
	Wed, 17 Jun 2026 11:46:25 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZois-0000000HFyM-2rCt
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781696779; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=thSN4qiuwD7kJRMtpqlhr/2Ldd7hTJyaIcnEUOs28zg=;
	b=TdZ75Uf4SI3vWLyGZfp5eGGFl9jljENVKH/NOZW6nnLWpFESRB/h+2lrt1F9acOIj8R/RiGZEbeiWjpJVsFay/zqGw5XtembwMYLbtAOW793vg11+09s762ETvUo59mhIB3PlFyBLpqBj5nK5yEcuQkL45Iauc32j7BTujh/O38=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X53e-V2_1781696772;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X53e-V2_1781696772 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 19:46:16 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	onathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: nvme-multipath: document service-time I/O policy
Date: Wed, 17 Jun 2026 19:45:59 +0800
Message-ID: <20260617114602.2224074-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260617114602.2224074-1-kanie@linux.alibaba.com>
References: <20260617114602.2224074-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_044622_880932_D9539ECD 
X-CRM114-Status: GOOD (  12.60  )
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

Add documentation for the service-time path selection policy, including
its algorithm overview, sysfs attributes (in_flight_bytes and
relative_throughput), and guidance on when to use it over queue-depth.

Document that setting relative_throughput to 0 makes the path a standby
that is only used when no path with a positive value is available.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 31 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459..2acfceaf3d65 100644
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


