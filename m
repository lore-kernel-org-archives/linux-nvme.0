Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ED3CD5BD0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FATuMQncqNFmbYIe816mNHV2QNF4y2uugNvUSgPqsyQ=; b=eqL1wGbj2nBozh9z6KwhXD/Zww
	E9HdcdGRPTsDUDs2GDklQgcrGiJZkg2Kq/XamC0GBYgHjmalEqmC5OLdOFlaM6MZYJGegCJhwgK0q
	NbE9q0yabuNBuDV99WPh3itfSjQQPTU+ezySPkr1CegfAK8sVPxhr7BXv+tYMRq/iU4B8JuZ2aYDZ
	8fPHu1lo65HusWRLMihckDWOaquxIJbAe29aV+EySjVQzD6BbZLjB8hM1/EOQudQ5YVT5NWTrYa7b
	nADwcW8gzq/kZBgxIaJU+XS2Et8hts86bJlFC0z+KwGmN65vQ3dYYuvyyHHqaZiGTkzitGC+sprSU
	1gRUuT2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRnzb-00000001Ucb-3GEf;
	Tue, 26 May 2026 09:22:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRnza-00000001UcS-1Fyn
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 09:22:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF5FD6008A;
	Tue, 26 May 2026 09:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221641F000E9;
	Tue, 26 May 2026 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779787349;
	bh=FATuMQncqNFmbYIe816mNHV2QNF4y2uugNvUSgPqsyQ=;
	h=From:To:Cc:Subject:Date;
	b=hqtzPU/wsj3Tx2ELBvry8vDJew2EoweyZf3e0X7KlJ3YW+XuEbzH+5Vup7/svfQqt
	 3qY6uw12kyrS91tgwD5O4Meu2zxbxjDDjXKMmP/7bjQEQZRW1hhziZtLPR1rEXKwiq
	 Xwv/oWxVO5quJUidzWbcR0d16o1uJSKzeclm5IAamNwVMewMPnmzn2MAnVYl6gfksk
	 oJRwRp5RQCrh/lR6v8pjpGRNya59QbqAouxYNoQQlItNTQW/YisoSX4FQkQY3AxLQT
	 Z3aUrzpiPoje2fnMGxlNKsxqwIKecYXawxHSQUlQBOTWxV1u/eMiJExrl6x7itUBWT
	 kJgb1dybHjuOQ==
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet-tcp: fix page fragment cache leak in error path
Date: Tue, 26 May 2026 17:22:22 +0800
Message-ID: <e4df8752611dc5914f849b1d17f5512434b954cb.1779787061.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

In nvmet_tcp_alloc_queue(), when a connection is closed during the
allocation process (e.g., nvmet_tcp_set_queue_sock() returns -ENOTCONN),
the error handling jumps to out_destroy_sq and then to out_ida_remove
without draining the page fragment cache.

Although nvmet_tcp_free_cmd() is called in some error paths to release
individual page fragments, the underlying page cache reference held by
queue->pf_cache is never released. The first allocation using pf_cache
is the call to nvmet_tcp_alloc_cmd() for queue->connect, which happens
after ida_alloc() returns successfully. This results in a page leak each
time a connection fails during allocation, which could lead to memory
exhaustion over time if connections are repeatedly opened and closed.

Fix this by calling page_frag_cache_drain() before freeing the queue
structure in the out_ida_remove label.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - As suggested by Christoph, move page_frag_cache_drain() to after the
   out_ida_remove label and add a comment.
v1:
 - https://patchwork.kernel.org/project/linux-nvme/patch/39d57858464bb3933160d6f7583640db086fbb80.1779702494.git.tanggeliang@kylinos.cn/
---
 drivers/nvme/target/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..e613da4c44e0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1999,6 +1999,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
+	/* Drain the page fragment cache if any allocations were done.
+	 * The first allocation using pf_cache is nvmet_tcp_alloc_cmd()
+	 * for queue->connect after ida_alloc().
+	 */
+	page_frag_cache_drain(&queue->pf_cache);
 out_sock:
 	fput(queue->sock->file);
 out_free_queue:
-- 
2.53.0


