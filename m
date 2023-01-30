Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D157C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PasJ3iDfX2TllVLQ6e7N8/T+ZQHWRBi9Mi0fIgNsQxA=; b=rFJa6N5cHAn0sT6mAIXrAJh4VM
	b+8Zo4iYTYOSLjkX3KjTWTDgqp8E0kXwIeKDQxBQ/vlUW/q56CbMf7CMMV9C0xZBS0JXO3sateYEx
	WpoweAgwqgEQPJMlr9H/hqpGbQZHgGCGlDpwbNy5hIRh0NCvieNDGiBaULqbiVBSopFKTIpDgT8kl
	M02J85Vnpq0quVJ7ROhHhoTxyXZZ/jjhgBQEaZ9IM3cdi/05JQ/xhFFdmiCvzMegjoWIg8plFDQRv
	C16S2Pnm1Z6lDxler8TIUJhnZTNwHDDIZmDK+QBWrpHNti6jFEBgAQN7Cs/tAJxmiHXUAJVhWtSGY
	x/feQ+rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQQ1-002peA-QC; Mon, 30 Jan 2023 09:25:41 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQMw-002o87-6w; Mon, 30 Jan 2023 09:22:30 +0000
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
Subject: [PATCH 08/23] rbd: use bvec_set_page to initialize the copy up bvec
Date: Mon, 30 Jan 2023 10:21:42 +0100
Message-Id: <20230130092157.1759539-9-hch@lst.de>
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

Use the bvec_set_page helper to initialize the copy up bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 04453f4a319cb4..1faca7e07a4d52 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3068,13 +3068,12 @@ static int setup_copyup_bvecs(struct rbd_obj_request *obj_req, u64 obj_overlap)
 
 	for (i = 0; i < obj_req->copyup_bvec_count; i++) {
 		unsigned int len = min(obj_overlap, (u64)PAGE_SIZE);
+		struct page *page = alloc_page(GFP_NOIO);
 
-		obj_req->copyup_bvecs[i].bv_page = alloc_page(GFP_NOIO);
-		if (!obj_req->copyup_bvecs[i].bv_page)
+		if (!page)
 			return -ENOMEM;
 
-		obj_req->copyup_bvecs[i].bv_offset = 0;
-		obj_req->copyup_bvecs[i].bv_len = len;
+		bvec_set_page(&obj_req->copyup_bvecs[i], page, len, 0);
 		obj_overlap -= len;
 	}
 
-- 
2.39.0


