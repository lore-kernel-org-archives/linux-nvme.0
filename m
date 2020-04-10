Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965E1C2D0EC
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 04:08:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF82063A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 04:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rhct5uAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF82063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BydOpBvubvhsBQy7ZMJtBB++xqGguiko7LnAZNMPUWI=; b=rhct5uAQNhItaiBMWwYpyoupb
	GdAzjlLCuNaODpNte26UOncFp7gB+Uk+H2KwhTkhKCOpYmLZpJwTAgUgxW6drF+1OHnZhQn3jRU+x
	+VCbPcu3WnlkovSop14Hb8izEUF2o7/gIxnCLOa0mnlhiiHRYed1RPkzQG7zAeHxdT3fP3cgrRNkL
	4ePnQdM3Wi0OR+FnYF/cSDeeceief6XPatvEfshAWD+QckBV1h9Y9EE3qLXL44Ip+VmYxQmvtZaei
	TvWEDn/PM3t39oEgsjKr8RaLD16DuTq59PC+gtqDz23mq7gfNw8k310y7Y+4LEG/XZp4zNYut/eRE
	uyUsb+Hqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMkxQ-0006ua-O1; Fri, 10 Apr 2020 04:07:56 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMkxO-0006uB-6S
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 04:07:55 +0000
Received: by mail-wr1-f68.google.com with SMTP id v5so881594wrp.12
 for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2020 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rjnqMKpjACNRG4zndMZ5w2gglLCMygk9vAbxRPtJfHY=;
 b=rBwfQqDplkCuakzt2aE7lt+bVpRUhMCoWuSjMnzbZ27HSYftFvq/vSuigPeCzb/d/M
 LunQwzqArCXo5g2UkeVhfDfp6ZrpRTLiaBaniI8aDofOvrdPJodfawmBwMB9ghNwsbLL
 kHMGzDwz4KrzWkbhOyQWjFd/3vSZQJ0r8POxph+qA00RaBQQjY4bbvJXBtk5D1FTNCjR
 TVRcReVLrzTVXfgpoYvY6Ds2QXJKnTp+jNtrWwUhIbFn589NyZDaZ8TIR1UryNuZr1i+
 dJPCLvqBCkPVHYrH3VAmsCUf3+YL/LQ5r/t4Huz2vxZFus11h7IUL+ULLAOYfHs41YmS
 426w==
X-Gm-Message-State: AGi0PuaSZBPzdIXyYIoswzqHyDdxy8MWt+ObQVD7FitNw2sgzdlAfJGW
 iRT6GppQ0M3fcFFwAnqBa5qO6S2W
X-Google-Smtp-Source: APiQypJkq/bQu6C975jQ827I4m6cejGifsaFXkJTR5n0EycsFPn0gDgZ6IITLit+1sxOQeKxzqGnYg==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr2346899wrw.290.1586491671004; 
 Thu, 09 Apr 2020 21:07:51 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id y16sm1209679wrp.78.2020.04.09.21.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 21:07:50 -0700 (PDT)
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
 <SN6PR04MB4973BC935AE3BFD4CE874D9B86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
 <f3f226be-0bda-5d5d-69b3-a0f3478ce51e@grimberg.me>
 <SN6PR04MB4973EEEE55016BAB488C180A86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fb1ec36e-93dc-c948-aed5-dcbe45e75b3b@grimberg.me>
Date: Thu, 9 Apr 2020 21:07:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB4973EEEE55016BAB488C180A86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_210754_237632_BAE47D05 
X-CRM114-Status: GOOD (  18.07  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> But maybe it won't be such a strange thing to dedicate a maintenance
>> thread that would do stuff like this. My main issue with his is that it
>> is polling which to me seems like a band-aid really...
> 
> It is, but having a lightweight maintenance thread is very simple way
> to implement this for bdev and file

Simple at first sight, my main concern is what the impact may be...

> without involving userspace or fancy hacks.

Wouldn't call these hacks really, we have several examples of
disk resize triggering events to usespace.

> What are your concerns about polling (as in sleep() and schedule()
> calls wrt to the code)? Can you please elaborate ?

What is the right polling scheme? what is the impact on the system 
performance? What happens when you have a lot of namespaces?
I view the polling scheme a band-aid resulting for lack of event driven
infrastructure for disk resize.

>>>> I'd suggest to expose a revalidate configfs attribute and have nvmetcli
>>>> install a udev rule that triggers a write to this attribute. Balbir
>>>> already got the udev notification for disk resize (see
>>>> set_capacity_revalidate_and_notify).
>>>
>>> Okay we can do that. So you are saying generate the AEN from configs
>>> attribute.
>>
>> Yes.. that won't work for file backed namespaces though...
>>
> 
> Isn't that defeats the purpose of having a file backend which provides
> more flexibility to the user ?

We could have something that leverages fsnotify to address files...

> I think we should at least try an implementation which has global
> maintenance thread, measure the impact and then discard it before going
> to userspace.

I'm not too fond of the idea in general, but I could be convinced
otherwise. I'm interested to learn what others think.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
