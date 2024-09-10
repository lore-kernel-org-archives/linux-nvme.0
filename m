Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A3EDE99A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 16:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39RgixzUzxus3tECEtDNAT+e7kH7+PZP6s9/2kh3j00=; b=BEEvX31Ih9A7dU5a0qc/YWdHLR
	R0I84/uSdD9a1nLnmv70L0HrTqBuOxMUrxEFFXTvCGhFKXn7i3b11ujS5LbpgcD4Es5MUyw2zZscc
	VkiJ5XygJbt7+fdMAu1iAwJmJACIxieTFmdcGkwPicSu+HaJcpE93cuIatNtbW0WQhhMimu2SQmqm
	+owSAzW11TLrJo4toDXTW0yKX/qmppz2jIZiGfNjFji64KaJRfA5tvEeMR8UH3FnEN4mOs332PxiV
	y8Jf07FHQQfcpBpx9+49qLVPISMrvXG597oxBBfssmhwVHJz5xitFLzRHVtr7nXuwZ28eBlpRwBug
	CBtxtDGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3cC-00000006JMe-0f5l;
	Tue, 10 Sep 2024 16:21:16 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3c9-00000006JLH-11sH
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 16:21:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E229EA449F3;
	Tue, 10 Sep 2024 16:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AD1C4CEC3;
	Tue, 10 Sep 2024 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725985272;
	bh=2IBMIJqI8PHktjccNnGcVhaiteOsqyw1iGPhtEuQJOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pS7U4OujPOstuwgVxtpKl4tNQfouvess+kEErgSp6YcSrPkX6nehTFaAKNbs/qRqa
	 j0oA6iMJZTdpy/5zXLEaqXomUJjBrmvDb4ibMMAk+O8R2064E6hByH+/NiDcy8baWF
	 2HZO5fu2Mquwcr065Zk6/ProjtZqobSk2ORvqnJrPpJ0UtkAf3wGjWGOL6tvZPqdoU
	 ASbPllaQyWJl7meCHUAKZ+Y6xLzwZmCwTBHaqNkt6W/bVZwmVSo7vqmfhXCvleSeGv
	 zzdOP0DH70mDMzb3jsn3yFVIDvoVIn8V/W71QkMyt9wEeuAUW9+BZR02dKATbApPwA
	 R+5rFQVvryOgw==
Date: Tue, 10 Sep 2024 10:21:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 08/10] blk-integrity: remove inappropriate limit checks
Message-ID: <ZuBx9blCTUvsS6yq@kbusch-mbp>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-9-kbusch@meta.com>
 <20240910154526.GH23805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910154526.GH23805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_092113_370997_7C6E0D1E 
X-CRM114-Status: GOOD (  14.92  )
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

On Tue, Sep 10, 2024 at 05:45:26PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2024 at 08:26:03AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The queue limits for block access are not the same as metadata access.
> > Delete these.
> 
> While for NVMe-PCIe there isn't any metadata mapping using PRPs, for RDMA
> the PRP-like scheme is used for anything, so the same virtual boundary
> limits apply for all mappings.

Oh shoot. The end goal here is to support NVMe META SGL mode, and that
virt boundary doesn't work there.

I was hoping to not introduce another queue limit for the metadata
virt_boundary_mask. We could remove the virt_boundary from the NVMe PCI
driver if it supports SGL's and then we're fine. But we're commiting to
that data format for all IO even if PRP might have been more efficient.
That might be alright, though.

