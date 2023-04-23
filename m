Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65711C6FD18
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1g9B5TxeLmYEuXx75noV3icMXCyYnuMg3vM2+ed7Xz4=; b=nhE7SRcjtvXeSBL6/DQj4nJVPp
	4YjAZv90sdt3hHv4Q2hfTIoUvdmShcefl7yWd+bvWMsFf6zJq1cM0EKo5B2WgApaiubVdlYIodmmo
	vj/9NzeX53SCkHxSWGgfyPm13P9lz1jQRPsswKOzO0008KLuoLNIYHCrNvLUgTe0bKAEW8uN2zlTf
	pAVar6DB5pnQgf8TlGcZJwC/wkEEBpyU0anIIqwqofoEwmqCRH6yTXtzthN4vtZTa784ridrH4P2Q
	d06gMNRgh6jZvBcYBe3501mIoowOAGqmcvkhIGRFw6MPUY09hffEPmtnzMdeTXjGW12otS/rzEa6j
	LwYBM9iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqabz-00EPV4-1o;
	Sun, 23 Apr 2023 14:22:43 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqabw-00EPUS-1s
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 14:22:41 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f1754e6ac2so8496945e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Apr 2023 07:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259754; x=1684851754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g9B5TxeLmYEuXx75noV3icMXCyYnuMg3vM2+ed7Xz4=;
        b=K0FFw7nGctgrvd13UR5D3r3mPI90t1SwdIgwZmiLF2zkGqO1VhpPJLaD1wOUrlXEmn
         rrosbgwuXZw480jehKPMTdjNGCCnCgSeeG3Fra1+xz3EqQKlb9YOdLl/zCuBZsuYjBM8
         CP1ji/SoKzP0rNT8MxRMBhupEmvOd6vv9acO18bm23YUCL1KdTL3ohHaOpHxRn6lMdxl
         WWhHe0KUK9f4lINL2fjuupL3zyQPtZpkjlXgSfRR7B1Q5/lLkUfcxrkSWtA47DN6NO67
         9nqgECWq1G6B+MQi1WTm1VaPeVR7TpMniaqkDIoY842Ysrs5KFD7ToHhZNbECx429v9o
         eM6w==
X-Gm-Message-State: AAQBX9ehMa/X0hJf2r3H1fcRJCjzCnE1zXw4x+eoUAacSXPjap89sZlE
	mmI73Obt/dQaB3O2ozYSe+8=
X-Google-Smtp-Source: AKy350bb16P53Zc09oZAgTlBBcf+K5UYKXDEEbibuzZWEoENLyHXg7j1TDocNhKNEAruaYhhwvhsYg==
X-Received: by 2002:a05:600c:3d92:b0:3f1:8c5d:145 with SMTP id bi18-20020a05600c3d9200b003f18c5d0145mr8284903wmb.0.1682259753843;
        Sun, 23 Apr 2023 07:22:33 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm9767406wmj.12.2023.04.23.07.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Apr 2023 07:22:33 -0700 (PDT)
Message-ID: <1084ccfa-c923-5f2d-b481-5016c320f1ad@grimberg.me>
Date: Sun, 23 Apr 2023 17:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 2/2] nvme-multipath: fix path failover for integrity ns
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
 hch@lst.de, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 oren@nvidia.com, oevron@nvidia.com, israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230423141330.40437-3-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230423141330.40437-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_072240_642902_4C220EB8 
X-CRM114-Status: GOOD (  16.32  )
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


> In case the integrity capabilities of the failed path and the failover
> path don't match, we may run into NULL dereference. Free the integrity
> context during the path failover and let the block layer prepare it
> again if needed during bio_submit.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Tested-by: Ori Evron <oevron@nvidia.com>
> Signed-off-by: Ori Evron <oevron@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/multipath.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9171452e2f6d..f439916f4447 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -6,6 +6,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/moduleparam.h>
>   #include <linux/vmalloc.h>
> +#include <linux/blk-integrity.h>
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> @@ -106,6 +107,14 @@ void nvme_failover_req(struct request *req)
>   			bio->bi_opf &= ~REQ_POLLED;
>   			bio->bi_cookie = BLK_QC_T_NONE;
>   		}
> +		/*
> +		 * If the failover path will not be integrity capable the bio
> +		 * should not have integrity context.
> +		 * If the failover path will be integrity capable the bio will
> +		 * be prepared for integrity again.
> +		 */
> +		if (bio_integrity(bio))
> +			bio_integrity_free(bio);
>   	}
>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);

This looks good to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

