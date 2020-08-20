Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF6EC433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 04:33:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8C72076E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 04:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KMtE7PGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8C72076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+qpvuyxuRo1Kb+MFfUT5Z0Q2Jz3iIZJrvVvRgMuwotk=; b=KMtE7PGsJBJsZf43pH4A5npnq
	oxDq19GnwBWoPPy/wyQP45fY5s9gF7ArH+NzWNAQ4naxhVG7hr3Ix0dPH+JbOXRCQH+aa+4V5RMEF
	uiB60BjGn8sxu2hFY7TLgdmBM1C7qc9vD+1j0KqwbyXGmK98lKy9q4MOv1Y2hL/tH6oipsU/5wgp4
	Nz4rqrChoya9TNo8T68+xBL1VcrwLM+rxOlj7w5CUbdKRibsaNQcywoakjGutC7govZLs6ZMvJYTw
	HbJv+tAjRR57pXS2SGSwTWuaurwxAYIqfcPWrkQiiWSwf3rQwmEwhfAQwhOppWSRPCLdCfH+mAnhh
	wo8d1+TyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8cGd-000219-Ph; Thu, 20 Aug 2020 04:33:35 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8cGc-00020d-8P
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 04:33:34 +0000
Received: by mail-wm1-f66.google.com with SMTP id g75so434690wme.4
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 21:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6QzgP2JdM0qPTwMe/jCkl+XDhscjZvcTxYrmimKytpw=;
 b=TDpP23nqEOuXVx74PR/OQ3zNZHrN85aRqODFxyAztKVNeuchfxeo4H41KQnxYLxDLS
 vKsDGqh+U+bMCCaOoewMMYqZgd7TTsJ9QGqi2bB4dpempPHY4SiqptoJ3aKd7UX7ZqQb
 Tvrz4tZ63+8qOxmpJVRFGCzn+aF5OA3T0D8hZIGP0Bcm/VQp5GNQ9/GX0/7p/dxt1dov
 Iuv9yllLsZoArcKYv71BVX1sefiUSWd7MIzKZrXYjffKyHm6Pc/bPkChH2ayokEzQvuk
 h7dCuXLLx1+7jvz4HlAoEAWGglvXWafgt9akx/OvEICfP4Kid+sXVDDoqDmSA4n8dqaW
 Soxg==
X-Gm-Message-State: AOAM533pUpIpsuHryJ7xKcID2G9E65S3Ru+wkWatjV7X6YNaW6v56WpI
 L9xdnTaKRNUNnHg2emQ8uPAaWfanOBjQqA==
X-Google-Smtp-Source: ABdhPJxNna9sxjd0eucObDI/+lTjzuC4I+s1tf5CTdLFslyf+qoHhipGX6OO8EZUZu53PxZo3lPpnw==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr1469276wmh.136.1597898012996; 
 Wed, 19 Aug 2020 21:33:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id x11sm1630207wrl.28.2020.08.19.21.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 21:33:32 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200820035357.1634-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
Date: Wed, 19 Aug 2020 21:33:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820035357.1634-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_003334_309243_8C113F17 
X-CRM114-Status: GOOD (  25.89  )
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


> nvme_revalidate_disk translate return error to 0 if it is not a fatal
> error, thus avoid false remove namespace. If return error less than 0,
> now only ENOMEM be translated to 0, but other error except ENODEV,
> such as EAGAIN or EBUSY etc, also need translate to 0.
> Another reason for improving the error translation: If request timeout
> when connect, __nvme_submit_sync_cmd will return
> NVME_SC_HOST_ABORTED_CMD(>0). At this time, should terminate the
> connect process, but falsely continue the connect process,
> this may cause deadlock. Many functions which call
> __nvme_submit_sync_cmd treat error code(> 0) as target not support and
> continue, but NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both
> are cancled io by host, to fix this bug, we need set the flag:
> NVME_REQ_CANCELLED, thus __nvme_submit_sync_cmd will translate return
> error to INTR. This is conflict with error translation of
> nvme_revalidate_disk, may cause false remove namespace.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4..43ac8a1ad65d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2130,10 +2130,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
>   	 * Only fail the function if we got a fatal error back from the
>   	 * device, otherwise ignore the error and just move on.
>   	 */
> -	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> -		ret = 0;
> -	else if (ret > 0)
> +	if (ret > 0 && (ret & NVME_SC_DNR))
>   		ret = blk_status_to_errno(nvme_error_status(ret));
> +	else if (ret != -ENODEV)
> +		ret = 0;
>   	return ret;

We really need to take a step back here, I really don't like how
we are growing implicit assumptions on how statuses are interpreted.

Why don't we remove the -ENODEV error propagation back and instead
take care of it in the specific call-sites where we want to ignore
errors with proper quirks?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
