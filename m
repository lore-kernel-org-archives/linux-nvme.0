Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B190C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrHnau3LEddNI1bV6JCGxIjrRrcua3o14M7tJs01tw8=; b=QljExTi7HZE9WSQ80JyVLUvrk5
	EerphJldLhDAMV/Y7lW3WeowZJuKv/84fnNcyUDDpHAwEqkoI/F88xMn5p636BUs/AAEK3Z/UvsKY
	UaBLmT17ZoOQJFAYTob29tx19tnvSmfE3gcPVKJ2aHnShTDpK0t+8eABk0no6Aw2TzFvq9eQzcPoj
	9krZJzXQMxWLJ11N7sPRb9AhulB8G6elgVpweo2r8avwI/HNMy/W/6VMAERiswZ6JDQCsFTXaoyuC
	T16Tjat87AqqgFJ+T6qzOhBStdaHiNjXZkPWRWbTGt4Z+g0s0tq5yoC8naCxkprh5+b9OK8npu+TL
	9oUFmEVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9iA-00Gjfe-SF; Mon, 22 Nov 2021 13:50:22 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9i7-00Gjcg-HU
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:50:20 +0000
Received: by mail-wm1-f45.google.com with SMTP id i12so15451601wmq.4
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 05:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MrHnau3LEddNI1bV6JCGxIjrRrcua3o14M7tJs01tw8=;
 b=zh2VW4FQLN5SMQMscHc7sQcUCk6HgElexfHBQNvuTYRxYIBVz0HXoAYBWIjexO9p/D
 j9+r9Sps3IKQ8HmzRuC7Wpst0HgTZtc2jYEbX1rCsAjlD19q13UggobqQdW5CW1thykT
 QoO7vJdjyDk0zZm/lmQyA5dMC3JIDUEbwb1tYESk3GX1rPb9csYCZjQDr2jPMIXVcYtP
 phwkFHeDmF4hzgyTyy06cEKdLAk8WNSE8npDsCObjxIZBgsrY1UHtA5fyB4sY9dvIpv+
 GAIMo21mnqAi+xRZM4qo167bUUQVIHgv2/gpexid4FrF/qgPPh/9mbMOzTKQwe33jgnG
 y62A==
X-Gm-Message-State: AOAM533xhfCN63S4uqFIRGiNQ0pZ9WN65s48aTuWV+plKyaHcdF7O9lo
 mvq6FmkewM31v1pv1Tnh+PY=
X-Google-Smtp-Source: ABdhPJyhzFR9ruJ/dWiNkF/ZZWcGkiaPHGcgbHbwYvKc3dozJihH3f0Mc6vX7BiMbzxY+QKoaRV9tg==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr29455274wmk.112.1637589015897; 
 Mon, 22 Nov 2021 05:50:15 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m2sm21401765wml.15.2021.11.22.05.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 05:50:15 -0800 (PST)
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
 <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me> <YZuZCsCIyQrc+539@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <737e0543-9b7b-4872-082c-9ea51069d57f@grimberg.me>
Date: Mon, 22 Nov 2021 15:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZuZCsCIyQrc+539@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_055019_629636_CFE767A4 
X-CRM114-Status: GOOD (  17.30  )
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



On 11/22/21 3:20 PM, Ming Lei wrote:
> On Mon, Nov 22, 2021 at 09:53:53AM +0200, Sagi Grimberg wrote:
>>
>>> -static inline void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
>>> -	__releases(hctx->srcu)
>>> +static inline void queue_unlock(struct request_queue *q, bool blocking,
>>> +		int srcu_idx)
>>> +	__releases(q->srcu)
>>>    {
>>> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>>> +	if (!blocking)
>>>    		rcu_read_unlock();
>>>    	else
>>> -		srcu_read_unlock(hctx->queue->srcu, srcu_idx);
>>> +		srcu_read_unlock(q->srcu, srcu_idx);
>>
>> Maybe instead of passing blocking bool just look at srcu_idx?
>>
>> 	if (srcu_idx < 0)
>> 		rcu_read_unlock();
>> 	else
>> 		srcu_read_unlock(q->srcu, srcu_idx);
> 
> This way needs to initialize srcu_idx in each callers.

Then look at q->has_srcu that Bart suggested?

> 
>>
>> Or look if the queue has srcu allocated?
>>
>> 	if (!q->srcu)
>> 		rcu_read_unlock();
>> 	else
>> 		srcu_read_unlock(q->srcu, srcu_idx);
> 
> This way is worse since q->srcu may involve one new cacheline fetch.
> 
> hctx->flags is always hot, so it is basically zero cost to check it.

Yea, but the interface is awkward that the caller tells the
routine how it should lock/unlock...

