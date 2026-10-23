Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC9607E943
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZzVUzUfL;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mbp9QXc9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=sPoejeJmKAZ2DI6UT2mo3hMico0U4s0b/qbAJG+YvPw=; b=ZzVUzUfLIXuuHZ
	wHcER9O4eRpYb7qmDWCWRte4ZIYwSIG3D4YpUk2dibiq2hktvytabcBbC//O1YyoL2VhObgUChl4P
	YISHFvA95ppVFc8bElmLiFPZMm+KdIrhNl3Cm3DZpmTU6ZVIZSNhlI4VrWTmHpidRQbPcdYc6bKoR
	xutru0waZcVq/JygXJ9oGoCa8HZz0uuWUwlKtTVP5u/5E5GZH7m0c4a9Vvwr11/RlcZQc8hUPN9gq
	e5K0nEyJ2pK7yl+VsXQhKvesf6PV8h3Mu/u8QAnhw6XN1FdfSSA0WpBFbVKYLsNuBehgPFSpkwiIH
	fDYoAo3k5lJW0ROpx23g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9Iz-0000000FhVv-3t57;
	Fri, 23 Oct 2026 07:03:09 +0000
Received: from out199-16.us.a.mail.aliyun.com ([47.90.199.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9In-0000000FhOE-3PKZ
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 07:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792738973; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=sPoejeJmKAZ2DI6UT2mo3hMico0U4s0b/qbAJG+YvPw=;
	b=Mbp9QXc9ydAhNyr1VQnA15r0jLT447EENe4gC1POD27xrebcWY618VQ6XKdQutxW6MoISkpkP1VXhQYF38NbUljslWANERuBem99R4o+l7k8uPWkB5g4Hd8JMBezdRSUYGNslzg5Un2V+UuIlED0Nhl1rgcbJ/BxML2p0CFHslk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLJ3Rd_1792738971;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLJ3Rd_1792738971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 15:02:52 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/3] nvme-multipath: document service-time iopolicy
Date: Fri, 23 Oct 2026 15:02:40 +0800
Message-ID: <20261023070243.2495522-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023070243.2495522-1-kanie@linux.alibaba.com>
References: <20261023070243.2495522-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_000258_119938_1079E1D5 
X-CRM114-Status: GOOD (  12.32  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


