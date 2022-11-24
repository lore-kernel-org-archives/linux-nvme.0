Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9E1C43217
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5vAXt2dZtbcLEsvG02cSS7Tx66Pf8/ErTOxGiG+mJI=; b=hDs5eLkI42uQ10AedZLuksnyXo
	zu3nKebCbvrmZZMkcptnCTLZpwpA/kEla2Zu7H9QKoLvw2ktelGEmxKLMg+ML5W+S6bCJt23uwHoo
	R2rNOkw/nFiajwDTkTjZGztL3ZeUItMXgixaiaVXf+m9u7VtCoHaXXk5DoyvplEWgU9jBgUu1BIDW
	zAsYwH4LMugDj313qdJ2KGRzBbkncoyBmO8ekTlQg4EqRNkGTA+9UkIwF7sZukbeYbgjGZTsNxoQ+
	0r9OGPaGsJEH1Zes38WjD4JkrIbsTsDEVCdhsCCZO0pAwbvdNbCKXqk2SSpZH0sUQKr2cn0heekQ4
	cdZcTm0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyD58-009Ecz-3N; Thu, 24 Nov 2022 14:20:02 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyD50-009EXh-E7
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 14:19:55 +0000
Received: by mail-wr1-f53.google.com with SMTP id s5so2706395wru.1
        for <linux-nvme@lists.infradead.org>; Thu, 24 Nov 2022 06:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5vAXt2dZtbcLEsvG02cSS7Tx66Pf8/ErTOxGiG+mJI=;
        b=RS39YePolqtmXblOv5SNxfDKYYfBjdBPtCd17hiP1tNcZEiZyUJSHX3FQN+2iMvt9u
         t3cwgO8rdMAPjhsAlnMlghi+qyJrP55X4x879HpYPfMjjmRFrQjKi+80GtbcDEMqs2mV
         pdVkNeWYMAe7TZONWCY30HmdkVrgTQ8yODTJ8UIFxr+kCFf2cOv4ySqgN1NK/5R8lz16
         zMfY0pJ0YIiQXVhrv4Fx8lBZhQhGxJ8lPlFe6LFklvQ1CxXN0YNCUsCrJIeqaVDhrmQW
         V2iIfI0Qchr2ZFgf1s049uZpNkXUVrNiCMJvMDNtoL7JVjgRq6wyhOsQMHnFNuSFAVrT
         Rx/g==
X-Gm-Message-State: ANoB5pmXllW+8NNlEAB8+ON8PUdQE9DjS1FUNl0KZWBerHVdwOrVOOdR
	pFGz5eQzwrcHB+nmfG5wSz4=
X-Google-Smtp-Source: AA0mqf7mwpRVR+N13p9u8cXB+RlL2D1XeL3KY8sgslsWiziedsWgMXH/twYRoskFxY9t6UW9NBlSuQ==
X-Received: by 2002:adf:d234:0:b0:241:fe0e:b99c with SMTP id k20-20020adfd234000000b00241fe0eb99cmr1825742wrh.456.1669299591524;
        Thu, 24 Nov 2022 06:19:51 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0560001c1100b00236695ff94fsm1605635wrb.34.2022.11.24.06.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:19:50 -0800 (PST)
Message-ID: <dcbf0d97-61b5-a524-7635-cd64cdfa0d7d@grimberg.me>
Date: Thu, 24 Nov 2022 16:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list
 (alternate)
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Uday Shankar <ushankar@purestorage.com>
References: <20221118232756.1457075-1-csander@purestorage.com>
 <20221124002432.3715594-1-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221124002432.3715594-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_061954_526023_EFD8955C 
X-CRM114-Status: GOOD (  18.86  )
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


> This is an alternate fix, protecting the nvme_ns_head siblings list
> with both RCU and SRCU.

There is no need for another srcu protection.

> Use RCU in nvme_mpath_revalidate_paths(), which doesn't sleep.
> And add synchronize_srcu() in nvme_ns_remove(),
> since nvme_ns_head_submit_bio() protects the list with SRCU.

submit_bio is already fenced in steps before so I don't see
why there is a need for srcu protection here.

> Signed-off-by: Caleb Sander <csander@purestorage.com>
> ---
>   drivers/nvme/host/core.c      | 1 +
>   drivers/nvme/host/multipath.c | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index da55ce45ac70..9b26d4781b32 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4305,6 +4305,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   
>   	/* guarantee not available in head->list */
>   	synchronize_rcu();
> +	synchronize_srcu(&ns->head->srcu);

This can be removed.

>   
>   	if (!nvme_ns_head_multipath(ns->head))
>   		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 93e2138a8b42..6d0aea477253 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -175,10 +175,12 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>   	sector_t capacity = get_capacity(head->disk);
>   	int node;
>   
> +	rcu_read_lock();
>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>   		if (capacity != get_capacity(ns->disk))
>   			clear_bit(NVME_NS_READY, &ns->flags);
>   	}
> +	rcu_read_unlock();
>   

This looks fine.

>   	for_each_node(node)
>   		rcu_assign_pointer(head->current_path[node], NULL);

