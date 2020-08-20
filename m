Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB8AC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 04:30:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954D8206B5
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 04:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fikgvIzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954D8206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=22+hfC3qVM4q3R02nb/GIE/aKUAgZw1QAvrZxOjy55M=; b=fikgvIzSrMxbC6hSGyDSEjBos
	GfBStPm3M/itgsJ0E2wXVoKZdNCmhlQerjaYhfGHdaLfrbKSMCTH62SBl+IaksUUWvSJ5aREAiJ4l
	4eHfhy9ludcjl67rs71cEpUnrPoxnhgpIW/glCmwf7r7QJpAMfnkiB859T7Gwy9zyqcYxv82Pqf6Z
	zyhXTB7K3TzFI/PVSo3gzdG0Qsd1lBVd1LPAh8K75ZunydMOVbqAANvEmoz890MA10J0Ezpfi9yPM
	H0I0mwmeum7UhUV+uqb59aNbkdi+wZj1fBvTwhx9k9Iywyy8p7uHQR8+yJu4RYyTncqai+EpYJuYP
	J5w/1260Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8cDd-0001sg-HW; Thu, 20 Aug 2020 04:30:29 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8cDb-0001sI-Fk
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 04:30:28 +0000
Received: by mail-wr1-f67.google.com with SMTP id a15so738237wrh.10
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 21:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1a1+7otDaTJz5KXKmossaZSX1hzkhNhAN/X/8U5gyvU=;
 b=AbbT0SkXCv68F3RFWph3YEkNmaFpzKj5AopeknHhL7RBbTPaDrW+x1wXikuF4yce2h
 oBAoPth2d4+cg4RclxaFeFvCN+quU5SLLzDTOEGCEzjIoNt2vQT0N9lIHi1WBUd4WFIf
 +i6deFFX8KlP1A1Aqti+uGnNytksqLV4/y9moUebzB6pIlm7SSdwAGicikIUKbeo1LC9
 im8uMBo/cLsTxb1HxRBoWmhl5o4lX8HeD/GBk2tqNZUl1bAS2r92ktsxC79EPXju0CEq
 OrBTedPwNi/MDbTUcgPBUYHPqX1aYG1TWb9whPNR/yt8+At+zCs7b1jxi87+gzRDzoyq
 iXAw==
X-Gm-Message-State: AOAM530S83RcB4wUb2HctE4AvzKLM/fAClPixRci5TF/w13aBjbpo53V
 sx/GNe3IFnhZGxGyAlb8vCH/Z/EVLH188g==
X-Google-Smtp-Source: ABdhPJxIbEBC+ER++Pop3ryb6BEwbAoJbZ9qIj2L5hkIGDARNzfBKBku6NiAMboqqNK28wizBhBwEQ==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr1165135wrw.365.1597897826211; 
 Wed, 19 Aug 2020 21:30:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id i6sm1536213wrp.92.2020.08.19.21.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 21:30:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme-core: fix crash when nvme_enable_aen timeout
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200820035413.1790-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc1efcce-99d9-05cf-5f32-9c454e3b0efe@grimberg.me>
Date: Wed, 19 Aug 2020 21:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820035413.1790-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_003027_760909_BE44200E 
X-CRM114-Status: GOOD (  16.55  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 74f76aa78b02..f4c347fe925a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1422,21 +1422,25 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
>   	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
>   	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
>   
> -static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> +static int nvme_enable_aen(struct nvme_ctrl *ctrl)
>   {
>   	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
>   	int status;
>   
>   	if (!supported_aens)
> -		return;
> +		return 0;
>   
>   	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
>   			NULL, 0, &result);
> -	if (status)
> +	if (status) {
>   		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
>   			 supported_aens);
> +		if (status < 0)
> +			return status;

Why do you need to check status < 0, you need to fail it regardless.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
