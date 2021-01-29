Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09095C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:16:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510A364DE7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510A364DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BcXu74yE+7P3mYEZiF5vUzDV0rFY6+ZQSRZwsEl5v5E=; b=I+idDk+1ItKcW01w7GjKSpVMH
	+9pSnrRtmqpibTQUH6fWq6Iz+lSfrM+qFpfKADw16QH3QRPO4E6LiiX9av/eFyGHUInta8iCPJvGQ
	GTbhbx0yleKi3kQO53hBwU2CrTMvxyo9NjmHVIvlRVETu2kapDV0+gH4itgdyfmkGqi8prwovuqfH
	ttShfqZf6jrImTWPoZ/JRUlNGXUY/SVMoKGWdb4MgJa7BPA0Wk/yzYbBl52YDco9xdzB3qghmLSJJ
	NtBbV12kbgpktaoc7/cTFnAkqsjuoa1pMizyjF7m4xAtNE9ICJ2EQG1VBsqUXUNfBHkd7mO0kzI/B
	of4Dt/MAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5aCB-00007c-VZ; Fri, 29 Jan 2021 20:16:44 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5aC7-00005u-I3
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:16:41 +0000
Received: by mail-pf1-f182.google.com with SMTP id q20so6930452pfu.8
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 12:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mywr+t/5LbHFXEcC2lOSCBe3CjwtLCThds4Z1slc5HA=;
 b=AiFjGuyKEPF0BBBtJziK7J4mqGetsVcbU2MZJ+kl2WsgOeSKFyXw2VOwf7nr9k9Qqq
 08fev0ohblM2Kg+WYPuipaTU6sIcR1U/ABDlbc3O2OgM0hsSKSovVYoaKVoZpkUYVA/A
 Ao3mJ0wuK34vMpb8HGxNBRg8iAJTWicMmrVBkWAqHybvUe0PzxbQZtEWgseFxWyVbjZk
 ngIhh0RRf5O0fY/ZryXyZRp920H+BRQ4aefkMo6rDgMKBLyFdmr2OJm1+BUM2C4vKwx+
 n5USuhACSmvqOhaAZ83+Jo7GKEvENNYf1Di7jZfwGKcPh5bNWgAKxoaT5J7tgpVIuYjl
 vv6Q==
X-Gm-Message-State: AOAM531YX2DfiAFr2MwFHjC2TymO7OVKAD0qCvTjHW7hgWZKrq76VBkU
 /XHlLnLvuffHbo7Mu1YwWA4=
X-Google-Smtp-Source: ABdhPJxXOP0ghq1aVqsYKW2Z33soVX63pGOCOlojyvQCma2XvrdPp/NG4t32yK3Rps9LK+Er070dMA==
X-Received: by 2002:a62:1a50:0:b029:1c5:112a:f42f with SMTP id
 a77-20020a621a500000b02901c5112af42fmr6017897pfa.77.1611951397895; 
 Fri, 29 Jan 2021 12:16:37 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id mr22sm47802pjb.21.2021.01.29.12.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 12:16:37 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
Date: Fri, 29 Jan 2021 12:16:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_151639_700720_F9E40411 
X-CRM114-Status: GOOD (  11.84  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> With this option, "nvme monitor" will keep created discovery
>>> controllers
>>> running even after it exits. If running in the initrd, this is will
>>> be
>>> done automatically. That has the advantage that the new monitor
>>> instance
>>> that will be started automatically after switching root can simply
>>> take
>>> over the already created discovery controllers.
>>
>> Why not make it the default?
> 
> Well, we've had a lot of discussions about persistent discovery
> connections not being universally loved. So I thought I'd make cleaning
> up the default.

Heh... well, I didn't see thus far of any other good suggestion on how
to propagate discovery change log events reliably (I've seen some bad
ones). And we are assuming that hosts need to know about these
changes...

The default matters here. The spec tells us how to learn about
change log events so I would suggest we follow it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
