Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4360CA600A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h0VpqbkgJnQJuKfvx689PZ+SvWczC3FcMRa4AXMg2hs=; b=sdG0+vzPVD8cz50kkA6RFmKqP7
	JIOLVIiGRcvHlJxlawq8/xN+GQ5rvggHVL8nbLWnk5QpgjVPL+GecObm8t55GyykL0JK3hi2an2ui
	wfjiTUgtpU7Grbv3XNKq8FH/kMu2acEYbKlJKQ1AP0sUakr8zrSuVLvRAcPiEVVzZUi1zsgJpgWLX
	92YOCHgM7NUNg6NwpYLwaZxZfhFDo9PAqYNXZJ1FpZiDggkT0ekg7VqjwcorVCGsW183xvhDRUoIN
	qh4URDc1NF15QIgek9KWu1ksd88ZTlV14IhMPsyQW+Un2Se6EMELTaKdecApc7v+TfraEvOoKwavv
	725ccbdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEigb-00000003lzy-1MzP;
	Thu, 08 Oct 2026 07:37:05 +0000
Received: from out-93.mta0.migadu.com ([2001:41d0:1004:224b::5d] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEigY-00000003lzH-0uN9
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 07:37:03 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Au5uJpuNuC+CmcOb4NW2/0yrdQgIbuQKXA4utc/zJs8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791445018; v=1; x=1792049818;
 b=mz0Lq6QPBGKMUw5/V3w7HDftEqNcH+CfYZdXQK0hcrUe6kLHZVUR3YH3IVQkfPRSrWHcwgAu
 sggT7YY4n44/A+1m69Vfs6dtiyBSt2IGB9QpC7OGG/Si5+BB+dwOiCcwurdgAg4iJoFshox0bPr
 nIh1ZKDtueA6Ge7HLPJGuGK0=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 4acdf2f0f9884e32;
	Thu, 08 Oct 2026 07:36:57 +0000
X-Mizu-Trace-ID: 4acdf2f0f9884e32
X-Migadu-Flow: FLOW_OUT
Message-ID: <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
Date: Thu, 8 Oct 2026 08:36:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation"
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, ahuang12@lenovo.com
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, sunjw10@lenovo.com,
 iommu@lists.linux.dev
References: <20261006120248.147654-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20261006120248.147654-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_003702_399943_3D30E243 
X-CRM114-Status: GOOD (  14.86  )
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

On 10/6/26 13:02, Christoph Hellwig wrote:
> This turns down to cause up to 15% performance regressions on standard
> large transfer workloads.  Revert it and hope the IOVA allocator can
> eventually be fixed to remove the need for the original workaround.
> 
> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
> 

What was the block size and conditions for the original issue? The 
commit just mentions that mdts=10 and we get a 4096KB max HW sectors.

I can't find the original thread.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5440cf18b55b..82e308fe4f4c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>   	 */
>   	dev->ctrl.max_hw_sectors = min_t(u32,
>   			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);
> +			dma_max_mapping_size(&pdev->dev) >> 9);
>   	dev->ctrl.max_segments = NVME_MAX_SEGS;
>   	dev->ctrl.max_integrity_segments = 1;
>   	return dev;


