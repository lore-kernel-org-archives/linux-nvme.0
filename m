Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D869C4346E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:50:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962A62054F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 08:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q6n7jrPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962A62054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MKyag33sJ9+UvZRR6k0jn4qYJX40kHjSnkMuq462yWE=; b=Q6n7jrPP5rE8OctChZhZmsKJW
	EiT/efgVbirx8zpZGROpA2gRg20ZEIAB7zaG/WfFf4zoclfQitXAyrCDIipoTFq5RRQI1Wb49IF6P
	7JUEMvBhMj8NYMbwBvtoNJQaG+tzQE0KpM6jRN63Fum+f7NbHQDRLvFW3QifK/izB+RzrblXFWxcy
	Nn8kLSs8zInvBWvSzgjyvotHgdh2lymzlf8xTv8MOF57yqrJPtCXvcYRo9OBsBtuiaSY4svuYBuJ5
	Bo8nxEj/PCuBZUyNBdQf99y8nKNYb2mjZ8vKuBHhVj2U/BHJ+Kkeh9O3ixPTZy7NrVw6mk90GbY5k
	F0nKY+lTA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNBLH-0002K4-3z; Tue, 29 Sep 2020 08:50:35 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNBLD-0002JO-GY
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 08:50:32 +0000
Received: by mail-pj1-f68.google.com with SMTP id t7so2289641pjd.3
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 01:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hg0olcKZTdeSxixbJRNcnZ0qwrPHZ004cmSy4cqg2iM=;
 b=BOKQvQ+b81FQ6e6iIzDx187c5v0juz3Kq+IkCkfWU/VqN+WtO/yf3cjWBuGvFdSYON
 emjhKketfg/85JqW4S833L8VWssk0jd9KtkTO2CVY5jlH9S/CzzNQaDokpzeNRrKr4XZ
 9y6wgHiBQnfVYm/fhwSbQjooz5x/4S7xn3rrnRlXxtK//LnS8OtoQliwLJHxlRYNzWmJ
 hrxrArJZskUxCwZGpXqZds/TMtlbdiIouVrklwSpkTj+niIDNRl3HRCmpBYUqS9yd9XS
 +r34yzmjQR36ywae89a4egTwmz0Pt6h8JDQyC0scHUUE7qmrtFtdfAxBQMm46+RBxKIP
 x98w==
X-Gm-Message-State: AOAM533U4+KE0COzSJbf+pdoE1Gn6qq689kka+L74U1b1LBkkpidrL3+
 EiueGefnKVSZt7cQRiGwC+c=
X-Google-Smtp-Source: ABdhPJznpcdlIlz2icydeI3BcKlppwWmnVbOPD7OTLsaz+Xk+7JA52dNWcGYchRbAHwWiLt/QM5lZA==
X-Received: by 2002:a17:90b:1988:: with SMTP id
 mv8mr3050300pjb.23.1601369429972; 
 Tue, 29 Sep 2020 01:50:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id n7sm4263404pfq.114.2020.09.29.01.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 01:50:29 -0700 (PDT)
Subject: Re: [PATCH 11/20] nvme: clean up the check for too large logic block
 sizes
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27bc18e4-d547-6995-d65c-1c45f84919a2@grimberg.me>
Date: Tue, 29 Sep 2020 01:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928123502.435373-12-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_045031_560733_BD5F1EC7 
X-CRM114-Status: GOOD (  22.14  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Use a single statement to set both the capacity and fake block size
> instead of two.

I have some vague recollection why these needed to be split, but
can't remember why...

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 82cd03c0ba21ba..0114fe47de3571 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2017,8 +2017,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	unsigned short bs = 1 << ns->lba_shift;
>   	u32 atomic_bs, phys_bs, io_opt = 0;
>   
> +	/*
> +	 * The block layer can't support LBA sizes larger than the page size
> +	 * yet, so catch this early and don't allow block I/O.
> +	 */
>   	if (ns->lba_shift > PAGE_SHIFT) {
> -		/* unsupported block size, set capacity to 0 later */
> +		capacity = 0;
>   		bs = (1 << 9);
>   	}
>   
> @@ -2055,13 +2059,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
>   	blk_queue_io_min(disk->queue, phys_bs);
>   	blk_queue_io_opt(disk->queue, io_opt);
>   
> -	/*
> -	 * The block layer can't support LBA sizes larger than the page size
> -	 * yet, so catch this early and don't allow block I/O.
> -	 */
> -	if (ns->lba_shift > PAGE_SHIFT)
> -		capacity = 0;
> -
>   	/*
>   	 * Register a metadata profile for PI, or the plain non-integrity NVMe
>   	 * metadata masquerading as Type 0 if supported, otherwise reject block
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
