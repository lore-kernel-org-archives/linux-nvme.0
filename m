Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ED4C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ivuZdJU66fGeGNrDCSX2XtHVJq8+h1pLMvYDbA6wQ8=; b=NnnX+NJrHo1kW9oZy0SdYYr3cn
	rM+X/ocNdjkU/mnqcbkOiQsaLSa9tD8wRTsgIRMuJLlVaQ8OtqL4ZSlLFj1viK8818RpvPCCePNx5
	ioDAGIid3bOSSGsV7b1r0lhccknPCsuRlWGmE8A88CmAzj7Ia9boVPgGXhx0UN1rbh3X5Ext7WIof
	80f5hMO5VGkjYp2Vp6ICp1mdXB9F68lQXfxd+cEU7MTpaUdl+1QfmNfTkq8iYE5lS+w//m41eaxIn
	56cqJtfQNHea/7ntRNCixhQX1HFJnlsQwhcGY2oQnzH2syCgV97jFqu/CODNbdG+ioelq5y6YSSDj
	jy/9g5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxtV-002gL7-8c; Fri, 03 Feb 2023 15:22:29 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxef-002ar9-Df; Fri, 03 Feb 2023 15:07:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org,
	io-uring@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/23] zram: use bvec_set_page to initialize bvecs
Date: Fri,  3 Feb 2023 16:06:21 +0100
Message-Id: <20230203150634.3199647-11-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150634.3199647-1-hch@lst.de>
References: <20230203150634.3199647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Feb 2023 07:21:38 -0800
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

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/zram/zram_drv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e290d6d970474e..bd8ae4822dc3ef 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -703,9 +703,7 @@ static ssize_t writeback_store(struct device *dev,
 	for (; nr_pages != 0; index++, nr_pages--) {
 		struct bio_vec bvec;
 
-		bvec.bv_page = page;
-		bvec.bv_len = PAGE_SIZE;
-		bvec.bv_offset = 0;
+		bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
@@ -1380,12 +1378,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int zram_bvec_read_from_bdev(struct zram *zram, struct page *page,
 				    u32 index, struct bio *bio, bool partial_io)
 {
-	struct bio_vec bvec = {
-		.bv_page = page,
-		.bv_len = PAGE_SIZE,
-		.bv_offset = 0,
-	};
+	struct bio_vec bvec;
 
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	return read_from_bdev(zram, &bvec, zram_get_element(zram, index), bio,
 			      partial_io);
 }
@@ -1652,9 +1647,7 @@ static int zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		memcpy_from_bvec(dst + offset, bvec);
 		kunmap_atomic(dst);
 
-		vec.bv_page = page;
-		vec.bv_len = PAGE_SIZE;
-		vec.bv_offset = 0;
+		bvec_set_page(&vec, page, PAGE_SIZE, 0);
 	}
 
 	ret = __zram_bvec_write(zram, &vec, index, bio);
-- 
2.39.0


