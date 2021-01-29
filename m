Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E6FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:57:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20CA64E05
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20CA64E05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kZvyxI4DfOu6bkj1FzbNj9ozMjczzjg3mkisccGyZAY=; b=3aGUqE/spbO6t9w3CeBUAPlX6
	igIk0IW9G+Mpcbup8yrdhjcQbtWxZUhTGcAcDV+2Ipo1aRKQajejnt3DSGwftb3taJ31rl70Uinum
	OYSH6axTUumCY85R7nbxIqr6pc6+uF/6IzuQiPB2wrjMR3rTlH63FVnQBm1Pu6pA77A2Kg34R2D4W
	CC37KVSRI1H+eXPe+QsPfg/ViahR7nriE9QCDvnWD0RmATUQ6ru6XybB0asNqDPRaNlVcDZ0goTKf
	Guo8MVBE8RVtM1J8m/CkG0XLy82d/CRaxpJe20HH2IlgfMIbBJNM9HtgV/aVQTMnN/pZZ3EfiQNJb
	1ubNX1UTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5apo-0004QI-RN; Fri, 29 Jan 2021 20:57:40 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5apm-0004Pq-In
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:57:39 +0000
Received: by mail-wm1-f44.google.com with SMTP id f16so7817175wmq.5
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 12:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pwofyZEhAzeLpAB5BkTY+4Jblgm7IRvSoc3pv0wUnNw=;
 b=Lf0nmRvwRLMixePPNsJ/Q3PsxOmib3NGL6WgXaQe3F8zd32GfjCJS+ceNdtZHTy3t6
 eoYO8v5+evXDuQWojTrzdpSA/yGhhSYyOw2ll6K4CQX5iWQG/Arwy4qknDHbF56hYU+w
 /X0S3zgSRssyDkkzJJyBGZ4A8aL0txMt+7D8Ue4mA2F3vfDsKuoGdEs3LnJGpR/GOGTW
 FFNoXKWlXoPNTHoa0dhDuHnKVy9tYnom+PuaYF9QUchNo9rFs7iUZTcSA0eO86JMEoYh
 5Bl30zVlbZMo84QrHHLRUDtAcDcmqU90APmU2Q40LTjAegmmPeNofrpirgbR4JDtbf4g
 ECBw==
X-Gm-Message-State: AOAM532Urn33JemdHJCuiaC6M4IiW+p1CysydhF76y5cKgdKntBYl0jj
 0qoltlUWQ7qgCY0O7TqRVIo=
X-Google-Smtp-Source: ABdhPJwVp2KOKEj883qYT2YGu2xCzmynFlmMmK1IyDDOVzrM4whrlxh+1LXQEXnZ60FjiOR44X4s0Q==
X-Received: by 2002:a05:600c:1986:: with SMTP id
 t6mr5394705wmq.93.1611953857393; 
 Fri, 29 Jan 2021 12:57:37 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id f6sm11076831wmq.33.2021.01.29.12.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 12:57:36 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
 <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
 <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
Date: Fri, 29 Jan 2021 12:57:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_155738_670416_FF1AA4BC 
X-CRM114-Status: GOOD (  12.30  )
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


>>> But I'm not quite following you here, because this option is about
>>> keeping controllers up after the monitor exits. Given that the
>>> monitor
>>> would be the instance that receives the AENs and acts upon them,
>>> what's
>>> the point of keeping them alive after it has terminated?
>>
>> It may run again at some point.
>>
> 
> If it does, it will recreate discovery controllers for every
> host_traddr/traddr/trsvcid tuple it finds. "--keep" semantics are only
> necessary for addresses on which no regular (non-discovery) connection
> exists.

Wait, Maybe I'm missing something here, but are you saying that for
every traddr/trsvcid it finds (both nvm and discovery) it will attempt
to connect a discovery controller?

If so, this is absolutely wrong.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
