Return-Path: <SRS0=P2Tb=7R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F245DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 16:58:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A7520772
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2020 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VccJSLcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7520772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Xt12QjbiSsJPibuoKN9wXDA3x9KypmaCGO5o0Qsq8Kk=; b=VccJSLcOjQA8GIcRAgUhKkVFC
	jR5DJeo5QbDYfNtjBC5YGDD9ubTkChJhSxoKVz6g+n4uEusOUlSLAa8M/ywE7/hrAOCOIlBO1iTL7
	CjBKMoVtJfK3iiCBtZc7qJ3wcSZMGTgDkR1rXFTIQL8VPfzURWQshVU8q62jJBZ5sLPJgVSCS9eay
	ZdfR5C6M97uImkCAbpnIssTTngcr48IDZb/ZFNKZqfSXm++PH/I60BiPQ+wmPNKew5211Wt2i6xHj
	ewdKWtU3NOGz/rEOXaiieZgbmxEdlGUWD3swud5Bni404PO9e5Z9aagUsCGtxYbuGjGdKix8oMuyI
	8S8d6GSrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgtCi-0001Ty-5D; Thu, 04 Jun 2020 16:58:56 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgtCf-0001TM-Ox
 for linux-nvme@lists.infradead.org; Thu, 04 Jun 2020 16:58:55 +0000
Received: by mail-pl1-f196.google.com with SMTP id y11so2409422plt.12
 for <linux-nvme@lists.infradead.org>; Thu, 04 Jun 2020 09:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=znbeWbPKUM0exIBIBb/xP8goCycIUtCUXcmkpJ8IvCE=;
 b=UP3VeeWT3mThil4FG+asZghAnjJEK2fF1pFrLedBAmdPJGqEtdktOswiRa/FAt19/j
 xNX3vmWGL4/Lzqj1ccmArJvIDeCfyVqKRyJWzr9LXQdatiATBPDDQ+Heb3yLWzA73yBb
 gNhg5d4EtZBydHoaQpq9/N+FyK4Co9tx6ITCdQ/6qiCBGh0+zLLVGadNZchTb+P6qFL7
 HSJENKBb/Ew2to9tV+xZn8ZNadgiYKxfnREMAhvhKVVYKO/LvBRNuI7Du4uLTRgGf+is
 I2K47bojbQ1WraTReFp0py0/i1/eSiaqWWjXlEG/jagRrv6zrWyWvh0h9H2kF3a1Iz8X
 /X3Q==
X-Gm-Message-State: AOAM531L5JnBFrdQ1hv4rQxDYq4g2pKyXHIgp+bBZsd1NWVVBdsnZUJl
 c9msq2Ez5z2XaPzo9daWf0/hIRHa34Q=
X-Google-Smtp-Source: ABdhPJwBKL1A8j3fFhSZEyvSJc+SyEE9zNzRXKYMAnqyEUDGoGscU4Ej+iVES8T3QsWa1cSSmx7veg==
X-Received: by 2002:a17:90a:dd43:: with SMTP id
 u3mr6505646pjv.221.1591289930790; 
 Thu, 04 Jun 2020 09:58:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:35c9:507c:6c7a:323b?
 ([2601:647:4802:9070:35c9:507c:6c7a:323b])
 by smtp.gmail.com with ESMTPSA id i14sm325775pfo.14.2020.06.04.09.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 09:58:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme: check for NVME_CTRL_LIVE in nvme_report_ns_ids()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200604115602.78446-1-hare@suse.de>
 <20200604115602.78446-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <905b2aa9-3c82-fab5-ccb1-c68faa15ae11@grimberg.me>
Date: Thu, 4 Jun 2020 09:58:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604115602.78446-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200604_095853_810407_F1E38CFE 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <daniel.wagner@suse.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When a controller reset happens during scanning nvme_identify_ns()
> will be aborted, but the subsequent call to nvme_identify_ns_descs()
> will stall as it will only be completed once the controller reconnect
> is finished.
> But as the reconnect waits for scanning to complete the particular
> namespace will deadlock and never reconnected again.
> 
> Reported-by: Martin George <martin.george@netapp.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 569671e264b5..b811787505f7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1792,7 +1792,7 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>   		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
>   	if (ctrl->vs >= NVME_VS(1, 2, 0))
>   		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> -	if (ctrl->vs >= NVME_VS(1, 3, 0))
> +	if (ctrl->vs >= NVME_VS(1, 3, 0) && ctrl->state == NVME_CTRL_LIVE)

I'm slightly allergic to these sort of state checks so untrivially placed...

Hannes, did you have the below applied when reproducing this?
--
commit 59c7c3caaaf8750df4ec3255082f15eb4e371514 (tag: block-5.7-2020-05-09)
Author: Sagi Grimberg <sagi@grimberg.me>
Date:   Wed May 6 15:44:02 2020 -0700

     nvme: fix possible hang when ns scanning fails during error recovery

     When the controller is reconnecting, the host fails I/O and admin
     commands as the host cannot reach the controller. ns scanning may
     revalidate namespaces during that period and it is wrong to remove
     namespaces due to these failures as we may hang (see 205da2434301).

     One command that may fail is nvme_identify_ns_descs. Since we return
     success due to having ns identify descriptor list optional, we continue
     to compare ns identifiers in nvme_revalidate_disk, obviously fail and
     return -ENODEV to nvme_validate_ns, which will remove the namespace.

     Exactly what we don't want to happen.

     Fixes: 22802bf742c2 ("nvme: Namepace identification descriptor list 
is optional")
     Tested-by: Anton Eidelman <anton@lightbitslabs.com>
     Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
     Reviewed-by: Keith Busch <kbusch@kernel.org>
     Signed-off-by: Christoph Hellwig <hch@lst.de>
     Signed-off-by: Jens Axboe <axboe@kernel.dk>
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
