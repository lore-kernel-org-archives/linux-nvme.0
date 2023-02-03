Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2FAC05027
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CiyB48vb6mrmTaEOVbqLR4u5Ie+kSkIibxGdt/yEGrQ=; b=sIO97UR4dKYHvs+Pry3ScgtBwB
	hNjqrbDpEqRYqKq1j0T5xsUjTnjlWomofqLoHN3Obbo144UBAQr/wkLX7qsDqBHKtdnKxNBr/fFMp
	Hcch80FpUMVWQDyJ4geDmbYOCcsPSAFSNUpzRLotZDVMfufSpYIadSnDZyOI9LjLLI9SnlchwWr3h
	NiJB+MKVBDBGeo8iK4zOiIS4tWfoRFn5s0ZdrG6k62TAKkff97Jx5qV6JPfY0vRZvuPwkqde6Wmqs
	YFLvqEAwpStvwGGImWDJ+dvgoHexQOWEYUami3gTsuynpED4vrgwHhzzqbFQ9Z7vp5GWN5ThsjBnH
	cx28qXwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxsq-002fyg-Qn; Fri, 03 Feb 2023 15:21:48 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxeE-002adJ-Pc; Fri, 03 Feb 2023 15:06:43 +0000
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
Subject: [PATCH 02/23] block: add a bvec_set_folio helper
Date: Fri,  3 Feb 2023 16:06:13 +0100
Message-Id: <20230203150634.3199647-3-hch@lst.de>
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

A smaller wrapper around bvec_set_page that takes a folio instead.
There are only two potential users for this in the tree, but the number
will grow in the future.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bvec.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 9e3dac51eb26b6..2bae1134499e7f 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -50,6 +50,19 @@ static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
 	bv->bv_offset = offset;
 }
 
+/**
+ * bvec_set_folio - initialize a bvec based off a struct folio
+ * @bv:		bvec to initialize
+ * @folio:	folio the bvec should point to
+ * @len:	length of the bvec
+ * @offset:	offset into the folio
+ */
+static inline void bvec_set_folio(struct bio_vec *bv, struct folio *folio,
+		unsigned int len, unsigned int offset)
+{
+	bvec_set_page(bv, &folio->page, len, offset);
+}
+
 struct bvec_iter {
 	sector_t		bi_sector;	/* device address in 512 byte
 						   sectors */
-- 
2.39.0


