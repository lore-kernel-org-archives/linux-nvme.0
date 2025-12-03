Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E88D12D45
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 11:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aD2hjsWXF2PDDDvGhu579pEIHMEDu4bPXokz+LYB2NE=; b=lZgUP1NAGH2SKlbFZ5eME5Pekt
	pAbkmau8RaL9d66MrlN4ga8eEvUEm3F6yPNpXJnnNFSY7NUTUn+at9nlpZkXVWRZC/sIiBFJzub0w
	U9r/fPLPz0ofNo75gTdEhYlK0K0JpDsYWlr69+NPm2gsZCTR21Ey7nK6v4F0GjTYgH9JWn86Xd9zw
	Tgaxf3EdGXJ/iq6baRSPxOn4sKE0CpjX4y7WA7j8yE+PJjRA33ECopZzOWU1CrNPKBzfIhPFlQwyc
	AMx/+H7NU7cVpyKcU+A04qgxCjchGRFDHzBDvYIDPdWpOixsT0UZiDT+ghCg7gJggR9NTFZmUsmmX
	2xE0S7+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQl3h-00000006V3x-1lje;
	Wed, 03 Dec 2025 11:30:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQl3e-00000006V3Q-39SL
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 11:30:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 97EEE43D48;
	Wed,  3 Dec 2025 11:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D66AC4CEFB;
	Wed,  3 Dec 2025 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764761405;
	bh=xGYVLobVCn03qiVYGkNlKBU9QYTSBW84mcNxZyUtN44=;
	h=From:To:Cc:Subject:Date:From;
	b=MFmIpyKVmVqytAuZL2u63GFP0/voRQaKwoV8UwUODpoF74Yv2R4O10u4hQo0Zq8yF
	 ICZcARTlqrR2FBZt5cDJ6wG4Ug0lnYE9D4RY8qRemYOf+a/66IsBz8MdYi9RXP5Kro
	 AfsCs/rsSfdZHEug0E3Dm2FHowIntLkUo9Y+Mwc8vmUzpSYYxuHz68QuDPIsB+heYZ
	 47egw6wZCWk177/to0D4qYPUiSXsQhLDyhMsxWY+6WMnZWz3gQjRi8hFOjDlNQ3v0V
	 gJEdQMGc08GbWh/npJZCPFaYqFTHfi1K+GHLil8A+QJoiMPh4/yaoMRZJmhN7MI5Js
	 vHkQQ79Xjgmlw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Abdulla Nasirli <nasirabd@fit.cvut.cz>
Subject: [PATCH] nvmet: lift blocksize restriction to 64k
Date: Wed,  3 Dec 2025 12:30:00 +0100
Message-ID: <20251203113000.67212-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_033006_831442_3B6112C7 
X-CRM114-Status: UNSURE (   8.98  )
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
index 2d068439b129..1ef4f262594a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -50,11 +50,10 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	nvmet_file_ns_revalidate(ns);
 
 	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
+	 * We can support blocksizes up to 64k (= 16 bits).
 	 */
 	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
+			file_inode(ns->file)->i_blkbits, 16);
 
 	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
 			mempool_free_slab, nvmet_bvec_cache);
-- 
2.43.0


