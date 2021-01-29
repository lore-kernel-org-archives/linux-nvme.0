Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:45:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC46664DE7
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC46664DE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BtESS43llWjFjGaQJ7mcbQVYRYnvpBeslFB/KH1zigA=; b=pnxPAaBciJx3OkAxx/8nVkLYf
	A3sMpFgnMZAQHCVdmnpYZx6pOzUuiuu+k5RKUgRRheeRPW/IlYUWH/69LlGxL/BYUIHu4iS2Kmi9X
	6L8Z/zRkgBHm77hHfzCrAvprPbHc56Ww3nC5HVtn4kLnER2sHTyEjdpcGWifVc5+Sur8Pq+6rftA/
	D5ourHXfxEJDhf2Qhm95Am6WGliD7TmW7f4S98tMGlD/1BM+nTnkUYQfdPps8sFhJpD2jlEf9zmju
	EFy8qV55FOV4LavIuS8QDT5h2Kbzu2BFwD5CHBQZvsJfuLQ3Lv53GIpQ5aoWZ3BOHWatseHPlsawR
	xLAL5Qhaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5adi-00039d-Vl; Fri, 29 Jan 2021 20:45:11 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5adh-00039F-3x
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:45:09 +0000
Received: by mail-wr1-f52.google.com with SMTP id 6so10127041wri.3
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 12:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/5b4SJ988QnnHX9yy4Q39A3uYInDnxLWaW5dOE4js+0=;
 b=qMV6nxv0dMyQnh+X4v5eyAH0ZOgwKsjNngEPJjpbK1acBy88NUSLvDSUrroGdEazZZ
 W4uAoDJWqtl/SeylBd6PVSR7XET34MK8DxskfMT81FzttnksGvw2e5ReLu9193y3WMt9
 Y45aMdO8DQjPosK0gcpvvOVpcfknEeOEkbXmppdMFN2o7TI+7wPHzakRIh7hbBQQEM6A
 bb6EkZOsHKEhao/vrAaCiE8XGzPiO+KrwwAKvwS3ZBlAu05VgKfTifnlnZ7103II7F8/
 ukIAHuWtUKaCE8pQmpQtInlaUvR5IwYkC7+ig7JNqmkGSm2DEkySO6UhKGTEu+EzN9Nj
 4Yzw==
X-Gm-Message-State: AOAM533SHoK6vj/449lapQ7XMe4I04E7LK/XYWpsGtwyztyYsXuUCuzh
 zYh2hmWrXd6CfVMKc2Uk09s=
X-Google-Smtp-Source: ABdhPJzLXFWkkL9yjuTv4GVxBb5s2Rno9tnpvndpAjdubc1du7pis26iXs6REX6aJ/XYBAQRSpKFHw==
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr6661558wru.0.1611953107811;
 Fri, 29 Jan 2021 12:45:07 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id l1sm13732912wrp.40.2021.01.29.12.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 12:45:07 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
Date: Fri, 29 Jan 2021 12:45:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_154509_195490_ED5674D6 
X-CRM114-Status: GOOD (  15.26  )
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


>>>>> With this option, "nvme monitor" will keep created discovery
>>>>> controllers
>>>>> running even after it exits. If running in the initrd, this is
>>>>> will
>>>>> be
>>>>> done automatically. That has the advantage that the new monitor
>>>>> instance
>>>>> that will be started automatically after switching root can
>>>>> simply
>>>>> take
>>>>> over the already created discovery controllers.
>>>>
>>>> Why not make it the default?
>>>
>>> Well, we've had a lot of discussions about persistent discovery
>>> connections not being universally loved. So I thought I'd make
>>> cleaning
>>> up the default.
>>
>> Heh... well, I didn't see thus far of any other good suggestion on
>> how
>> to propagate discovery change log events reliably (I've seen some bad
>> ones). And we are assuming that hosts need to know about these
>> changes...
>>
>> The default matters here. The spec tells us how to learn about
>> change log events so I would suggest we follow it.
>>
> 
> No problem, I can change this.
> 
> But I'm not quite following you here, because this option is about
> keeping controllers up after the monitor exits. Given that the monitor
> would be the instance that receives the AENs and acts upon them, what's
> the point of keeping them alive after it has terminated?

It may run again at some point.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
