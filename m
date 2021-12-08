Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBC2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYH/sRLBPleRFcKivJ4eo0TXpFe+PUcyhNxulaKbV2g=; b=U1/BTNV2o/O9E9x5OMoZit1tSv
	xaEuZZy4ARZXi7oSbYzNK6Kj+6UWLQ33FpH7VwH02vYPgvV6lDqB4PNyFSGjfEA//LXWWEbDJWfQg
	vS8w14RG7Gmb2DevhoT+AQJo5yyegA7NS7NM7QmJKhV9lElCYAxwbQ9vN3CiFhIu6WNVSLu6fUvBG
	prD5SdJeuhCPuqtCwpyS3kb6sTL8kzyaHzlm+F2n627WCNasS/pbeMkORPwYoBgW0gWY4NwTu9VLM
	f2KR5PRKlTazUmTsPOL/D7O2P0PVccZydw92TJz9vGUOJzF5qODyHmHcDqXLI5DqcVBap18BJIYNx
	zgyF9VXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muwOD-00CaWP-Qp; Wed, 08 Dec 2021 12:49:41 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwO6-00CaSh-5U
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 12:49:35 +0000
Received: by mail-wr1-f51.google.com with SMTP id t18so3856056wrg.11
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 04:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FYH/sRLBPleRFcKivJ4eo0TXpFe+PUcyhNxulaKbV2g=;
 b=3WfiAiqhdweN/X08pYm10t6J/uar45Ceh0WbZJFeDQcxHDt9HGeVVZXcHDwO2Yyo6g
 bp7B2py4Wrs7bV0JM9YDqne/TjJDjDs0+eRiirIVoVjdB4N5ONgw9rHNqyk9NY3kk6y3
 wjvvibYGZ+Huxe3etUVHxlkj46q76eJ8+hciDbB3bF2fIq9D+K4/tt8J6YlY7NhexQs3
 WJsm0OgAJA9IABYThnLjmx3iUPwcxNRpxYbLYrToW8WiOqi2ryBFiAZgp1WWZDON6IgT
 kLXWSMfVEfKgww6gNBcX388EieOGRW+oAUe6OppBYbkfxDn2755sWhqYugPnfzxv6IBu
 2LVQ==
X-Gm-Message-State: AOAM5337git0rBhtA15z9aaapgA4YllEg14WCtCp3OW/UA5PY5idqP1k
 ftUpfxKGCig4RmyKDspq4rmReJNgmzs=
X-Google-Smtp-Source: ABdhPJwqgeHzS+IbEYPxPRtwHZ6X78/4f9whMBS/JU960T1maZxl3zWma4xGqPiC4FUDcCF7ARBw4Q==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr60754430wrv.186.1638967767449; 
 Wed, 08 Dec 2021 04:49:27 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j40sm5699863wms.19.2021.12.08.04.49.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 04:49:26 -0800 (PST)
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me> <YZuagPbZJ6CjiUNi@T590>
 <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me> <YZwzEBtFug6JEmMZ@T590>
 <a3ea006a-738b-af69-4dd5-f33444e3559d@grimberg.me> <YaWNZF3ZYWPQBSbk@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4394200f-782b-5d75-4570-79a1f63110b1@grimberg.me>
Date: Wed, 8 Dec 2021 14:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaWNZF3ZYWPQBSbk@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_044934_282551_1B660FA0 
X-CRM114-Status: GOOD (  20.43  )
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



On 11/30/21 4:33 AM, Ming Lei wrote:
> On Tue, Nov 23, 2021 at 11:00:45AM +0200, Sagi Grimberg wrote:
>>
>>>>>>> Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
>>>>>>> queues in parallel, then we can just wait once if global quiesce wait
>>>>>>> is allowed.
>>>>>>
>>>>>> blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
>>>>>> obviously it has a scope.
>>>>>
>>>>> How about blk_mq_shared_quiesce_wait()? or any suggestion?
>>>>
>>>> Shared between what?
>>>
>>> All request queues in one host-wide, both scsi and nvme has such
>>> requirement.
>>>
>>>>
>>>> Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
>>>> flag that is cleared in unquiesce? then the callers can just continue
>>>> to iterate but will only wait the rcu grace period once.
>>>
>>> Yeah, that is what these patches try to implement.
>>
>> I was suggesting to "hide" it in the interface.
>> Maybe something like:
>> --
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8799fa73ef34..627b631db1f9 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -263,14 +263,18 @@ void blk_mq_wait_quiesce_done(struct request_queue *q)
>>          unsigned int i;
>>          bool rcu = false;
>>
>> +       if (!q->has_srcu && q->quiesced)
>> +               return;
>>          queue_for_each_hw_ctx(q, hctx, i) {
>>                  if (hctx->flags & BLK_MQ_F_BLOCKING)
>>                          synchronize_srcu(hctx->srcu);
>>                  else
>>                          rcu = true;
>>          }
>> -       if (rcu)
>> +       if (rcu) {
>>                  synchronize_rcu();
>> +               q->quiesced = true;
>> +       }
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>>
>> @@ -308,6 +312,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>          } else if (!--q->quiesce_depth) {
>>                  blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>>                  run_queue = true;
>> +               q->quiesced = false;
> 
> Different request queues are passed to blk_mq_wait_quiesce_done() during
> the iteration, so marking 'quiesced' doesn't make any difference here.

I actually meant q->tag_set->quiesced, such that the flag will be
used in the tag_set reference. This way this sharing will be kept
hidden from the callers.

