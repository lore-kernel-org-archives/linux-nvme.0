Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D72C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:11:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5903A613A9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 22:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5903A613A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8ayeFLYYTKwnyIWH5BukYtp4MhZFjHnBbWwGBU6kcQs=; b=IlImOCDOPqOSyHxEZam0mskj+
	sijeLMJEx8NQsjbWQWLg6ubwLH5MDJGaBq45kJXWMDC500oPwa/mZWp6WuSg+zP+5cTx3cV3+ZKJF
	bEXbJN60xlsZQC5EIFALG4DG0Xoa0FrtESuU5cM2rJG+KYB4FSFXsGZ5mk9Ojk+GvBl6kOHh01ccG
	jgR67gKxPT9x5Rlq1b9SOgYPd16Um/952qToRvHtmQ12DwEcTol4KuV2yxcfwryyYv/lyaXP+71d4
	BworNKSvvmvnHe4iw3f7Mkcj/W1aLX2H+vuJeLoJOoJ12FdbakvcriW1xQRf29injg0Hu9CCQKDax
	o8698TC4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgx4O-00489v-Ss; Wed, 12 May 2021 22:11:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx4L-00489d-HD
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 22:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=SCqLxJf0+9Xv5oHYhvN5Usd5q1FWnTVefGLnMau8//4=; b=HoHEabbH5NXc6hv3wMLv+h5rDD
 neH7w3Yy89GjbC11qp4jjFkW51jBBU+zkIW8x9HiqvahBLZfuEChUfc3oB/fR36y1whEjlwIZkdBq
 3aKqCqspBZvlIjig49KMyYqJPTug4pquXDvjrNXOPayfaJ/pwp41EZqW/PE1Eq9983tX6q0fDCSeg
 Kbk0xCFhiapbNEG5BBUe9ZE7dzAybaCtsgDSHUaWU3X0ZlyUDdqfrdfr1PYJqA+E69sS2ZsX+b1jk
 x6OB2BWRnSjeZIgD9XIpv4IfFebu1I9wYQkZIDuN2+IrsaSvjv1oKEGNu4uPR3qoKVOeGUgyadT1m
 FkulSRSA==;
Received: from mail-qk1-f176.google.com ([209.85.222.176])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgx4I-00ArZs-UV
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 22:11:04 +0000
Received: by mail-qk1-f176.google.com with SMTP id f18so1976438qko.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 15:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SCqLxJf0+9Xv5oHYhvN5Usd5q1FWnTVefGLnMau8//4=;
 b=LbNHz45Vjw232MhydxRVhOgOQSz8TRO+XDYQdoLhvh3iGRKsI0j3m3sIRixh6Wf1Qh
 G/F58cuT5g/Mw/s0Pm3S+Uos3H6e4tt/iJ1Ev3Si7HK7oorX075aP+Fu/huqo6iAtlpo
 F8fNgvQZOD97ii30OuJVkpjGPgC6gpny3Ls/FVw835MaNnXMH19jzH4BFSFAyNmhcy+n
 OIOL+Y3DTwUiMa/uBK7+6MLscCuAnRWqm3SXXKGGwuFu4W8E87xV8IKerv+RH7U5SMlz
 ltZuFjdq4Z0JsrrNNqXdXWKcHhmpjKudrEvL1/LeQXyZv18Mn8NRp6PdhjXxxO8xxfXU
 4Fiw==
X-Gm-Message-State: AOAM531WJCUPO56A6lp+0UB+rdIF0hqmXOBS5uYeoxjpVnqGe/jM4Q+h
 dcN/GihPgJhLNe/9rFIBi7a672HlphQ=
X-Google-Smtp-Source: ABdhPJwiFho7EirWytFWbXSBRx6w3tCpQCdkAagD5zxtBueiOMsBwn4nn/jghk0vwnMtLPSYBycWKQ==
X-Received: by 2002:a37:5f41:: with SMTP id t62mr35409256qkb.458.1620857461602; 
 Wed, 12 May 2021 15:11:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id r9sm1071163qtf.62.2021.05.12.15.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 15:11:01 -0700 (PDT)
Subject: Re: [PATCH 15/15] nvme-multipath: enable polled I/O
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-16-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
Date: Wed, 12 May 2021 15:10:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-16-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_151103_013813_F8491623 
X-CRM114-Status: GOOD (  21.25  )
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


> Set the poll queue flag to enable polling, given that the multipath
> node just dispatches the bios to a lower queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/multipath.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 516fe977606d..e95b93655d06 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -446,6 +446,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   		goto out;
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>   	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> +	/*
> +	 * This assumes all controllers that refer to a namespace either
> +	 * support poll queues or not.  That is not a strict guarantee,
> +	 * but if the assumption is wrong the effect is only suboptimal
> +	 * performance but not correctness problem.
> +	 */
> +	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
> +	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
> +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);

If one controller does not support polling and the other does, won't
the block layer fail to map a queue for REQ_POLLED requests?

Maybe clear in the else case here?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
