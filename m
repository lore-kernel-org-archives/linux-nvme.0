Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E75C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMd5rJEBZEVbaApbw7z+cWXb3j6zwwXbX0R+pjxh1NI=; b=CDUVl/xtCVxZnCcgdkKusDDTPz
	Kp1o8CepFrVQhBoTfSmc1Z+4/k+GnmyHn1hOv369pqCXcrzj/0s4JXFUd9KWOHy3o2Ls6n8SAGPR4
	sG+sLpuGK4PfgT/QHX1aJFdECk0ZYBheVehicZhylt9bEuVgvJ3pq7mazEo5ViEjKBlSiGFAVkmf6
	i+rs6hIpo9gf8jfGLupvg2KmVsZlyTAYUwPS1JwQwd5fpxxOwX3Y5QxskEgiiFvkmcE6V1b5ukX7O
	2z9HM9cIeylenATLb1qcP3JR5dpr1Lc5LeTniXVYMDV4+m3k62PcAb9xnj0c/K3OkJOHGWFpCZKwG
	Fw61pjpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSxv-00GFya-5L; Mon, 14 Nov 2022 06:29:07 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSxs-00GFwz-0d
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:29:05 +0000
Received: by mail-wr1-f53.google.com with SMTP id j15so16275414wrq.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMd5rJEBZEVbaApbw7z+cWXb3j6zwwXbX0R+pjxh1NI=;
        b=6t9LpYVPcI0S74myA3aaI2fe/0w6fsfwgvMyo12XNdJVmpc6qcaTfFiupwHMSnOneL
         eZNbnTx1XkiVev5+7byrXzNFNczp+TSl8mwv3w5m3sPrR75Ubs9KegnQJ9mQ44AecTzg
         2Lshs5FvJhG7p3DtJBqAzvvG85eIQHYsr5PBwFAeZlGEfKfTeweH7fHln7jCHSgxxxFf
         +pITyiLc6QbBptIU0/fvkvgbEcQP0NsGYO/LMrV87M+xIvm59S0ZGlGEquQBxshJzDgQ
         8l5PtR1UJs3knt/qSPidBPyZce/JNctJJR7FbDO0RGExgSh2p+oJg9NZZeLKvhPOwork
         Il1w==
X-Gm-Message-State: ANoB5pmBRmplf/yF5oZJYLKI6ZsDmTJK4sNZCVtra08JvZNmGBayuTJs
	2sGOnr0kqgxdZNgIpCMnKNw=
X-Google-Smtp-Source: AA0mqf4M9bEIzkIUpuGch87/aZzw1Ezif3JQzv37SgmUM3YcRqmgI29TR7qjPufowzErEhlUviQf+w==
X-Received: by 2002:a5d:42c7:0:b0:22e:35c9:fce5 with SMTP id t7-20020a5d42c7000000b0022e35c9fce5mr6512162wrr.534.1668407341694;
        Sun, 13 Nov 2022 22:29:01 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003a3170a7af9sm12205379wms.4.2022.11.13.22.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:29:01 -0800 (PST)
Message-ID: <c4d05cbf-f647-b05c-7c58-fa8620077956@grimberg.me>
Date: Mon, 14 Nov 2022 08:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/13] nvme-pci: simplify nvme_dbbuf_dma_alloc
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221113161138.883195-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_222904_079654_6A733B69 
X-CRM114-Status: GOOD (  16.40  )
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


> Move the OACS check and the error checking into nvme_dbbuf_dma_alloc so
> that an upcoming second caller doesn't have to duplicate this boilerplate
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c2e3a87237da8..4da339690ec67 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -239,10 +239,13 @@ static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
>   	return dev->nr_allocated_queues * 8 * dev->db_stride;
>   }
>   
> -static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
> +static void nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
>   {
>   	unsigned int mem_size = nvme_dbbuf_size(dev);
>   
> +	if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
> +		return;
> +

I usually dislike functions that may or may not operate based on
caps check inside them. Even if there are more than one call-site.
But that is a personal taste.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

