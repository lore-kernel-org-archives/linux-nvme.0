Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D4BECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iu59F2yjjnSxMinTkBcnO/aIj/eLxi+uzNZPz+D0Xj4=; b=hHi5dZPE2ZU2qi9QuEHyFeOXNY
	q7mEtrs8HH05VZw/jHQBXCvhSDN6/hMkEAx93qZ7OntXVb7cZQ7/6mFcmN/zOg7aa8vjL6nxa8oIn
	lBKqe81sKD5k8+M8+/c34gknPbCx1FT0nA107iCwKn6EhM6/LAFSKRW0QwU+XldRhvTlcVv4twNQf
	kTVUyJj85vqfBa2EoqWRM9QboNJvs082emjTElwR0Wcad9oZSeWNHA1KmiyuF63nmN3txV1YNW+b8
	MvdnftVBSfTCz8rhPedlXRKvYhC0ih0VMCAgmza1Nf3F3hGH/dP2Y/LkhSpAX0AM+FIpYypfy2U5P
	I7aOCksQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaup0-009pPG-Md; Wed, 21 Sep 2022 08:11:06 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oauow-009pMK-E6
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:11:04 +0000
Received: by mail-wr1-f53.google.com with SMTP id z6so8578807wrq.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Iu59F2yjjnSxMinTkBcnO/aIj/eLxi+uzNZPz+D0Xj4=;
        b=L8HFN9V6WPAXU2Id9PvmXvxQg7RTJb00QDiZ8+3OZ/dZZcA2EhfsXW+sIvBs7GEW7Q
         tSQoKH74IFoH2YN20XXeThXSmoU+/aVoAR3EAb6COnAPk9dYU1KaoLZndOObGe4SgW1k
         mxdJNi5Y3LyR9lDWuMRvSpeSxF/LJmMTC4oxe3WfMg9KV6utWOhPgwUPVkXZFPpBKbD+
         10/0p+Fqc25unHbUk+loLAdtP1viPSkN1CFxPMUcKlKGTcgaeRhFKPPkLD/zzWDZt7M8
         Pl63ofaA2atT928BasPns16UnrnpHNXbiaz/j4YtmH5Cwx6dITOBwJCbLl6XJvldu3x4
         V8Ow==
X-Gm-Message-State: ACrzQf2ZQ+oH0sXNAIb7Dq4HLuysLeTxnS6mNXCNmv+WC6uw27H8Bkcp
	0Rt47nxjzkZfVi70qDGac1Q=
X-Google-Smtp-Source: AMsMyM7QiaZiVKEESkFqK79/DIVCfrBFdt0Oww5MRhd+O/TFHWAGAGnuMbY6OC9J0k2l9jgEt+4E5A==
X-Received: by 2002:adf:dc4c:0:b0:22a:42eb:1e34 with SMTP id m12-20020adfdc4c000000b0022a42eb1e34mr16706381wrj.258.1663747860533;
        Wed, 21 Sep 2022 01:11:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b003b482fbd93bsm1980372wmq.24.2022.09.21.01.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:11:00 -0700 (PDT)
Message-ID: <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
Date: Wed, 21 Sep 2022 11:10:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating
 max_hw_sectors
Content-Language: en-US
To: Rishabh Bhatnagar <risbhat@amazon.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@fb.com, kbusch@kernel.org, mbacco@amazon.com
References: <20220920191932.22797-1-risbhat@amazon.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920191932.22797-1-risbhat@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_011102_540527_F0F6229D 
X-CRM114-Status: GOOD (  17.92  )
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


> If swiotlb is force enabled dma_max_mapping_size ends up calling
> swiotlb_max_mapping_size which takes into account the min align
> mask for the device.
> Set the min align mask for nvme driver before calling
> dma_max_mapping_size while calculating max hw sectors.

Does this fix a specific bug? if so it needs a fixes tag so it can
go to stable backports as well.

> 
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 98864b853eef..30e71e41a0a2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2834,6 +2834,8 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_start_admin_queue(&dev->ctrl);
>   	}
>   
> +	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +
>   	/*
>   	 * Limit the max command size to prevent iod->sg allocations going
>   	 * over a single page.
> @@ -2846,7 +2848,6 @@ static void nvme_reset_work(struct work_struct *work)
>   	 * Don't limit the IOMMU merged segment size.
>   	 */
>   	dma_set_max_seg_size(dev->dev, 0xffffffff);
> -	dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
>   
>   	mutex_unlock(&dev->shutdown_lock);
>   

