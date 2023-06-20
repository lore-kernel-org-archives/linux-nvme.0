Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E290EEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysvppiRvqWNOYMjvznNUXCKfuXSqBXF28xSVy3bwGm4=; b=H0IEVbDHlUO4X/EDVtgvBzYyiT
	ihgoJTJuh5doZBVbDnvNGjrckGYrBbz/ho8b3wHt+jy8SIaXAjSn/YxiHLSnzpPTL7fi9+V7/fi63
	Cz1WONaGUxIgBmllmg+vfqDvvN3GrcXvKYftlxxVf2oANiQL+O2zJCx27BqKXTXdwkNdlDySs+eVJ
	g2XXCX6W1uYbwAQuG3IrNbjeTJeBNfXUSvqLMTenCFFBDGIo0YLOClJaw+bpygw6hrQnY7XAMlClN
	CkmxvPOeSSuvUDT/9KOtFwY0hurf9BHSXvjDoPmh7xViAVV7TUaC+qBD4WzQS+/WP4DQ5zDH0iTyR
	y521RsOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYA3-00AnTW-03;
	Tue, 20 Jun 2023 10:00:31 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYA0-00AnSR-1L
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 10:00:29 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31114d47414so966542f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255225; x=1689847225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysvppiRvqWNOYMjvznNUXCKfuXSqBXF28xSVy3bwGm4=;
        b=BA9Kq1YvNFGpd1VdiqQcpF0ql3BLAAvJ+twFpnvBQsBG4IIhJt3okdLCBAkh3/T4iR
         y0efKV3IljdYZdohXkXiUdZ5h3vgRymxsFCyA4Ep+acJgnJFOPZVApn+keTeIL88cc1i
         rU2RJSwGr5NHbnRx3YGsApJGSzCN7MYfNA/0aezf4HI847oedWEw1+V6rokDJZ9kiZIU
         K+SMCmYhugkn0tuOyMVcTPHYi1lPQ9zt5xWjZzQ9CpHuQebYIzWnTBT3vX1IVOfaIHTk
         Nqw56DO3AWmv++0RCs/XsP7gEKtXvF2UgUTaU3ECTzY4qlSoGl07eUew98MA5t54MJ+z
         YZcg==
X-Gm-Message-State: AC+VfDyp09czJg2fp68W+EfMGrQtNN2h7wKveH2UJrDj8y2zirXl7D9H
	xWTQRpBBjgHaB/bE9bmek5g=
X-Google-Smtp-Source: ACHHUZ4aGT47GcG48Si7/fcWLrwhUTxqsZh0d+IdbR4FmKGMJ5pFHQ8AM00NgxAA6m+Gq5ehzyMD7Q==
X-Received: by 2002:a5d:6846:0:b0:2d2:9c19:f75 with SMTP id o6-20020a5d6846000000b002d29c190f75mr10641393wrw.1.1687255224849;
        Tue, 20 Jun 2023 03:00:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d58ec000000b00309382eb047sm1580146wrd.112.2023.06.20.03.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:00:24 -0700 (PDT)
Message-ID: <a2cb007e-8cf8-edd7-5654-1cd1c9968f78@grimberg.me>
Date: Tue, 20 Jun 2023 13:00:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] nvme-mpath: fix I/O failure with EAGAIN when failing over
 I/O
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20230619141036.1051673-1-sagi@grimberg.me>
 <20230620042830.GA10371@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620042830.GA10371@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_030028_460232_2F286019 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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


>> +++ b/drivers/nvme/host/multipath.c
>> @@ -102,6 +102,7 @@ void nvme_failover_req(struct request *req)
>>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>>   	for (bio = req->bio; bio; bio = bio->bi_next) {
>>   		bio_set_dev(bio, ns->head->disk->part0);
>> +		bio->bi_opf &= ~REQ_NOWAIT;
> 
> Please add a comment based on your explanation in the commit log here.

Will do.

