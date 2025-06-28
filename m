Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED320C54ED1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Jun 2025 10:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LClUed192tILHo+/vwfpU9tbOrExqi15ULo3AzIBDm4=; b=vk4KOlq5RE8/zaHyOJTR3tS+d4
	sJekDNUxwnNRNC5iHQ8sDqTv1RomdoTJxNn7K0fx2AziLwpap01loVyN1fOxVFottPEizxn0VkAUT
	+ZOPnDYNEFR3jqlH6v95rPJCg775S6gvuVvyIXf31aNLLd6PAGwDU3lzZjkIH5hCSKAggcn1R4CQv
	NE7KAXEwYsg6H51GQXORQiHUI9xGHeEFBHG0Jg6Smuilsn6LTmbRn74sx8nw4ZXX7OD9/KisJjxwD
	meG5+vYayGRPBqlc4blHIYpQ/ikBBEn5qdZX1qZLs0AoHK419UNP8w402vAqMfOPJ4g1xTlFW0VXN
	ygEwl8HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVSjE-0000000GgWV-0Zxy;
	Sat, 28 Jun 2025 10:24:12 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVSjB-0000000GgVi-0Xs6
	for linux-nvme@lists.infradead.org;
	Sat, 28 Jun 2025 10:24:10 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1652339f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 28 Jun 2025 03:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751106247; x=1751711047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LClUed192tILHo+/vwfpU9tbOrExqi15ULo3AzIBDm4=;
        b=jGCc4HBug/wcclprqDJXoZWd2iMLxUSGs5jQq3mZXjPLYrG/15AAqiyXR6pi59nPTw
         6aDgcr/6KDAwxvKjWgveJS4LK3zqCAg+pNSR9VFXpZQMXpisnrOqqcW4pJojYgkvnR71
         Qv0WkITIeJEGTa3I213L63HS+zWeRdRSGlcaYTlK3vMusSMdpuuW7eKnnT2YTI/RMGL3
         cAnTjHf2eauRROdxLEcwzg4wrtwgul7f0omxEwR1JoXgH2KPIq7TGocinbQRBXmTaxmt
         77WSrQNM4u2nBo1FH2e33zTxj2hxQS+Elzoh2vXEla8JFHggXHSSEskgHocdYSU2gJNg
         KFoQ==
X-Gm-Message-State: AOJu0YzPo0Z1880cGvyv9WC7hsLW8IKqsWH7lD48xASyxnOIrFXMe30i
	CDm704fA11xzYhRTKg37YXpNgvm0g5o+4wSiFVe2xSgqeAxzz11HPvQmw0eSow==
X-Gm-Gg: ASbGncs7ou1dF7RSZgT3ScbCfj0HdOBRcqdeX1KAmn6fOspDS0CxlhNdX7hzLd5c++j
	CviZrYuRtJ+VmdJVfvJcX/1b9VXauILloop6BqEbzQWQXIlvwqTmdljrw4LddAMaF2gtApKKHr4
	y6VzmFjDuTDCd+0wO0bs6g1ipKDIjEZjvmhiOE/8At9v6T9h8WhOs33gqzBZPIgmDVUxnFbPLZL
	ZxszwfiHLCPRMkdaWOv1YuAf/Cr+iMTJ3BNPVK2RyD9GyjHgSOZDqQy+DY6KVGq4/KG7vlwGrjZ
	kWspyt6kHmS+g+dCn2Xl74FnqNdPf2WKrfDcEny8V/ITTwovzgind8SU6FpYtHoC7Kerth2M7iq
	dv4hyMfbtD8RMyakIUpCfPLkt/0EC3dYA
X-Google-Smtp-Source: AGHT+IF5bL19Bz2cqkIHP5r+d05dZkzyqX/hGKmsQU7T9lSjmrQTh5HCl5FyPu4JrS/fhx3Ws33kjA==
X-Received: by 2002:adf:ca92:0:b0:3a4:f722:f98d with SMTP id ffacd0b85a97d-3a9008557admr4519014f8f.51.1751106247302;
        Sat, 28 Jun 2025 03:24:07 -0700 (PDT)
Received: from [10.100.102.74] (89-138-75-164.bb.netvision.net.il. [89.138.75.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e71dfsm4901565f8f.7.2025.06.28.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 03:24:07 -0700 (PDT)
Message-ID: <c66548d0-1211-4176-b698-05a36320cf94@grimberg.me>
Date: Sat, 28 Jun 2025 13:24:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
To: Ming Lei <ming.lei@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>, Hannes Reinecke
 <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, "hch@infradead.org" <hch@infradead.org>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
 <aEuviL5O2kD70Sij@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aEuviL5O2kD70Sij@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250628_032409_177312_1BFE25BF 
X-CRM114-Status: GOOD (  23.74  )
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



On 13/06/2025 7:56, Ming Lei wrote:
> On Wed, Jun 04, 2025 at 11:17:05AM +0000, Shinichiro Kawasaki wrote:
>> Cc+: Ming,
>>
>> Hi Sagi, thanks for the background explanation and the suggestion.
>>
>> On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
>> ...
>>>> This is a problem. We are flushing a work that is IO bound, which can
>>>> take a long time to complete.
>>>> Up until now, we have deliberately avoided introducing dependency
>>>> between reset forward progress
>>>> and scan work IO to completely finish.
>>>>
>>>> I would like to keep it this way.
>>>>
>>>> BTW, this is not TCP specific.
>> I see. The blktests test case nvme/063 is dedicated to tcp transport, so that's
>> why it was reported for the TCP transport.
>>
>>> blk_mq_unquiesce_queue is still very much safe to call as many times as we
>>> want.
>>> The only thing that comes in the way is this pesky WARN. How about we make
>>> it go away and have
>>> a debug print instead?
>>>
>>> My preference would be to allow nvme to unquiesce queues that were not
>>> previously quiesced (just
>>> like it historically was) instead of having to block a controller reset
>>> until the scan_work is completed (which
>>> is admin I/O dependent, and may get stuck until admin timeout, which can be
>>> changed by the user for 60
>>> minutes or something arbitrarily long btw).
>>>
>>> How about something like this patch instead:
>>> --
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index c2697db59109..74f3ad16e812 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>>>          bool run_queue = false;
>>>
>>>          spin_lock_irqsave(&q->queue_lock, flags);
>>> -       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
>>> -               ;
>>> +       if (q->quiesce_depth <= 0) {
>>> +               printk(KERN_DEBUG
>>> +                       "dev %s: unquiescing a non-quiesced queue,
>>> expected?\n",
>>> +                       q->disk ? q->disk->disk_name : "?", );
>>>          } else if (!--q->quiesce_depth) {
>>>                  blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>>>                  run_queue = true;
>>> --
>> The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
>> concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
>> ask your comment on the suggestion by Sagi?
> I think it is bad to use one standard block layer API in this unbalanced way,
> that is why WARN_ON_ONCE() is added. We shouldn't encourage driver to use
> APIs in this way.
>
> Question is why nvme have to unquiesce one non-quiesced queue?

It started before quiesce/unquiesce became an API that had to be balanced.

In this case, we are using the tagset quiesce/unquiesce interface. Which 
iterates
over the request queues from the tagset. The problem is that due to 
namespace
scanning, we may add new namespaces (and their request queues) after we
quiesced the tagset. Then when we call tagset unquiesce, we have a new 
request
queue that wasn't quiesced (added after the quiesce).

I don't mind having a BLK_FEAT_ALLOW_UNBALANCED_QUIESCE for the nvme request
queues if you don't want to blindly remove the WARN_ON.

