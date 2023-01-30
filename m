Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C1C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+yCA75hP3xTA4z0JqY98N90poOlsvGyo37k4Ap2woM=; b=L5SfK2pP/4o8Olt5l7KDoMQovx
	+GxQVpVy1KcRuBLesXtI9ilACMN82sIr27EaqZGNw6I3Qoee+qyq8h4rRh+hM3ooAC+0+c/c+1A09
	4oUQPIM3EY3wjQYz2Gk08hO61jeL6IkUTc+V5NjnlgAOldfZxYn/dytqW2DrJ28LZ4/vfjFICswzP
	L9huEVKse4Ze6ACFYXrovy7X9X+nkkoD8YUaDNOYEpvqLbEnXyxsOi8o3sTjT/AfqbsTp3Cqlasn4
	4HSjY9vPihY69r0i876xAfInLAquQd4/6mlD0Nx4qoBpNMa/48ENv/woyEUP5w/I1lhI+uMQkWO5X
	FHVVLxkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQPj-002pSq-Am; Mon, 30 Jan 2023 09:25:23 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQMj-002o2F-W8; Mon, 30 Jan 2023 09:22:18 +0000
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
	linux-mm@kvack.org
Subject: [PATCH 04/23] sd: factor out a sd_set_special_bvec helper
Date: Mon, 30 Jan 2023 10:21:38 +0100
Message-Id: <20230130092157.1759539-5-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130092157.1759539-1-hch@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Jan 2023 01:24:49 -0800
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

Add a helper for setting up the special_bvec instead of open coding it
in three place, and use the new bvec_set_page helper to initialize
special_vec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 47dafe6b8a66d1..277960decc104b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -831,6 +831,19 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	blk_queue_max_discard_sectors(q, max_blocks * (logical_block_size >> 9));
 }
 
+static void *sd_set_special_bvec(struct request *rq, unsigned int data_len)
+{
+	struct page *page;
+
+	page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
+	if (!page)
+		return NULL;
+	clear_highpage(page);
+	bvec_set_page(&rq->special_vec, page, data_len, 0);
+	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
+	return bvec_virt(&rq->special_vec);
+}
+
 static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdp = cmd->device;
@@ -841,19 +854,14 @@ static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
 	unsigned int data_len = 24;
 	char *buf;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	buf = sd_set_special_bvec(rq, data_len);
+	if (!buf)
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = UNMAP;
 	cmd->cmnd[8] = 24;
 
-	buf = bvec_virt(&rq->special_vec);
 	put_unaligned_be16(6 + 16, &buf[0]);
 	put_unaligned_be16(16, &buf[2]);
 	put_unaligned_be64(lba, &buf[8]);
@@ -876,13 +884,8 @@ static blk_status_t sd_setup_write_same16_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	if (!sd_set_special_bvec(rq, data_len))
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 16;
 	cmd->cmnd[0] = WRITE_SAME_16;
@@ -908,13 +911,8 @@ static blk_status_t sd_setup_write_same10_cmnd(struct scsi_cmnd *cmd,
 	u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
 	u32 data_len = sdp->sector_size;
 
-	rq->special_vec.bv_page = mempool_alloc(sd_page_pool, GFP_ATOMIC);
-	if (!rq->special_vec.bv_page)
+	if (!sd_set_special_bvec(rq, data_len))
 		return BLK_STS_RESOURCE;
-	clear_highpage(rq->special_vec.bv_page);
-	rq->special_vec.bv_offset = 0;
-	rq->special_vec.bv_len = data_len;
-	rq->rq_flags |= RQF_SPECIAL_PAYLOAD;
 
 	cmd->cmd_len = 10;
 	cmd->cmnd[0] = WRITE_SAME;
-- 
2.39.0


