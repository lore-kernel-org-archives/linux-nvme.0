Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED53E607E951
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Sk5QWqlq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=HicaYKRm;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Dxav85LK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Xq4qCwWy+pbQ8iTazo3Vexd1X8qBhBcmv8Kv7kseiz0=; b=Sk5QWqlqrGYWF3
	akiJlKvWLfZFLN6PTpwm+Jb1vrhoKQSbGqpcVjctM8tmkkG9N10XC4VKjQGsZ/GMIPIYHGvtWzgdr
	d4jvtBEP8C9fJ/JyJmDIKBYYyZ3KZ8pEpT+qkFo83O9z8Yrdqv8e1VMpqIcErmad1vNjMG3Bpi3gr
	JmbvOUtg10eX6hrH9zrWImNJjfssi3PjbZeCmnpGfpRKG/k2m22BTa0LVOjaNitfmyzfYlvQxqKZC
	mW5Rpb1QdKw1EO0I6+MJCmnUKkhsvQBSsr4+0/qVFI35Bl2dcWRCIMAKuyFocYFCssZgX/swdlsyy
	XsHVmhBQutAmXefmLJtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9JC-0000000FhcP-2Hwi;
	Fri, 23 Oct 2026 07:03:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9JB-0000000Fhbr-08yM
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 07:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Xq4qCwWy+pbQ8iTazo3Vexd1X8qBhBcmv8Kv7kseiz0=; b=HicaYKRmaLHq4YoDQji5fERjK5
	PYDvjsHPK5CM+bi/HhebErMAB4J0TjUkcW3pSrKcb20ppQFa/pMHtkzmdnxyWF5Wtsqno2+jd7Z7A
	qBo/SUcr+4tXd7L8qrnY1urcVhox/f/7RuIEAztgSgvDhcopsUM7YJ5/zQoKdZhkCUxQtYhQS3obz
	58yKI372B4X8O7ZGABb7ct/GvsQ3I5um84qN9tcjF4+iJNcCDXlsQfAGuCWHwF5Y3faom0WPaG8nQ
	Vot477OnfEB6e4HTz6qpcxvltlgCN4qqfJhgyyFdS2OMtk73D71AEUyHyyql8cc1i2IL4Iy3KBAPR
	qO5kdpvg==;
Received: from out199-14.us.a.mail.aliyun.com ([47.90.199.14])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9J7-00000009wM4-0G95
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 07:03:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792738973; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Xq4qCwWy+pbQ8iTazo3Vexd1X8qBhBcmv8Kv7kseiz0=;
	b=Dxav85LKlb/tMTXyGtqaG3c4uP8P8+3hLh+D+EGsJt2RHpOr2RfGhg6b9eglZjLXhmoQ6Ht2RdrfpaXZtbOoErJN07cxEp7wuNgaZBUJE9G1tn5QZBjZr10YrQ6VxyhdzH/6tFDu8sLtWgzI4+MqthVDFwJL/ieZV6Dm0lXSgl8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLKYJo_1792738972;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLKYJo_1792738972 cluster:ay36)
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
Subject: [PATCH v3 3/3] nvme: document the service-time iopolicy sysfs attributes
Date: Fri, 23 Oct 2026 15:02:41 +0800
Message-ID: <20261023070243.2495522-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023070243.2495522-1-kanie@linux.alibaba.com>
References: <20261023070243.2495522-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_080317_381996_518AA19A 
X-CRM114-Status: GOOD (  10.41  )
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
values of the subsystem iopolicy attribute.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/ABI/stable/sysfs-nvme | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index a2f5d0710db40..0c1db84165f19 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -326,6 +326,28 @@ Description:
 		currently selected path. Returns empty if iopolicy is not
 		"numa". Requires CONFIG_NVME_MULTIPATH.
 
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
@@ -440,9 +462,9 @@ Contact:	Hannes Reinecke <hare@suse.de>
 Description:
 		Shows or sets the multipath I/O path selection policy for
 		this subsystem. Accepted values: "numa", "round-robin",
-		"queue-depth". Changing the policy clears all current path
-		selections. Only available when CONFIG_NVME_MULTIPATH is
-		enabled.
+		"queue-depth", "service-time". Changing the policy clears
+		all current path selections. Only available when
+		CONFIG_NVME_MULTIPATH is enabled.
 
 What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
 Date:		September 2021
-- 
2.43.7


