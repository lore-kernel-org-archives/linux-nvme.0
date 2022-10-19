Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4283DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EvVWhk/BBaku1ZpMDQOh5RR4YdPhYTMo8mECNdmaEzA=; b=d/geeHUCgUF2bwXN4q8oj+CJ7R
	y5jveQkRjHFh8HTrq0BpWOV/LMaLu8oPS82uLD7P9BdMamP/YHOSQXBthgLqF3w3JsdxU2PyKrJG+
	hoHOyvYDVqUQv/8Thf7uwGejdiAHppLYq6tlwAJDOR3h4/5nrq1TTVjMAVL3hgRUVBuWYmoOcNmtI
	JdPaS/4ez8y345vTQ685GeU4bHYaMnPjyP1QXayV9EqUaXJYi8XrYgrqJDbK/P4VNCrPYSDlxRd9W
	HPvOXaNdZo83up+9RRQ9yDPKvJISIoYoLHH7boyM+UqXwcY7kDC6hUFbtDSPEOSCFtrvnCBfTCSdi
	WMTaUlsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3Ik-00G5oy-1H; Wed, 19 Oct 2022 07:15:42 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3Ig-00G5m3-34
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:15:40 +0000
Received: by mail-wm1-f46.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so13931388wmq.4
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 00:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvVWhk/BBaku1ZpMDQOh5RR4YdPhYTMo8mECNdmaEzA=;
        b=uhKpgMNt9oXlzK1vCNuJyWeWVd/TrBF2meAgXRMrYJKDlQoYtiX9M+Sz+AZxQMNUnv
         MCE8WMV52IUXptS8mBaq3RS/UTb/dG9qacGt1xQDGyeduz0p9mJoHQ+wZnt6sPcrQAQC
         OxTQOgu+Z/R8WJrhrasn7ug09T/mTCkwxT46nugMSGO8QSqE0L8zBOsNrTubHcJon8bc
         hdQclUNJdaonvsrCu9KZqXt3P+qWRnLQLz7Lw8oNdofMAlWyKyCRSonkLifawS7Izfzd
         qPnk9YP6BitUAomIriHNx9yaIsC8a6X5Xbcgm/op5I2ecMyigsnzZGDIEXYXgOTOapP0
         quPg==
X-Gm-Message-State: ACrzQf1cZAbEMEK7iZGk2w+8I9nSlyRGWpJgl/YMrLuCHZ0P+LA2HDa0
	RtOrqumP5vk8ehLq9zknoco=
X-Google-Smtp-Source: AMsMyM5l42PXh4XxSQ3VMjZQsW+o5W0El0fbSviQq+qtnJ4ULUpcN7CX8KvH06cNK+tOcZUCEr6qug==
X-Received: by 2002:a05:600c:4448:b0:3c6:fb65:2462 with SMTP id v8-20020a05600c444800b003c6fb652462mr4464065wmn.39.1666163728309;
        Wed, 19 Oct 2022 00:15:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b002206203ed3dsm12973900wrs.29.2022.10.19.00.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:15:27 -0700 (PDT)
Message-ID: <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
Date: Wed, 19 Oct 2022 10:15:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y09GROYqk3FMM21W@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_001539_033484_2FE01D97 
X-CRM114-Status: GOOD (  22.70  )
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


>>> Then the big question is "how long do the SRCU readers run?"
>>>
>>> If all of the readers ran for exactly the same duration, there would be
>>> little point in having more than one srcu_struct.
>>
>> The SRCU readers are the I/O dispatch, which will have quite similar
>> runtimes for the different queues.
>>
>>> If the kernel knew up front how long the SRCU readers for a given entry
>>> would run, it could provide an srcu_struct structure for each duration.
>>> For a (fanciful) example, you could have one srcu_struct structure for
>>> SSDs, another for rotating rust, a third for LAN-attached storage, and
>>> a fourth for WAN-attached storage.  Maybe a fifth for lunar-based storage.
>>
>> All the different request_queues in a tag_set are for the same device.
>> There might be some corner cases like storare arrays where they have
>> different latencies.  But we're not even waiting for the I/O completion
>> here, this just protects the submission.
>>
>>> Does that help, or am I off in the weeds here?
>>
>> I think this was very helpful, and at least to be moving the srcu_struct
>> to the tag_set sounds like a good idea to explore.
>>
>> Ming, anything I might have missed?
> 
> I think it is fine to move it to tag_set, this way could simplify a
> lot.
> 
> The effect could be that blk_mq_quiesce_queue() becomes a little
> slow, but it is always in slow path, and synchronize_srcu() won't
> wait new read-side critical-section.
> 
> Just one corner case, in case of BLK_MQ_F_BLOCKING, is there any such driver
> which may block too long in ->queue_rq() sometime? such as wait for dozens
> of seconds.

nvme-tcp will opportunistically try a network send directly from
.queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.

nbd though can block in .queue_rq() with blocking network sends, however
afaict nbd allocates a tagset per nbd_device, and also a request_queue
per device, so its effectively the same if the srcu is in the tagset or
in the request_queue.

