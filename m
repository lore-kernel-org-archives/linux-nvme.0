Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A19BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXHG5PQcBw4zVhVsvbh/O6JOrzn6OacpyFKCKAnSXZc=; b=uJGjKAEJKliRwZlxbS/86hsRgs
	WSNTZj4VcPk4DiDniPFN+A5Ya6NceiG5RCyPheHVPjfCHfvfiVtTdHAF8KFDpyagcku4K/ENe50Iv
	RmkAFP0+x/GFeMpjw6st90JhoSVsolrr2+2ka2zWiEBcT9AKxx2u+hK3VIeGGfnrh7DbBTWyxt9qY
	5Quzr+Em7wl8d2aTOi/xUpkkC85uM1v6tFzeq3gj45i+jFonYH5fXEl1HwL6X8PqO2zgimpUdY+xS
	fAx9EeaUyaY/eMT40wcI+ZvydFh0NiTTMcbymC15eb9jzD3tRc/sBz33Zy/tsu/dwxHXrWd0V1QSG
	JLG07zxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU5wK-008yWu-Dg; Tue, 15 Mar 2022 12:06:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU5wG-008yUr-LR
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 12:06:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6212268AA6; Tue, 15 Mar 2022 13:06:02 +0100 (CET)
Date: Tue, 15 Mar 2022 13:06:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 Mark_Hsieh@wistron.com, Walt Hubis <whubis@micron.com>
Subject: Re: [PATCH] nvme-pci: disable write zeros support on specific SSDs
Message-ID: <20220315120601.GA7918@lst.de>
References: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315104702.20798-1-mark_hsieh@wistron.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_050608_926617_5EE90012 
X-CRM114-Status: GOOD (  19.02  )
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

On Tue, Mar 15, 2022 at 06:47:02PM +0800, Mark Hsieh wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Micron has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev
> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> So also disable Write Zeroes command on Micron.
> 
> Signed-off-by: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
> Change-Id: Ic6ebfe141702d1869490bbf210627055b5b4d80f

Please drop these strange Change-Id tags.  But more importantly
something seems really broken here if the device claims to support
Write Zeroes but then doesn't claims it is not supported.

Can you see if this only happens with some I/O size?  With our without
the nounmap flag?  Does the device report non-MDTS command limits?

> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a7a502a5b2b5..68745e1d7b6a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3245,6 +3245,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE(0x2646, 0x500d),   /* Kingston OM3PDP3256B-AH 256G */
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +	{ PCI_DEVICE(0x1344, 0x5411),   /* Micron 2450 MTFDKCD256TFK 256G */
> +		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
> -- 
> 2.17.1
---end quoted text---

