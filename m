Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EB3C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjnWElruolPujfuaQzrOj/G3l/fBXPdeJ5vitS9FjeU=; b=rh1tw3EEXlNkqznGrUps47Bx8U
	ErxQnMaL6vHpevmzvlt6P2najq+/Dm3mBcZ25B828leI573sQ/lkd+zwab8cBxD9pJr6EzJl00ySK
	rGxt+cHgZQz9CMiZ7Zh+QIJo3tt6xBlkrDj4bJO3W1jfC221IsncotBi5gPsXavyz9dAyuTN2bTnq
	o5vJgu1TdnEnlPMruY/37fmqGz9waWr8u37AHIyDeKgODekmeHl8FiUTG6MrSEdxtlFt2dvBSUL28
	L29cEYv52NoV9eU3UuRwfZgrqPwBp4hfxQkeGoSKligjK63aeCbJFSZh8GsHJmZEugOrUa06iK19B
	RZTXfNvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQQe-002qB6-CM; Mon, 30 Jan 2023 09:26:20 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQNC-002oES-K9; Mon, 30 Jan 2023 09:22:47 +0000
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
Subject: [PATCH 13/23] cifs: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:47 +0100
Message-Id: <20230130092157.1759539-14-hch@lst.de>
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

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/cifs/connect.c |  5 +++--
 fs/cifs/fscache.c | 16 ++++++----------
 fs/cifs/misc.c    |  5 ++---
 fs/cifs/smb2ops.c |  6 +++---
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index b2a04b4e89a5e7..e6088d96eb04d2 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -759,8 +759,9 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
 	unsigned int page_offset, unsigned int to_read)
 {
 	struct msghdr smb_msg = {};
-	struct bio_vec bv = {
-		.bv_page = page, .bv_len = to_read, .bv_offset = page_offset};
+	struct bio_vec bv;
+
+	bvec_set_page(&bv, page, to_read, page_offset);
 	iov_iter_bvec(&smb_msg.msg_iter, ITER_DEST, &bv, 1, to_read);
 	return cifs_readv_from_socket(server, &smb_msg);
 }
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index f6f3a6b75601be..0911327ebfdeb4 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -143,14 +143,12 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 	struct iov_iter iter;
-	struct bio_vec bvec[1];
+	struct bio_vec bvec;
 	int ret;
 
 	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, ITER_DEST, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
+	iov_iter_bvec(&iter, ITER_DEST, &bvec, 1, PAGE_SIZE);
 
 	ret = fscache_begin_read_operation(&cres, cookie);
 	if (ret < 0)
@@ -171,16 +169,14 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = cifs_inode_cookie(inode);
 	struct iov_iter iter;
-	struct bio_vec bvec[1];
+	struct bio_vec bvec;
 	loff_t start = page_offset(page);
 	size_t len = PAGE_SIZE;
 	int ret;
 
 	memset(&cres, 0, sizeof(cres));
-	bvec[0].bv_page		= page;
-	bvec[0].bv_offset	= 0;
-	bvec[0].bv_len		= PAGE_SIZE;
-	iov_iter_bvec(&iter, ITER_SOURCE, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
+	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 
 	ret = fscache_begin_write_operation(&cres, cookie);
 	if (ret < 0)
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 2a19c7987c5bd8..95cc4d7dd806d7 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1054,9 +1054,8 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 
 		for (i = 0; i < cur_npages; i++) {
 			len = rc > PAGE_SIZE ? PAGE_SIZE : rc;
-			bv[npages + i].bv_page = pages[i];
-			bv[npages + i].bv_offset = start;
-			bv[npages + i].bv_len = len - start;
+			bvec_set_page(&bv[npages + i], pages[i], len - start,
+				      start);
 			rc -= len;
 			start = 0;
 		}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e6bcd2baf446a9..cb2deac6b2d70e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4598,9 +4598,9 @@ init_read_bvec(struct page **pages, unsigned int npages, unsigned int data_size,
 		return -ENOMEM;
 
 	for (i = 0; i < npages; i++) {
-		bvec[i].bv_page = pages[i];
-		bvec[i].bv_offset = (i == 0) ? cur_off : 0;
-		bvec[i].bv_len = min_t(unsigned int, PAGE_SIZE, data_size);
+		bvec_set_page(&bvec[i], pages[i],
+			      min_t(unsigned int, PAGE_SIZE, data_size),
+			      i == 0 ? cur_off : 0);
 		data_size -= bvec[i].bv_len;
 	}
 
-- 
2.39.0


