Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC09EC54EAA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JggVdFejlVrHezfZyUPZIF+fbKFzTvLqyM6x/B/bNX0=; b=tYa8LyQF56/SOfPSRVbW1e2E0t
	bBgfdL+nnXuX56kDt8CjXPgX30GgHpvqNsCkl03HZUfMcpkorkzqrOccq6rcplZ11hSQGpU7Evif/
	LNYC4vF+LkNrj/2s4JG4mGgc5faKC+yMO8E5lSmvSbUfJ5sC8shpffwuE09CsMZlKzWgqaUZSHe3A
	l4GxBB0YrRlkSfRHGJDHa4dPmeixD83Nc86hvwraDqOyFum2ZNzKpqPflekvNNhWHxxzaGFXBAPt8
	yGvZ50jEAWTgHkEMGo/a/8MkHywtt3T99ZcfbCqQTlGaFhhawruS7yuLQx+AptEPLNitOwCpVJqF5
	rTxsEiyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQTO-002rxh-NL; Mon, 30 Jan 2023 09:29:10 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQNs-002oRV-Sa; Mon, 30 Jan 2023 09:23:29 +0000
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
Subject: [PATCH 21/23] sunrpc: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:55 +0100
Message-Id: <20230130092157.1759539-22-hch@lst.de>
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
 net/sunrpc/svcsock.c | 7 ++-----
 net/sunrpc/xdr.c     | 5 ++---
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 815baf308236a9..91252adcae4696 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -252,11 +252,8 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 
-	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE) {
-		bvec[i].bv_page = rqstp->rq_pages[i];
-		bvec[i].bv_len = PAGE_SIZE;
-		bvec[i].bv_offset = 0;
-	}
+	for (i = 0, t = 0; t < buflen; i++, t += PAGE_SIZE)
+		bvec_set_page(&bvec[i], rqstp->rq_pages[i], PAGE_SIZE, 0);
 	rqstp->rq_respages = &rqstp->rq_pages[i];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f7767bf224069f..afe7ec02d23229 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -150,9 +150,8 @@ xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp)
 		if (!buf->bvec)
 			return -ENOMEM;
 		for (i = 0; i < n; i++) {
-			buf->bvec[i].bv_page = buf->pages[i];
-			buf->bvec[i].bv_len = PAGE_SIZE;
-			buf->bvec[i].bv_offset = 0;
+			bvec_set_page(&buf->bvec[i], buf->pages[i], PAGE_SIZE,
+				      0);
 		}
 	}
 	return 0;
-- 
2.39.0


