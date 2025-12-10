Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA76D3C52A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39YBv5d2YqLQdDEnItuIY/opvZj5W2WOx1eF0cnY4/k=; b=mKqBa1d4lYXLxfWgTut/m4O96g
	Gu2DxC1DTPtNtRp0L+ry2KkPQRkSsa0cjSrBEkC21UcJKqYccITZ6COIBBdmq+cA9kY7wKSck8vzF
	QOfeaQsf4dbZ65ha5EJNZhpafEfqFQQdhD1JUNS7p0YtDcConuqGnJ58/v5mlhh4skvD9xAGd9s2S
	DUgG7bbCeF7sDu3FC4+F4AlFVtnTFJAU2hpqHRvxuE4WTo4KNAs+oXKUxQU8obHl2Nb6IOMsAlc1G
	cfJmVKv12Kt3ZS60v2TQehUz/39CEu7xtYZOU6uiSFltC+/j8XHp5R5B02EI1INsHFE8GPz1uoFGU
	YZwGjlKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTIMu-0000000FNZW-2gLj;
	Wed, 10 Dec 2025 11:28:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTIMq-0000000FNYu-08tJ
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 11:28:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FA2643626;
	Wed, 10 Dec 2025 11:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4FAC19421;
	Wed, 10 Dec 2025 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765366103;
	bh=gg8hl7nTHDakoQLZv6QxgPTOn2zhObCa9+AvPzyKdXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGqk9OWiUeYLcSid5N2CFDeHMDLKlbx3Xthod0DimM1ITfI21ZX8DeGD4RFD98wqh
	 n1TGpk0/J9DS1V42TVy5abFvhp3bMvb9hV5xWmTv//ZuxY9my0DiIy+f17p1Nm6iQw
	 Sd16TyqbtNDf8cf0SYXDZPJ3GZaW2kTwy5/BLPvOj9ySS7QCVEB/Af/ZkUdlCQzrsH
	 8W7Dbhp0oEFgtwy+YjkofXApmpkZWkfDB3EJbtIqHz7B8hE/pgP0HWnpDPw3PqYpMH
	 DwtuaFQkTxUwH5CvkhX4dKfF2YMOT2FiXtby6DIsKpdIr8qZNoAt2I0RfTn/XUkphB
	 Eq57rP7w9vN6w==
Date: Wed, 10 Dec 2025 20:28:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, kch@nvidia.com, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
Message-ID: <aTlZU_2SqgajJ64v@kbusch-mbp>
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
 <20251209064015.GC27728@lst.de>
 <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6649eb8e-ae68-460d-95db-deece134e9d1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_032826_488181_0546EF6C 
X-CRM114-Status: GOOD (  13.19  )
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

On Tue, Dec 09, 2025 at 01:31:21PM +0200, Max Gurtovoy wrote:
> dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> 
> and
> 
> lim->dma_alignment = 3;
> 
> to ease the restriction for capable devices with NVME_CTRL_SGLS_BYTE_ALIGNED
> support ?

Yeah, the dma_alignment is the limit you'd need to change. Note, you
can't actually set the dma_alignment to be byte aligned as it's a mask,
so you'd want the value to be 0 to allow any alignment, but the block
layer currently won't let it be 0, so you'd have to set it to 1, for
word alignment.

But I'm surprised to hear of a device that can do byte aligned SGLs, as
PCIe fundamentally can't do byte aligned DMA. It's all dword based, so
if you have a device that does report byte alignment, it's still sending
dwords over the wire. It's just using the "byte enable" fields in the
TLP header to have the receiver strip off preceding and/or trailing
bytes, so it is a bit inefficient way to transfer data.

