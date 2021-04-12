Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADFC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:21:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3348561025
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3348561025
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MfkkNInddebAxHJnM7w3VoixZM2yacobEVrj4h7lkoI=; b=XyTC5zZmly+iRq2x21UexJnba
	HCHb3oFfghumeR6crasmXLziefIqHxMa6F78J4CFMpl+LaGMSWpv0CyfGqceSKwazxME1TOR9NgqB
	x8h7FqKAGAIB1UFlpg6SnPziv7JsE6Ot2Z2xNp7gSZtEZUd3u2joalQUlnY+x6ygaf6EHQR2v2xl2
	virfsAVRB/64oYsjRsQJSFtsyNVnNT9pdfJua/URpzFdjL2Q2a22X44yQVgBL6fMRejOMSZ3QwoYJ
	CLZ22nOzMnv0VZMm6TIebEdtRiOcY5U1yK0S5cl77tv55arp2YsFkcA0a3cY33An3/HqJOCLPoUFv
	3RvNMFLHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVsky-006GHj-4i; Mon, 12 Apr 2021 09:21:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVskw-006GHb-0F
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 09:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=9IOKrWU95ZRvfpZkdKwDcDDphdVloJpayno+OPrGl0o=; b=tFcn2EZDlD7FgnHQyXDHACO2/l
 VgrFz/LSPTJuovcdqnlGhjx7fvyst08o1l83chQO4E304l4KbGyGle8XeuC1oqGr/aeGyYm0N9f/M
 o6RbDMpjwPYAQRCBVomv9JqPas54nqXRNB2KZjN/9Neta1YFVHsTTni/T0zFjUuq6EWiSocWL7ZzA
 oblinEQS+Ch2pzjFDFkPtaPws/5eWq6XI/Yb//Ebpn1Ho8NW85hKOApBxQfrCXgv/30LhlygkqB+C
 fL964vKZcXzBsZ2heQi8ivmhuOcCrPeG7LhRL8H8FV+xBIKTmpzy9mWtyJt7EWb61qtKxIiw9flai
 hC90ENqw==;
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVskt-006389-1n
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 09:21:16 +0000
Received: by mail-ej1-x62c.google.com with SMTP id g17so16317423ejp.8
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9IOKrWU95ZRvfpZkdKwDcDDphdVloJpayno+OPrGl0o=;
 b=1Kwmi+Sysa4wTvMX/yMtXBTGFMX+5BuGhNDc3YEn9ZxRL9s2wAtLRKVxJ41WkCTR6i
 Aq7H/lKBfPsTGmc/KHKSDUcOUJimh/sGEe+PpauMLQlVPkEpr7XsPntGW9oSiM+l3KQo
 aZ3DNuUBXrklUVtVp3anwnk67i4bS785DM/yZTQ2JeRrSfcM5xDiWQsXNYRJE+OLLFXn
 gjSFR18CZgHTfZPpbFI2X+Y2zUHddXYftPcLQSpLI9UuYl7LOKr054D8RormsMq8ilFb
 Xi/qIhbqJangsJqOehcgd/Z8xBdWk9aJJL7CKNe16qTJCpn6FYBJeHuWJ4JeH9OprKEo
 SAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9IOKrWU95ZRvfpZkdKwDcDDphdVloJpayno+OPrGl0o=;
 b=bkHS09AWm9nmJfUZrwiw99FeefcFqXQcAPsOIjgK4xqlTYkAj+ANIzoACRcsuf7snM
 vns9Dce328IhH4NAY8ApM7g6Qsh5KkLTIp7hTJlm91VfzNdLUkf0qDOcv6uKqQ0dToCy
 eFGANM9TLzRfd3jIuDcrJRee+786dUZ4YrBRwvbLBOHI9SIj+m4ek+b0P2g+wgnrD1rJ
 nL/JiHxYXEadIJF7cLsjixijYqpD9oC9zyRfP5c9kgDxZi3BjOPqY9Gb9XSyCIyDmU3I
 BRvB/Z5mEqfnxBGghfOr3ASInlbt0iEvklVxKOSuOcugGVqOPcgd4WpIOawbTbNP00hU
 YALQ==
X-Gm-Message-State: AOAM530rULFtZ17qDvjyglu9xVtjK1P0A3VmBXrVXVHVq45jE36a+dtC
 u1wADpgzrXYcFdpcAvfkHjii1jwFqwr4Qw==
X-Google-Smtp-Source: ABdhPJxDJZRN7yFZ+iKwftAwM78EABKNXzHa+3YcKieF41T0TBFMlXCOhhvAqL+84VIMKqdL7arhyg==
X-Received: by 2002:a17:906:2755:: with SMTP id
 a21mr10915856ejd.278.1618219272605; 
 Mon, 12 Apr 2021 02:21:12 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id p2sm5255857ejo.108.2021.04.12.02.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Apr 2021 02:21:12 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Date: Mon, 12 Apr 2021 11:21:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412081257.2585860-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_022115_193097_E2899663 
X-CRM114-Status: GOOD (  25.22  )
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

On 12/04/2021 10.12, Christoph Hellwig wrote:
> Lightnvm was an innovative idea to expose more low-level control over SSDs.
> But it failed to get properly standardized and remains a non-standarized
> extension to NVMe that requires vendor specific quirks for a few now mostly
> obsolete SSD devices.  The standardized ZNS command set for NVMe has take
> over a lot of the approaches and allows for fully standardized operation.
>
> Remove the Linux code to support open channel SSDs as the few production
> deployments of the above mentioned SSDs are using userspace driver stacks
> instead of the fairly limited Linux support.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/lightnvm/Kconfig | 4 +++-
>   drivers/lightnvm/core.c  | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 4c2ce210c1237d..04caa0f2d445c7 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,7 +4,7 @@
>   #
>   
>   menuconfig NVM
> -	bool "Open-Channel SSD target support"
> +	bool "Open-Channel SSD target support (DEPRECATED)"
>   	depends on BLOCK
>   	help
>   	  Say Y here to get to enable Open-channel SSDs.
> @@ -15,6 +15,8 @@ menuconfig NVM
>   	  If you say N, all options in this submenu will be skipped and disabled
>   	  only do this if you know what you are doing.
>   
> +	  This code is deprecated and will be removed in Linux 5.15.
> +
>   if NVM
>   
>   config NVM_PBLK
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 28ddcaa5358b14..4394f47c81296a 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1174,6 +1174,8 @@ int nvm_register(struct nvm_dev *dev)
>   {
>   	int ret, exp_pool_size;
>   
> +	pr_warn_once("lightnvm support is deprecated and will be removed in Linux 5.15.\n");
> +
>   	if (!dev->q || !dev->ops) {
>   		kref_put(&dev->ref, nvm_free);
>   		return -EINVAL;

Thanks, Christoph.

I'll send it to Jens with today's lightnvm PR.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
