Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2762FC636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qP38AeUO0Rmk+VJkMh1f6goA+lT+IUSKmsc4pvMdtPc=; b=HVWdHI2r2iwCyQCwDlC06/THsd
	f6SQWNFHjpcsS3x1hZemBxuJv3JLu1ewBIfbq6DLTvx2sPl7oEJ48rTN/ZXKF2t046mR3ZV2NtrxO
	INebRs/LSlgYqZnAB9DaM9OwsDQYf3GXgNRa7IyaSq4qU+QJ0KJKk4NBF2rY09k+NeCq3LHZDxiX9
	xi7gzF7vswmD4DpL3xSpYRo7skZPYkvMcZccZW/BMtchfL6iiEevkAI86GOmaOKnS83Kb10Ermb4Z
	vO7ic2e+v7bSi2ryte/7nTF9R27IBZVJRynLVgF72WPTncQRd8hscqC2Gw4NsKMDiNTSewtxD8CyR
	0qTitYJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQR0-002qQl-Ha; Mon, 30 Jan 2023 09:26:42 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQNH-002oGb-QE; Mon, 30 Jan 2023 09:22:52 +0000
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
Subject: [PATCH 15/23] nfs: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:49 +0100
Message-Id: <20230130092157.1759539-16-hch@lst.de>
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
 fs/nfs/fscache.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index e731c00a9fcbc3..ea5f2976dfaba4 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -245,14 +245,12 @@ static int fscache_fallback_read_page(struct inode *inode, struct page *page)
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
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
@@ -273,16 +271,14 @@ static int fscache_fallback_write_page(struct inode *inode, struct page *page,
 	struct netfs_cache_resources cres;
 	struct fscache_cookie *cookie = nfs_i_fscache(inode);
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
-- 
2.39.0


