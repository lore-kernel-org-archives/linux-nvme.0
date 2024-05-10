Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0067DC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sHi0YTJEzojGxNSVUYMhoD4MTkNCunf201SP5gkHNqI=; b=1m8kGtlt2eTAhNYY7GRkqyAd/B
	aCxu+zytJK67cIkx2Se7+8pVYxIW7PJafoDxo8tQUKuFXJGTJF2ouDGTlkeO5IbpZRDDTfo9LkaSq
	f/6OSd1xQj/t1e/WwWyYV6Nrr+nt3MDRU55xPTxr6zbXgsGNFgvvnrGWbmotyIL6y63EQBy0H9uT/
	7Ou2V5bsq8N8ScQAC5yyX3lRMDL8OLYiyUhjCvljgx+ZXX4W1nbFbNz5fq6Y9jIwjkNndDz4xkIIm
	3yssYDbAeYSAhcwsMo0rOSEdc5LtdEVpovyPswUFtTzs48qj2icH3Y104tO9lT7ob0wU0RBUfkgAo
	61vZZ92w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVX-00000004s09-2cBs;
	Fri, 10 May 2024 10:29:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVR-00000004rvN-1XHK
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 10:29:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AF58BCE1CF2;
	Fri, 10 May 2024 10:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CF5C113CC;
	Fri, 10 May 2024 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336975;
	bh=13Q13FxbeBZfXsma08UVYuDt48mFE069IzP5r4sL7n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRASUid+NCrno7Pi9fT4HWOe1Pv/5IujmapV0DAiwpMzBSlYWeGVYaY8fhzLPPbmF
	 0Cc/9nb+zyjy0JASv+Rfyf7cJIdzpI63/q16FxrYr6B1AgeyHF4Op7xFSlxZ3Be8M7
	 B0IWarwHNhEC9UYpGY3/lN9+dwm7p6SRLXGddTOJc8xevUlGNsJ9NX9HgSVLoygxPs
	 19MQziag/eCNi0P0WdU2gsGsuCleST19KSrexsXLiP7rqoihfCHB04IbmX/RT53Ocv
	 92o1kb0YAXKFYU4St+nL3qIdD8YS59s6QmnptcpUZzp+/SyYPu67f8UKLZd7Bs5l1e
	 R61COEGfOJk1g==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/5] fs/mpage: avoid negative shift for large blocksize
Date: Fri, 10 May 2024 12:29:03 +0200
Message-Id: <20240510102906.51844-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_032937_674866_5E34CE67 
X-CRM114-Status: GOOD (  11.99  )
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

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use shift to calculate the sector number from the page cache index.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 379a71475c42..e3732686e65f 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -188,7 +188,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	last_block = block_in_file + args->nr_pages * blocks_per_folio;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -534,7 +534,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = (sector_t)(((loff_t)folio->index << PAGE_SHIFT) >> blkbits);
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.35.3


