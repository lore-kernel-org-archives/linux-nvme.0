Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A95CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Jymx+EA6KESZceDiO0ZcOJChcO4ShLkCuHB0UCXkIw=; b=EIZjgCPXteHg3zzQZrvo4JrAaH
	iiXYa2KTxXStODMm7xULKq8g8rcAMKzhCCL3BEVS362z+fvEyDd/J7NkQLdxUsCZlHlJxzAEJlLSl
	H1Xofj7JubN9DQzPZ5dNAVE22nEfSB6GZBLY5MfVCOpzgmn3rL2HSG/wWWHnnhfwupX03N7whyc4H
	4hGFPz08JXldiWHzuMls1khFch0iTw5vlRPzrWBDe0hO6KytiF7OmZInVAQvIbnUWTUxcKrERp1ir
	5AakCNSz8Z4D+Euh+T/thvTegI1tLO5pNeZ1TbkITWK6VbBHFW/CCwC4IWtcr2DfJS1/0ntnpNLQx
	oum0JDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uowE5-0000000Fhb3-1eO7;
	Thu, 21 Aug 2025 03:44:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoR0o-0000000BHnu-3fFu
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 18:24:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 340915C655A;
	Tue, 19 Aug 2025 18:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53727C4CEF1;
	Tue, 19 Aug 2025 18:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627885;
	bh=SvC+jn4R/dc0Ind2g0hlwOADBQmeZeKp/GI1XBT+Aws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwzZComdy/Uu53OXhh/BwwXin3VgP9XbYbPukl1+6UUrrmT0/QUgfHPWbl0yeg2IQ
	 anqpbJ7fssVt9ylAxZXZBFI6XmgBFt76Sf9R+5d1q0uCECHn7z6AVgdwiNFmtPzUpZ
	 oIJpPvDGleeIPwFshu0MK91r/Q4vlnE3hv5K/BQn4hYDk2V66e58pXhNfNYLb9ftUC
	 FsprkYGd3dpPDZ4hTpasdYuKUOBt3HQa7ezc4te6CtdhPT3gjHwY76TvaUfRVubpfk
	 /uH6qQQOd5J1UhIfM2bjnt3K6ADP7bZZTesuRvLRHriJ0TMIrB1SG3izjobM9UNSdA
	 OKRS+aPZzKk+g==
Date: Tue, 19 Aug 2025 12:24:42 -0600
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
Message-ID: <aKTBariwz1_XsRv0@kbusch-mbp>
References: <cover.1755624249.git.leon@kernel.org>
 <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642dbeb7aa94257eaea71ec63c06e3f939270023.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_112446_952458_F0E21775 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 20 Aug 2025 20:44:16 -0700
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
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that CPU is not synced and IOMMU is configured to take
> MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

We may have a minor patch conflict here with my unmerged dma metadata
series, but not a big deal.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

