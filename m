Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA12C7115A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BFihR2u9uShVazRKD2cPFEFgf/AGg+eQMX8rIB71qqY=; b=ASaTNhPznUlioUFwXncRHXMczH
	0MzFzAYg/YAQnkTBtM2siBMjIvyqswOP5kg6x44ME8+aeRZP5nF2Nscdsv8VN9ZczmQk+Oa2NArMn
	pkYw5ZS/bmGIN2c1I5v4JOOXelq/X4q07FlJ+QzBDgwVO0FEnCfLgycXTKrreiz5HsXFt33x85wvV
	+xoto4Tb+waCjs/TLogY4Ll03EdewA0Aw1cnpFMYmwbNKOBF9QD02SZQxigafO2gEouP0b708Eq5E
	w5uOBrdKKRWMKw9+km+u1cK8mOg81ndJAVk7+XMAsOWrJnJQXgTkpBnfJ/wP0h6LphAyh/4m0gyaF
	krhP5MUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRBif-00000004p2H-27rL;
	Mon, 16 Jun 2025 15:25:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9TY-00000004T9u-0pkv
	for linux-nvme@bombadil.infradead.org;
	Mon, 16 Jun 2025 13:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BFihR2u9uShVazRKD2cPFEFgf/AGg+eQMX8rIB71qqY=; b=H/ygWQwvPgF+klD3ksnxsSWeF2
	FEAzoPrUJEAx+137cMMd0mfrcB4LIIO2pZY9oJy4qsKo/oGd1ORggWxcZ7/mHxc2nsaYGOwFzhNHa
	ap6UMiSzfo7/4Qx9Ox0qTfjuGjH3qwq45xI5gyrEn4FDLqok3GfByRx888FcmmY4HAqDP27W3IF/H
	WaQDHDBB0qvGtmDpZ0zJlPyqS6CO1S39hcos+QTp+oSjpE00JO0YRw1+SdrD0z0E+7awx6GG++nmi
	RkNTPpvCFLDf4TpHBRsPuNga9AJ0FBQUsdNBa7DqHUxHCcBCjd26J3jItmaeNoNrmrrvrJceH9wao
	gfomiVNA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9TW-00000003aAq-03qB
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 13:02:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B9D567373; Mon, 16 Jun 2025 15:01:59 +0200 (CEST)
Date: Mon, 16 Jun 2025 15:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616130158.GA28914@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org> <20250616113141.GA21749@lst.de> <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org> <20250616124205.GA27570@lst.de> <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c210c03-9213-4c62-aa4f-2803b6d0ef0a@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_140210_243558_3AC0E30A 
X-CRM114-Status: GOOD (  12.05  )
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

On Mon, Jun 16, 2025 at 02:52:15PM +0200, Daniel Gomez wrote:
> It should be valid already. But if the initialized value at line 160 can be
> changed through the previous code then, this should suffice:

Why?  If pci_p2pdma_state returns something other than
PCI_P2PDMA_MAP_BUS_ADDR or PCI_P2PDMA_MAP_THRU_HOST_BRIDGE, BLK_STS_INVAL
should be propagated up the callchain.


