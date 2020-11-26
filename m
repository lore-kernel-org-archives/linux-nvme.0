Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38ADC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:59:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B63E21741
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 03:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="USICwGXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B63E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mHn4RPO4eFyifSHUD1KUnh5TD33j7Ui0jATkkfq22l0=; b=USICwGXCl0y5QYdSOUKTft+th
	f2flZx1kFdUDRPaPEz60K9AOmk1NuiKm4e7edz4W+hc/+1zEc+u7AhvuKRDDtyXVG/OvSROguCaEF
	lTo2US1XD3YPxPZsXOKCz6jOYN6PoP0ETxFO8szyfMaYLg6svYGpef0UTBCuEsvQKJdnR2vyEPBPJ
	dzoQiHv6vfsR4R09UC4+PxUN1plE86VTZz4y3aqDo0/IFTmIAGNN0lITA8PMPLzXIl9+W3yUnOvzA
	WwPPsgcCi+vGK0H7aYVmheeU/c6Nfo5GlvreXS7/uZXjvtNqfwdDoFenZshCMKofeB9lfJUjF4WuY
	HNfCFMD8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki8RZ-0001vK-L1; Thu, 26 Nov 2020 03:59:41 +0000
Received: from mail-pg1-f173.google.com ([209.85.215.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki8RX-0001uo-C7
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 03:59:40 +0000
Received: by mail-pg1-f173.google.com with SMTP id 81so600871pgf.0
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 19:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5yglJxjwYOkl0rNuyQ29ZKEbLkJAv4ilYSu4c1LwI5M=;
 b=ATBLOR146wR8hc0W077m9gVCifiqY5hnw7M+KdFNgb5ha3CAnb4TNjzhq4UEJoZzKT
 FZjzRdWQrIsjDJ3QuQ93eaM84MTR4/Jgb3uBtO7NcuG+SYUr8CDrJ/Ht6li14IAGl8+m
 C2gQL7pI5A90rx6f//9xNix2WDuusyE0IJwGkLMvVARSZYRIBOGogfTDZDDtmZKApUoU
 YUYcH0dCQvIBuFJb4Ww4lOOUgsdbXP4icOTt9lTaK97YBHfZlWvwr7kgZu8tkt7C3ira
 2hL6DhcBWLmPVvfm2Jnm/9RvkzCZWumeevomtTawREY8WrnGzqa2pR5flXh5AVUcn597
 1pWg==
X-Gm-Message-State: AOAM530xYzz+K9uBtbeZIRP60wMg9xT4pfW5ZyMfKiWuFtZHouWv6hkm
 hQOfTTj2vnphmM0V/HPYeqg=
X-Google-Smtp-Source: ABdhPJxpgwOGNcDQAEnCwGBJTqqjuuhBy4zFzcRG7KVa+kViVTwxo0EVr9fizGOA4Osvddcx9MtNHw==
X-Received: by 2002:a17:90a:f994:: with SMTP id
 cq20mr1280074pjb.62.1606363177065; 
 Wed, 25 Nov 2020 19:59:37 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id v18sm3019913pfn.35.2020.11.25.19.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 19:59:36 -0800 (PST)
Subject: Re: [PATCH V2 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-4-yi.zhang@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
Date: Wed, 25 Nov 2020 19:59:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201125073205.8788-4-yi.zhang@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_225939_471475_6303F131 
X-CRM114-Status: GOOD (  12.94  )
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

On 11/24/20 11:32 PM, Yi Zhang wrote:
> +# Get block dev scheduler list
> +get_scheduler_list() {
> +	local b=$1 p
> +	p=/sys/block/"$b"/queue/scheduler
> +	if [ -e "$p" ]; then
> +		scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
> +		echo "$scheds"
> +	else
> +		return 1
> +	fi
> +}

Can the echo statement and the 'scheds' assignment be left out? This is
what I have in mind:

	sed 's/[][]//g' /sys/block/"$b"/queue/scheduler

Otherwise this patch looks good to me.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
