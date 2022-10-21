Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6B6FA3740
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=89QTElwZFXRfggrOmp22BVYbNApHwJCc7/AtxsSaqyQ=; b=arlQdc3WQCzN8m2NzP9fBtI0xM
	pFzwYpIPJB1vkHQ6FldIdsZLZxp3tNXkmPZ7u/GGGEjPZ08b7JFEaT3Mo77w/Q2/Gjt2fGyLSU5cR
	RUQsgC9AELnxm8WUHymdmLSJcDvNs90HCDywgFw+TedwSl9rp+tXMDO8NBPVI4qJjPWPMAQYsdlbg
	e58P6xSC3P7Gips6O5MnhywYI0R33CYAcsjEAEIwqCbYmE/aspo1fkVbfAr8p2XRA+vWh0WA+1Kvt
	+Wn0pcXhkgwczpKAEASl/Hen5M0XZPKMTwZeT2VzCQTwxbvT/o16WbQOTwJ3nA0xA67vjpPBajBt+
	8bnP9/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw1S-009EUj-KG; Fri, 21 Oct 2022 17:41:30 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olw1P-009EQf-Ms
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 17:41:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=89QTElwZFXRfggrOmp22BVYbNApHwJCc7/AtxsSaqyQ=; b=DUFJL4ob6bvKEwDSE4GWtIirYS
	X97GxPsQU/8gpPukGv4stsVhpCVMpaZfqfjtZunkmVXWQISTg/R/BOcVA3pa7CZfACS0bNB43mpI+
	c4OTnsrV1MciXZB4TbndO5a7ikBN/fz/wDgukCPrwSjCFtZ9ZyqxXcPgPcEnqgfdFeSTZyfCOy53l
	RxY+GZLkNNPiCm5OAKU8w+xesdg2eMT/Wb02k7Pdlz/yKsq/T6ahDZumCPpUSmcZ/3oCl/3HEMwwC
	cKWDtI+6VVeKGW1kms9Qbz0IR8J14E2KIWUlJDjVvyMCgYEjQLZ/KBKnSkVH95V20TixmWMKF5dVk
	bcv8KLUw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1K-00DoI1-5N; Fri, 21 Oct 2022 11:41:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1olw1G-0001tO-8W; Fri, 21 Oct 2022 11:41:18 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 21 Oct 2022 11:41:14 -0600
Message-Id: <20221021174116.7200-8-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021174116.7200-1-logang@deltatee.com>
References: <20221021174116.7200-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v11 7/9] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_104127_849230_59965A47 
X-CRM114-Status: GOOD (  12.51  )
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

When a bio's queue supports PCI P2PDMA, set FOLL_PCI_P2PDMA for
iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be
passed from userspace and enables the NVMe passthru requests to
use P2PDMA pages.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 block/blk-map.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 34735626b00f..8750f82d7da4 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -267,6 +267,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 {
 	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
+	unsigned int gup_flags = 0;
 	struct bio *bio;
 	int ret;
 	int j;
@@ -278,6 +279,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (bio == NULL)
 		return -ENOMEM;
 
+	if (blk_queue_pci_p2pdma(rq->q))
+		gup_flags |= FOLL_PCI_P2PDMA;
+
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;
@@ -286,11 +290,11 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
 			pages = stack_pages;
-			bytes = iov_iter_get_pages2(iter, pages, LONG_MAX,
-							nr_vecs, &offs);
+			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
+						   nr_vecs, &offs, gup_flags);
 		} else {
-			bytes = iov_iter_get_pages_alloc2(iter, &pages,
-							LONG_MAX, &offs);
+			bytes = iov_iter_get_pages_alloc(iter, &pages,
+						LONG_MAX, &offs, gup_flags);
 		}
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
-- 
2.30.2


