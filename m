Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF0C636D4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTork4lgSqwAnNzEK3lzK1UwHk37chVOVoUGPRhe1ko=; b=SezWSaW2sUmZ1nWWhcrWK2qn85
	Qoywh5uKhBWJQTjjH6mzQoxLHEilXmR+ThBy6+bKyb2NdVQBiclf32HomF5Q3Ns3i7bcK7gnuwt3H
	scyqcO6kzvR/C8yVWk4GUjhe473Ux6iWYDUdX11xxlJf+NYx77Njgxn/B5wiNa/09aZmCUjiANhbu
	OAPRxYXQi5BpzmjzpPRzIDms7N0JFLEgW/4NRfqEvKyiySl8pPvohH/gyzNOfImkn2f46s3eepxcv
	hkLM434FwRs57P0UwtDpm60XSD3ttn8XPrrT7FPrY7pO5XFZGPQu9Q2AXZpEvJrB0N/GLxr+OdzlZ
	v2a/kmxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxu1-002ggE-Ul; Fri, 03 Feb 2023 15:23:01 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxeu-002b0b-M3; Fri, 03 Feb 2023 15:07:25 +0000
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
Subject: [PATCH 14/23] coredump: use bvec_set_page to initialize a bvec
Date: Fri,  3 Feb 2023 16:06:25 +0100
Message-Id: <20230203150634.3199647-15-hch@lst.de>
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
---
 fs/coredump.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991beb..0a6873a9c4d0cd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -840,11 +840,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
-	struct bio_vec bvec = {
-		.bv_page	= page,
-		.bv_offset	= 0,
-		.bv_len		= PAGE_SIZE,
-	};
+	struct bio_vec bvec;
 	struct iov_iter iter;
 	struct file *file = cprm->file;
 	loff_t pos;
@@ -860,6 +856,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (dump_interrupted())
 		return 0;
 	pos = file->f_pos;
+	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
 	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
 	n = __kernel_write_iter(cprm->file, &iter, &pos);
 	if (n != PAGE_SIZE)
-- 
2.39.0


