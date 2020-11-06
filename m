Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F78C388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC6620720
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fba4okFM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="chSuzXXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC6620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J9UbMCwe1sWRLyunJEf3xZWQHvBkiOOV1KBIxyvbHIQ=; b=Fba4okFMwgY3O7rSVebrNIjxc
	KgNuODjT75ysy5TsCw98FVBeN/xlFgLJEar+jFUrDODTnytjMtvcmJrpSeXdri36/0UU9xPcGjAWD
	mVnh4rbbfijsZYmosuz4we6OL7MUk35eNFLFtBFMMnhXfO2hMDZdzkplFZuvICsih4hKbVZTseE9f
	KTg/ae0574Vu6RvXY5plgh8Yz1jNTc/G2gbN45LuR18ffIFqhXHTFmml+LzlNimaTIuvcMpHCA5uL
	Ka0QHpyUNezAqULt9wf9TWmV65aRD0709eUwbcXdJHOzv/hwSAraREVt+NWbnqUSznsRpsQOJr61g
	M0kR9E6Iw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb58S-0001zg-1F; Fri, 06 Nov 2020 17:02:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb56l-0000wr-Cf
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m3VUYIxc1jPda5VSWLgLRAw02xsge+Z5NCWv/SFFLZ8=; b=chSuzXXnNIiMj8x5tY0yWvzN4Y
 uBDq8UiWGCPIy2lWdq+rPDZ2h5EhO1gULhRxUsFaANPfnMgWurYOAuvt26685GVMhBb3qwsZ3pRCa
 qVFIWSiO1Mb/oIoh/gHNuYpYp6odfYJAIowmbsy5Y3GC0wZj5M0XK2xzEBEmyjq9q0ziFlmpyKJWG
 47/pRiA99NbZLRcUGsRkkujiMQhJJjYYf4o9FkVaDUmcu5ymPZBUg7YBmec0FxLbxZrNIZNzERe5y
 u6NhVVJ3PSa7O/jaPyEpsddskNSLUAkBaQPsg5bpjX2A6AM4QSjRQj/0hxsZIuls70Rg2Q0qvQYG9
 jEWfZTtw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56g-0002PW-Bc; Fri, 06 Nov 2020 10:00:59 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56V-0004tK-FA; Fri, 06 Nov 2020 10:00:47 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:32 -0700
Message-Id: <20201106170036.18713-12-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 11/15] iov_iter: Introduce
 iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_120104_269209_E49F5118 
X-CRM114-Status: GOOD (  14.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
which take a flags argument that is passed to get_user_pages_fast().

This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/uio.h | 21 +++++++++++++++++----
 lib/iov_iter.c      | 25 ++++++++++++++-----------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..694caa868c05 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -221,10 +221,23 @@ void iov_iter_bvec(struct iov_iter *i, unsigned int direction, const struct bio_
 void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode_info *pipe,
 			size_t count);
 void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
-ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
-			size_t maxsize, unsigned maxpages, size_t *start);
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i, struct page ***pages,
-			size_t maxsize, size_t *start);
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i, struct page **pages,
+		size_t maxsize, unsigned maxpages, size_t *start,
+		unsigned int gup_flags);
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start,
+		unsigned int gup_flags);
+static inline ssize_t iov_iter_get_pages(struct iov_iter *i,
+		struct page **pages, size_t maxsize, unsigned maxpages,
+		size_t *start)
+{
+	return iov_iter_get_pages_flags(i, pages, maxsize, maxpages, start, 0);
+}
+static inline ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+		struct page ***pages, size_t maxsize, size_t *start)
+{
+	return iov_iter_get_pages_alloc_flags(i, pages, maxsize, start, 0);
+}
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 
 const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..700effe0bb86 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1313,9 +1313,9 @@ static ssize_t pipe_get_pages(struct iov_iter *i,
 	return __pipe_get_pages(i, min(maxsize, capacity), pages, iter_head, start);
 }
 
-ssize_t iov_iter_get_pages(struct iov_iter *i,
+ssize_t iov_iter_get_pages_flags(struct iov_iter *i,
 		   struct page **pages, size_t maxsize, unsigned maxpages,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	if (maxsize > i->count)
 		maxsize = i->count;
@@ -1325,6 +1325,9 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
+	if (iov_iter_rw(i) != WRITE)
+		gup_flags |= FOLL_WRITE;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1335,9 +1338,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 			len = maxpages * PAGE_SIZE;
 		addr &= ~(PAGE_SIZE - 1);
 		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0,
-				pages);
+		res = get_user_pages_fast(addr, n, gup_flags, pages);
 		if (unlikely(res < 0))
 			return res;
 		return (res == n ? len : res * PAGE_SIZE) - *start;
@@ -1352,7 +1353,7 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 	)
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_get_pages);
+EXPORT_SYMBOL(iov_iter_get_pages_flags);
 
 static struct page **get_pages_array(size_t n)
 {
@@ -1392,9 +1393,9 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 	return n;
 }
 
-ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
+ssize_t iov_iter_get_pages_alloc_flags(struct iov_iter *i,
 		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   size_t *start, unsigned int gup_flags)
 {
 	struct page **p;
 
@@ -1406,6 +1407,9 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	if (unlikely(iov_iter_is_discard(i)))
 		return -EFAULT;
 
+	if (iov_iter_rw(i) != WRITE)
+		gup_flags |= FOLL_WRITE;
+
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
 		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
@@ -1417,8 +1421,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		p = get_pages_array(n);
 		if (!p)
 			return -ENOMEM;
-		res = get_user_pages_fast(addr, n,
-				iov_iter_rw(i) != WRITE ?  FOLL_WRITE : 0, p);
+		res = get_user_pages_fast(addr, n, gup_flags, p);
 		if (unlikely(res < 0)) {
 			kvfree(p);
 			return res;
@@ -1439,7 +1442,7 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 	)
 	return 0;
 }
-EXPORT_SYMBOL(iov_iter_get_pages_alloc);
+EXPORT_SYMBOL(iov_iter_get_pages_alloc_flags);
 
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
