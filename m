Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36024C04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBZyPsxulqnXsWPUix69+9zUdvlwy1JayLRxrZ0cJTw=; b=HdNIi95vz1lIcvMfvuPM+ZnIcg
	+AoHw/+FjzQolfESjTgAQdtrpAE9BwP53SZEYU0464ef5+2xZsx5ofA+QJieCwjJjGo/gJzFBLeJS
	1vOn61Us236sHZhRDrIOK7BBv+uWrPDe9gysikeZBoYqv8LkAXpI2tzX5sSeweSrd0c8M4NyyN1WJ
	4WNjzOO1BYFPQAQqgf36aUPlPk8Gyufuxt/g9sHW33g3Zf9YBpuuTY0Z4NkmJ1OS9EwoV7AXrcDYq
	psgeW6cW7EtVjdACTqjK0tXXqAnFlZl3Rdp6NIFy7Z2ZHs5c96BLibcmOit18ruWGz3x3Cryjov1j
	s/BrqQyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7g-0000000GgLM-2usI;
	Tue, 14 May 2024 17:39:32 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7a-0000000GgEb-1cTN
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A51EACE12D4;
	Tue, 14 May 2024 17:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61091C32786;
	Tue, 14 May 2024 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708363;
	bh=7s3ygm1qdmW1SDxuIuRIwVke+9uiYVb8lCs0ybKAYMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDL3a79WQhHZh0uAZSQ5XbZo3r9X875ZxUn51Ayr32ZkSQJfGRuuaMYytRzPbVyFX
	 ASHrJK/sOIm58CniJPZxEmh8Nq+LGnwhmcajZLR0j52NDltUdRjFU/zB05e7ZlEgGa
	 A8l0Xj5BydMygYn8klsgyXWFi4q871hNdiyramenxkETcg2tm0+zBrS9REqfnNLeBE
	 Sw5G5Gj7g1BCMORYpDeE6/XnWOdapbF6q4O7E6yygsfwzmJf+Ui/xq2vuAt9VIQtjV
	 hVetRfz31805bcjckOxuUtPCrTHhuckcnPbtp2AmSsj8c7KQQOW0zg4FdvKXWjLbkG
	 MPPfzXipA+sww==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/6] block/bdev: enable large folio support for large logical block sizes
Date: Tue, 14 May 2024 19:38:58 +0200
Message-Id: <20240514173900.62207-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103927_064768_D8A69E6D 
X-CRM114-Status: UNSURE (   9.75  )
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

Call mapping_set_folio_min_order() when modifying the logical block
size to ensure folios are allocated with the correct size.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/bdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..bd2efcad4f32 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -142,6 +142,8 @@ static void set_init_blocksize(struct block_device *bdev)
 		bsize <<= 1;
 	}
 	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+				    get_order(bsize));
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -158,6 +160,8 @@ int set_blocksize(struct block_device *bdev, int size)
 	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
+		mapping_set_folio_min_order(bdev->bd_inode->i_mapping,
+					    get_order(size));
 		kill_bdev(bdev);
 	}
 	return 0;
-- 
2.35.3


