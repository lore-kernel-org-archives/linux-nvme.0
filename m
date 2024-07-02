Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19819C3065E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QtKqiS2FdqQyx5V42cRxrrsXLbP2wtKYMXoP2kKFaO4=; b=zCkP7ddAy77qkktBh/QEoEONq2
	DbTowS2G4ecRRX9W5GsmpPVBQlqDywWpfJA2lmv7GuZnVZrQNUnsJRemEmUjg/rP5zsQfgb1mQzpK
	ZDdhLh/SjXs7YyrDugkT9/ndNjdY1PWmEkajaM9YrugPCrx/CQaehhCSw3aEsxQSkJc8YZ7IOcpYc
	+sTxPW2rFpqXEhstwsg176rzPc6oXOnhx2NFhWWEKog5ew1Dsb066YQN31qkAFbe8qw7/mT+hd524
	rrw7okVvWAvmd6H1PW9T+pqVd7Rkh1/SozmFn907KI52d2JRig/9y337JkyzJLxtz0SO7GG+JEtwq
	L1tHqatg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaXv-00000006JLg-2r1H;
	Tue, 02 Jul 2024 10:15:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZYN-000000066cg-4AY3
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Jul 2024 09:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QtKqiS2FdqQyx5V42cRxrrsXLbP2wtKYMXoP2kKFaO4=; b=FrLx0aCugA99vJ8FyUFHv6ygpi
	XTRcaw+abVaG2ye9xiK1FPqBSuikJxk9FT9+uWiX/v4OaL/D5gK5kb2gUOqy0fKDTvFA+bgVHZBMX
	TGQXcCzYAi8wniBndz4jTsmPkAHRXXph2q/PR2LWvsO1Uei88k6knuG7iZFvQl1NPr+/9yp7T1Vg2
	TqdbKsIo0oHymbcNoxL9EpysIvMIGlos5GjxQm4E6X847iLwuYcUAuSDy7Pdze9TYOfiBmIVCtWIv
	p2O5ZCjgzoAQ2dicdqjMv/8vCJLRLQwqqPgdBLhr5hlSTjvL9V2nZEJUbevr39nZfyrPeAO/mUJWs
	XbL4GNtg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZXn-00000009nM7-3LR3
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:11:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2FA6561A27;
	Tue,  2 Jul 2024 09:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38628C116B1;
	Tue,  2 Jul 2024 09:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911466;
	bh=awqNz5OGdWfjQsJN8aSzpTwPuTxHlPEDhpz1xfEBgC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmMV07HWOakUhLEx0CG5Sw8D1u/vJiFeT/1LOA4/MYdwbWSy8GvydRXDag+XzNQuF
	 8Mrby6JUZOtPEv8fs7zqbYmgnJ3vQ0E8UKqg2AiGbf2B4rjUPAo8OMiBBUtmXlUtED
	 I7lOY1LwtkVhj5RlocDgysGvTm0aU3G+jzWGhM9DlHlbRQ+NQwCweNkMi/QFwfNt5f
	 Zt/8qIdBUHskSlNSHY+lwUUXkwkAM2VZSfuGEizQOnbvlLYGPXRFfuO7ZnqRmHvzP3
	 sHQW3H4gZFNAN04PzGFcNOHwkG6/bvqhEaQ9QjvKDRliH9gVdc0oevJLqLUVJ+y2YD
	 4NmY108G1I3Ow==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 17/18] block: export helper to get segment max size
Date: Tue,  2 Jul 2024 12:09:47 +0300
Message-ID: <3649c1dc673ea0a49a90f3e01b76ef91fb90f076.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_101156_689424_BB0B49A6 
X-CRM114-Status: GOOD (  14.86  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Export the get_max_segment_size() so driver can do use that to create
DMA mapping when it receives the request.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-merge.c      | 3 ++-
 include/linux/blk-mq.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8534c35e0497..0561e728ef95 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -190,7 +190,7 @@ static inline unsigned get_max_io_size(struct bio *bio,
  *
  * Returns the maximum number of bytes that can be added as a single segment.
  */
-static inline unsigned get_max_segment_size(const struct queue_limits *lim,
+inline unsigned get_max_segment_size(const struct queue_limits *lim,
 		struct page *start_page, unsigned long offset)
 {
 	unsigned long mask = lim->seg_boundary_mask;
@@ -203,6 +203,7 @@ static inline unsigned get_max_segment_size(const struct queue_limits *lim,
 	 */
 	return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
 }
+EXPORT_SYMBOL_GPL(get_max_segment_size);
 
 /**
  * bvec_split_segs - verify whether or not a bvec should be split in the middle
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 89ba6b16fe8b..008c77c9b518 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1150,4 +1150,7 @@ static inline int blk_rq_map_sg(struct request_queue *q, struct request *rq,
 }
 void blk_dump_rq_flags(struct request *, char *);
 
+unsigned get_max_segment_size(const struct queue_limits *lim,
+		struct page *start_page, unsigned long offset);
+
 #endif /* BLK_MQ_H */
-- 
2.45.2


