Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AA60A2629
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=evcbfZYI;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hzWJM9Vx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2uRmJ4vJi0Et3QyEg+NJx+jeeSlVKIAx1DaVMNsi6KQ=; b=evcbfZYI40lZx9
	AHS6gvu1MemJEzWHU7F+9LaT3r0HttYoyoSBr58G3p12ZXxFQwJvcKLXIrFDKp2O7JQ2v983fx2Ch
	DJ3VWW32zzLC2lK/SHVW9fmLIFWmJnNURTyuaJ8mWhp2H/iP8VkmwgCyRmsaP9tMFdWVAppsHrQzL
	9RKQhl6Qo9PBeJ+Q5I7AKHzbQ34yI6iINVS8DgSIPiicshuO4P148l+CYKsri8X+CXhLNrcGyZExy
	gam1bZQzedlXgqzyuClrqZ8L/M3WuT1n6HBxtAbrfFCbh0jiCALimz/TR3PLBDwkcf2hRzEpxtFYq
	q5xdnQD98ktMecaHHxrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIbA-00000002KYV-01U3;
	Mon, 26 Oct 2026 11:10:40 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIb5-00000002KOs-1FUc
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 11:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793013033; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2uRmJ4vJi0Et3QyEg+NJx+jeeSlVKIAx1DaVMNsi6KQ=;
	b=hzWJM9VxUQ2lLQoVXrraXXdODfixUX0wL0A3t8BDe5aCXmdr07popfQfJkMIVmCnzl1w98V9twbphpYj/41hz4UXo5NcaXLqxB6lVJcCwwKLRbBmAcegL8rjumdLXwqcARKXutGst3Y5tkJcMAKMD8jw2IjWyAWpHWz+TmQB/UQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDX7UkC_1793013032;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDX7UkC_1793013032 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 19:10:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 3/3] nvme: document the service-time iopolicy sysfs attributes
Date: Mon, 26 Oct 2026 19:10:18 +0800
Message-ID: <20261026111019.3724465-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261026111019.3724465-1-kanie@linux.alibaba.com>
References: <20261026111019.3724465-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_041035_558428_B873378C 
X-CRM114-Status: GOOD (  14.12  )
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

The service-time iopolicy adds two sysfs attributes to the NVMe path
namespace devices: in_flight_bytes, reporting the bytes currently in
flight on the path's controller, and relative_throughput, the
per-path throughput weight used by the service-time estimation.

Document both in the stable sysfs ABI, including the 0-100 value
range, the default of 1, and the standby semantics of a
relative_throughput of 0.  Also add "service-time" to the accepted
values of the subsystem iopolicy attribute and to the policies
listed by the iopolicies attribute.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/ABI/stable/sysfs-nvme | 35 ++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 9291595f8102f..9a682d66a3ec2 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -347,6 +347,28 @@ Description:
 
 		Requires CONFIG_NVME_MULTIPATH.
 
+What:		/sys/block/nvmeXcYnZ/in_flight_bytes
+What:		/sys/block/nvmeXcYnZ/relative_throughput
+Date:		October 2026
+KernelVersion:	7.5
+Contact:	Guixin Liu <kanie@linux.alibaba.com>
+Description:
+		in_flight_bytes: Shows the number of bytes currently in
+		flight on this path's controller. Returns empty if
+		iopolicy is not "service-time".
+		Requires CONFIG_NVME_MULTIPATH.
+
+		relative_throughput: Shows or sets the relative
+		throughput weight of this path's controller, which the
+		"service-time" iopolicy uses to estimate the path service
+		time as in_flight_bytes / relative_throughput. The value is
+		an integer in the range 0-100 and defaults to 1; assign
+		higher values to faster paths. A path with a value of 0 is
+		only selected when no path with a positive value is
+		available. Reading returns empty if iopolicy is not
+		"service-time"; writing is accepted regardless of the
+		active policy. Requires CONFIG_NVME_MULTIPATH.
+
 What:		/sys/block/nvmeXnY/delayed_removal_secs
 Date:		May 2025
 KernelVersion:	6.16
@@ -477,9 +499,9 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows or sets the multipath I/O path selection policy for
 		this subsystem. Accepted values: "numa", "round-robin",
-		"queue-depth". Changing the policy clears all current path
-		selections. Only available when CONFIG_NVME_MULTIPATH is
-		enabled.
+		"queue-depth", "service-time". Changing the policy clears
+		all current path selections. Only available when
+		CONFIG_NVME_MULTIPATH is enabled.
 
 		A discovery subsystem has no namespaces and hence no I/O
 		paths to select from: reading returns "none" and writing
@@ -492,9 +514,10 @@ Contact:	Laurence Oberman <loberman@redhat.com>
 Description:
 		Shows the I/O path selection policies that may be written
 		to the iopolicy attribute of this subsystem, separated by
-		spaces: "numa round-robin queue-depth". A discovery
-		subsystem accepts no policy at all and reports "none".
-		Only available when CONFIG_NVME_MULTIPATH is enabled.
+		spaces: "numa round-robin queue-depth service-time". A
+		discovery subsystem accepts no policy at all and reports
+		"none". Only available when CONFIG_NVME_MULTIPATH is
+		enabled.
 
 What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
 Date:		September 2021
-- 
2.43.7


