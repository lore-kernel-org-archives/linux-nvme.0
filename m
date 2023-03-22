Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CDBC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3meQ+lrxC9BJ/OyjEYX7qFm/v31sIlnbNsnwnVx1a84=; b=Hy5TxUS46fjPkZuoU+kMxj3jxZ
	QrJb26bcOASYyqO2bgiQQlaU8FiWNHNXeh/Z2a2nfBhsD3UxSIaSP8C6nwEMIvYqMb0KA6/e5pNKN
	khIcJMQeXKxF+Kc27Uo/hsAukqJwixf7aD0/GfhkOHNzXNtBrCj+uByCyQavdDXlzv3pJ2tQd9oU3
	aiplxq4st/myr6HdO3Xa32bypsthK1oUVqXteVKO+HkZw14n+fmUT6FDvkqA6fYkaF7s3Lssl335n
	7wypbVpcZs1qKoZ84gtVo1JtlsVrqK+j+W1y6wqiRx9ktny6sak1kkrb7MIRuQdLvDBATgMeiUAGt
	ErcIKJ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peseg-00EydC-37;
	Wed, 22 Mar 2023 07:13:07 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pesed-00EycN-2k
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 07:13:05 +0000
Received: by mail-wm1-f43.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso1231734wmo.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 00:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3meQ+lrxC9BJ/OyjEYX7qFm/v31sIlnbNsnwnVx1a84=;
        b=yTPriyH4bNC0CmcGlpzRatwkoZcwsT3XY7/Mk92SQWKHyj8QtwYqZZ9rq4FCKoSfFw
         UoawPINvlvQ7tD6/r7BlRLZctBrz8HROya32E+fEYOnw/y+jfJljwLoL47Se9Pry5FEi
         zIkHVkWeedVNe1fwlwX27z2STnEChQEodVcLCIqYTYBAXFfMAIkM4kTTRi/ImtxSV2Sr
         iRyw0GgSBbDqdGCE+NrXqVz6J6wVTAri4E2iWhgOzony2pxKJVa14YcUh6wh9ydLBmV2
         bY9ZxdUsf/ueQX0d+9Kwt/JFEM91QApUAvSXHCJ9KkusXrB7z/jRqnU3OqFxJQTYNKFF
         thCA==
X-Gm-Message-State: AO0yUKVbXLltu34c+7HBVECJfPJlMawWaRbtr6hQgcAhYUUUGPY9u4MX
	N/kUDn1e/y2aDEeEfi1n7Q4=
X-Google-Smtp-Source: AK7set9cDlvq8gS8x3qWLT4tX4KvuZXEOAuIJzan4Rm69EhGvXDdVjbbjK781mUPqv3HFth9V8c9ig==
X-Received: by 2002:a05:600c:4515:b0:3ed:793d:9dd6 with SMTP id t21-20020a05600c451500b003ed793d9dd6mr4933279wmo.1.1679469180892;
        Wed, 22 Mar 2023 00:13:00 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003edddce5b00sm10029004wmn.12.2023.03.22.00.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:13:00 -0700 (PDT)
Message-ID: <2c014465-3a4e-e527-eeaf-0f7d4161a53a@grimberg.me>
Date: Wed, 22 Mar 2023 09:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <038ea0b7-9cf4-4b19-0fd3-bf3cd69342ca@grimberg.me>
 <ZBnape+BlqgWZLFo@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZBnape+BlqgWZLFo@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_001303_895762_B71E1EE3 
X-CRM114-Status: GOOD (  15.81  )
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


>> I just attempted with the below patch and it seems to work.
>> The only change I did was to pass to blk_poll the cookie as well,
>> from bio_poll that is bi_cookie, and from blk_rq_poll it is computed
>> from the hctx directly.
> 
> I think we can can really simplify this path a lot knowing that we are dealing
> with a live request from a polling queue. Then we can poll for requests without
> bios too.
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d60ef2f0fa50b..b64c7d491306b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1323,8 +1323,6 @@ bool blk_rq_is_poll(struct request *rq)
>   		return false;
>   	if (rq->mq_hctx->type != HCTX_TYPE_POLL)
>   		return false;
> -	if (WARN_ON_ONCE(!rq->bio))
> -		return false;
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(blk_rq_is_poll);
> @@ -1332,7 +1330,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
>   static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
>   {
>   	do {
> -		bio_poll(rq->bio, NULL, 0);
> +		blk_mq_poll(rq->q, blk_rq_to_qc(rq), NULL, 0);
>   		cond_resched();
>   	} while (!completion_done(wait));
>   }
> --

Much simpler! Like

