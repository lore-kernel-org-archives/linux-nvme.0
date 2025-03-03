Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7782FC282CD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L74JSotHWDPUP5TBM0hQkEM8p8tPw00XqklUA9G8JwE=; b=Xj3pwykLJafK5LcmtF8s7+5keB
	IVzftLy5ey/++xHJfxwfP7Fo5BW3BOZwxDTb/mOm/E5gpIzXUwcGcpuXB447/HBdbZwq5OxDu4TGb
	dUdgfUnBbrUtpm81j0JTPpiCSO5PqTf23lzpUAzF82w+/KqCF1oBDIWm5bS5gDNs8io6yCOGH+hQf
	WDc8F44us8PVGmMPUQwFTZKAfaqK+Wx3e9S8s3vUALTaI2d9Bnr6moVWFErptY106XBH8QEuUKo/S
	LPGRNgGw26vXqjjy8MJcvDpPKWqI1I86zahnLlP3y6kx4X54eN+/s7ezTpqFgl2WfBGwZ27m/bF4T
	+TMLA6Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp71w-000000019hQ-065s;
	Mon, 03 Mar 2025 14:44:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp705-000000019Me-2X2d
	for linux-nvme@bombadil.infradead.org;
	Mon, 03 Mar 2025 14:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L74JSotHWDPUP5TBM0hQkEM8p8tPw00XqklUA9G8JwE=; b=fMjtlw9/24EtzGGZI9GLAsjmLW
	iinSMSOKeK8riTV5HUi8/78FGb99T3v4BDXSuHkLTUodOSGGz6ONIHOqYniE2FRj4/7HBDtdCZZFQ
	un91u5skTOYWJH4+Ac0FkXBskIxivhSrl5npbunuU9iJNbIH1HhOIs5S0/F26TkEeiZzDW53cUUy/
	0T2DC7YHeMmfGR9A147o3gPqBEgFfJBE90ooXKN9sMR9dT2QIUL6qADqjUKeoCPWPYMXaQzrB13j/
	XRjDDvdZDt6Ie7PBSKGblc5hELN6ISusevEEOHNK/mff5C0BBtQvuIDnt6MDy7J7/GKNBzuFvUcdO
	zjEgniGw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tp703-0000000BlqL-0XV4;
	Mon, 03 Mar 2025 14:42:31 +0000
Date: Mon, 3 Mar 2025 14:42:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8W_1l7lCFqMiwXV@casper.infradead.org>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8W8OtJYFzr9OQac@casper.infradead.org>
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

On Mon, Mar 03, 2025 at 02:27:06PM +0000, Matthew Wilcox wrote:
> We have a _lot_ of page types available.  We should mark large kmallocs
> as such.  I'll send a patch to do that.

Can you try this?  It should fix the crash, at least.  Not sure why the
frozen patch triggered it.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 36d283552f80..df9234e5f478 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -925,14 +925,15 @@ FOLIO_FLAG_FALSE(has_hwpoisoned)
 enum pagetype {
 	/* 0x00-0x7f are positive numbers, ie mapcount */
 	/* Reserve 0x80-0xef for mapcount overflow. */
-	PGTY_buddy	= 0xf0,
-	PGTY_offline	= 0xf1,
-	PGTY_table	= 0xf2,
-	PGTY_guard	= 0xf3,
-	PGTY_hugetlb	= 0xf4,
-	PGTY_slab	= 0xf5,
-	PGTY_zsmalloc	= 0xf6,
-	PGTY_unaccepted	= 0xf7,
+	PGTY_buddy		= 0xf0,
+	PGTY_offline		= 0xf1,
+	PGTY_table		= 0xf2,
+	PGTY_guard		= 0xf3,
+	PGTY_hugetlb		= 0xf4,
+	PGTY_slab		= 0xf5,
+	PGTY_zsmalloc		= 0xf6,
+	PGTY_unaccepted		= 0xf7,
+	PGTY_large_kmalloc	= 0xf8,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1075,6 +1076,7 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
  * Serialized with zone lock.
  */
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
+FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
 
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..872e1bab3bd1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4241,6 +4241,7 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
 		ptr = folio_address(folio);
 		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 				      PAGE_SIZE << order);
+		__folio_set_large_kmalloc(folio);
 	}
 
 	ptr = kasan_kmalloc_large(ptr, size, flags);
@@ -4716,6 +4717,11 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 {
 	unsigned int order = folio_order(folio);
 
+	if (WARN_ON_ONCE(!folio_test_large_kmalloc(folio))) {
+		dump_page(&folio->page, "Not a kmalloc allocation");
+		return;
+	}
+
 	if (WARN_ON_ONCE(order == 0))
 		pr_warn_once("object pointer: 0x%p\n", object);
 
@@ -4725,6 +4731,7 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 
 	lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B,
 			      -(PAGE_SIZE << order));
+	__folio_clear_large_kmalloc(folio);
 	folio_put(folio);
 }
 

