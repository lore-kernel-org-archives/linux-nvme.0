Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B759BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMX25NFeojUzl7wweYcmWjYVH+c9Jz/n1YntA1yElaE=; b=prT4US0xcP9gT1vM+ofCeya1Ft
	jOM8CqtxUA3fMU9QLS54tOlaUjcuCDt8EFrcDU/y3exod4bJx9cDZCXbh9onjoTey8+kPwLYdR3IV
	1nBaHV7oo3od7QI6Dvx53K8MApEymftV9lp/f+mBpP2rFch3FLW7wbix5erG2wV2rPf9Ir+rzeKZF
	d0jJxoipt42bx5e50A5HRqF1YgYQIcMq0A0wqx+UV/tQ3McHtKVwDGSIx2OXwIeJ3bGXA8IZ39F9c
	3xn10trRD2YxZvULmt7apHblMicXXOiGYh9nt+xGQcL7aIKPvtvdzsTX9rRPqBVqyIfHAw4ZaC3Rp
	SzOGLW9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfu0-009IdN-Qf; Wed, 26 Oct 2022 12:53:00 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onftX-009IQT-4q
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:52:32 +0000
Received: by mail-wr1-f53.google.com with SMTP id h9so15063787wrt.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMX25NFeojUzl7wweYcmWjYVH+c9Jz/n1YntA1yElaE=;
        b=gl2nF28w5wefx/N0LvaUqqugxUJQWjvg12+fG1g3KdivzFTf6wR0C367XJSZYy3gHr
         C63SjPJblgVkstYRO4q9dDhp/G565zCunGHSw3G6Rsh1O6O+us4SiZTK1sGxSp5VBAnk
         hXwcJiP6+ugUKF7FDbbwYQ3KcBfRTgMbZyvM2PKHD1W6WsS8mYrT+MKluZwWO4OekqYU
         CcY/OKH4Gzb6WjKRvlA9u5AJO/YFmkSwrfLN++GuFLpTuukeh+0bEeNddMGzWko245MU
         G/JXgIp6sNdsnPayQnUiv6c1hNtxqCnsSOrwQ7rbEci62W9G87OnpSG4cWfXnJUaMZUb
         Pp1A==
X-Gm-Message-State: ACrzQf2i+YDIIC4/3gtoiXIMPeE+CcU7AZl+IHvkzemnif9uRqrBcNct
	Z3hJ+jA1tV723ek825EdhBw=
X-Google-Smtp-Source: AMsMyM7YhzNq7Sr4UbWF18bzQw4syqt03+a1XNQZSWLb73Wv/6I7YX+1Rkf0AiUir8G3JFU7wJoUVg==
X-Received: by 2002:adf:f743:0:b0:236:7309:1209 with SMTP id z3-20020adff743000000b0023673091209mr9791475wrp.14.1666788747515;
        Wed, 26 Oct 2022 05:52:27 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t11-20020adfdc0b000000b002365254ea42sm5266202wri.1.2022.10.26.05.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:52:26 -0700 (PDT)
Message-ID: <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
Date: Wed, 26 Oct 2022 15:52:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/17] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055231_232017_35102FF2 
X-CRM114-Status: GOOD (  15.75  )
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


> We never rescan namespaces after marking them dead, so this check is dead
> now.

scan_work can still run, I'd keep this one.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2ec838e608509..99eabbe7fac98 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4333,10 +4333,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
> -	if (test_bit(NVME_NS_DEAD, &ns->flags))
> -		goto out;
> -
> -	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
>   		dev_err(ns->ctrl->device,
>   			"identifiers changed for nsid %d\n", ns->head->ns_id);

