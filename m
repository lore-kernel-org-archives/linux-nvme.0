Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B86C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 11:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2C8iITfXyqrGSSelF6ORCsVtQLkFzsmpKhnPxYjSV6k=; b=x5rMgdssWQlgTd0fUXQVjYdJLA
	rKog5EFbz7KNNRDOxQZjuDHPmyBe1TWQRIBVPca9ooxkYdu+ezEwlxYIlfGRVTzbSgbtaIpkiVbkJ
	ffU/FpWMwHvcgorLVZTFOTq2wRH8Nuk1ObRxKKoJCXqLgD0wmROc5HJ2DPAc/Hj8wOGVDVd8UQMzT
	uNL1ste5tBsNsyGSwgtVuPH4xZem6nuzjKUkXJ1M5vn/oUQnV33AchT+xBRtK1NnsvW9Gj74a0BDT
	PLhmWDuJfrhvWy2G5HUvgaoVwbyTxdUeyrvTumwFqtx2eWoRc2yZZmRrnnMy1eTnWd2LE9Evw7Diu
	ttZelo3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2sTD-000c8i-3u; Wed, 07 Dec 2022 11:20:11 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2sT9-000c1K-DS
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 11:20:09 +0000
Received: by mail-wm1-f47.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so813384wmh.0
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 03:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2C8iITfXyqrGSSelF6ORCsVtQLkFzsmpKhnPxYjSV6k=;
        b=TOVv2Td/FD0GhdI3a9Ekpj6P8DdgTWwwuGJ7kyKtvQAcHZrr9YBDU1wcOnKETiCGpU
         tssDI9Cedk1BtfGT1iF51qdwQ0aUIlB/z/s7Cw+WotXCDWCkupWwgIGlFJt25I+y2i0o
         FiXDZpii5EsIdcGoj1RgsKaXaIqhgYc1+eexax7GNJ6dYVK2bnDKIj213fAkdmEzHjFg
         K3Ks6Z99kL4l9PYPHaGh6jrDEpGAjOWIUM3xzXKt1Nkbk09ihNGKFKr/ieneQRJz1+ey
         qDsJo11PvoGsQG3DHmecBQF5N1Wd8EfJXihHgvaomz215+u1G1xMhO1lXpdRVNpOztpk
         1xpg==
X-Gm-Message-State: ANoB5pkCBBhc9KoAlcmAGTiw8GoUgBgsWBoHh8dBsAy7jAdaJ0SiJdkh
	1E4KnUNLKdCi6OoMY5sZt5k=
X-Google-Smtp-Source: AA0mqf6qn/0sToPXA92fF1/foq1DVLL+CFf4Kq1JwLTVKCD4Q4u3I5UIho4spVc/oB/Uggq59RuSGg==
X-Received: by 2002:a05:600c:6012:b0:3cf:cb16:f242 with SMTP id az18-20020a05600c601200b003cfcb16f242mr58389564wmb.82.1670412003120;
        Wed, 07 Dec 2022 03:20:03 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f4-20020a05600c44c400b003cfa80443a0sm1253051wmo.35.2022.12.07.03.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 03:20:02 -0800 (PST)
Message-ID: <40ec518c-db1b-8fa2-af66-3b2f3dcc235d@grimberg.me>
Date: Wed, 7 Dec 2022 13:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
 <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_032007_502858_540ADCE5 
X-CRM114-Status: GOOD (  13.39  )
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


> From: Amit Engel <Amit.Engel@dell.com>
> 
> This provides additional details about the rq/cmd that is timed out
> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1eed0fc26b3a..f2be7c23ace5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2277,8 +2277,9 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>   
>   	dev_warn(ctrl->device,
> -		"queue %d: timeout request %#x type %d\n",
> -		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
> +		"queue %d: timeout cid %#x opcode %#x type %d\n",

How about using show_opcode_name() instead (or in addition).

