Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24993D29FB2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QnuEY7cZcQaL+Hy7RipG7GiBlvQyw8PPossnV6kYzKA=; b=BGznBkCVPUXo0u4qjojHAC0BP0
	0kNPCBpAYq9uBLNtqtqsWteGM9ns1vncW16A5jOL14bvD5C63Iue/zQ6Qv8NMUyexe+Nq9zar4Odh
	pRu3Hych0R1q62jAsXKfRlHs0BLOk3vbBFIIJeqDaKrhcrLtDGTcNM/MyNQimeaQAebENN9jedLjX
	/h/PiKOmtaBwTxDPAIwp4NbYYjQ2QUZHBjAQ3X73DVqRicgf9HvjqxptU+tN702x3sohPo92QfZdU
	STz62KgDcVMgGgQi0bB06KZAO6emCu8Q1wggBOiX+8P/K1p2j3ex6DisSJA6rjCbBDF2dCGY8I9RB
	DVcTB4Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREgH-00000008Txw-2FxP;
	Thu, 04 Dec 2025 19:07:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREgG-00000008TxO-1rPS
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:07:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7DBB560051;
	Thu,  4 Dec 2025 19:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA03C116C6;
	Thu,  4 Dec 2025 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764875275;
	bh=0T0myU9ZH1tB3I+V7V43BU4jBwzUFIVwxphPm1myBzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJith8/Gx4Wd98GNbJ7JgxHjEk0D7lIa7DnpsSn1yMaGQI1EqxuiciLXwN8wZjnEJ
	 qlxn4LehW7CPwkt/TTMulNZcItXi43kAMUvpYKmyfbKYiRELimMl9ItWI0kgWE/kNY
	 DfWbzXb0XWX6awag8QffycQU0ga5vSjnsYEqXVBd4zpvHQQQX3d1dxhOaC5FzIJ6Ma
	 Hy0H7EzRJg/nhYxMd5AhbzQ9AjRWFsCy3fbNeeBFBkprwe4nvjOnrPt+oWQqfVnP6K
	 TFX5BFa3hA3MJBYZfIM9zGb8IH9ErkKMEgjMl3Ts9QSjnlc/e0kR6/Uc/FgMonv2Sx
	 JSCz/VsurrB9A==
Date: Thu, 4 Dec 2025 12:07:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
Message-ID: <aTHcB7Vm80XDMiaH@kbusch-mbp>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
 <aTFpsl3o7IoJ_xPg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTFpsl3o7IoJ_xPg@infradead.org>
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

On Thu, Dec 04, 2025 at 03:00:02AM -0800, Christoph Hellwig wrote:
> Why do you care about alignment to the controller page size?
> 
> > +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
> > +		dma_addr_t dma = sg_dma_address(sg);
> > +		unsigned long sg_len = sg_dma_len(sg);
> > +
> > +		while (sg_len) {
> > +			dma_list[i++] = dma;
> > +			dma += NVME_CTRL_PAGE_SIZE;
> > +			sg_len -= NVME_CTRL_PAGE_SIZE;
> > +		}
> > +	}
> 
> Why does this build controller pages sized chunks?

I think the idea was that having fixed size entries aligned to the
device's PRP unit is that it's efficient to jump to the correct index
for any given offset. A vector of mixed sizes would require you walk the
list to find the correct starting point, which we want to avoid.

This is similar to the way io_uring registered memory is set up, though
io_uring has extra logic to use largest common contiguous segment size,
or even just one segment if it coalesces. We could probably do that too.

Anyway, that representation naturally translates to the PRP format, but
this could be done in the SGL format too.

