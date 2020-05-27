Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 20:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231692075A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 20:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Utzsm+h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231692075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I4LbbKADwRY97h9j4/WhIW3ppw8xomI/BEh1QTDEZ6Q=; b=Utzsm+h4l6YJ9G5AJujyCPWQb
	NK6vAN9cq5/Sbp/fC+fIMdVF0+6svf3q+TPUKqRa08ho3j9fNmGSE4UPtzt8VvlTXdxo8tf5vfgy5
	KldC82ZH7yWgxl/djxeHhWOw6pxhsslTbXzBZxzTKUFYAQTMoIiPW/uswIf8Jr7u9RFAZPIh36UDb
	nkRSOLC7K2LOtsn6JSjk6qdSiMUQBrE/5M9pwKTB7+tU8Welya+pXfnyjEeDwryWfszuYeA3iU4Fp
	XoHE/UBmNpU3YnCgbe9Ap3lllbT7sZTh9IvE5LF7D01ugZR6898qroFRg0aEJqBBp9O5DfyBd9ISx
	jxO1OctIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je2VO-000450-Jj; Wed, 27 May 2020 20:18:26 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je2VL-00041m-KG
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 20:18:24 +0000
Received: by mail-pf1-f193.google.com with SMTP id x13so12348692pfn.11
 for <linux-nvme@lists.infradead.org>; Wed, 27 May 2020 13:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5TXLbJm/JLn4M6QqtTDVnxjC5/yrFjlrg76f8VBphHU=;
 b=JSq18wporvwpGMFIDEOYGLfjg6Od6jYQfAGzLkdX+nXNUzbMsNdsjr1TKkbdeCYcaH
 PKGRmJ+C9O2ThMYogWIcSVvoHW6FbAqkyYuYnkNGZGkk/JKgsn+evAMzMvwsshnd0psl
 36BbD1KRrdbrJioxanotLWlGzPCex0sD+G+1moKZ1nxc7y4TcL38p2iZnzvRrqh55gY+
 kt/rNBE5Jng7eApDOgTTIdeOl2iTGcRkbpaXGcXbejzgoR5M/iM9Dnm1uvg9qY1n2FAs
 8cpQN60fByFIdjqnrQyXp2hDAWtex+3Ex7BhhW7ttjLChiJV0sNZMqAy5tfMWLMYSQ0b
 sQ6Q==
X-Gm-Message-State: AOAM530H66Fqp5vO/suv35woXdGEsADCpTNiYQoOBfSSMbZVzUFqO1Lk
 OLzCYAjA5TG4ZQQ/GOw2CFs=
X-Google-Smtp-Source: ABdhPJwfEJ81vPiTeZzTjGl3Rx32Z4IiFoNSdvCHJYZLLcBNbYDBwfcGw8HIVQ2EcgfnVCl5jwOXEQ==
X-Received: by 2002:a63:b513:: with SMTP id y19mr5261807pge.29.1590610702301; 
 Wed, 27 May 2020 13:18:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:218a:690b:802f:16a3?
 ([2601:647:4802:9070:218a:690b:802f:16a3])
 by smtp.gmail.com with ESMTPSA id b74sm2663264pga.31.2020.05.27.13.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 13:18:21 -0700 (PDT)
Subject: Re: [PATCH] nvme: cancel requests for real
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20200527190913.3461503-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cb108e7e-d386-883c-4d4a-64e517891220@grimberg.me>
Date: Wed, 27 May 2020 13:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527190913.3461503-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_131823_686588_A73FF3A3 
X-CRM114-Status: GOOD (  16.15  )
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
Cc: axboe@kernel.dk, alan.adamson@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Once the driver decides to cancel requests, the concept of those
> requests timing out should no longer exist. Since we can't stop fake
> timeouts from preventing a forced reclaim, continue completing the same
> request until the block layer isn't told to pretend that didn't happen.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..72e5973dda3a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   		return true;
>   
>   	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -	blk_mq_complete_request(req);
> +	while (!blk_mq_complete_request(req));

Maybe add cond_resched in the loop? just to play nice in case something
is wrong?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
