Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03808C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9DdaLlqFZ5Pr37b+RVdD4qdIRmEBx2b/qz7J0papOo=; b=Vc3qX6FHaeDapkVprS8lGEwa3G
	sGsevZse1/nYDlOLfZeKyHdf7HMdD8fyD6egdk2tOHtpcb50/Jtv+AeWNPvId54uVU7VG/Q/QKt+n
	r2APc0PYGDRLhvqK6Yj62gfDSBeN48gMfbq2jRAWYh9v7i3tdoYwew6YD9GIvCZ0T6HJEWKpi0jkS
	s0IxiaEWr5bJHk0WnsbqYjQMFx9PQ48LBYHEK+5WqKQy+NecI97XH88VS0Y2EyDuQS+IGhdJGOdL7
	/ZT+EWvU1XOJ+wRY4BX7b3G5aGkU+WKXJL53fv6HtvmX2DkehrqMqDTHT0r6MAaiSCSy/40IH3iQm
	W0JSmAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXcp-00000008oOp-3yV3;
	Fri, 08 Mar 2024 10:38:51 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riXcm-00000008oN2-1Z5t
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 10:38:50 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33db19538d0so457573f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 02:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894327; x=1710499127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9DdaLlqFZ5Pr37b+RVdD4qdIRmEBx2b/qz7J0papOo=;
        b=eDEmDiVRWX+MJb3CKssNfh1EuAWHyVzSIhBPovJPhQIvQG0YFX5OHeAqp6Z6wMiXRi
         JTWEztaQnPfiiQxAYhFhBFe7eflyhnDaKMk0WsBoIsDglLfKgaRqklMHRt5fb+OS8H8g
         MxlxfBsIGjWtXKaw6aqS5TQUIp4iJP9X1lrG0C62ZnOwrS15G14ZkjOpAuZG4P4SpWZI
         vLdcQA/lmjyjnnIiz8zAyEHMlsRIkv24dFaU+RfBd0R/WJPUUx7lyKhSOpJfjeg6/b/G
         ulxgGfcghTtngR8Tlob8FHgN91/e1jNwOBrgQ8N0ixMdfvAweDHoUWIKRgQXlDdIsqcT
         mWCw==
X-Forwarded-Encrypted: i=1; AJvYcCXfXKVZ2hzVYqnGaTcGqoOJUpPpzghAjwM42hzo6TmZNC1ZomROVY6Mffqbd7EXBx5/nYZum3BMfsk9pJPV8KtJ1sJwPGC7C1hU3EXc+6E=
X-Gm-Message-State: AOJu0YzS0/kQZMf7X+DL5lbnRQngnMmcO3BTO5U1C7i3j6eXwYs+I6tU
	/ZTWxz+RBntiGa4W2Wmk3l54fO6BFpsMj1afdojjBlcvkkAFEb8wqpdOmv6M
X-Google-Smtp-Source: AGHT+IHqoDhk7C8TgEawgARK+27E9PwUyHJu3u3cDnCr70B3ZfQ1u0Thi05yFIXcF58HnCS1NxRhIw==
X-Received: by 2002:a05:6000:11:b0:33e:70a0:40e6 with SMTP id h17-20020a056000001100b0033e70a040e6mr1141532wrx.6.1709894326664;
        Fri, 08 Mar 2024 02:38:46 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id d30-20020adfa35e000000b0033e79d81b7asm410593wrb.62.2024.03.08.02.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:38:46 -0800 (PST)
Message-ID: <2b0bdbfb-1bff-405a-8f95-163a99022d94@grimberg.me>
Date: Fri, 8 Mar 2024 12:38:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-fc: FPIN link integrity handling
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240219085929.31255-1-hare@kernel.org>
 <1dfa9a4e-e4a2-4d48-b569-85e48ce4311c@grimberg.me>
 <1c3eea31-b80f-4b95-ab15-ac42f7c45c16@suse.de>
 <7ff7c9cc-6b02-4adc-9b78-8bab26341049@grimberg.me>
 <0b18f1f9-5011-46f4-a0a1-a69cd54bfc88@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0b18f1f9-5011-46f4-a0a1-a69cd54bfc88@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_023848_492933_819273A8 
X-CRM114-Status: GOOD (  28.52  )
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



On 07/03/2024 14:13, Hannes Reinecke wrote:
> On 3/7/24 13:01, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 13:29, Hannes Reinecke wrote:
>>> On 3/7/24 11:10, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 19/02/2024 10:59, hare@kernel.org wrote:
>>>>> From: Hannes Reinecke <hare@suse.de>
>>>>>
>>>>> FPIN LI (link integrity) messages are received when the attached
>>>>> fabric detects hardware errors. In response to these messages the
>>>>> affected ports should not be used for I/O, and only put back into
>>>>> service once the ports had been reset as then the hardware might
>>>>> have been replaced.
>>>>
>>>> Does this mean it cannot service any type of communication over
>>>> the wire?
>>>>
>>> It means that the service is impacted, and communication cannot be 
>>> guaranteed (CRC errors, packet loss, you name it).
>>> So the link should be taken out of service until it's been (manually)
>>> replaced.
>>
>> OK, that's what I assumed.
>>
>>>
>>>>> This patch adds a new controller flag 'NVME_CTRL_TRANSPORT_BLOCKED'
>>>>> which will be checked during multipath path selection, causing the
>>>>> path to be skipped.
>>>>
>>>> While this looks sensible to me, it also looks like this introduces 
>>>> a ctrl state
>>>> outside of ctrl->state... Wouldn't it make sense to move the 
>>>> controller to
>>>> NVME_CTRL_DEAD ? or is it not a terminal state?
>>>>
>>> Actually, I was trying to model it alongside the 
>>> 'devloss_tmo'/'fast_io_fail' mechanism we have in SCSI.
>>> Technically the controller is still present, it's just that we 
>>> shouldn't
>>> send I/O to it.
>>
>> Sounds like a dead controller to me.
>>
> Sort of, yes.
>
>>> And I'd rather not disconnect here as we're trying to
>>> do an autoconnect on FC, so manually disconnect would interfere with
>>> that and we probably end in a death spiral doing disconnect/reconnect.
>>
>> I suggested just transitioning the state to DEAD... Not sure how 
>> keep-alives behave though...
>>
> Hmm. The state machine has the transition LIVE->DELETING->DEAD,
> ie a dead controller is on the way out, with all resources being
> reclaimed.
>
> A direct transition would pretty much violate that.
> If we were going that way I'd prefer to have another state
> ('IMPACTED' ? 'LIVE_NOIO' ?) with the transitions
> LIVE->IMPACTED->DELETING->DEAD
>
>>>
>>> We could 'elevate' it to a new controller state, but wasn't sure how 
>>> big
>>> an appetite there is. And we already have flags like 'stopped' which
>>> seem to fall into the same category.
>>
>> stopped is different because it is not used to determine if it is 
>> capable
>> for IO (admin or io queues). Hence it is ok to be a flag.
>>
> Okay.
>
> So yeah, we could introduce a new state, but I guess a direct transition
> to 'DEAD' is not really a good idea.

How common do you think this state would be? On the one hand, having a 
generic
state that the transport is kept a live but simply refuses to accept I/O 
sounds like
a generic state, but I can't think of an equivalent in the other transports.

If this is something that is private to FC, perhaps the right way is to 
add a flag
for it that only fc sets, and when a second usage of it appears, we 
promote it
to a proper controller state. Thoughts?

