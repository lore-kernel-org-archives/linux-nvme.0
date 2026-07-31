Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41678C55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jo5WsU3sZUe0MqdLjmuTE4Rwo6DyUV8T77Q0XG227CY=; b=3iCdptNJ/praxQuzK8X+2I/S0O
	DAroLSzK66gLqzEII06Yy7Z+HE8wqlGHeVHJ8H8IAnwWGLmlF+SxNbnnbHq0S96VlIxEYG8qKFiYD
	3Vrx0NvcRg0U+ikM+jb5MP198JH4SFYHA+0aaEnPzHVGhMUN63LGczAwQyTfC+8vIorIIdJaGXcMK
	AR16uzUIANEULaWEqq9nEq08qhTR4nAIrhuF6RXg16zW2fczccz5AA6avIBpyTvdk+54qgvHcraMK
	3VnZrDBtZpu7MjFvGezd5uwFIjb3wz6QmEREaS8lTRfbgUSus7lqEuCdkSTkzkHg/mfdfzxMiisuN
	sreyRzfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdsy-0000000BgkM-3chA;
	Fri, 31 Jul 2026 03:26:12 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdsv-0000000BgjV-00pU
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468366; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jo5WsU3sZUe0MqdLjmuTE4Rwo6DyUV8T77Q0XG227CY=;
	b=DVzN3aHQ3tx3DRJrNVxwt08gGGHYavRFv+1UO/WA6RsfDJ9eLXTqNBojcfXw6ia3Ly/cgAIa788DX/y8CPNtmST4W2ZRUFVQqpP9PbMD5/kht1X82pQSJ0R05f3cZOnpCveSy0E7fGXsKYqA8xnsegbhPvVq6PHTm4vQsWMlDMY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X86j3L-_1785468365;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86j3L-_1785468365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:26:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: shinichiro.kawasaki@wdc.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvme/070: add a test for Identify CNS 07h NULL pointer dereference
Date: Fri, 31 Jul 2026 11:26:01 +0800
Message-ID: <20260731032601.1100664-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202609_212827_2D2B3A05 
X-CRM114-Status: GOOD (  15.35  )
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

nvmet_execute_identify_nslist() handles both the Active Namespace ID list
(CNS 02h) and the per-command-set variant (CNS 07h). For CNS 07h it
filtered the list on req->ns->csi, but this handler never resolves
req->ns, so it is always NULL. As soon as an enabled namespace with an
NSID above the requested value exists, the target dereferenced a NULL
pointer and oopsed.

This test connects a target with a single namespace and issues an
Identify with CNS 07h starting from NSID 0, which is exactly the
condition that triggered the crash. Without the kernel fix [0] the target
oopses; with it the command completes normally.

[0] https://lore.kernel.org/linux-nvme/20260730043105.3071328-2-kanie@linux.alibaba.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 tests/nvme/070     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/nvme/070
 create mode 100644 tests/nvme/070.out

diff --git a/tests/nvme/070 b/tests/nvme/070
new file mode 100755
index 0000000..1f29a69
--- /dev/null
+++ b/tests/nvme/070
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Guixin Liu
+#
+# Regression test for the NULL pointer dereference in
+# nvmet_execute_identify_nslist() when handling Identify CNS 07h (Active
+# Namespace ID List for the specified I/O Command Set). The CNS 07h handler
+# filtered the list on req->ns->csi, but this handler never resolves req->ns
+# so it is always NULL. As soon as an enabled namespace with an NSID above the
+# requested value exists, the target dereferenced a NULL pointer and oopsed.
+
+. tests/nvme/rc
+
+DESCRIPTION="issue Identify CNS 07h (per-command-set active NS list)"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	local nvmedev
+	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
+
+	# CNS 07h == Active Namespace ID list for the specified I/O Command Set.
+	# CDW10 bits[7:0] hold the CNS; CDW11 bits[31:24] hold the CSI (0 == NVM).
+	# Request from NSID 0 so the enabled namespace (NSID 1) is listed, which
+	# is exactly the condition that used to dereference the NULL req->ns.
+	if ! nvme admin-passthru "/dev/${nvmedev}" --opcode=0x06 \
+		--namespace-id=0 --cdw10=0x07 --cdw11=0 --data-len=4096 -r \
+		>> "${FULL}" 2>&1; then
+		echo "Error: Identify CNS 07h failed"
+	fi
+
+	_nvme_disconnect_subsys
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/070.out b/tests/nvme/070.out
new file mode 100644
index 0000000..b765a28
--- /dev/null
+++ b/tests/nvme/070.out
@@ -0,0 +1,2 @@
+Running nvme/070
+Test complete
-- 
2.43.7


