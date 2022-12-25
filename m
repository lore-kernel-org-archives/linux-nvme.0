Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4957C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I/nFhe7CJs+xLmc7YJtLcGvX5F5+2Z+/y0vIV3kRE3c=; b=A1NckICZHZxuHq8LMKr2L4ba85
	AUeOnCgOxv56tOZRb0VhKBW5LAWwVEojA1AWzwaV4AmC6dSVtCjTjA2b5PMEKMc3K/tA7YdZZTFhT
	9l9Wh3/9gUNDrmIDn/PZONXl6X31ln261XPSTJpzBqEe6nx3zKlBCwh1jMqUW8OVsrC66YAi6BkLL
	Vk5MLg/9YMCdBQjz7BrfgAkp9C81M4/phZeuxrAitgvdqXvxblEsEuwUsvFnEX1nFaK2v081WSjW/
	gfIoHsa5HipD3M6JqKusE5hHnKrn2wBCpN2FPuWW4WiOZoKC9lQ23sANf6+ZEmfdkuW5ghcB8fM28
	foD4EZNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9P9y-00ATSe-6I; Sun, 25 Dec 2022 11:27:18 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9ObT-00ACQ6-5Y
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:52:14 +0000
Received: by mail-wm1-f54.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso2729676wms.5
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/nFhe7CJs+xLmc7YJtLcGvX5F5+2Z+/y0vIV3kRE3c=;
        b=oNEumzKE2fTtwfIOH/mKiRNvD1H9pzbwbh6VCgILGlmM9OHWwZocQU/cTq8ZdydVLM
         2BlXQZg+n3iRHX5aGq5Na5N00OCA6KE9o0mOD/jWULcO6HqcYvVRIjQZ26V74wrPBHn4
         RPJi9WKjg9AKVdTcIUlURolHPb5vRw3wF1IPPZ0MABnGpDvRn1gshvG6eRCUZ5szOILp
         oKlbwlUanUbRl+SC+26J8YaBxUd3kbRzAHb2w6ttwrXOfGU5j+ofGE4wOKYOPrMG7f3l
         ecAKGJnGpQh0XN9vjwRN+FAdzJtoFps+gm3UfNGrjujLjVLzNCoHj/7zCKKghlofe9Cl
         Ov/w==
X-Gm-Message-State: AFqh2koX4pdVdKIqzfaBqI5lDSOZOYpeEZUpSzdU32FAkr0+7iaRgZBB
	Rd9++ofiQAenK/0+rf8OmLc=
X-Google-Smtp-Source: AMrXdXtqICmghPTe8fCcoLGOH7Ljg/cvl6/R5NIzeeoizbUqMkcBAfgq1m3pYBSP2Nc7cdRJCI16Ug==
X-Received: by 2002:a05:600c:1c81:b0:3d1:e907:17cb with SMTP id k1-20020a05600c1c8100b003d1e90717cbmr11188922wms.1.1671965496691;
        Sun, 25 Dec 2022 02:51:36 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003cfaae07f68sm16223060wmq.17.2022.12.25.02.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:51:36 -0800 (PST)
Message-ID: <a7a593fa-9a48-6f6b-a428-2fe6db694d22@grimberg.me>
Date: Sun, 25 Dec 2022 12:51:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] nvme: fix setting the queue depth in
 nvme_alloc_io_tag_set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221225103234.226794-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_025139_292234_DC1F4C07 
X-CRM114-Status: GOOD (  21.43  )
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


> While the CAP.MQES field in NVMe is a 0s based filed with a natural one
> off, we also need to account for the queue wrap condition and fix undo
> the one off again in nvme_alloc_io_tag_set.  This was never properly
> done by the fabrics drivers, but they don't seem to care because there
> is no actual physical queue that can wrap around, but it became a
> problem when converting over the PCIe driver.  Also add back the
> BLK_MQ_MAX_DEPTH check that was lost in the same commit.
> 
> Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")

This looks fine, but does this actually fix anything?
How does nvme-pci ever set sqsize anywhere close to BLK_MQ_MAX_DEPTH ?
NVME_PCI_MAX_QUEUE_SIZE is 4095...

> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e26b085a007aea..cda1361e6d4fbb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4897,7 +4897,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   
>   	memset(set, 0, sizeof(*set));
>   	set->ops = ops;
> -	set->queue_depth = ctrl->sqsize + 1;
> +	set->queue_depth = min_t(unsigned, ctrl->sqsize, BLK_MQ_MAX_DEPTH - 1);
>   	/*
>   	 * Some Apple controllers requires tags to be unique across admin and
>   	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.

