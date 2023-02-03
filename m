Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AE0C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hrqLS9VRJdwWgQKPMrZrcg15ZPJuMvt1hsLhaUGAnIc=; b=UijHuhB7QO889rMA6eCcYjTVkq
	2Sb6xxwx9OBnUieO43rKC1UOLsZpbhpJcCMq8Ps3JnCIeuK37ckU0ycsUzBmVLj0+bE1y/1i7szAd
	mkSmhcPbnDDFcNzJG8TTINQFWbswPNm4+yu0/aedqaXSKDYJR465euPjtyPAWTt/ud6o4RvUFPi+9
	6dHTef7Umpx2PH3OKxlottx1yRB9FCzpBv7Gmjv4/tET13yU3nFVqLdZVjiojAvl6VgGTmpzu5Ehl
	b1s73ovotJucZx3eN1xjHtVP1fDdzqmFiGHPbmWvznleuAe3yhNxfg1crkzE9YTYGbRz70LrA43VA
	JwsWTBBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxwI-002i3I-Fq; Fri, 03 Feb 2023 15:25:22 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxfT-002bcT-3j; Fri, 03 Feb 2023 15:07:59 +0000
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
Subject: [PATCH 23/23] libceph: use bvec_set_page to initialize bvecs
Date: Fri,  3 Feb 2023 16:06:34 +0100
Message-Id: <20230203150634.3199647-24-hch@lst.de>
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
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger_v1.c |  7 ++-----
 net/ceph/messenger_v2.c | 28 +++++++++++-----------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index d1787d7d33ef9a..d664cb1593a777 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -40,15 +40,12 @@ static int ceph_tcp_recvmsg(struct socket *sock, void *buf, size_t len)
 static int ceph_tcp_recvpage(struct socket *sock, struct page *page,
 		     int page_offset, size_t length)
 {
-	struct bio_vec bvec = {
-		.bv_page = page,
-		.bv_offset = page_offset,
-		.bv_len = length
-	};
+	struct bio_vec bvec;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL };
 	int r;
 
 	BUG_ON(page_offset + length > PAGE_SIZE);
+	bvec_set_page(&bvec, page, length, page_offset);
 	iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
 	r = sock_recvmsg(sock, &msg, msg.msg_flags);
 	if (r == -EAGAIN)
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 3009028c4fa28f..301a991dc6a68e 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -149,10 +149,10 @@ static int do_try_sendpage(struct socket *sock, struct iov_iter *it)
 
 	while (iov_iter_count(it)) {
 		/* iov_iter_iovec() for ITER_BVEC */
-		bv.bv_page = it->bvec->bv_page;
-		bv.bv_offset = it->bvec->bv_offset + it->iov_offset;
-		bv.bv_len = min(iov_iter_count(it),
-				it->bvec->bv_len - it->iov_offset);
+		bvec_set_page(&bv, it->bvec->bv_page,
+			      min(iov_iter_count(it),
+				  it->bvec->bv_len - it->iov_offset),
+			      it->bvec->bv_offset + it->iov_offset);
 
 		/*
 		 * sendpage cannot properly handle pages with
@@ -286,9 +286,8 @@ static void set_out_bvec_zero(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	WARN_ON(!con->v2.out_zero);
 
-	con->v2.out_bvec.bv_page = ceph_zero_page;
-	con->v2.out_bvec.bv_offset = 0;
-	con->v2.out_bvec.bv_len = min(con->v2.out_zero, (int)PAGE_SIZE);
+	bvec_set_page(&con->v2.out_bvec, ceph_zero_page,
+		      min(con->v2.out_zero, (int)PAGE_SIZE), 0);
 	con->v2.out_iter_sendpage = true;
 	iov_iter_bvec(&con->v2.out_iter, ITER_SOURCE, &con->v2.out_bvec, 1,
 		      con->v2.out_bvec.bv_len);
@@ -863,10 +862,7 @@ static void get_bvec_at(struct ceph_msg_data_cursor *cursor,
 
 	/* get a piece of data, cursor isn't advanced */
 	page = ceph_msg_data_next(cursor, &off, &len);
-
-	bv->bv_page = page;
-	bv->bv_offset = off;
-	bv->bv_len = len;
+	bvec_set_page(bv, page, len, off);
 }
 
 static int calc_sg_cnt(void *buf, int buf_len)
@@ -1855,9 +1851,8 @@ static void prepare_read_enc_page(struct ceph_connection *con)
 	     con->v2.in_enc_resid);
 	WARN_ON(!con->v2.in_enc_resid);
 
-	bv.bv_page = con->v2.in_enc_pages[con->v2.in_enc_i];
-	bv.bv_offset = 0;
-	bv.bv_len = min(con->v2.in_enc_resid, (int)PAGE_SIZE);
+	bvec_set_page(&bv, con->v2.in_enc_pages[con->v2.in_enc_i],
+		      min(con->v2.in_enc_resid, (int)PAGE_SIZE), 0);
 
 	set_in_bvec(con, &bv);
 	con->v2.in_enc_i++;
@@ -2998,9 +2993,8 @@ static void queue_enc_page(struct ceph_connection *con)
 	     con->v2.out_enc_resid);
 	WARN_ON(!con->v2.out_enc_resid);
 
-	bv.bv_page = con->v2.out_enc_pages[con->v2.out_enc_i];
-	bv.bv_offset = 0;
-	bv.bv_len = min(con->v2.out_enc_resid, (int)PAGE_SIZE);
+	bvec_set_page(&bv, con->v2.out_enc_pages[con->v2.out_enc_i],
+		      min(con->v2.out_enc_resid, (int)PAGE_SIZE), 0);
 
 	set_out_bvec(con, &bv, false);
 	con->v2.out_enc_i++;
-- 
2.39.0


