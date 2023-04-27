Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D768C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Uxca9pe/yGj61Xn7b0qdaKHJXvzXZBitlFHQ2EJ9gg=; b=nVon9/plN3tCiLbyHHz0YrTJAU
	GbL2pQHSqYYt38WDRNyaCTqmmBayPGVejlOusWVzFBUJi/Qq9dLS06Lul/tul7XYb3pO+cpMSVmVl
	suSluHcpIP8uc0vW2edBkUij+KNvojXgCIAwDNqS3O4eg1O3T7lLMTSThC+qXOeLy1/y8ph6i6pOl
	QQy72rq7j3/koxMUmUco8iLw5qkSlUWpWSs3g7a6N6RgI934iuje9PMtG5dbmb4CLbecUxJjVthOh
	EiYhB7/6b4XNgpqhDduzUtvpgrRelm89RqdJgIGX2u/EuQy/5F+hZv1oNdwnc2EVJPOj7SkXVqhP2
	fiGYbodg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0TE-006UX5-1H;
	Thu, 27 Apr 2023 12:11:32 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps0TB-006UUV-0d
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 12:11:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-2f94fe993edso880247f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 05:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597487; x=1685189487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uxca9pe/yGj61Xn7b0qdaKHJXvzXZBitlFHQ2EJ9gg=;
        b=ENa2Irj92HOkti217gv46mHAGUXJK+NiEvRAOHi4MEX2YzUuU4iXE86qIa4/xgPS8p
         b3mrSBCF/5UzjUWwBv3BhKitqoYgrTdv5bz9z+pY+d1s+nTLeaWmCZKMLjLoDKdNYAb0
         Fm3UzDID2j8mj+iWPvvmRyEz44ADQKaJz+jP8jFdRTvo7z1D+iSXiHRpFJWKKrguXyf8
         rFszU0cXZDQz8lMTNgcqd6/a+6FeFMg3ykvNuWTnixDP4+KT+Q+5tGxYhGiz+05WG6pe
         t0arh4uiWHt4Q5XHl8WAeRO7OEJBUDCkm9pSAI3jQ5066lQZTWEkdkUJg5GnI6pU4SSz
         KcTg==
X-Gm-Message-State: AC+VfDwiQAsE3nxCe0sXr8y+Pm90fJTp1hXBLxfzu9NhuM0V6FB7doiZ
	A9j9igJfiYA71rkBJ7WzANE=
X-Google-Smtp-Source: ACHHUZ7T+CF99CWVFJwXPakc8HIfF+FoSAfxQMp9U3Ks3QprWHCOwT1Ng0PXhjS5LNYHLzCSURsqPA==
X-Received: by 2002:adf:f349:0:b0:2ef:9699:f906 with SMTP id e9-20020adff349000000b002ef9699f906mr1036242wrp.7.1682597487098;
        Thu, 27 Apr 2023 05:11:27 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e8-20020adfdbc8000000b003047d5b8817sm9370339wrj.80.2023.04.27.05.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:11:26 -0700 (PDT)
Message-ID: <4517d754-1594-9913-cf7f-da58a7cb23a8@grimberg.me>
Date: Thu, 27 Apr 2023 15:11:25 +0300
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
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
 <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_051129_239879_93629F4B 
X-CRM114-Status: GOOD (  28.04  )
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


> Hi Sagi,
> 
> On Wed, Apr 19, 2023 at 5:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>>>> Hey Li,
>>>>
>>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>>> have a bad performance.
>>>>> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
>>>>> socket worker threads.  The parameter is a comma separated list of CPU
>>>>> numbers.  The list is parsed and the resulting cpumask is used to set the
>>>>> affinity of the socket worker threads.  If the list is empty or the
>>>>> parsing fails, the default affinity is used.
>>>>
>>>> I can see how this may benefit a specific set of workloads, but I have a
>>>> few issues with this.
>>>>
>>>> - This is exposing a user interface for something that is really
>>>> internal to the driver.
>>>>
>>>> - This is something that can be misleading and could be tricky to get
>>>> right, my concern is that this would only benefit a very niche case.
>>> Our storage products needs this feature~
>>> If the user doesn’t know what this is, they can keep it default, so I thinks this is
>>> not unacceptable.
>>
>> It doesn't work like that. A user interface is not something exposed to
>> a specific consumer.
>>
>>>> - If the setting should exist, it should not be global.
>>> V2 has fixed it.
>>>>
>>>> - I prefer not to introduce new modparams.
>>>>
>>>> - I'd prefer to find a way to support your use-case without introducing
>>>> a config knob for it.
>>>>
>>> I’m looking forward to it.
>>
>> If you change queue_work_on to queue_work, ignoring the io_cpu, does it
>> address your problem?
> Sorry for the late response, I just got my machine back.
> Replace the queue_work_on to queue_work, looks like it has a little
> good performance.
> The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
> 90('cpus_allowed=90'),
> I don't know why the worker 56 is selected.
> The performance of 256k read up from 1.15GB/s to 1.35GB/s.

The question becomes what would be the impact for multi-threaded
workloads and different NIC/CPU/App placements... This is the
tricky part of touching this stuff.

>> Not saying that this should be a solution though.
>>
>> How many queues does your controller support that you happen to use
>> queue 0 ?
> Our controller only support one io queue currently.

I don't think I ever heard of a fabrics controller that supports
a single io queue.

>>
>> Also, what happens if you don't pin your process to a specific cpu, does
>> that change anything?
> If I don't pin the cpu, the performance has no effect.

Which again, makes this optimization point a niche.

