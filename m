Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D2CAC598
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zMm2NBLKPbhkgjTIqBzOjplNw/nP7kHLNg99irSoOEk=; b=WO7BuRSE/lHIvXKwah+J/xVoBz
	3V9rk4g83ArS6VgKFJzNTiTf3wmHh9br8gdM1M8qc5JpKIWi9WP7ogrrPslFHqaOrRcpXzKh77ZtY
	BU/jBCHaq3cJFSHAs7DZy2dSDNbpkqRGP86MN53rgSuDZv8Xs8F8WyJsuBSklkH37HaTuVH6WKaLA
	aITyc6IZkGUp0XeX+1Z/9HIE6Jx8hl4xnlUHttu1ZJpzcbLeJEleV/HPnddgaqWO8l5yQ8yNS+unb
	AFH1iqdNo7DJyfW5Tvy9RmFeRVq/okgpgSWHn9R3I/W62WAd/jIAh7XZ+XwGZxYuF3kBmfVdv7Lmi
	P0k47s0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwDN0-0000000C9NN-0ue5;
	Wed, 10 Sep 2025 05:27:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw4A5-00000009kbc-1Wcf
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 19:37:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F194442F8;
	Tue,  9 Sep 2025 19:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BB1C4CEF4;
	Tue,  9 Sep 2025 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757446672;
	bh=Vkfs1C2Q/m2ciXngYEnMywKI/5g7jYuOYmYnMi4Z+6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK33sGpV6gJZdNQka35B5igzFncF6O4QoVJduYx5uymEwm19+Pae/Y8Ji2ztm6vFh
	 Of79hrgQzN752E6kK9Pd6CitdpQ05JM71b0yY2nJK5WUadz3JmWI4AqHd+rhRkpPML
	 jPSesTwS7Zw48bKNgh3AxJtfj3r28MMf09jWFv3Lide1Ok8C5lkasp0zoJfr6zuOnF
	 N5cxlSvTSt07fnYvpbKZtFqt6TP2eL80kCSBPIQL9mOveIT/STSyNFrSlP91N6uUF+
	 FdL0uwcDH/ATxbhiykxuiJP1XMjnnp4vhtxpR+0sRrU4PCEIaA22KI5S4HXWZpjWlB
	 smMV1bUYsFvcA==
Date: Tue, 9 Sep 2025 22:37:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	David Hildenbrand <david@redhat.com>, iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>, kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 03/16] dma-debug: refactor to use physical addresses
 for page mapping
Message-ID: <20250909193748.GG341237@unreal>
References: <cover.1757423202.git.leonro@nvidia.com>
 <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_123753_427914_24E9CEB7 
X-CRM114-Status: GOOD (  11.48  )
X-Mailman-Approved-At: Tue, 09 Sep 2025 22:27:42 -0700
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

On Tue, Sep 09, 2025 at 04:27:31PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>

<...>

>  include/linux/page-flags.h         |  1 +

<...>

> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -614,6 +614,7 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
>   * available at this point.
>   */
>  #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
> +#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))

This was a not so great idea to add PhysHighMem() because of "else"
below which unfolds to maze of macros and automatically generated
functions with "static inline int Page##uname ..." signature.

>  #define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
>  #else
>  PAGEFLAG_FALSE(HighMem, highmem)

Thanks

