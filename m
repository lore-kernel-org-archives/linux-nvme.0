Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72453E7716A
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnO0zEUNmzQ2EEfFmjSf93qNgJ217vMhPPjxqXu1Q+Y=; b=FwYHTdCGCD3z1Tw+s6XynCznCF
	DHaRlBEMasqS1te+YzkZRnAdUrz/4/tyZFs3/RDbEUKzxhrnGc/IYhN+0uIobuyZIaDPYVKdmH+k5
	NV2Vg135u2LpixTF2ymWQU+9f/6iz06zz661QMSnBw8Ek+kfV30FGO5Riuu6JWzVy7TJaQc2VkMXI
	Rb98YRCFGzlI6MmcNW2eY55+ODxQvR9S0tgc92AYQCXXDvK+aH4WmMhunx3kgfBSiio8xaSD5n79X
	OFbKRHaqs8m8KcGeXcr98WCzBscPQDGDfNcN8E1v3wdRT1JNnG76RZImGOnvWznbmeBP+WSxLWDcu
	DhHDBwzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIeJK-0000000BCb2-2Pwq;
	Wed, 04 Dec 2024 01:36:14 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIeJI-0000000BCaZ-0QYp
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 01:36:13 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ea5a7a5e48so2907846b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Dec 2024 17:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733276171; x=1733880971; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnO0zEUNmzQ2EEfFmjSf93qNgJ217vMhPPjxqXu1Q+Y=;
        b=OyGXaLzlFVihMV2vOLHOdPIDod4EDckQ0nlSzEe0vRtvv57UZbP2Vm59uMeHSiv1Re
         kN2bDZVuzYLJ/6HiylW0RRQMXGzABcgBzWfOO5Ux7yfpeXUQ4wIeiLFg9yz2cyGfu0sb
         Cc8vcHgXeWA7xdfeCDepxQrYvBhoN37KkbDo/p0aliLHPCVNa01nxmrF1b41iCAqrPMt
         RQZu+uCADxHxp9NWOCsL34B2XzZFjqwmEu1ISgT5iFOa8dxv016A4L6xAvfHkwTso0XW
         hj9b+C3eCo/xucr9B+inee89CZflwwTCcKhaAefhVPHXADqN8FX+bjl9q14ACDHVCwiI
         J2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733276171; x=1733880971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnO0zEUNmzQ2EEfFmjSf93qNgJ217vMhPPjxqXu1Q+Y=;
        b=rntg3Hqiy+NvI+RZflb3+970F2Kt5DNNEziweFtPKDCkjHQyl37MJZn6WhTiNwqO9B
         WHbVW5X9aBRXruIutLipB0h4O8VM8/wX83Oyh2NvWFAmtKQd+R1uQmhklf4DWdQiHKbp
         8xA5wn1DDP9Go5TITYEgrarqlcq/yGNQ8qPO+HqrwRG5HebNPSaecsj3N+t/2+kp083A
         xQBbyL3B0eXEN6QQz1oIF6DSCTdzWmFcW+iLmXDwD5XQLyy6HVYs93pYQsglZbuyL10g
         Qzy/JZ1XItsRbjBdttyDdm9wmemZxTIcTxXB9092clG++w/lZmH42dn8g5XqcXuWPYAl
         NWaA==
X-Gm-Message-State: AOJu0Ywv8KMtyQNBHOL6w63Pg9qphHRXW6e9ynkwpF7TrQTyQhZm+NAw
	OOKnx0jaPA4BFZyN2ZJyGITvzomBfAAY2lw13gxz/GL/qGEulGzuwu/r1Bir/Y0=
X-Gm-Gg: ASbGncse8s7LLXhSdjAPs6sQxQ7uJzWCu9bNOwyNaVIaQSEKd1xXoi2pMAbrom02jAb
	grT6EbCW/ZPx+09PP/FshFNXDKByFR46fI+2SturwCBJV5x2wFtOSfwfemgxt3Xb+Idy1BSxuur
	WWaVLdNu3wrGFmP5vv95jZFT7DNbSW3FTU7DzsktRFuY9mrQ0b6gKTOBmPfwLuaOcEcJHY1P8ek
	qKU68HkFFpp8qSpHUNckRm1yFQ4kp4Vk9ffWNlupjp+A/Ae
X-Google-Smtp-Source: AGHT+IF/k3rfqdrtLzGyYyg1bcvKm0/fFGqPQful4UQtH0pjT9gi/p9DSeF3qIZnLOxhnHXebaYBpQ==
X-Received: by 2002:a05:6808:2124:b0:3e7:b644:e4ec with SMTP id 5614622812f47-3eae505a33amr3654802b6e.26.1733276170695;
        Tue, 03 Dec 2024 17:36:10 -0800 (PST)
Received: from [172.20.2.46] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86125f51sm3254912b6e.31.2024.12.03.17.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 17:36:10 -0800 (PST)
Message-ID: <39a67024-2926-4a20-8feb-77dd64ab7c39@kernel.dk>
Date: Tue, 3 Dec 2024 18:36:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
 boundary
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Leon Romanovsky <leon@kernel.org>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
References: <20241204004240.687875-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241204004240.687875-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_173612_414221_29EAE2EF 
X-CRM114-Status: GOOD (  18.46  )
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

On 12/3/24 5:42 PM, Christoph Hellwig wrote:
> Only call into nvme_alloc_host_mem_single which uses
> dma_alloc_noncontiguous when there is non-null dma merge boundary.
> Without this we'll call into dma_alloc_noncontiguous for device using
> dma-direct, which can work fine as long as the preferred size is below the
> MAX_ORDER of the page allocator, but blows up with a warning if it is
> too large.
> 
> Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4c644bb7f069..778f124c2e21 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2172,6 +2172,7 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
>  
>  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>  {
> +	unsigned long dma_merge_moundary = dma_get_merge_boundary(dev->dev);

Fix looks fine, but s/moundary/boundary?

-- 
Jens Axboe


