Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99BAC64ED6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/5drPNbPmzztpwiFKBZ2XR1wEQeUVJY96UcnR/Z70o=; b=3f9v2ra3H9xAbX8spvkTITLlW6
	JpO6Hrwk3fm2d8GH7TxBCabCM8XcgUjkPRZMl0u6mG7gAqrHLTEfJMVWTrbCgybEwTPYPjct+pjAM
	kXCwFuPvYYWnCmGG/XjfnCc0Z6MWdldS1/zmZgnimL6Yp/xqxo4px2OUxzc6Ew2ShCmJBojJm+cZi
	djSHG53WYF72jWIynn30HsyvQ5kI4kRuKl1QSADJOzD92Ff1N2CEYCNUKNIbRs3NaHI6dGYvZMDKo
	ajj1mtXgiihbo5gxCiKi0Qb7SuHtdLo5Mwz41F67BMOf1acVoIv8SXdCY1PrfHbkPVlpCUWnuh8/N
	BR6KwDWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX0WC-00DNfT-Rn; Tue, 28 Feb 2023 13:59:48 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX0W9-00DNce-EG
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 13:59:46 +0000
Received: by mail-wm1-f52.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso4955669wmq.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Feb 2023 05:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677592783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/5drPNbPmzztpwiFKBZ2XR1wEQeUVJY96UcnR/Z70o=;
        b=1K5vN+CjL3qHwMW3iNzruPExE7sP5hyzh88UEIxpXA8P+uYs7HM7O8lc4jGtmuSLQR
         PPREjScn4BZYoyEBIcoB9h7C7LI42x2H7J/NFsldCocdJA8y/3V5RKtP5Z7oSZOJcN4G
         YUhkwa3LoUl9+IfHM2qrsoPJxXF7bnNqBEYhOhLl1SRq/wFFKye2ylNZNKBbFcQnWWuJ
         qYqotGVD/fIZuCyiKOSoocbrq9z/R0G2Gj79/BI0lDvraWDIOUURMVGbNULIWiW2Khmj
         GgHLFRVv1u9vTxdIgyYU1xeFXxYtzKnpW413gUt2Z9/JVRGytNDFrkV3b/jrA3myYt4A
         JAWg==
X-Gm-Message-State: AO0yUKVMUoNZbyA1kEJ6PyhxUFLzhZBa2GYp/IDz65w19tQGj1WFeAQc
	eOfXAkttI8gz7pfP7u8IiY0=
X-Google-Smtp-Source: AK7set8eqyvjxfHRUFEVS/wnS95KT+jBjVkX23c4jbj39UksAQwCKm1lpoFr62Nk5Mj7kAJzNP4+/A==
X-Received: by 2002:a05:600c:3506:b0:3ea:c86e:4377 with SMTP id h6-20020a05600c350600b003eac86e4377mr2462172wmq.0.1677592783237;
        Tue, 28 Feb 2023 05:59:43 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c1d0800b003de2fc8214esm13643627wms.20.2023.02.28.05.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 05:59:42 -0800 (PST)
Message-ID: <d0b967b5-1972-5ded-4849-dae7b5f1f2a3@grimberg.me>
Date: Tue, 28 Feb 2023 15:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Fwd: [PATCH] nvme-pci: fixing memory leak in probe teardown path
Content-Language: en-US
To: irvin cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, axboe@fb.com, linux-nvme@lists.infradead.org
References: <Y/lmo9yfA1w0+Bp2@archlinux>
 <CALL+9ejc+wPgG6x3CZgqwwU7P-f7mT=5U6RoZGBuiumr+P59Lw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CALL+9ejc+wPgG6x3CZgqwwU7P-f7mT=5U6RoZGBuiumr+P59Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_055945_519596_6C3C0342 
X-CRM114-Status: GOOD (  15.54  )
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


> From: Irvin Cote <irvincoteg@gmail.com>
> Date: Fri, 24 Feb 2023 at 22:38
> Subject: [PATCH] nvme-pci: fixing memory leak in probe teardown path
> To: <kbusch@kernel.org>
> Cc: <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
> 
> 
> In case the nvme_probe teardown path is triggered the ctrl ref count
> does not reach 0 thus creating a memory leak upon failure of nvme_probe
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5b95c94ee40f..0b61caf6be67 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3072,6 +3072,7 @@ static int nvme_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>   out_dev_unmap:
>          nvme_dev_unmap(dev);
>   out_uninit_ctrl:
> +       nvme_put_ctrl(&dev->ctrl);
>          nvme_uninit_ctrl(&dev->ctrl);

I'd reverse the order. But looks good.

