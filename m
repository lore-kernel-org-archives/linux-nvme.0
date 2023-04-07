Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F6BC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Datt06y6QOn3vVdQaOHrLIlblRQOgkrxQaZSIY+FYG0=; b=U+fDazto7uwytXtDeuGQhFlmtd
	4h7lOT0uksUz+s7krfl89DNskvWeGrqXAZJzOAXqx4BT57lFrATw3kgag/ZjNoFRlNqSyB8sSPP0u
	4KCeDWuR0qYmX6X3LCGBt8SBBHhHpmIInyJzErM82aZmp2NMp9DM+KV8b9SIwCn5O0q6HFdp1Lb2S
	iPaXP5z3fFurwU3lOHK/HnxYj+mM1Ra9Yq3kI24TmSWdYqChEZFxlJcPIwBL6aG6iwKt/IBgriuEu
	0+8ZbqLdJAPPM/VYDQNC6hmuj9QHmWH4/lI+CY+KlIgOuQO6wXdTEvLv/tW5jg7zSVhWPJ5fw0h4I
	MmDIW/MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pktj4-00BB99-0s;
	Fri, 07 Apr 2023 21:34:30 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pktj0-00BB8X-2Q
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 21:34:27 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f080f53fc6so2805e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 14:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680903264; x=1683495264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Datt06y6QOn3vVdQaOHrLIlblRQOgkrxQaZSIY+FYG0=;
        b=Y0HQWyC/CWJ1mTaqv/3onfxkHE2uXaj9812QdbXSy+YDyc71GgUkc0syaFyt/AtAS5
         Ckj5d17JDYBwSsciCE6Cq+EflOVj0OuwxQNzzlQxETHcdpwCHPv8Ezn1FcxhANYoNF0y
         qcdYnA1LibyeZ3ctY4U8R4MjNnGCb3YfS1S9NnCDR9qc7RModS3nc23JHypp8uXxB3Zb
         5uzI2ZhtBB0+6YxbFPIF7+2WSqkbbrLhNcyVbeHMvmfctppmruMErI94EeIwIArfeqkc
         VPOhX+y+Yx60DDRJHApmLdQXF5i5CDpfw8fJkvAcH4eG8xIh2GRw2A8mG1hY9mFYy37H
         Kw6g==
X-Gm-Message-State: AAQBX9fQZFgTyuIm8MFBKxharJ7dWaL6wC27yc2jW+AK5Xqtfobm7feS
	DaM94O/r7JTDVdJq4An/WP/9HEL0ZN0=
X-Google-Smtp-Source: AKy350baUMxCZkE2nsZcNtWR9Nkg/ifoAdbJKZh8R8Xpz+6OML1wgprg9hWp45VmnR6Dx/XJWz8FAg==
X-Received: by 2002:a05:600c:1ca4:b0:3ed:d2ae:9adb with SMTP id k36-20020a05600c1ca400b003edd2ae9adbmr562659wms.0.1680903263903;
        Fri, 07 Apr 2023 14:34:23 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003ee2a0d49dbsm9694305wmo.25.2023.04.07.14.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:34:23 -0700 (PDT)
Message-ID: <ab82c5fd-03d6-683d-2c8a-1b71b940d94a@grimberg.me>
Date: Sat, 8 Apr 2023 00:34:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Lei Lei2 Yin <yinlei2@lenovo.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_143426_806441_1FB5735A 
X-CRM114-Status: GOOD (  10.31  )
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


>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 53ef028596c6..c1cc384f4f3e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>>   	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>>   				"Cancelling I/O %d", req->tag);
>>   
>> -	/* don't abort one completed request */
>> -	if (blk_mq_request_completed(req))
>> +	/* don't abort one completed or idle request */
>> +	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
>>   		return true;
> 
> I was suspicious about this path too, and had the same change long ago, but
> shelved it when I couldn't produce any errors there. But the change makes sense
> to me!
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

We need to change nvmf_complete_timed_out_request() too.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

