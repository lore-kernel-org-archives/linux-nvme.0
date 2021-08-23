Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6D0C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75F5613BD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B75F5613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6y+PMrum/y4vlLvQppmClGApJDBle962xf5cxa+UCA=; b=j2uiQeZQtwCh3egvDczwrxGL1Q
	eyafVT6CNwU7ZrmQmuuo/k14rNXFF04TX+VsIBPH9p7nSdprOQ52oSUfAWI6q5X+8ZWOGVArZFAGW
	xhe7e7wTXxs7afsxGMEbS9q3buiNx7My40LdgT6nlbr28ktx8DKg6qcy0rAob1FPIlo7WvuAYUmnU
	VPurXlgFanNpe9skDecH10iHqsv13C8Olwkn2Fy4aotSYwFE55ufWqGsCywJXZX7x9NEkifM6apD4
	0FWNhszQ2mvfqG8jCN9HG9axYitmstlI71NdEH5jt7zwjFQPPjcdl2CtZ9gxffr4ZwOmnPeYF7fTg
	CLEs5Bug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIDWf-0006Wv-Gz; Mon, 23 Aug 2021 17:14:21 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIDWd-0006W0-Gl
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 17:14:20 +0000
Received: by mail-ej1-f49.google.com with SMTP id h9so38512497ejs.4
 for <linux-nvme@lists.infradead.org>; Mon, 23 Aug 2021 10:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=swbyVwi+m7CtLBJ7tLDUItGZWE50v4oeBRYhGfvLPb8=;
 b=A6GfmVnr4Nf73PBGwdrsRSXXrVMFFLDxU6NaMbgmj7KVwxUwW+ePOJIkfGK4rnx0yf
 CYpYUdQBHwfv29Zm6ZauKtz7+fEnozYvAXUqk9doRyvWK8G4KoOgIRaxDFr0rWpM8PCT
 PjAAe2UZn4Bri5EBroYWA1ygTxnkJ53qA0E/z1A7otf5n2aZggBVCIf6KwWgxlMQz4jN
 RVQio8K93SKBQLNRHsIzzjODZZT7xArggA8GKV5BuaOL9w9IaZau0HyuLHCT4puYcb8V
 pg3NJe5SdehbogCKXERoxpJJfPWmEt0HlQv4jllQa4uxBYUU3GTgciZCiexalp8KSmMm
 8/dg==
X-Gm-Message-State: AOAM531TXduQbmHA38TzEryGYa0r1H5TBnb6BsBDcg4K1sm1S+d353LN
 zb+zasxooK25L7ygw2Eu7+GJdZoXJAU=
X-Google-Smtp-Source: ABdhPJx48DtIk8TgVgoRUZCe6+CoJuj6Ey2lMvLrBfRe7SywxuHqyx1nLDFydn9KS5g2/mh9WrhIng==
X-Received: by 2002:a17:906:c055:: with SMTP id
 bm21mr37462898ejb.350.1629738857577; 
 Mon, 23 Aug 2021 10:14:17 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id q5sm9794647edt.50.2021.08.23.10.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 10:14:17 -0700 (PDT)
Subject: Re: [PATCH] nvme-multipath: set QUEUE_FLAG_NOWAIT
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20210823080207.711362-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1b92a225-f298-2687-ec9a-00cc70ad1152@grimberg.me>
Date: Mon, 23 Aug 2021 10:14:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823080207.711362-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_101419_591201_DFDEA487 
X-CRM114-Status: GOOD (  18.05  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The nvme multipathing code just dispatches bios to one of the blk-mq
> based paths and never blocks on its own, so set QUEUE_FLAG_NOWAIT
> to support REQ_NOWAIT bios.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/multipath.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d390f14b8bb6..c77dfe28df67 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -480,6 +480,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   			ctrl->subsys->instance, head->instance);
>   
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, head->disk->queue);
> +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, head->disk->queue);
> +
>   	/* set to a default value of 512 until the disk is validated */
>   	blk_queue_logical_block_size(head->disk->queue, 512);
>   	blk_set_stacking_limits(&head->disk->queue->limits);
> 

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
