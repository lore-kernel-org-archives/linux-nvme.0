Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9778C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjBxCy4KdKHXLg8qp3eQ2l0d98HskHx6Bo4iw1+O0PM=; b=XxsY0JPs41r90dON1gRvfmmMOL
	9Ob8mvcUdGWsxijFXFRGWEayQL40eqrCLgpfTIuEkErQ1noejoW1jCNqDccXvMOb3Si2UFG34Sl2b
	scPIv14JiX+X1M6xs86QuSYCZfDwj6HGF8QQtBIAqkWxzFZAdhUUlkv1cXgAB9otFZ1HvS5sCx4Ib
	NRjd4OUToXzCeL7AuNoXTlvM/LejmT/HNWWJIGVCqRvdHIawp0Lmc6iCPiD0+bfOu2XFfVYIef7Cg
	t7Jga1H+C4EsreVZUEXUVNs7emeOQ2LfbC1yJmXjgIH1Wl0au57L1I8E5HtwtROcE2ZUuH5BapeEO
	uItpcAcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nhFRO-00A7Pn-60; Wed, 20 Apr 2022 18:52:38 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nhFRM-00A7PN-Of; Wed, 20 Apr 2022 18:52:36 +0000
Date: Wed, 20 Apr 2022 11:52:36 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sasha Levin <sashal@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 18/18] nvme-pci: disable namespace
 identifiers for Qemu controllers
Message-ID: <YmBWdMfQ/WIACcTg@bombadil.infradead.org>
References: <20220419181353.485719-1-sashal@kernel.org>
 <20220419181353.485719-18-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419181353.485719-18-sashal@kernel.org>
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

On Tue, Apr 19, 2022 at 02:13:52PM -0400, Sasha Levin wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> [ Upstream commit 66dd346b84d79fde20832ed691a54f4881eac20d ]
> 
> Qemu unconditionally reports a UUID, which depending on the qemu version
> is either all-null (which is incorrect but harmless) or contains a single
> bit set for all controllers.  In addition it can also optionally report
> a eui64 which needs to be manually set.  Disable namespace identifiers
> for Qemu controlles entirely even if in some cases they could be set
> correctly through manual intervention.
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Huh? The NVME_QUIRK_BOGUS_NID is a new define and the code which uses
this quirk is also new, and so I'm curious *how and why* the auto-sel
stuff for stable can decide to merge this and this should not even
compile? I see this was backported to v5.15  and v5.17 as well.

I didn't get Cc'd on perhaps some other patches, but this immediately
caught my attention as not applicable, unless of course the patch
"nvme: add a quirk to disable namespace identifiers" was also sent
as part of this series to stable kernels. And if that was done, well
holy crap, really?

Cc'ing Klaus on the qemu side of things so he's aware.

  Luis

> ---
>  drivers/nvme/host/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 97afeb898b25..6939b03a16c5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3212,7 +3212,10 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>  		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
> -				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES |
> +				NVME_QUIRK_BOGUS_NID, },
> +	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
> +		.driver_data = NVME_QUIRK_BOGUS_NID, },
>  	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
>  		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
>  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> -- 
> 2.35.1
> 

