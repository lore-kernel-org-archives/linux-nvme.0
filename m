Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36339C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:05:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1D223382
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 22:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1D223382
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0F9e3yjEiB603IC9FwCKcb4PQXctNeF+jEmLSFCKQIc=; b=MfY6RAKVBxi5vCBqnG30ZI0VP
	0H27hBBKytFwW9CzI9S3q3oVT/OVdMMxq5kZn2XMqzVQ0WDkca4cgtGTn3UpSAPeygZvppSQsDNjM
	vYZ3efOVKQmjLdk3iEgnTAT9b5cBtTwMsPvrxFDlo8+EqCJjh80rasX3qt25EBebx1Iwv7mpWEMO6
	B4TRhdqmUF2h17VBR1bRLPuqWVXQ5bNUl9L6iVVIYdMAMD5W0ntQMYimCbLxf0JvVswtfMvrRL9zi
	scS/m/XW/2C5rqE0R7NYwdEecfgvZzyqHKuVXDOEqpctS30QakR4hmulSacqXSmqMx0VIlXv6myPj
	/Im+GToCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzoFv-0006Xg-VD; Wed, 13 Jan 2021 22:04:44 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzoFu-0006Wr-CZ
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 22:04:43 +0000
Received: by mail-wm1-f42.google.com with SMTP id a6so2936990wmc.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 14:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bTcCOQl543UlfGJtiGMQ0ZaDpPpTqVdysOlPIyBYgk8=;
 b=rQJZO0ci3scNCWWD3k795JizyoMx2idv9LE1ceUDdrGMyfq/ehlkvnBzbI2UnFFZds
 Jr7AbtT+z6Y3ejvVCdb6Wd/83kZ1+lrvBsW/pkxhitR05czpptSxBmH2mEOLx9NtJI1O
 g1G98OrRjhyP/6v2CibTj7EsVclbVXSeuD8CY3exZrwTn6kwSyZfzI7CpTrsWC5xGBHg
 LF347muFZ4iQ/hhsgH/v+UfBtmRw4FeOCItaUi+HYpyQIinWl/Oeia753oaDro2VvDNp
 NocIQiS/FC1bRaC7I2IZEPfGo84zVHbxjQVPdtPnvVgay3AkygP5qoX7ZbCeB91556Ms
 XzGQ==
X-Gm-Message-State: AOAM5323Jsfx7v0HcO6y7HPlt/S6bN0+RFxQeB8wHPu8p4tYmi0I4zcB
 iClTlnpRBrF7YTO8RDcpa7cj3JGCv5Y=
X-Google-Smtp-Source: ABdhPJw1n1wt+rE6CPcGCQOvR9DwAeN2vf4RxVaTIbcwmPvIxRLTUeQIYInE0LR7J+EK/tYQbqS28A==
X-Received: by 2002:a1c:7c03:: with SMTP id x3mr1119083wmc.17.1610575480937;
 Wed, 13 Jan 2021 14:04:40 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id h13sm5556462wrm.28.2021.01.13.14.04.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 14:04:40 -0800 (PST)
Subject: Re: [V3 2/4] nvmet: remove extra variable in smart log nsid
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210112211410.24742-1-chaitanya.kulkarni@wdc.com>
 <20210112211410.24742-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <82384bb5-26d4-3148-f33a-178cb56655f9@grimberg.me>
Date: Wed, 13 Jan 2021 14:04:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112211410.24742-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_170442_487987_40D875C7 
X-CRM114-Status: GOOD (  13.60  )
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> @@ -86,23 +86,21 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
>   	}
>   
>   	/* we don't have the right data for file backed ns */
> -	if (!ns->bdev)
> +	if (!req->ns->bdev)
>   		goto out;
>   
> -	host_reads = part_stat_read(ns->bdev, ios[READ]);
> +	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
>   	data_units_read =
> -		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[READ]), 1000);
> -	host_writes = part_stat_read(ns->bdev, ios[WRITE]);
> +		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
> +	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
>   	data_units_written =
> -		DIV_ROUND_UP(part_stat_read(ns->bdev, sectors[WRITE]), 1000);
> +		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
>   
>   	put_unaligned_le64(host_reads, &slog->host_reads[0]);
>   	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
>   	put_unaligned_le64(host_writes, &slog->host_writes[0]);
>   	put_unaligned_le64(data_units_written, &slog->data_units_written[0]);
>   out:
> -	nvmet_put_namespace(ns);
> -

I think the out label can also be eliminated now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
