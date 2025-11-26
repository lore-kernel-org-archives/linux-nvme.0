Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762CAD10397
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=; b=z6CDSr/qVrGNJ+NrohYhY1FJfo
	qV0PFoCQFgmkbyIXfbJderzpxl0DfveYKPuEH7CRJCuFcvs2vJws1yyItDQHIMLGEdWC2h9nMwhw/
	QwZpPRdIoh5GKdP386jZed6XA+i/+bZ/48QI0jqOE/7PLAe3BZ+XHz8CK7tzc2707+DvpQkLUXc00
	EvLx1ohHHOxSglfasvObzkf9IFldpPMHZiuRfi0qE74KKa4h6WzvdTj1YmdOBLHMBHqhWAg27AYE1
	YamtDDqtGyMcRTDzgFafZOz0FIJq8YJW37I/0OfMSRfZEEeLnbTTX+a0Og7pK2vqZ/tmhB70bVFaT
	Grq0KCUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCXq-0000000Ela6-1pr5;
	Wed, 26 Nov 2025 10:14:42 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOCXn-0000000ElZk-38Ez
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 10:14:41 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-34585428e33so6509053a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Nov 2025 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764152079; x=1764756879; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=B7iXETVaDRfC7gM2c7qe/S1Myrh0+xjOpT77IJdnM6/yYfIJgC1PGXnbujOm24d8Fh
         I5tEmHB1eiSqkIQWKSRl6QWXwCgPYcG0suvlsNitoUUyBNobHutdrXPlpEKdFfcJj9xJ
         7+V44MLrQEl4gaOf17AyXNJ6vTOA9b0AuhMbnUZeSoDtoGckUbKa4b4+1j8sCLM2f2Hu
         s5U4FrnKTDoh6XwuOhs9jJG8+uUGFtQzUVyS9Gt0ZNAMmCPjE72v6dTqdHnI2IHdRTGy
         RhS6MJleXPg7nArTJGpa7P/sVHWqFjzdBtowiG9iMALi4z+VBhYmJzND9CvpuEYl1qf7
         gKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152079; x=1764756879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi+SDeiIoLJQ2kckUqTjOMqCDPLpLNM9S07CFUmnZ6s=;
        b=JVjJ/XuU11OgNd/8MesP/uIQpY12OHVZIVJ7C5utD/5S38AFal7xut1ZHhjf/0Agh3
         qj0crhcBp5sVM5YFAl0t4I26qCS1NCl2KKTMLXZRZXO+VIExbxdHQiINzomej76JYvb7
         TuPlgF/IjkPjuez3jNUlRF4IdAZvEJ9lni07RyolB7a2OSQcTqWvjtX/uFpDxoab30cg
         vt4nlwK2bMezdS0NvNgvkQjsnYkHozjzHUPLW5o5JfrjPd6zoWvdt9BOf2AQPynq7CTk
         jM8bITGEzt3qx4VnQV/eaHe9h6xcWEFGhYhtfW62L0Y/5BdpVpV+cblweoclEQbIGU6K
         YaWA==
X-Forwarded-Encrypted: i=1; AJvYcCUfmyLfqdQZz0/YItGukIyXvl8CenUoFMoIIoblvFk43fR6+erDjK4dW2r0ThVhoGRjGfw8mxiQppCZ@lists.infradead.org
X-Gm-Message-State: AOJu0Yz61HJTIB9O2Ozvz91Ed+vePQU0R3Sxiohw+MLio3SxzaYVqqht
	YKW8ZEsd+oXSBsf6UEP7QmuvXMsZyHvtu3EHxAzud13Ce3ehzXu9hZQQ
