Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E734BC8303F
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Wz4elI208IK+JSajFW9ZYSY4sJyfxAIN3oV4QuXWNY=; b=vftAYSIK4vni3UHsds1CM6IV9A
	FO9wqnuOJOQn2zdSC6U+4xVvP0Ue1YonnY03bVXzKyYLZI1TxuOg48jYqb8rRDhrhwZ3kgqw34A50
	GQWH/UnyA+Enb3CZAZIeo9rc+9sMbS+Bfmnu1OJ7Eme35Z/qNqLzvhzYj4/bljUaSIxdNFLlk27mm
	WsiFFex9DY+4LGTSIePRIi05rbkqc83wAZB7zFG5gxn12YaWiawHa1qLjbzHGhPfu+Aa9Uo3h7BwN
	uPg9fIyC2TmMRiuhUHFFvXfddIj7uarPCMgYmyNO5IqazXvMIFMwdUw9jaFk6kNs2sbGAiYm/Jw0E
	VGi2oSpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqyK-00000004P1v-1uml;
	Fri, 29 Aug 2025 04:44:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urePM-000000025BU-1mpS
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 15:19:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8EB99404AA;
	Thu, 28 Aug 2025 15:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D216BC4CEEB;
	Thu, 28 Aug 2025 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756394363;
	bh=nTKrcpDsshWT34MR4DBCaPN8mPA7gJtcVOPD1NWA+qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fiz/IFX/cbprksFrwcYLPDvY3Zj3oM+9xj/s3otiwCFW0WEBrDAgB6JRjK+IdqZnC
	 OFN4Z0AL7m05VQmwPYApcrLewjZzB+NKCYXZOIU9ibwe7/P/cr26ecTqFmQEgaS6pv
	 89DgMHR/jfK9TG7bugNXs7ta3ON2u0FFPpRcZMhF8LuBBzR8fYiYNcrkRaeoqL84Pa
	 vG8dcgdTqIBhIwwgWFEaigYJZlxM0LDruE+7Hf8BMGaT2uPwEeDcL2AHvfnUbMmlQ1
	 qic40gUjOmMG1Ib24qu6/1eYpqYTDcYO5/R+Bonh5umwbDCeb4/lCZ33BnqzYEikCq
	 EOso5xuGJTjTg==
Date: Thu, 28 Aug 2025 09:19:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, linux-block@vger.kernel.org,
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
Subject: Re: [PATCH v4 15/16] block-dma: properly take MMIO path
Message-ID: <aLBzeMNT3WOrjprC@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_081924_484776_803CA340 
X-CRM114-Status: GOOD (  13.98  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:42:14 -0700
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

On Tue, Aug 19, 2025 at 08:36:59PM +0300, Leon Romanovsky wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 09b99d52fd36..283058bcb5b1 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -387,6 +387,7 @@ enum req_flag_bits {
>  	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
>  	__REQ_ATOMIC,		/* for atomic write operations */
>  	__REQ_P2PDMA,		/* contains P2P DMA pages */
> +	__REQ_MMIO,		/* contains MMIO memory */
>  	/*
>  	 * Command specific flags, keep last:
>  	 */
> @@ -420,6 +421,7 @@ enum req_flag_bits {
>  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
>  #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
>  #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
> +#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)

Now that my integrity metadata DMA series is staged, I don't think we
can use REQ flags like this because data and metadata may have different
mapping types. I think we should add a flags field to the dma_iova_state
instead.

