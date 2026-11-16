Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAB9606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kdX4T/qB;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iNn92fIN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=3LMoUdQJE78FUlsh3p167/b46phRODMkNEEC8q8CuAw=; b=kdX4T/qBptkQmVRB+V4a1hAmss
	pgyiq4Q4RcQKcgARv6mTzdN/rHNpc8ylOhF6hFNCpt/B305zQXcBgrwK4Xa5VGpxQ6D0YxO58AE42
	JyMwE+lZuUZgUOlGQL2bP5QVS6/NBCTt2JzjDRodSNHupedq3WKQV935pAj2Zkn4Ej63Mb2Zf98/c
	7IgeHW5ZfVWWnD0Dkf7j3uBUXESgYbyS6PvzF3+23RDjiiHU20XoNcoYEW/ckkE+4Q2G/CQCF55iT
	GIvosfhsBs367HLj+IcyY+opPqK9gaNJt0ynvcT+bifk3g/i9KS2my3063I2LbUXzziAggRbeiQPO
	9rfl7TRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSv6I-00000002DeY-3WUf;
	Mon, 16 Nov 2026 11:42:18 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSv6G-00000002Ddx-2Hih
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794829334; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3LMoUdQJE78FUlsh3p167/b46phRODMkNEEC8q8CuAw=;
	b=iNn92fIN2yyqixbNxZbQ4BC9FrX1OsNx+Ybwmp2tjfjAD5S457p6+ZrfK1KFDNvN7U7dtZME89uXEwieSJZzjAxzdrl8zeGxeP3ZjDo75D64X89XLO1rzTnCB7qCfXUXKwkHxntkB2yqjoFld7W8o+Zs/SjPwkUNVlFqo6w/IKU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XErWifi_1794829332;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XErWifi_1794829332 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 19:42:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: document the per-subsystem iopolicy sysfs attributes
Date: Mon, 16 Nov 2026 19:42:08 +0800
Message-ID: <20261116114208.2226472-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_034217_030036_D7BF25BA 
X-CRM114-Status: GOOD (  14.61  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme-multipath.rst only mentions the global nvme_core.iopolicy module
parameter. That value is only picked up when a subsystem is created;
changing it does not affect subsystems that already exist. The runtime
interface is the per-subsystem iopolicy attribute, which applies the
new policy to a single subsystem immediately, plus the read-only
iopolicies attribute listing the supported policies. Document both,
and note that discovery subsystems report "none" and reject writes.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/admin-guide/nvme-multipath.rst | 35 +++++++++++++++++---
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/nvme-multipath.rst b/Documentation/admin-guide/nvme-multipath.rst
index 97ca1ccef459b..058894187cbb8 100644
--- a/Documentation/admin-guide/nvme-multipath.rst
+++ b/Documentation/admin-guide/nvme-multipath.rst
@@ -24,12 +24,37 @@ Policies
 
 All policies follow the ANA (Asymmetric Namespace Access) mechanism, meaning
 that when an optimized path is available, it will be chosen over a non-optimized
-one. Current the NVMe multipath policies include numa(default), round-robin and
-queue-depth.
+one. The NVMe multipath policies currently include numa(default),
+round-robin and queue-depth.
 
-To set the desired policy (e.g., round-robin), use one of the following methods:
-   1. echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
-   2. or add the "nvme_core.iopolicy=round-robin" to cmdline.
+To set the desired policy, use one of the following methods:
+
+  1. Set the global default policy (e.g., round-robin), which is applied to
+     every subsystem when it is created, using either the sysfs module
+     parameter::
+
+	echo -n "round-robin" > /sys/module/nvme_core/parameters/iopolicy
+
+     or the kernel command line parameter "nvme_core.iopolicy=round-robin".
+     Subsystems that already exist keep their current policy.
+
+  2. Change the policy of a single subsystem at runtime::
+
+	echo -n "queue-depth" > /sys/class/nvme-subsystem/nvme-subsys0/iopolicy
+
+     The per-subsystem "iopolicy" attribute shows the policy currently in
+     effect. Writing a supported policy name to it takes effect immediately
+     for that subsystem only: the currently selected path of each namespace
+     is dropped, so that subsequent I/O is dispatched according to the new
+     policy, and the change is reported in the kernel log.
+
+The list of policies supported by the kernel can be read from the read-only
+"iopolicies" attribute::
+
+	cat /sys/class/nvme-subsystem/nvme-subsys0/iopolicies
+
+Discovery subsystems have no I/O paths and report "none" for both attributes;
+writing to their "iopolicy" attribute is not supported.
 
 
 NUMA
-- 
2.43.7


