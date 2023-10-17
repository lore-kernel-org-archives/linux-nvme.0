Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F98DCDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 01:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTDPTjfgxnr5SDeiJxhCoSS96LC0ZBfWET+x1ujw6W0=; b=4DOzQl8pu0T0YejqPX6kgpLEJj
	l1JfBCfC3MW6CG64w64UeZTMiFFKrRbkwlm4/T7YoeAfEJew9Lt+IxNMA9IP5J6sRhB4IyJpGbwcI
	pWmMADdj8EvrC689vXsZZfXQ1/CxDqOIkMzclJEk/tYTVc3ync1sXlA0Oj+GkUQbFVCliCjMz7Rey
	kp9A0mlzNeA7A0d9j+q6dW+w/9Bvv31/L9K/JFjQkAx8nKCkBTiB4nf0JMuXzGm5qvqKjXhbwFnfz
	VUuXcuEGejmrvJLnKlkqMnWfnTQksKU0t0BvWJJsA/kU4hVVozT3xbLDe783gpiVkyZYCiWKZH945
	MiCjZi6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsYfm-00AyYs-0A;
	Tue, 17 Oct 2023 01:15:02 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsYfi-00AyYE-2q
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 01:15:01 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ca79b731f1so3276505ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697505297; x=1698110097; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTDPTjfgxnr5SDeiJxhCoSS96LC0ZBfWET+x1ujw6W0=;
        b=SKMPuAqBQoOvYtcgvBgLUmF+sh2gFxi2Vt0gzlrGIRQHAO72fczEwvGEfhUgyaEq9u
         vkICwAWbzT/HCp/VsLtx7vsqnkbA7UJjkoi07TxfRuT9Ul7ILZgqXBHIMwgb9ms05RNi
         fou0jh9PomUJgPD4OZ2wwovQS7HBdqkCQcVuteEp0N1s+ijpt6Ov4LWZU0kWTHNU2HVE
         2RaX9I8O8jMRclDVsQiD/SyckcXSdmvecR6MDaMPUss3GODtdHGgBMfTe9ijqYqt9RKA
         y0Mk1t7jingCVn0Du8zh2YPM7yTqIEGw8rKBMFgs7ySRe4siS2QLDukc2HE86jz0okw9
         lUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697505297; x=1698110097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTDPTjfgxnr5SDeiJxhCoSS96LC0ZBfWET+x1ujw6W0=;
        b=IcSKpWGExH9YLL6pKHWFWUHiUgC2+luGKCHJDywHGF4+H4XJT7EDF9ZQRElfNVVMSw
         rjh8ILaQeYgDAWHPPG9YY4f2oTRwoA4Nq8w8LJe8oStYauFCqlv7sSJg8RD3RPYSjcxX
         nVE8OGvTBCi/7MKn04EdgYb/MoiubkzBeF04xfZSoU1mT/KQFLxHQxanBhcPMoUDBrHQ
         Q0Xq6X903U+h7ywSj8vswg8aNoGOt4/Hq9eHsqpja0HoDp7AleYhnQvVCZli2sIGsfoR
         HIE9RHLtQq3JwkB7DA7G3+3y1PCiMK/7azJfokC8nE1tfs1UwKPH5cZIQmXRuxj2vwLe
         GgpA==
X-Gm-Message-State: AOJu0YwDocvo/GFgAmHGjE4qa6wKepJuP7fdXLEltpIDgogT1oA7BRgc
	e6gxMycFaeIEBz9EGFy20fK3papI1h10e3dhQpAZpw==
X-Google-Smtp-Source: AGHT+IHyzwzrgQNiCmNuxI+TOyJxKiJxijjlN+8SRr/hIUorRydTPKrtvKEhLYH1dBJ8GSCHKIxEmg==
X-Received: by 2002:a17:903:30c4:b0:1c3:a4f2:7c99 with SMTP id s4-20020a17090330c400b001c3a4f27c99mr883256plc.4.1697505297255;
        Mon, 16 Oct 2023 18:14:57 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902d38900b001c5fa48b9a0sm231465pld.33.2023.10.16.18.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 18:14:56 -0700 (PDT)
Message-ID: <bee7f34a-cfe0-4e4e-baf9-846c211fc398@kernel.dk>
Date: Mon, 16 Oct 2023 19:14:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20231016230625.3792823-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016230625.3792823-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_181458_920911_B7BFEC67 
X-CRM114-Status: GOOD (  17.31  )
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

On 10/16/23 5:06 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User can request more metadata bytes than the device will write. Ensure
> kernel buffer is initialized so we are not leaking unsanitized memory on
> the completion's copy-out.
> 
> Fixes: 0b7f1f26f95a51a ("nvme: use the block layer for userspace passthrough metadata")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>   correctly split data direction handling (axboe)
> 
>  drivers/nvme/host/ioctl.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 788b36e7915ab..eb2ef3e149614 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -36,9 +36,13 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
>  	if (!buf)
>  		goto out;
>  
> -	ret = -EFAULT;
> -	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
> -		goto out_free_meta;
> +	if (req_op(req) == REQ_OP_DRV_OUT) {
> +		ret = -EFAULT;
> +		if (copy_from_user(buf, ubuf, len))
> +			goto out_free_meta;
> +	} else {
> +		memset(buf, 0, len);
> +	}
>  
>  	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
>  	if (IS_ERR(bip)) {

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



