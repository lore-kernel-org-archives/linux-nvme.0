Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 17:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkkVGV05lv0CRWPOx1aNSbQEHovTv1Jz5BwTja4gYMc=; b=nQfMMbN3B5hmzfXi+IQWabd8u6
	XgQXBySfFyn08fzQYywVamWXekykUffPUW8vukgap5yFYpmh8vqaWoQWvu247CuUoSMCDvAK4t1XR
	pWaubg3rxrCUNcTnSmT7lNK5Cz3N2ya8Q/31NLth7sdWOikpIJQ8x8hxE21A5xGl3fxVRj0wAHcJU
	0H8FioTz80xJ3JEUFiZlX0RvY5lUveAvnQOzKGnQ34/+zDa5KZyNCey0610k5hJIbAD2k1nV3Jod+
	QXWvbH6pBcclUI6xarCCmh7w4UhNJ0b4Wrclcw9Inf5Tb5SnV7N+EsCe5fLsNJwbkeLO+jNCkSCbN
	piK15xug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1WcC-00FdQe-6y; Wed, 15 Jun 2022 17:15:36 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1VdT-00FJYv-Cs
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 16:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=lkkVGV05lv0CRWPOx1aNSbQEHovTv1Jz5BwTja4gYMc=; b=UA65EMT8xNvd8UHWetmwqme2a8
	mbh5ZAtLMo8oOkZni6a7e7xdFqgBaoKX6BW/nxEmRzBODrgtFlIhBvcgXCHi8DFCSj6ybFs8cFwFU
	JN5NcIKa2YwfaEFkGBKhq98tfYdc1ip6TDMNluisXCqwKBiArxGhT8ctmSh7yv0ONfMQKfAbFrlZ9
	GPQ1EKHrP0E8uLkOsybyw5PjBkPkxm2wJNwPMXA7XshLSwQare9mNo0JzCLQGmtGTjS8GRORUOZTW
	4uR6gNCfjlfo6idpW5EL2HFlkSZ0pa8rOW0YLmVjRT5GSymz5ydETTSteAPM/W/wXKf8A0ksSqUyH
	Qqr3rCNQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdP-0084iS-Qu; Wed, 15 Jun 2022 10:12:48 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1o1VdJ-0004as-C7; Wed, 15 Jun 2022 10:12:41 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org,
	iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
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
	Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 15 Jun 2022 10:12:30 -0600
Message-Id: <20220615161233.17527-19-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 18/21] block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_091251_537798_40FECB0F 
X-CRM114-Status: GOOD (  10.93  )
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
iov_iter_get_pages_flags(). This allows PCI P2PDMA pages to be passed
from userspace and enables the O_DIRECT path in iomap based filesystems
and direct to block devices.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index a402a4760457..0d152da8938d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1180,6 +1180,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages = (struct page **)bv;
 	bool same_page = false;
+	unsigned int flags = 0;
 	ssize_t size, left;
 	unsigned len, i;
 	size_t offset;
@@ -1192,7 +1193,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
 	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
 
-	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (bio->bi_bdev && bio->bi_bdev->bd_disk &&
+	    blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
+		flags |= FOLL_PCI_P2PDMA;
+
+	size = iov_iter_get_pages_flags(iter, pages, LONG_MAX, nr_pages,
+					&offset, flags);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
-- 
2.30.2


