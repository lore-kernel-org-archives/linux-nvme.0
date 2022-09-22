Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FD5C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ItJ8m+lleZiH/D7kr9kZGMa9/tjBgpeVzB8HkP75IQA=; b=1Kt/INtbSL0bdYKXie+gG9WlLe
	/JphZnjFweNqUahN8lu56MwjzAucdDb2uMwCP5K8PVv4YILdymk4WpL/VvRNnOAuNCyt+feU6JZjj
	hxsgx7STWvb7G6/SlowcdjT9sqn6BFAeJ0nNMxoLc1Z6nS8citLd3dp4XiSO2fCQGL/Ung/rFaII+
	eX5CK/0ptEOpIiI14wTqHNU57Q/9dNB6XX+BAPeOf/KV1BOKHMuT2MemD9zt/VI81FO1WO+YBNET/
	BTWDR3y225+xJONSQBuzwawtlD/itQqHISz/zWF3QSUfPvlyoeGhUm9umeW/yHVNVAv8KaEc5x9YT
	BgvuzK9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPG3-00Gpzw-Mm; Thu, 22 Sep 2022 16:41:03 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPEk-00Gp5V-KW
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 16:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=ItJ8m+lleZiH/D7kr9kZGMa9/tjBgpeVzB8HkP75IQA=; b=i85S0w54THJ/szqoMR3ZacShUv
	a3GTE6oGOI/VG2h9xDPtebfYgBwmX1XmrkRIQhemgp0Phm8eYDKuLxvuJFO9eBcPY7yuSw+kRZ0ED
	vYZw4u66yNlD8hsoNco9ZGPhRt1Ypz5B0/PmIyvsmcVYhzRboMrhqL0oB1mC4USezlKo2AE7obNR0
	b19WDFcJQiAJbV1NW7TMHoMeNDHb2IwNni4rmJIc9jAmlmSq6TIAa8MWHKK8H02ozzkB3M8ExcUob
	+YZnm6uzE1jQovPZr8i5AU9V0YsG1X/yvDy0alQ6/CL2cQm/73TQ1KmSPz12Z2zt+bt4kKDbUPGgM
	CI8cs/cA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEf-00862c-HN; Thu, 22 Sep 2022 10:39:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEa-0001rm-Va; Thu, 22 Sep 2022 10:39:33 -0600
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
Date: Thu, 22 Sep 2022 10:39:20 -0600
Message-Id: <20220922163926.7077-3-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v10 2/8] iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_093942_791769_7F1CEEB2 
X-CRM114-Status: GOOD (  12.18  )
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

Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
which take a flags argument that is passed to get_user_pages_fast().

This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/uio.h |  6 ++++++
 lib/iov_iter.c      | 32 ++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5896af36199c..5d976d01ccb9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned gup_flags);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start,
+		unsigned gup_flags);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4b7fce72e3e5..8f089d661a41 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1427,7 +1427,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
 
 static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   unsigned int maxpages, size_t *start)
+		   unsigned int maxpages, size_t *start,
+		   unsigned int gup_flags)
 {
 	unsigned int n;
 
@@ -1439,7 +1440,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = MAX_RW_COUNT;
 
 	if (likely(user_backed_iter(i))) {
-		unsigned int gup_flags = 0;
 		unsigned long addr;
 		int res;
 
@@ -1489,33 +1489,49 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 	return -EFAULT;
 }
 
-ssize_t iov_iter_get_pages2(struct iov_iter *i,
+ssize_t iov_iter_get_pages(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, unsigned gup_flags)
 {
 	if (!maxpages)
 		return 0;
 	BUG_ON(!pages);
 
-	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
+	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
+					  start, gup_flags);
+}
+EXPORT_SYMBOL_GPL(iov_iter_get_pages);
+
+ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start)
+{
+	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
 }
 EXPORT_SYMBOL(iov_iter_get_pages2);
 
-ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, unsigned gup_flags)
 {
 	ssize_t len;
 
 	*pages = NULL;
 
-	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
+	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
+					 gup_flags);
 	if (len <= 0) {
 		kvfree(*pages);
 		*pages = NULL;
 	}
 	return len;
 }
+EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc);
+
+ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start)
+{
+	return iov_iter_get_pages_alloc(i, pages, maxsize, start, 0);
+}
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-- 
2.30.2


