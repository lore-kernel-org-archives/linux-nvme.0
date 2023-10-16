Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC8CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N7lBTXc46FtHTuy4Yr+62tml5XduilKU2wh0XEaO2pM=; b=Cm1WKxAfRNYpdjyEc3ldNaNKPk
	cT0yRnJEfY8Nk655Dc6gcoLsPO2YkeDmQfKo5U2qj8eBbAXMtC5s1rXHbdoyrLYqTR0BpNTylwJjP
	rmI+hn9wIQ7Xew/+zYd1VL7A12PivsSeRUzMi7RSWiXn3FyoRFIQqNAJZVYmt6yvE7JnWgM0hSkdo
	csUtTdDUUjtgs+C2EXYTAFqwS/tcqdZP12rLq4JrmaebLO5rKgtsQAVeZ1fwhzXSHUe2ek2j+xzut
	GPwT17nJ5XdxsA/YWvXjGsdZJXerPnqfVXoQ94h8akNGJAuxFAflzfY1mvVMLfqfS2jKXqaZ4qT2M
	u278RTTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsU9P-00AUgX-1T;
	Mon, 16 Oct 2023 20:25:19 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsU9L-00AUfy-2n
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 20:25:18 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca3c63d7f0so1089505ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697487913; x=1698092713; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7lBTXc46FtHTuy4Yr+62tml5XduilKU2wh0XEaO2pM=;
        b=f6qeDZRMymJ2Qnd3wN7O2N0ZA8Pg/XaecaAQ++YFwewq9jxHR7ewgMosrJ2oTbra2h
         FtJbNLe0LGlD7kOAdNmpeaBzPO9HnVg168G7BOHRyHv1xqxyDBRNufFaIXvBqmfPhNO+
         8rL9MyTWBYuKzJAuyTNYq49QTQ9RBj8D2VOK7DJBJFhpvUeRNyGdIA4ikzNTL5qCmmOZ
         PI9DljdWqHQsWqSfv/+JVoU66bTrRoVVRtFq2I7trV3F4Kfl5yfPiDMuziYPzdcvWxDY
         xoNM4iXrAnVhdnWh6ZrcAORXW0RI/rfiH1c+W0t5gwsa7LHlpqnYmXIzfg2n2Uf711nY
         9Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487913; x=1698092713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7lBTXc46FtHTuy4Yr+62tml5XduilKU2wh0XEaO2pM=;
        b=J+/CJwbR5wQKDfib/6uPANGCYa7KZOVA1X9uxxk4vqeihWVUzswwfVlgHfmlaSxE50
         5ISaYVGAOBLoy7+2hOT7MPDHOBAHG4jyza8xYo5x/78Pi74mD8/QSfnpshDRyoT7uO81
         5vyS2YlPsvslBmrcHPFQXsbzUetzy4pbQuzw6pN7iAm1PXUiFFbGXfSKS0G3pJe/Yd37
         /IRrwPokIVlEKFfKwkY4AP56sYlNwMrqE7FUKL6f+sKnNhhWI4FqqQwRTGg8jE+Z3bsI
         VUPhZj8eiLJmUmQzGBZ6GtkIT+hbNMjGrGMsvykimNUqf1p+/koLUAQEHHh31KFOTMqA
         1bOg==
X-Gm-Message-State: AOJu0YwmcLVpEOzDypyp08VI7debwWPBhume8MaS+lq6H98lpLY/a/1r
	/ITodkezbAL5vEf+K/RWngFucA==
X-Google-Smtp-Source: AGHT+IF6e36RXk3pXEtpSG7Lz/zh4viPYudCXjOFRYc6n9ch7y1A7dp0LgNKuRMPNh2TbN/bCD7opA==
X-Received: by 2002:a17:903:5ce:b0:1ca:858d:5bef with SMTP id kf14-20020a17090305ce00b001ca858d5befmr348610plb.4.1697487912971;
        Mon, 16 Oct 2023 13:25:12 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001c5fed0b35esm26734plg.300.2023.10.16.13.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 13:25:12 -0700 (PDT)
Message-ID: <90fd6d9e-5bcf-40d8-b85b-9d33c91406b6@kernel.dk>
Date: Mon, 16 Oct 2023 14:25:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: sanitize metadata bounce buffer for reads
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, hch@lst.de, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20231016202124.2957213-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231016202124.2957213-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_132516_128527_A7347652 
X-CRM114-Status: GOOD (  15.35  )
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

On 10/16/23 2:21 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User can request more metadata bytes than the device will write. Ensure
> kernel buffer is initialized so we're not leaking unsanitized memory on
> the copy-out.
> 
> Fixes: 0b7f1f26f95a51a ("nvme: use the block layer for userspace passthrough metadata")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 788b36e7915ab..154eb7c944e76 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -39,6 +39,8 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
>  	ret = -EFAULT;
>  	if ((req_op(req) == REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, len))
>  		goto out_free_meta;
> +	else
> +		memset(buf, 0, len);

Do you need this else?

-- 
Jens Axboe



