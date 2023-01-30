Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E72C64ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kORmqO/9LhO3glrNFnQu4Hg9yMGINb4dC3Y3cN2SyCY=; b=DLmLWxxZ/TpzyFdkyLB7qnNmvl
	3L1k67QCeQkQZSK6M0JPLzzy+DqtaYl1K7y28483Jkp+vtaNj6lFmN9G9t22sVkkC+CYdo4CRBg8Y
	DfwcpFDK86WzFW2VrEow2mE1dYb2p2zSw/t+RdrNamMymcphROVf8KAEL8wsv730omVEKnJlNj1U9
	efQttg0BZbc9b6vFNhwW2Djb6riEhsk2dP0FR9Dgvkuexy9EgVieleNwaM6RJOdP7OSblXctluN1t
	K8PZXlS7ht6DBEghGhclGwGoC4y6MnW4pFKPXLihzepOWiI4hV+zXcj+5/v97krnTMwv1WL6Y+TtI
	g4QLrFAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQRF-002qci-6h; Mon, 30 Jan 2023 09:26:57 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQNQ-002oHi-98; Mon, 30 Jan 2023 09:23:00 +0000
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
Subject: [PATCH 16/23] orangefs: use bvec_set_{page,folio} to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:50 +0100
Message-Id: <20230130092157.1759539-17-hch@lst.de>
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

Use the bvec_set_page and bvec_set_folio helpers to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/orangefs/inode.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4df56089438664..215f6cb3dc4129 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -49,10 +49,8 @@ static int orangefs_writepage_locked(struct page *page,
 	/* Should've been handled in orangefs_invalidate_folio. */
 	WARN_ON(off == len || off + wlen > len);
 
-	bv.bv_page = page;
-	bv.bv_len = wlen;
-	bv.bv_offset = off % PAGE_SIZE;
 	WARN_ON(wlen == 0);
+	bvec_set_page(&bv, page, wlen, off % PAGE_SIZE);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,
@@ -102,15 +100,11 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 
 	for (i = 0; i < ow->npages; i++) {
 		set_page_writeback(ow->pages[i]);
-		ow->bv[i].bv_page = ow->pages[i];
-		ow->bv[i].bv_len = min(page_offset(ow->pages[i]) + PAGE_SIZE,
-		    ow->off + ow->len) -
-		    max(ow->off, page_offset(ow->pages[i]));
-		if (i == 0)
-			ow->bv[i].bv_offset = ow->off -
-			    page_offset(ow->pages[i]);
-		else
-			ow->bv[i].bv_offset = 0;
+		bvec_set_page(&ow->bv[i], ow->pages[i],
+			      min(page_offset(ow->pages[i]) + PAGE_SIZE,
+			          ow->off + ow->len) -
+			      max(ow->off, page_offset(ow->pages[i])),
+			      i == 0 ? ow->off - page_offset(ow->pages[i]) : 0);
 	}
 	iov_iter_bvec(&iter, ITER_SOURCE, ow->bv, ow->npages, ow->len);
 
@@ -300,9 +294,7 @@ static int orangefs_read_folio(struct file *file, struct folio *folio)
 		orangefs_launder_folio(folio);
 
 	off = folio_pos(folio);
-	bv.bv_page = &folio->page;
-	bv.bv_len = folio_size(folio);
-	bv.bv_offset = 0;
+	bvec_set_folio(&bv, folio, folio_size(folio), 0);
 	iov_iter_bvec(&iter, ITER_DEST, &bv, 1, folio_size(folio));
 
 	ret = wait_for_direct_io(ORANGEFS_IO_READ, inode, &off, &iter,
-- 
2.39.0


