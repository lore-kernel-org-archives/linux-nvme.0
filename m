Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10025E67495
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rlyvxFeosUCTgS/NckPF7IGlpen8lONAZ5K7J2cadI0=; b=BXLF/nSLAjjguv
	5y+FVuwwJYnd4oNo0X98HQzDVLO8W7ecB9nHxjgeg1S5sHN3cvbnz1SHzikyeyxLcQsMHEmTaXAj1
	vQaktxE28FYT6goOqq9LqTrerI4BSY9/FJVw6uQLKnC9UWOmo/5JKKmggp/AkreKyDi6UwUhxiX84
	RhqEGboHx2lU6V2Oeo/vFDOgfnArUtWdJqfqvXlElmgJ9HVwZwyzNCbzrWb4LVD3ejnicgsqb3yMD
	qpeDTAqqRYZ1fbb2EvLSuhDwE5n1y7gH/l8psuHPBY8TAXghfxz3M2txLU5r+l1Tz1FJLzbNYJFLk
	nwEhl1qv0WApyjmgmGTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXjQu-0000000E0gd-1XHM;
	Mon, 22 Dec 2025 17:10:56 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXjQr-0000000E0g5-1KmM
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 17:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=rlyvxFeosUCTgS/NckPF7IGlpen8lONAZ5K7J2cadI0=; b=tRWsY5/sJc3LPeDw1XCCSz61w0
	BvWaboyhIaIEstf+FY+Pw3Mrt5ROwsjzprelE/Dbmh9BRCgZcjM9cRhrK2xDiKCWBtQWK5F/lzZkP
	PpNJy8D3qK5jOtsyf83j2b/46tSYE2IZtAb2YXy03L2FOOBYZuZTHLkFQ9P/e3jjabtrTcdFSKFS2
	6tbk1P8d+7aR874dnSz0hvwa3Pr8j0MJ/1UMfgGkU4Hep4RAWOBos1XCBpfcxtIjMFxDzRDQaYobq
	fYyVRqMJCkHhV1tUjPk9oLYItwU/iRUmJ6kI8a7h/oSA1jTsdui5AzoJ6T3PNXSVXYLTCvV3Wt/ZH
	rSeMv9vw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXjQp-00000008K3A-3QRR;
	Mon, 22 Dec 2025 10:10:52 -0700
Message-ID: <33c4a321-0e5c-4090-be2c-4bfbee603f5a@deltatee.com>
Date: Mon, 22 Dec 2025 10:10:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-14-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-14-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 13/13] PCI/P2PDMA: enable compound page support for p2pdma
 memory
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_091053_363673_008EFEFB 
X-CRM114-Status: GOOD (  20.09  )
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



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Compound page support for P2PDMA memory in both kernel and user space is
> now in place. Enable it by allowing PUD_SIZE and PMD_SIZE alignment.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  drivers/pci/p2pdma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4a133219ac43..969bdacdcf8b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -452,9 +452,19 @@ static inline int pci_p2pdma_check_pagemap_align(struct pci_dev *pdev, int bar,
>  						 u64 size, size_t align,
>  						 u64 offset)
>  {
> +	if (has_transparent_pud_hugepage() && align == PUD_SIZE)
> +		goto more_check;
> +	if (has_transparent_hugepage() && align == PMD_SIZE)
> +		goto more_check;
>  	if (align == PAGE_SIZE)
>  		return 0;
>  	return -EINVAL;
> +
> +more_check:
> +	if (IS_ALIGNED(pci_resource_start(pdev, bar), align) &&
> +	    IS_ALIGNED(size, align) && IS_ALIGNED(offset, align))
> +		return 0;
> +	return -EINVAL;
>  }

Again this seems strange. It's a bit unlikely to have a large BAR that
wouldn't be well aligned, but this change is now requiring all P2P
memory to be aligned to 1GB if the CPU supports PUDs. So if a particular
device only has a small (say 256MB) imperfectly aligned bar it may now
fail to be registered.

I don't think the alignment should be a property of the device. When a
mapping is created, if everything is aligned appropriately, and there is
enough free aligned P2PDMA memory, then it should map a full PUD page.
There shouldn't be other restrictions placed on the hardware to make
this work.

Logan

