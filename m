Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33622C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0dnvJ4/YC2qBSRJoUXjkVbZEbeJtTI76nFk14xqdiQw=; b=x1bfTVPkZ8G/VDysLyXScToVAi
	SI5KeM56fYrHa6hsd9u6sggaqiO+RxpXSeWpSJ6SxdP/XgQPCXHyvo2KIHDOn4pQPR1XbjXbVrUPa
	/YbrAxAhJ5U2C2jtEtThrZQ1zJHfxz7soSOHfFhPGoGlNbJWb9G3qwmTcqDkn6eMQAumlLhTlORwz
	wpSokvfvvrZwOqDgOiA9rf7LCsju5I3hr80wxYmPnWKuOrir/mgmzX7uOSCgwaemAK25t3vNLM6Go
	r/cV1670J4MSlOvLW0uqDcpVLlJ8bmyKapjRzIU/jiWx4GqZXXg5Ba/+Gu7ZnW20diC9WrLyMaZ4M
	FShyxpzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxsl-002fx4-SX; Fri, 03 Feb 2023 15:21:43 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxeB-002ac4-UN; Fri, 03 Feb 2023 15:06:40 +0000
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
Subject: [PATCH 01/23] block: factor out a bvec_set_page helper
Date: Fri,  3 Feb 2023 16:06:12 +0100
Message-Id: <20230203150634.3199647-2-hch@lst.de>
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

Add a helper to initialize a bvec based of a page pointer.  This will help
removing various open code bvec initializations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio-integrity.c |  7 +------
 block/bio.c           | 12 ++----------
 include/linux/bvec.h  | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 3f5685c00e360b..a3776064c52a16 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -124,23 +124,18 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 			   unsigned int len, unsigned int offset)
 {
 	struct bio_integrity_payload *bip = bio_integrity(bio);
-	struct bio_vec *iv;
 
 	if (bip->bip_vcnt >= bip->bip_max_vcnt) {
 		printk(KERN_ERR "%s: bip_vec full\n", __func__);
 		return 0;
 	}
 
-	iv = bip->bip_vec + bip->bip_vcnt;
-
 	if (bip->bip_vcnt &&
 	    bvec_gap_to_prev(&bdev_get_queue(bio->bi_bdev)->limits,
 			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
 		return 0;
 
-	iv->bv_page = page;
-	iv->bv_len = len;
-	iv->bv_offset = offset;
+	bvec_set_page(&bip->bip_vec[bip->bip_vcnt], page, len, offset);
 	bip->bip_vcnt++;
 
 	return len;
diff --git a/block/bio.c b/block/bio.c
index d7fbc7adfc50aa..71e411a0c12950 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1029,10 +1029,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	if (bio->bi_vcnt >= queue_max_segments(q))
 		return 0;
 
-	bvec = &bio->bi_io_vec[bio->bi_vcnt];
-	bvec->bv_page = page;
-	bvec->bv_len = len;
-	bvec->bv_offset = offset;
+	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, offset);
 	bio->bi_vcnt++;
 	bio->bi_iter.bi_size += len;
 	return len;
@@ -1108,15 +1105,10 @@ EXPORT_SYMBOL_GPL(bio_add_zone_append_page);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off)
 {
-	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt];
-
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
 	WARN_ON_ONCE(bio_full(bio, len));
 
-	bv->bv_page = page;
-	bv->bv_offset = off;
-	bv->bv_len = len;
-
+	bvec_set_page(&bio->bi_io_vec[bio->bi_vcnt], page, len, off);
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
 }
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 35c25dff651a5e..9e3dac51eb26b6 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -35,6 +35,21 @@ struct bio_vec {
 	unsigned int	bv_offset;
 };
 
+/**
+ * bvec_set_page - initialize a bvec based off a struct page
+ * @bv:		bvec to initialize
+ * @page:	page the bvec should point to
+ * @len:	length of the bvec
+ * @offset:	offset into the page
+ */
+static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
+		unsigned int len, unsigned int offset)
+{
+	bv->bv_page = page;
+	bv->bv_len = len;
+	bv->bv_offset = offset;
+}
+
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
-- 
2.39.0


