Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1910ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Sep 2022 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NiBFjO3wI2sGv0d0wAyMkjoQfB5rEgpfHupcON/Y0nk=; b=MENI41irihY/i4XJG+c6oq33xn
	hVpBLMU0G5GluHjurhO3NidWWDxdEdRY+ZXlI/mUQZsa/TIOVKxxB9uPGLKgrBmwTCRUiDu2AzzmQ
	t7P3Up/iL92eeg7LGJtt40+Hs4/k+IHiNif6AyLebBejpkuYlDB2vo2Sy1e8TSL49qWWnbXjRJjY/
	tjoaaUsKLPtRYmpP9WnPtRyTHFjHSIhWq/5BVjfRz4ZgTkDQnNrO1vHJ6hPiD+weHVzDPvI7OUbaH
	oR1gp7zyCFmlNKvnrUf7WLT0qppR1H8Sb69TwRfOnKZqDUrRciFFbkCQXb8fChcpaxxm2hQeMwRwB
	dL9etmYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZFmH-00FhT7-Sq; Fri, 16 Sep 2022 18:09:25 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZFmF-00FhRl-Bx
	for linux-nvme@lists.infradead.org; Fri, 16 Sep 2022 18:09:24 +0000
Received: by mail-qt1-x829.google.com with SMTP id ay9so5824822qtb.0
        for <linux-nvme@lists.infradead.org>; Fri, 16 Sep 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NiBFjO3wI2sGv0d0wAyMkjoQfB5rEgpfHupcON/Y0nk=;
        b=FeSzJFOHSJkg1TrXEddBw425Cg2xVtFzHsc5pHt7FVGM2blHojdVe48yB+zDtZOqTT
         fkRQwbkxfDXyPfR1Ogh+SR0ADtqgDSz5Rsl2XlpDRTkDzqYHU7+EjXfPMKWA1vv/fJMx
         uQA07VQrprowsu4hUTfYXAnsUTGnTm46bOYTMNByPQw+4GTIe2Qvn/o4cp/7vVG6mtbZ
         N2lWwkCQZu/BE+7fIAo+DVri9Lfqp0tb+4HGMuffbNXYM9+pPaimkWYgqwc7ESL1Qr4r
         OairlVKXcNfdwUFlJN66FNBmxpAl6oLvzutBsn9OM3YMCJmaV0oUftCtlWL+avxGGlgL
         W2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NiBFjO3wI2sGv0d0wAyMkjoQfB5rEgpfHupcON/Y0nk=;
        b=PAEj23y9pJnIBiGFzH8DXMND3av6D2h1rkYhgt4KyjIDSCVxgXGiPk7/dkJDKlD8bU
         hfJxHwE55zcZx8+YBOL/Hxaby2lzxQHAx2Hz9tq5JwVpiaUAbLHrRKXDh1OcChiQ5q9C
         mlAhF7iPRE+WH/qsumEd9wLdsEU0I9PuSES+E759uuv/rqFsEobzasRSZHjj9rQoC5Un
         gaUrb2su2DX56T2NXLPglQ0DYHpRwSqIzIwNZRDt1srl0xFNb1YmDBDKcoL/P2kw86GB
         biSwLiF6Kx3hGyixR7wobeW9KNUIpmjCGYLs7+49YfQvsLdzTOiqBuNiKsNih1YeBbyd
         e83g==
X-Gm-Message-State: ACrzQf3oJayBnl3CoUbodLz+WFC0oj1ISXpBVBNIeLXpaOd8ts2+YGCX
	aEcZoKrgcsOVn0SV2OGc6apb1/urk7s=
X-Google-Smtp-Source: AMsMyM4317qzrYDKcdEWrJ6+81KO+othCDfkfHgUgqrT9YKFL/sBF38PDO0H0lsmQRETEut9ikL47Q==
X-Received: by 2002:ac8:5f54:0:b0:344:a210:3f64 with SMTP id y20-20020ac85f54000000b00344a2103f64mr5565022qta.683.1663351761066;
        Fri, 16 Sep 2022 11:09:21 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f1-20020ac84981000000b0035c1e18762csm5503480qtq.84.2022.09.16.11.09.20
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 11:09:20 -0700 (PDT)
Message-ID: <805c0c9c-4ebe-3028-de0b-abfbe8081549@gmail.com>
Date: Fri, 16 Sep 2022 11:09:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet-fc: Fix potential Use-after-free bug in
 nvmet_fc_delete_target_queue()
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20220916082953.4095940-1-windhl@126.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220916082953.4095940-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220916_110923_451905_4A988339 
X-CRM114-Status: GOOD (  17.17  )
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

On 9/16/2022 1:29 AM, Liang He wrote:
> In nvmet_fc_delete_target_queue(), the nvmet_fc_tgt_q_put() may free
> queue if its refcount hits 0. And the following code will dereference
> it to get qclock by 'queue->qlock', so there is a potential UAF bug.
> 
> Fixes: 619c62dcc62b ("nvmet-fc: correct ref counting error when deferred rcv used")
> Signed-off-by: Liang He <windhl@126.com>
> ---
>   drivers/nvme/target/fc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index ab2627e17bb9..32e1d62017d2 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -881,6 +881,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
>   	struct nvmet_fc_tgtport *tgtport = queue->assoc->tgtport;
>   	struct nvmet_fc_fcp_iod *fod = queue->fod;
>   	struct nvmet_fc_defer_fcp_req *deferfcp, *tempptr;
> +	spinlock_t *q_lock = &queue->qlock;
>   	unsigned long flags;
>   	int i;
>   	bool disconnect;
> @@ -942,7 +943,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
>   
>   		kfree(deferfcp);
>   
> -		spin_lock_irqsave(&queue->qlock, flags);
> +		spin_lock_irqsave(q_lock, flags);
>   	}
>   	spin_unlock_irqrestore(&queue->qlock, flags);
>   

several things about this are fishy...

on the surface - why was the following spin_unlock_irqrestore() not 
changed for q_lock as well ?

This sounds like its correcting a symptom not necessarily the problem.
The put that you are correcting after should not have freed it, the put 
at the bottom of the routine should have. So it's pointing at an 
imbalanced reference counting.

Need to take a look at commit 619c62dcc62b9, which added the put that is 
freeing. To see if it wasn't done right.

-- james


