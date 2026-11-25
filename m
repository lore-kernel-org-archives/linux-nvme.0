Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0D606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=V+KEpsYv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nn8jlrGHtmWZt2sgHyHcOrh00bAlIigyKvbBbapqRNM=; b=V+KEpsYvajApmGGbBOG/TqQoCZ
	ZDBuEe1ZHS5mdcwaE+aZuFpo6PQDu7UboVsQRsyWWw94nUG5COEsQd+EBvM70VYdSEu6L0nfS6tbl
	KVtLqGR4Dpc3mfLGKmS7oQInbdGzCQdmAa4MPNkGlswUXGUkj5LuRelUk5qk5tgR7Qt2d/DE2P1lq
	F+he9+YuNPlyZg6NbVDShmtWiKwNIHaQzlB0+zzbS8fYG+amQ/iGaI6V4si3t3nOYfX5Br3B0HDwM
	xDkrI8KOUl6E++nnmTQUZtc6ALh9vTLb7J5S4MfxQVnjsC5THiMzS8DAF3KS/WOdDG9o7+FQa7dRl
	211mlbgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW588-00000008R2q-0Rg7;
	Wed, 25 Nov 2026 05:01:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW584-00000008R20-3UFg
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:01:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3982A68AFE; Wed, 25 Nov 2026 06:01:03 +0100 (CET)
Date: Wed, 25 Nov 2026 06:01:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Omar Alzand <omaribrahimfadel@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH RESEND] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for
 Micron 2200
Message-ID: <20261125050102.GA19926@lst.de>
References: <CALJMncxA-=OFc05Ht74hWnia8-sCd5yLn5hK+KfnoHMO_sbzSQ@mail.gmail.com> <20261121204652.16374-1-omaribrahimfadel@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121204652.16374-1-omaribrahimfadel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_210113_017638_ED8A4EAB 
X-CRM114-Status: GOOD (  17.40  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 11:46:52PM +0300, Omar Alzand wrote:
> The Micron 2200 (1344:5410) corrupts the last page of reads of exactly
> 33 pages (132 KiB).  Such a read uses a 32-entry PRP list, which exactly
> fills a 256-byte small-pool descriptor, and the final page is dropped
> while the read still returns success.  On btrfs this appears as
> intermittent "csum failed" read errors that succeed on retry.
> 
> A raw-device test (eight O_DIRECT readers of N pages into a 0xAA-filled
> buffer, plus mixed-size background load) isolates it to 33-page reads:
> 
>   pages   reads    bad pages
>      32   23515    0
>      33   17715    1001   (all at page 33, ~5.65%)
>      34   13735    0
> 
> Booting with nvme.quirks=1344:5410:dmapool_align_512 eliminates it
> (133280 reads at 33 pages, 0 bad) and clears the btrfs checksum errors.
> Splitting the read via max_sectors_kb=128 also avoids it; writes are
> unaffected.  This is the same quirk the Micron 4100AT needed.
> 
> Verified through the nvme.quirks module parameter on a single 2200V
> (Micron_2200V_MTFDHBA512TCK, firmware P1MA0V4); this adds the equivalent
> id_table entry.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Omar Alzand <omaribrahimfadel@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


