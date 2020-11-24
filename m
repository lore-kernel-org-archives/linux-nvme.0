Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29186C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:26:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3072085B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 03:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rryntr0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3072085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z14ZwdjX1sOttJ0NEB/sv4ZOGQ1HOHKXKLNjAln3cNM=; b=rryntr0eZElcpAVeIuPGn5dsD
	R9YkCQ/S2d8QszNy6ZKtux7b6Bty+j2UqONz5gveL493WKtbGJELAU68EpXqNcemKsL/ihkWCq6zs
	Gpxr+pRVFEwDPsn037ycuEhV1Q0DUjPcx8ShdXP2LpL6EJGVq3tx1wZNp2YKlBqmXP71i9paHY40z
	Ze+Sqzva1HuF0rIBKQWyzZKo+0YFXSuvtdQPzZknK28pcUzoe376s7Re7kMpryhvivoarKy8dbdIl
	ES9aQifoJ7dfLie8PrsrgAkl/YXUTGskYDx88yH/6hEisEsDhnHwKUaSHmS1S+JC5xC/J1twvKg+C
	KXNNbrZKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khOyS-0000WO-2I; Tue, 24 Nov 2020 03:26:36 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khOyP-0000VT-1s
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 03:26:34 +0000
Received: by mail-pl1-f193.google.com with SMTP id r2so2309766pls.3
 for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2020 19:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W6//6ZvX6573PLLZNDv+zmQJndnbDNQGVwH9Emnfll4=;
 b=OVeO4gv+Nl+e0SrzDqFoWzsLZzR3wdPECS6w39t5M6QBXp7YgSSWhhcZ4jHyzkEQr6
 1wRBVWm6eL9FeALn5cNiVDK1VASYfTzHYKhyW6nLSBPWU3FSvf8gqanRlJtfjlF30pVA
 x2btc4ic5KmSdyYdfC+U6RSmwr+ilaIeFTJnFuU9taNTyXp/Nb5R6RXILG9k7FiVpY9w
 cIJOX6u83fAbheSToXM4zNHXvqzXYjBLkNvshuPbVaSJa9EOdUjrKJo5zfnhrjoXf3v8
 P6utlBrLVyPW08bDkxsPgYTtwHfRz4DmuhduX8vdjTFLa4QcZqfjzt1qJ6X4vDbU6ZFG
 tJvw==
X-Gm-Message-State: AOAM530KOODOHR7ZLBfM3R97cQ9Xe6s/34EAKFq++gFbjPWDuBdKGD58
 3NkFbAbIbT4nLeSsWl0x2apQoWDkp+0=
X-Google-Smtp-Source: ABdhPJwIoYQm3SQdejdxNNHtT3/QFhrIDeHf5HzXiivMyO8uMiBX9DRZW+/udcPOE79FXy+8KGQSsQ==
X-Received: by 2002:a17:902:ba8b:b029:d9:d8b9:f2d7 with SMTP id
 k11-20020a170902ba8bb02900d9d8b9f2d7mr2300069pls.77.1606188389487; 
 Mon, 23 Nov 2020 19:26:29 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id t9sm529323pfq.39.2020.11.23.19.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 19:26:28 -0800 (PST)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
Date: Mon, 23 Nov 2020 19:26:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201124010427.18595-3-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_222633_189378_2FE34A87 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/23/20 5:04 PM, Yi Zhang wrote:
> To enable it, just do bellow step before we run it:
> $ echo "options nvme_core multipath=N" >/etc/modprobe.d/nvme.conf
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
> index d7a7c87..bc78f14 100755
> --- a/tests/nvmeof-mp/rc
> +++ b/tests/nvmeof-mp/rc
> @@ -17,7 +17,7 @@ group_requires() {
>  	# Since the nvmeof-mp tests are based on the dm-mpath driver, these
>  	# tests are incompatible with the NVME_MULTIPATH kernel configuration
>  	# option.
> -	if _have_kernel_option NVME_MULTIPATH; then
> +	if _have_kernel_option NVME_MULTIPATH && _have_module_param_value nvme_core multipath Y; then
>  		SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
>  		return
>  	fi

Please set different SKIP_REASON string for each case such that it
remains easy for a blktests user to figure out why these tests have been
skipped.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
