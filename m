Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741D4C021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 19:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0oDWL9MqCLrBHhvluseel4yAvZkVftMTuSIpYrKtT5U=; b=b2jqs8PR0MZnUAgcByuiWEVKQE
	tigC+UGM4GmLLGkANN/hyo2h2vqEOCjCOisM/LA7BTUTku+TQpz0IxpV6juEhAvQ6bJJRR937twDH
	21rKTcjimY3VfwBn6JlSKlWVOeCa0dIMw6YD//vwmKbzxgOKyjPQOLbqmn4kr2oe4H1rpX+UZ/RKx
	Y3V3PSNo0U2Npzwfv2p0LjFfzd24x2Evz4a8ztN0r7211omWSjKebt0vEexbf6gE/MUydLLLMkOse
	nnUeCgjXX+NKTM1g4n3BHjc/yN6nkF9yWvCTO1/jLJNn5fuT0mAaKq9wVb0TyccMYWcps1TLd/E1s
	HveYv/6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpY1R-000000061v0-2amB;
	Tue, 04 Mar 2025 19:33:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWes-00000005lck-0jbo
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 18:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0oDWL9MqCLrBHhvluseel4yAvZkVftMTuSIpYrKtT5U=; b=lFoQptTxFgvn2eDMe9RbVEMjHy
	bVVWUfCw27Rz8+6Vz9Pfs5Qms1vQk2tYgDHqnjK26Wj+5L+vcRKbLEqg8Er6WzIBfh81P7jRO1I1C
	S5amhajrZ2oT5+vUYjI2Zt+UJB45R7DD0cGnhtNujyBXgLM2rJpYmxVfAv1BUnHwBVEd3NG014M9V
	+WEbi3C00dMo3EwKzxqFH3F6vYB64aX382NuxQeD/au7NsDFJm42CPTl1hGqdVMIn9sh7EXtjKOd9
	hqLXRwfcddIr7ZnpduODpJ00ZKAdNPJ8DGCmUjnyxYe1BfhQwdXTt+ACr3t2zHqx8bobuxqwbTB+j
	oc+BD3dQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWeA-00000002cln-3T7m;
	Tue, 04 Mar 2025 18:05:43 +0000
Date: Tue, 4 Mar 2025 18:05:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Kernel oops with 6.14 when enabling TLS
Message-ID: <Z8dA8l1NR-xmFWyq@casper.infradead.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8cv9VKka2KBnBKV@casper.infradead.org>
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

On Tue, Mar 04, 2025 at 04:53:09PM +0000, Matthew Wilcox wrote:
> Right, that's what happened in the block layer.  We mark the bio with
> BIO_PAGE_PINNED if the pincount needs to be dropped.  As a transitional
> period, we had BIO_PAGE_REFFED which indicated that the page refcount
> needed to be dropped.  Perhaps there's something similar that network
> could be doing.

Until that time ... how does this look as a quick hack to avoid
reverting the slab change?

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d6fed25243c3..ca08a923ac6d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1520,7 +1520,10 @@ static inline void folio_get(struct folio *folio)
 
 static inline void get_page(struct page *page)
 {
-	folio_get(page_folio(page));
+	struct folio *folio = page_folio(page);
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return;
+	folio_get(folio);
 }
 
 static inline __must_check bool try_get_page(struct page *page)
@@ -1614,6 +1617,8 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
+	if (folio_test_slab(folio))
+		return;
 	folio_put(folio);
 }
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 65f550cb5081..8c7fdb7d8c8f 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1190,8 +1190,12 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
 		if (!n)
 			return -ENOMEM;
 		p = *pages;
-		for (int k = 0; k < n; k++)
-			get_page(p[k] = page + k);
+		for (int k = 0; k < n; k++) {
+			struct folio *folio = page_folio(page);
+			p[k] = page + k;
+			if (!folio_test_slab(folio))
+				folio_get(folio);
+		}
 		maxsize = min_t(size_t, maxsize, n * PAGE_SIZE - *start);
 		i->count -= maxsize;
 		i->iov_offset += maxsize;

