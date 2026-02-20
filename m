Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79453C56209
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OIAR0rdCmF4IQhjxJ+gOPwn/w9j9ttggFMVQgkQ7SUg=; b=fsnrmxoA7GkxuIrQZbej/DiN3s
	ed5YnT7wNc82LUeIrRkb3pkZgnoZ/MmhnnHrdmgwswBb8NZw4rGEl/LFGlj8AA58j0YK0kgmacRFG
	eqM0Jvoaq646ZgIvxyJK23BO+qF8bwmo+wCKh8k2SE72JT+uMOlHTimFkK0/fIcbPZyQKVxoAHgUv
	NmdAQsbR/o48rYqgikniEO/BZQeHVhcqTtN1vYhrZrTPIi6dcF6UHYC2XXfqapgYJNf0W2SIKA8Ku
	AN8LNZz899ZX1wnXAX8ncqw3f8L/xbtAKUlaWomW+OkyAVNsfJ7KxF1CdwpMb9HKVXR4CC3PXckQ7
	T96GOJ7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSBq-0000000Exuu-3iNg;
	Fri, 20 Feb 2026 15:13:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtSBn-0000000Exsj-4ALk
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 15:13:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C0A6744482;
	Fri, 20 Feb 2026 15:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32120C116D0;
	Fri, 20 Feb 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771600386;
	bh=/uC60Qdao4o+Fcbc87qMgA2iJt/KCdqicuRA6Y9BTAU=;
	h=From:To:Cc:Subject:Date:From;
	b=qEr9YnsBu1xF2pq8bMNh/X8D9zP55MUQuMTOVS+C0n+W19jtvBLpnBJDnxyUglV2/
	 0jjsHqnq1YcuX5HBmhwSn0t6SF4FjabNVR+r0sWlJ8UozXz/GSHjYxPNi8A0Udl/GX
	 NhrvNO5cxyMCuTIyhtDYwap//Xz7z+pRUOiPeC5Oz+O0kfgmw6Sp6JzP3RmdLp86Fh
	 QGih1s18WK2aUtCZ/fhcwcWSNxCvGX4P5ESZz2e0WWUba0SJ8NW+dR/vtSbBdyrNEs
	 4On7wkokPDi6ZqFwpwN99IGLUlZZVLxoYV8111dAzmsbGunMnl7ZYQecxiREfQYEEn
	 MsOSwR7PeUi7w==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Abdulla Nasirli <nasirabd@fit.cvut.cz>
Subject: [PATCHv2] nvmet: lift blocksize restriction to 64k
Date: Fri, 20 Feb 2026 16:12:59 +0100
Message-ID: <20260220151259.20372-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_071308_072313_49C2FAB5 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

With commit 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
we can now support up to 64k block sizes, so lift the restriction on 4k for
file-backed namespaces.

Reported-by: Abdulla Nasirli <nasirabd@fit.cvut.cz>
Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..fdc15c59632f 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -50,11 +50,10 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	nvmet_file_ns_revalidate(ns);
 
 	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
+	 * We can support blocksizes up to 64k.
 	 */
 	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+			file_inode(ns->file)->i_blkbits, ilog2(SZ_64K));
 
 	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
 			mempool_free_slab, nvmet_bvec_cache);
-- 
2.43.0


