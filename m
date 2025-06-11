Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46435C71143
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ss8rDp79ZiQ6cBAw9DaHR0I3DPaIchxjuB7P/h2zS00=; b=GSLCwsViarW0dfxvKOtjwTm3p1
	oy7gzZkj5gDAdwT0knJHdDEuv7VUQCMLcxABoNbizYf18pcGg+snZa55drAgSKAhTQWoBzj4ymqqL
	2goC9Ifxi3RxdV1RC/RgEaj4tg7IVfR7TF3g/uaZSt5XIkMH+1FdV7UJ3iIp4W2Kd4bYuT8BILeRL
	xL/gfV/CBGHvea335e35Vk/qm0wZsuqp2JGofPnBtRKXv9lJXznIOD9DUiy6OAKwuEo7l2y49Js5w
	Vb1p0b3iesNjksdimYGEuH0XgeNCyOTY/Fq1KyId7P9ybaY485DmqQZcTmVD0xx6j+xCao5FCq4ux
	WUQ0kBug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPjx-0000000AmI6-1TIC;
	Wed, 11 Jun 2025 17:59:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPLjx-00000009zZ7-0gLA
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 13:43:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CBC7E5C5ABA;
	Wed, 11 Jun 2025 13:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A942C4CEEE;
	Wed, 11 Jun 2025 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749649420;
	bh=zR+8aAQMpGlSGz0t5RpWSSfmxivnCbCkRAhWEzYsTYc=;
	h=Date:From:Subject:Reply-To:To:Cc:References:In-Reply-To:From;
	b=U93JaJV2B/yzKXABGFMjzQbCDd4o3jHnexKaFSp9C/R9qfA86z7QbRSfw7aXtM3Y+
	 OyyrhFyvUOBdWcnW4ipHfzagAH4XOWPG/oSAj0xsOJyahSFXs/tOu4wgPtkGEMzWtl
	 UNJrEw7OVRMLU72st04yK/IccIzvmQ90+NEIQekzse3pG4lkGS6Ya47AjwV3I+ADIZ
	 stPRi69eVDik6/U9q/Sz+ZMy209jzG+ncnplz8kLN3PFbnDFPmQx2S8SgX6eJmXpKC
	 grijeIbua3IHEXxV4VHDzRZe0GqyK+Pb3VF2vV5SmrUCeqQc9mYxLQja5muj113H5s
	 0eVXqZy0Ha9/A==
Message-ID: <c5d5abc0-9aec-42ba-b21a-a4ac2b34d03c@kernel.org>
Date: Wed, 11 Jun 2025 15:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 4/9] nvme-pci: refactor nvme_pci_use_sgls
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-5-hch@lst.de>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_064341_248029_6F44BC97 
X-CRM114-Status: GOOD (  14.36  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/06/2025 07.06, Christoph Hellwig wrote:
> Move the average segment size into a separate helper, and return a
> tristate to distinguish the case where can use SGL vs where we have to
> use SGLs.  This will allow the simplify the code and make more efficient
> decisions in follow on changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 449a9950b46c..0b85c11d3c96 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c

...

> @@ -886,7 +897,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out_free_sg;
>  	}
>  
> -	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
> +	if (use_sgl == SGL_FORCED ||
> +	    (use_sgl == SGL_SUPPORTED &&

FORCED implies SUPPORTED, what about simplifying to:

if (use_sgl >= SGL_SUPPORTED)

or just do:

if (use_sgl)

