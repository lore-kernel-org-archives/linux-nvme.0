Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77658C61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68cg5sT+53fHc5ofdY3atwSg1h/zl/AMIkCUias8WPw=; b=e7YaoTT7SOQWKTJGtuXOZbH5Cx
	EIYxtyoWnsAh4Azy1KqnWUkC3MVmBva4i7M+3LPpFMyk5rRUUF0efnOxrI4MWd/gblchz6neO5s0l
	VOtL6mFT9Ry3rZt3skkOMXjyupbZWTZiubrynr2IXNTh23Wxz+H2XaXnS2CGuRei+uwlkom6oARYc
	SBCP5yPYmAG1fl9z9aXe3I/G7iHALDUZPSohwfBJaZYo2Ga49WW7+1/Uv0PVpXXEVoPiUYDl3PIEj
	+JSvEJ68R1vemnPFCL5EIfyqaRgVz7E129MAkd4risYRPWDb3WZCOcEZ8Frzt65sEuyv/CVvcIPyQ
	YUFC0XPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxw0-002hsx-Bg; Fri, 03 Feb 2023 15:25:04 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxfP-002bWg-QF; Fri, 03 Feb 2023 15:07:56 +0000
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
Subject: [PATCH 22/23] vringh: use bvec_set_page to initialize a bvec
Date: Fri,  3 Feb 2023 16:06:33 +0100
Message-Id: <20230203150634.3199647-23-hch@lst.de>
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

Use the bvec_set_page helper to initialize a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vringh.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 33eb941fcf1546..a1e27da544814a 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1126,9 +1126,8 @@ static int iotlb_translate(const struct vringh *vrh,
 		size = map->size - addr + map->start;
 		pa = map->addr + addr - map->start;
 		pfn = pa >> PAGE_SHIFT;
-		iov[ret].bv_page = pfn_to_page(pfn);
-		iov[ret].bv_len = min(len - s, size);
-		iov[ret].bv_offset = pa & (PAGE_SIZE - 1);
+		bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
+			      pa & (PAGE_SIZE - 1));
 		s += size;
 		addr += size;
 		++ret;
-- 
2.39.0


