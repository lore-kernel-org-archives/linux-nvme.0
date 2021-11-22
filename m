Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E8EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2p0Anl/Hp40Z+kJU8iVohVkBOqdp10wLUJBBQgkwUxw=; b=1/o3zPI4NR2aCwJtGPekWWTNVQ
	bxDsGXktqYLj49kA7UIe2maDHfrhEAy+E/Gja720PlUFelCviZVDNcIVCDPp0sMvBSpz7JZ/Bjp9Y
	MKjcv0VADrgMlsKgjRTZ9DRQPz3S3OlJINJXUxp25W8xf7viSLkbu4YhapJZh1vRl4lfDNE9U3U+r
	nBzWCdSb0AKTC0ia7FAGH9O/hkS37pmyy4C1MACvuNIwJOGTi8lcn0/5eLXy3sjycmFaYoI386SXn
	MJBK1aHILZPS8nBOZOi0aU5U0HvtWl6LBofaGE/PRnaA4RbhUcmoL/cDAzsxGgZii4ez35YUySNsX
	WTX5m1mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5ig-00FcIl-MG; Mon, 22 Nov 2021 09:34:38 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4FO-00FCCr-Ok
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 08:00:20 +0000
Received: by mail-wr1-f52.google.com with SMTP id a9so30993750wrr.8
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 00:00:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2p0Anl/Hp40Z+kJU8iVohVkBOqdp10wLUJBBQgkwUxw=;
 b=qMr9E8IRy5+d/Z2YsEh8upzw/Sn/nF+hdaMKSAQu6Yg2QDqkpwZge+MtFHgKq7VOOI
 84IGfMoFlsf/vcKBn8k2o6Kt3noa5jrNABYxn2IQC04AXXHl8DmcPQHB2YbXqDATKC4n
 ktSmPB+DFHMywlVlPri13G7LPOvGZ6jLsywMgXWEzyYfvLEemY1h+QmiH5fl4KFg9Jmt
 hQFnfa7xj66GNYPkIrbeshJbIE7gA7WOeWdm5SJU7S19Pi96SHOV4uXYS67nIJwHa18l
 SYJe5uIU5vqAcErv7bBr7OC7SHXJi06jdv86nIlfkTLGW0RP4k6YwxkCaujHOs2JuorP
 mfEA==
X-Gm-Message-State: AOAM531t8PclEE5MXTXOX+7Rc1xnXtNEO9FrD+xKIrJxy+t9QJzkkzSM
 pTAVRGnMkeQHO3g2hXVq+ssfUrlhzIc=
X-Google-Smtp-Source: ABdhPJw7NiOcUuKogho041u6gxFJakYmXYz6ZpubZXkXzNXvTRi1noobcFgC7NR0ahrcqxS/2BuXZw==
X-Received: by 2002:adf:e7cf:: with SMTP id e15mr35553803wrn.287.1637568016730; 
 Mon, 22 Nov 2021 00:00:16 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g13sm10637911wrd.57.2021.11.22.00.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 00:00:16 -0800 (PST)
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
From: Sagi Grimberg <sagi@grimberg.me>
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
Message-ID: <b642d5bb-de39-905f-0e12-991ef50ec75d@grimberg.me>
Date: Mon, 22 Nov 2021 10:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_000018_855307_6AF06B77 
X-CRM114-Status: GOOD (  19.61  )
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



On 11/22/21 9:56 AM, Sagi Grimberg wrote:
> 
>> Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
>> queues in parallel, then we can just wait once if global quiesce wait
>> is allowed.
> 
> blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
> obviously it has a scope.
> 
> 
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> ---
>>   include/linux/blk-mq.h | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 5cc7fc1ea863..a9fecda2507e 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -777,6 +777,19 @@ static inline bool blk_mq_add_to_batch(struct 
>> request *req,
>>       return true;
>>   }
>> +/*
>> + * If the queue has allocated & used srcu to quiesce queue, quiesce 
>> wait is
>> + * done via the synchronize_srcu(q->rcu), otherwise it is done via 
>> global
>> + * synchronize_rcu().
>> + *
>> + * This helper can help us to support quiescing queue in parallel, so 
>> just
>> + * one quiesce wait is enough if global quiesce wait is allowed.
>> + */
>> +static inline bool blk_mq_global_quiesce_wait(struct request_queue *q)
>> +{
>> +    return !q->alloc_srcu;

	return !q->srcu ?

