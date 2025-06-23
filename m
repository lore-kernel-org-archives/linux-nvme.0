Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA00C7115B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLZPXS/IE26y8M+Ci2YtALk0z/tBpuKi2GgJJhoHEx8=; b=L2Tf9DY7BM4K+GuFUixidx1SXb
	Qz5jJgp0Heqvp2WHpv/e0MtKaHkYehQmseXfeLgjBXR9K1IumdEZivH9xKT0rQ+EktnR8Ybgh940A
	KFA8jC0DjHvR/m41xoz+RtlwzeLAfcYK1X4Z1alE1mSM2BenF8Z/Ivl3go2W9hInUyxgsMHYVBUR3
	x5qlKoAr4yKqIEQd+P8E2B3YSHMq3GTA5DMLfxlWmmwzaXTFYLcJ5GEDiVu/69CT8VJqMowW9fW7K
	/MaxjYJ0pCVP3ugXYGQysG6Qir/EBOl4Y04+edX57PJ2zDcceHwZNstAJjJdCHspVmu14+DW1Vis3
	IXMLk0Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTraz-00000004HMw-21uZ;
	Tue, 24 Jun 2025 00:33:05 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo2J-00000003wsH-1MPi
	for linux-nvme@bombadil.infradead.org;
	Mon, 23 Jun 2025 20:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=SLZPXS/IE26y8M+Ci2YtALk0z/tBpuKi2GgJJhoHEx8=; b=hr/K2fV3U72Dh/p6RdDxoT/ehE
	AVGJLxzaRAF70VpRyq4i5gcBNiyHkvlYMANjLBpgwttFZdWAylmGgZC7Cm+Ul0oB9eGjfMvXTD5Ve
	K/lb5kN3yL8xyOHQwZpDb4NFQogQSMDSHx5B5csdfxZO2J2aGIHAU7ydiLV7lyxftiklLyXIzgDVv
	wmEpaUBb1JwRd+nXHiobv8RY3IlXMBfZHJnWXJr2GpX6lBu6vEN1HedZFk/Hyo+d10hNZMFpkPCqa
	oo5uHIVofuXLXhWv03KOEBB81U6ouFON2qr4njQu1rfU/BeCbdaCavDVMWVh5jl3CJNCv7O5X/yXI
	8u/qI1Hw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo2H-00000004YoT-2Vek;
	Mon, 23 Jun 2025 20:45:01 +0000
Message-ID: <9bcc6786-772f-4298-928f-34f3c6dc64d6@infradead.org>
Date: Mon, 23 Jun 2025 13:44:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme: Fix incorrect variable in io cqes error message
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
 <20250623064036.4187788-3-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-3-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/22/25 11:40 PM, Alok Tiwari wrote:
> Corrected the error log to print ctrl->io_cqes instead of
> incorrectly using ctrl->io_sqes for the io cqes size check.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvme/target/pci-epf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index a4295a5b8d280..44288d8f5aa11 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1860,7 +1860,7 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
>  	ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
>  	if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
>  		dev_err(ctrl->dev, "Unsupported I/O CQES %zu (need %zu)\n",
> -			ctrl->io_sqes, sizeof(struct nvme_completion));
> +			ctrl->io_cqes, sizeof(struct nvme_completion));
>  		goto err;
>  	}
>  

-- 
~Randy

