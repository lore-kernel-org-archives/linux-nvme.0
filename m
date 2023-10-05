Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B05FE92725
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=76a8YQ0hLV5bUIBYfne2+TIqNG1r6p78CzGnl00LQkI=; b=DLBFN+3XMAQVt+C5tIL1xwC8Ih
	ZsiPAydfJT3hKmB+OVsKqM5tzp396zY35bjxMn7zOYdY3S3CGoXz0p88kQb+GsYeMadza0I54qCbC
	uHJYAS35zsXb7p9gJMlf9B9hC3Q06ic0x8POUxQNku9Rbt0E/CI7yS14YMamf76AS83a6jrCpQl1S
	0fQC9IQ723lTj3N48qOhPKVinWpPxM8t8xzvvaRHyZmfLeFp9dy7AwuhRxIDKq9YsLjkU5AKaZblP
	rm66SQnn4jPwuK6Y884io45Sy0cnep5BhfCYCCHIsP2V/74roFyxncHbwR+TlcHRLzeQtPsJS02jJ
	m0zzUxNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoSgA-004FAS-1f;
	Thu, 05 Oct 2023 18:02:30 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoSg8-004FA7-0F
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 18:02:29 +0000
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-565e395e7a6so754026a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Oct 2023 11:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528945; x=1697133745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76a8YQ0hLV5bUIBYfne2+TIqNG1r6p78CzGnl00LQkI=;
        b=JWGhMbaDRFKmEQPycJDiPsT3xAAOiMoHM0Mz/qqW6HqNDfIg23T+pkGNGEpcerKO9o
         wJiWdvjrtYEYDXj2S6bIvraNabg4tE7x5T02/anx3agC49dZsT9cxgj3USpJqtBPucVB
         LuaS8sdS93pd4rIG8n+AuXg8sC3YweP6B7nLfQcEFkZCmWSwuo9bfB7Puv1CDY4Tf27G
         QbsXb8GC3fm/uzXF9ow2OOSKdjaUgTf+kXGnaGuSSczLjQatVXqQZAZk4FnOsQNz7ipl
         O5TGZFu7mAqvlpsNXqmN+300yOKVPWyTxPCPTw62E78pE+8zMZFPc2ogt5sjXnzOd/q0
         lq8w==
X-Gm-Message-State: AOJu0YyvIPqP9QT0aM89ekPOKmxdleqBy6yHaOlc5Yfh2xgtNg5tRjYs
	FdW808ndVI7l2FNAPt20doQ=
X-Google-Smtp-Source: AGHT+IEtxhx8Df6oc23r6vTVfpi0GCljdCBIuAHJXI9tx/vfH9rfZ3EhYCygbBmPeUDVC2fu0Q7kog==
X-Received: by 2002:a17:90a:9d82:b0:269:621e:a673 with SMTP id k2-20020a17090a9d8200b00269621ea673mr5809723pjp.1.1696528945326;
        Thu, 05 Oct 2023 11:02:25 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ca3e:70ef:bad:2f? ([2620:15c:211:201:ca3e:70ef:bad:2f])
        by smtp.gmail.com with ESMTPSA id mp3-20020a17090b190300b00267d9f4d340sm3897773pjb.44.2023.10.05.11.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:02:24 -0700 (PDT)
Message-ID: <6b267348-7548-4cb5-a62a-284c6750aeae@acm.org>
Date: Thu, 5 Oct 2023 11:02:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/rc: fix rdma driver check
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231005080242.292291-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_110228_135302_ECD4F9C4 
X-CRM114-Status: GOOD (  17.57  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/5/23 01:02, Shin'ichiro Kawasaki wrote:
> Since the commit 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not
> return value"), blktests no longer checks return values of _have_foo
> helpers. Instead, it checks if _have_foo helpers set SKIP_REASON, which
> was renamed to SKIP_REASONS later, to judge test case skip. If two
> _have_foo helpers are chained with ||, the skip check does not work as
> expected since one of the helper may set SKIP_REASONS even when the
> other does not set. Such chain with || is done in _nvme_requires() to
> check rdma drivers.
> 
> To fix the check, do not chain the helper functions with || operator.
> Instead, refer $use_rxe to call only the required function.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/rc | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1ec9eb6..bac2db7 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -44,7 +44,11 @@ _nvme_requires() {
>   		_have_driver nvmet-rdma
>   		_have_configfs
>   		_have_program rdma
> -		_have_driver rdma_rxe || _have_driver siw
> +		if [ -n "$use_rxe" ]; then
> +			_have_driver rdma_rxe
> +		else
> +			_have_driver siw
> +		fi
>   		;;
>   	fc)
>   		_have_driver nvme-fc

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