X-Gm-Gg: ASbGncvms2hNyyCUIFVgXX+GNzy4BXS71BToeRhv0IHZ5E/0csXwLtiRyf4DVmkiFCC
	neSTZ5TSCB7izdTgoFvAa0Y1DktaLdXx4br+C4DCQiLL1u5I5swYTZ9iYw6AuJmW2lEzmAAz0mN
	CusqNPqx/b61ZPoy1qQDouU/pUH1WtcTF+dJ7H+u54fzT0HmWg2VcGIshs+ozcEG18RcbrZMfAZ
	IoQSDXmTqBNh3G791q97e8syxspPUqNME1DlJ8brAnOmOFeZYdlYp1NXyP3NMArzIE/T+tTh+rw
	RhC6ZHkXMj6m51Mxv5GpEtSUoPP09nHpwTyBDEcWuiU4+tAbm747f2kcve4Wt0DGRKQCdjmw9YD
	wyurJpbnJeg3dQli+JqISYv9UggHiKBpuLwvO1ymaQuw00PXp+CcMKasWowObIHPhAVNo2wlUmn
	5jdnozv5Q4fFbmaXrSsEvmf+HYhqtKNA==
X-Google-Smtp-Source: AGHT+IFQEabv4PNtolwpa8n5AuKpK1H58aTBlKZdu0dHQlwrZWrJMaYnh5FBOmSumqqz/nyBBS5z/A==
X-Received: by 2002:a17:90b:1c91:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-34733f3e84fmr16715848a91.34.1764152078789;
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm20905512b3a.50.2025.11.26.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 02:14:38 -0800 (PST)
Message-ID: <e40cb47c-9f92-4982-bf3f-45ec9f2a1681@gmail.com>
Date: Wed, 26 Nov 2025 18:14:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 4/6] nvmet: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org
Cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251124234806.75216-5-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_021439_862622_EAA5B2D8 
X-CRM114-Status: GOOD (  18.49  )
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


On 11/25/25 07:48, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error checking
> in nvmet_bdev_discard_range() dead code.
> 
> Kill the function nvmet_bdev_discard_range() and call
> __blkdev_issue_discard() directly from nvmet_bdev_execute_discard(),
> since no error handling is needed anymore for __blkdev_issue_discard()
> call.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 8d246b8ca604..ca7731048940 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -362,29 +362,14 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
>   	return 0;
>   }
>   
> -static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
> -		struct nvme_dsm_range *range, struct bio **bio)
> -{
> -	struct nvmet_ns *ns = req->ns;
> -	int ret;
> -
> -	ret = __blkdev_issue_discard(ns->bdev,
> -			nvmet_lba_to_sect(ns, range->slba),
> -			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
> -			GFP_KERNEL, bio);
> -	if (ret && ret != -EOPNOTSUPP) {
> -		req->error_slba = le64_to_cpu(range->slba);
> -		return errno_to_nvme_status(req, ret);
> -	}
> -	return NVME_SC_SUCCESS;
> -}
> -
>   static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   {
> +	struct nvmet_ns *ns = req->ns;
>   	struct nvme_dsm_range range;
>   	struct bio *bio = NULL;
> +	sector_t nr_sects;
>   	int i;
> -	u16 status;
> +	u16 status = NVME_SC_SUCCESS;
>   
>   	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
>   		status = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
> @@ -392,9 +377,10 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
>   		if (status)
>   			break;
>   
> -		status = nvmet_bdev_discard_range(req, &range, &bio);
> -		if (status)
> -			break;
> +		nr_sects = le32_to_cpu(range.nlb) << (ns->blksize_shift - 9);
> +		__blkdev_issue_discard(ns->bdev,
> +				nvmet_lba_to_sect(ns, range.slba), nr_sects,
> +				GFP_KERNEL, &bio);

We also need to check for memory allocation errors in
__blkdev_issue_discard(). However, this cannot be done by simply
checking if bio is NULL. Similar to the issue with xfs_discard_extents,
once __blkdev_issue_discard()->blk_alloc_discard_bio() succeeds once,
any subsequent memory allocation failures cannot be detected by checking
if bio is NULL.

Yongpeng,

>   	}
>   
>   	if (bio) {


