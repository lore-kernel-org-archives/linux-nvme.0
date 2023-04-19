Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A9C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5a1BeLDyhZNZilZ/KK2GAKnGHlOBBbp1X8Ya2E3EHwU=; b=YorNd8DuB8cMG2F+3I5MuJrM2A
	SRNlcS1ZH2kcEgbvAF3gP6P7IVfYsY+lXQgLyh78VelkIRPrhoAb9b85r+Jr4d8WHVvrNgnVc4t5d
	0SshihrRmuF9C9XZw7+NWpbUJxVXdOSG9e/4A181e2JQOayRTanKbC5XRNk0mjgtwY/Rf4tEebCJX
	tWh97dklAhsE9c6LFw00Dv276CJcA9BsItpN/raeM4iYvc+qDDAKQUza8/BTFpDjoczjFfwCayxI+
	hyKeQvmYTySvlDor65iLHcQBEEENT2lkbFugutrhmTW04L4rK4Vw3rwBoa2KVgaK3vh6tyi9t6U45
	bqSU0/CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4Au-004kWt-1G;
	Wed, 19 Apr 2023 09:32:28 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4Ar-004kVs-2U
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:32:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so13977115e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896744; x=1684488744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5a1BeLDyhZNZilZ/KK2GAKnGHlOBBbp1X8Ya2E3EHwU=;
        b=JkM2QXr3grDOfRG4t79rEhKjjeswTORzrZFs4B8ZGFE48CmleNrzq0yTFvjCrhwXGQ
         LIbbsFxtMP2Qp0tLYPlI5F6SbzA4NtQtKqV3ug98CtGhEP9gLMXJkjZ7/sjx+nYbqSys
         7JEZ11bW28mHt4gnmAoqyG7MFkn28I99UXLHoNswc2mTpdmG1OJVFMLJ0G653Mr1ua85
         OqRVssrfHvNSBsttvdYFCC8qYA5ZLRaw2btMskAICUi1v87buKDlyJuOR/ycxvaihmqB
         2v+JiEmjnFH5qqBeS+MIcMWF6M/QL5gPhCo/ti4FhNbvrT1zx+7uICw17XddFODSBOYf
         pXrA==
X-Gm-Message-State: AAQBX9dL3Pwnos4uIWFMENSTTlFla0YbofTMddytXl1NHisfeAMqSCrw
	LXrxMAcHPQEbBQwFudSIVPE=
X-Google-Smtp-Source: AKy350bvi3g5YtM/nCwPxpFZIzGbqVFhyRT4L17VakLrN1VwX/A9A90OQPmROaptfGqwrGiPG+6evw==
X-Received: by 2002:a05:600c:4ece:b0:3f1:7a4b:bf17 with SMTP id g14-20020a05600c4ece00b003f17a4bbf17mr4120868wmq.1.1681896744341;
        Wed, 19 Apr 2023 02:32:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m12-20020a7bca4c000000b003f173419e7asm1554214wml.43.2023.04.19.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:32:24 -0700 (PDT)
Message-ID: <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
Date: Wed, 19 Apr 2023 12:32:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To: Li Feng <fengli@smartx.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_023225_808224_7F429A53 
X-CRM114-Status: GOOD (  23.09  )
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


>> Hey Li,
>>
>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>> have a bad performance.
>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>> socket worker threads.  The parameter is a comma separated list of CPU
>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>> affinity of the socket worker threads.  If the list is empty or the
>>> parsing fails, the default affinity is used.
>>
>> I can see how this may benefit a specific set of workloads, but I have a
>> few issues with this.
>>
>> - This is exposing a user interface for something that is really
>> internal to the driver.
>>
>> - This is something that can be misleading and could be tricky to get
>> right, my concern is that this would only benefit a very niche case.
> Our storage products needs this feature~
> If the user doesn’t know what this is, they can keep it default, so I thinks this is
> not unacceptable.

It doesn't work like that. A user interface is not something exposed to
a specific consumer.

>> - If the setting should exist, it should not be global.
> V2 has fixed it.
>>
>> - I prefer not to introduce new modparams.
>>
>> - I'd prefer to find a way to support your use-case without introducing
>> a config knob for it.
>>
> I’m looking forward to it.

If you change queue_work_on to queue_work, ignoring the io_cpu, does it
address your problem?

Not saying that this should be a solution though.

How many queues does your controller support that you happen to use
queue 0 ?

Also, what happens if you don't pin your process to a specific cpu, does
that change anything?

