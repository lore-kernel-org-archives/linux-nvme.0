Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26697C83F26
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqcgzX13dWI9O0Xz1ezqTjiey1M5H0BIKPz94PyzVK4=; b=IzmdWU8LC56p2F5eA7PXlwuJwe
	kAJ8m5ppL8t7kq/RLVqD7ZT+V7bM0e0I9QRurL0cOAYfcmsBgqVnIxTOpsVRDFiMP/hgIztBkY4ET
	XuNfv2iLKngQzsIk+TP4w+iLTOhMpHAhLCWr4l3PrbD0lf4zIR3Zs9oWJ7c+nsSRGxpJG5DsBzOlS
	bbcyVSJuTUJxOsCepf05afysNICylBToYvkHfKK3w+vs/6pZ/e8ytUaOyO2eAlXB0VR0GgmISadPN
	vxQeKjLz2q5xaX9/Zv9vtR9H34yrLHYB3bh/UiDc9mk74X/berBYkiiuURicuTXpJnsuzzVo2Iojv
	FaNcYAUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQj-0000000G5VT-2OID;
	Tue, 29 Jul 2025 07:07:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQf-0000000G5SO-0HPw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CC2AD45F8C;
	Tue, 29 Jul 2025 07:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D81DC4CEF5;
	Tue, 29 Jul 2025 07:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772836;
	bh=zMSIiAM1hspJ7M8wvxBvaCPcOo9t0VJdD5VUp2ItoWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8MCh403al531dN/RLJqBBidWRyBmFEgGHIIJu4B06GeF2fILovJv5ktDxR3Jmw3s
	 d5W3PzcouyJkvWHUERGS6PjKCtHB2atHMDfR3sAZcPm3NG/Sf55i6HxvPc788qZ9AG
	 98nR9IUDbyF4ga9GXQXUZfB/Une7/SyFljnYfPtiG0mrv5svRdV7qTqYfGbjDcC2tZ
	 6ggANkSvBIqMZ62z3UgEjTLLgp3unZDuWU7SdH5CSBz7U7oHVdtM9f7O1on+a7wGI6
	 K549h6zF3yX3jVSYyMAVZWAC3bRX45gh/GCiweiJ76zvAg+eh/UC4BopwITjzeNd7L
	 bKbdM+xdzMFdA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/6] tools/testing/selftests: add sample nvme bpf path selector
Date: Tue, 29 Jul 2025 09:06:53 +0200
Message-ID: <20250729070653.125258-7-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000717_125132_37BFE33A 
X-CRM114-Status: GOOD (  13.28  )
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

From: Hannes Reinecke <hare@kernel.org>

As a simple nvme bpf path selector to demonstrate the namespace
path iteration.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 .../selftests/bpf/progs/bpf_nvme_simple.c     | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_nvme_simple.c

diff --git a/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c b/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
new file mode 100644
index 000000000000..c9cafb6bd253
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_nvme_simple.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * simple nvme ebpf path selector
+ *
+ * Simulates a RAID layout with chunk size 2M
+ */
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+static sector_t simple_offset = 0;
+static sector_t simple_blocksize = 1048576;
+
+SEC("struct_ops")
+int BPF_PROG(simple_select, struct nvme_bpf_iter *iter, sector_t sector)
+{
+	sector_t offset = simple_offset;
+	sector_t block_size = simple_blocksize;
+	u32 num_blks, num_paths, num_iter, i;
+	int cntlid;
+
+	if (sector > offset)
+		sector -= offset;
+	cntlid = nvme_bpf_first_path(iter);
+	if (cntlid < 0)
+		return cntlid;
+	if (!block_size || sector < block_size)
+		return cntlid;
+
+	num_blks = (sector / block_size);
+	num_paths = nvme_bpf_count_paths(iter);
+	num_iter = num_blks % num_paths;
+	bpf_for (i, 1, num_iter) {
+		cntlid = nvme_bpf_next_path(iter);
+		if (cntlid < 0)
+			break;
+	}
+	return cntlid;
+}
+
+SEC(".struct_ops")
+struct nvme_bpf_ops bpf_nvme_simple = {
+	.uuid = { 0x86, 0xee, 0x41, 0xd5, 0x25, 0x6b, 0x45, 0xd0, 0xa4, 0x81, 0x5e, 0x35, 0xf6, 0x02, 0xf5, 0x11 },
+	.subsysnqn = "blktests-subsystem-1",
+	.nsid = 1,
+	.select_path = (void *)simple_select,
+};
-- 
2.43.0


