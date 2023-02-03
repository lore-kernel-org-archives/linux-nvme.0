Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF94C05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozMZvF4F/akQ9A5h2X8GtqkaNdRpJcsfIZKKgUgmw0I=; b=e6AMRNzzQehBj2xkTFQfLNMXyt
	qkDqs9E7E99wKWWbjn9I8P61s0JnUzMbKd/O3GEyiM1QlhbE2m1/O5+rp3X4lIE18NSdBLDAYK3p7
	1GhtPjX7zydWdh2iO/lXSnlW6cfL8/vp2cwTYdeNMOeaooGv67Uty75gUacGZftaJSN6NV9EXnbxU
	i7lqRrYMkGe+e3jKQtngyA3yWxPIeNt9VMgV+iJtdq/zDSVwmycd60tdsjTHzJFAM6066bRBlGIW+
	/9AD33SdAD0cP8L8VT+Y4ITJHrREoTYnAleULHiIev/CAm76q6b9Cem66/JLU32sPXtB+2W3iMdHh
	Hcp5Esmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxtd-002gQE-E4; Fri, 03 Feb 2023 15:22:37 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxej-002at9-3V; Fri, 03 Feb 2023 15:07:13 +0000
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
Subject: [PATCH 11/23] afs: use bvec_set_folio to initialize a bvec
Date: Fri,  3 Feb 2023 16:06:22 +0100
Message-Id: <20230203150634.3199647-12-hch@lst.de>
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

Use the bvec_set_folio helper to initialize a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/afs/write.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 19df10d63323d8..2d17891b618e6e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -992,7 +992,7 @@ int afs_launder_folio(struct folio *folio)
 {
 	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
 	struct iov_iter iter;
-	struct bio_vec bv[1];
+	struct bio_vec bv;
 	unsigned long priv;
 	unsigned int f, t;
 	int ret = 0;
@@ -1008,10 +1008,8 @@ int afs_launder_folio(struct folio *folio)
 			t = afs_folio_dirty_to(folio, priv);
 		}
 
-		bv[0].bv_page = &folio->page;
-		bv[0].bv_offset = f;
-		bv[0].bv_len = t - f;
-		iov_iter_bvec(&iter, ITER_SOURCE, bv, 1, bv[0].bv_len);
+		bvec_set_folio(&bv, folio, t - f, f);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bv, 1, bv.bv_len);
 
 		trace_afs_folio_dirty(vnode, tracepoint_string("launder"), folio);
 		ret = afs_store_data(vnode, &iter, folio_pos(folio) + f, true);
-- 
2.39.0


