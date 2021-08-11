Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18241C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:31:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB9160EFF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDB9160EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BFXbqdkZJBusrLJkBO63xfKuJ8wO8HJmegV14CWC2VU=; b=V0t1Hcq6Je4ynBq/mghxy2EgG7
	ISm9tD6PsMxPLdcPTlRvpTOWmp3jiCjkmWo5Must1LYwdvVFJ49CX+601l/gBYnzunMG7E42LWpBU
	ElHIBkzUSLZ5zPJn6bzWDG06JbBwygDrL9HS4LrKZJbJ3X8O5CIkZso0Dy5r9CKmcDKOvGMqEfzmT
	xR6iGLK9dhZFf8HcbijMn+9iHXf/sSdcC7N6f9wvBqsVtbmN9O8XceBgmF1IxQmQfLPlrbGbG/W5k
	0RQOTtTIcyGE23/xkeL62+1VjLdfvdrTl2jVv+67P1Hpu7Qs33XctiFd/M6ckcNrE6ze3W0CzAskn
	+23FA3/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDd5U-005Ak2-Df; Wed, 11 Aug 2021 01:31:20 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDd5Q-005AjS-Sm
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:31:19 +0000
Received: by mail-pj1-f51.google.com with SMTP id nt11so912781pjb.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AFFDmG4hzrkZsTOvKWa43vgT0SfhANn//NFQXbbogp8=;
 b=ZY7lPiipoyaXu8s3OvmakcMKp+xVupZGSvMJ4YRXTbe4erRlX/mkXBCuaM5NLtMFYk
 8Fg59og1HhhbFpBrobTnSLhdtnryPcVbAVrU1y+QVqocVxMU6sbg1HPgo+wlu77pVj1N
 Qm7StAsRkRFOwEYvWO2oh27EtANdYtFjAK5/xzueuxD0JTdUKAohcq83d33Bn7LGblEh
 yYXA8ZUl1te6JM92BivHdkz6gdOglQ1ADTj0HLJ7izNQuUiuPFUe/v1XtJyAP2cup9zp
 uXqzsr/6Am2IhpgHdc3HgIrhbAMPW1utC+IUFW7i+v5yyLZErZqiFC03qMb+Rkd13u6j
 0BRw==
X-Gm-Message-State: AOAM532GiaWqaDOTZE7KAMIM7QqNbouXKq9E1ZRRu9xAhJu1qdJ+yeB8
 oQngg7gMKvK0cIUkd/3V3a2IjcKjGAE=
X-Google-Smtp-Source: ABdhPJyXRVW0Y3KTQay8akc25u4zFNIljTD2eg3GfjhBtfWGk4dachYRbfPJzRy40yfv617vrtNF2g==
X-Received: by 2002:a17:90a:f81:: with SMTP id 1mr231963pjz.234.1628645476031; 
 Tue, 10 Aug 2021 18:31:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id c12sm24330828pfl.56.2021.08.10.18.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:31:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: don't do scan work if io queue count is zero
To: Ruozhu Li <liruozhu@huawei.com>, linux-nvme@lists.infradead.org
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-3-liruozhu@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ec3196a-debc-43fd-3025-6a969775985f@grimberg.me>
Date: Tue, 10 Aug 2021 18:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803090630.14425-3-liruozhu@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_183116_984937_D0FED3B7 
X-CRM114-Status: GOOD (  19.46  )
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


> kernel panic when try to rescan ns when io queue count is zero.Because
> kernel BUG_ON when hctx_idx is greater than ctrl->queue_count.
> --
> nvme_rdma_init_hctx+0x58/0x60 [nvme_rdma]
> blk_mq_realloc_hw_ctxs+0x140/0x4c0
> blk_mq_init_allocated_queue+0x130/0x410
> blk_mq_init_queue+0x40/0x88
> nvme_validate_ns+0xb8/0x740
> nvme_scan_work+0x29c/0x460
> process_one_work+0x1f8/0x490
> worker_thread+0x50/0x4b8
> kthread+0x134/0x138
> ret_from_fork+0x10/0x18
> --
> Defence it by not allowing rescan ns when io queue count is zero.
> 
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>   drivers/nvme/host/core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..d9f837eb3e26 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -141,7 +141,8 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   	/*
>   	 * Only new queue scan work when admin and IO queues are both alive
>   	 */
> -	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
> +	if (ctrl->state == NVME_CTRL_LIVE &&
> +	    ctrl->tagset && ctrl->queue_count > 1)
>   		queue_work(nvme_wq, &ctrl->scan_work);
>   }
>   
> @@ -4047,7 +4048,8 @@ static void nvme_scan_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, scan_work);
>   
>   	/* No tagset on a live ctrl means IO queues could not created */
> -	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
> +	if (ctrl->state != NVME_CTRL_LIVE ||
> +	    !ctrl->tagset || ctrl->queue_count < 2)
>   		return;

We can't keep growing sporadic conditionals here, its becoming a mess...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
