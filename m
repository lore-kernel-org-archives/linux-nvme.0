Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4319EC25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oSWPxvpE1poSwKY5+ekPffVav6PRLREnakX2y5g3Mig=; b=escQzEp486pivNSlWfKToCDXmx
	U0kkR56w85T8gWf0CjmNhp5HS9woFBO4XIgKywWhux159ToCR6X6eNC2/tYy/iP/LKjmLhpU6+pV0
	olXsxVexvXUtjuKWV9U1L15VpJczgjuyCnFDN1yDcWGJ/up1OosaVKAyuHPahYHikQbT/qtg2jXav
	AC4JoFYpb052QVziNrGzTiwEo9eD46oOrGU+Xgx+lUeJiKBahsp8Zvp758kQlpgsx+2GdmUYXUuTH
	t+5YBL00qjW7EnE1YA0sXd09iPHrOtNyMNQmh6aPG5y0O4FfCFlYYqUmgnTKC2rzYv2EuxbwvU9i/
	rVxdXEZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7W-0000000GgBU-1cug;
	Tue, 14 May 2024 17:39:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7S-0000000Gg8L-3q4x
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 61032612D5;
	Tue, 14 May 2024 17:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B23C4AF08;
	Tue, 14 May 2024 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708358;
	bh=nfZe9PyFcNTBz+0MHtHtGvd+j23GfMlHF02ruavVO6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8KkhFEGgXJ94xhNL/cTpJqbsnNTkK/tBlwgBBH9S5gYr8UIdQONeWyRm3qlhNdNC
	 H9WwXJJETlCIYLj8/dzCvvANr1imqRCDgh36tNiFkVv473ytgKAXwIg5Ha0uKibXN2
	 qzbpYiKFMCWt0EIOCH3MF9wPjsT1c55mHIkBNDGSBZxGZCAkT4XTQeVWDWGHiYGLjl
	 /UW8OUJta+uw1GCV3gOmVMy0fQscyHbVVDvY/MtW2Pa+T4wq8nTAgyUiUPTZgTNZXs
	 6TkTd64nx5niCsajI9D4W0qaOcoCdWL/tVGQDAx6Ga3TN1UHCKU1quwVVcGD444BQ2
	 d2mi2zLItvQrQ==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/6] fs/mpage: avoid negative shift for large blocksize
Date: Tue, 14 May 2024 19:38:55 +0200
Message-Id: <20240514173900.62207-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103919_015436_DE43118F 
X-CRM114-Status: GOOD (  11.55  )
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

For large blocksizes the number of block bits is larger than PAGE_SHIFT,
so use folio_pos() to calculate the sector number from the folio.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/mpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index fa8b99a199fa..558b627d382c 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -188,7 +188,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 	if (folio_buffers(folio))
 		goto confused;
 
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	last_block = block_in_file + args->nr_pages * blocks_per_page;
 	last_block_in_file = (i_size_read(inode) + blocksize - 1) >> blkbits;
 	if (last_block > last_block_in_file)
@@ -534,7 +534,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * The page has no buffers: map it to disk
 	 */
 	BUG_ON(!folio_test_uptodate(folio));
-	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
+	block_in_file = folio_pos(folio) >> blkbits;
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
-- 
2.35.3


