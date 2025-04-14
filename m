Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCABC369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 20:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2LkNKoJc272ydRzthwkmkOA8tAzFNblF5gb1AnCUMY=; b=w54YH9sdF17keRS/LwioP0pNNO
	NJOvtPBxvXpirEccUCh69JDldn3yDuQfS7xq8cnXmlwHT9ksJ6FNAwqaP/gKzJ/7MLc6eTlhXTKpD
	PvKqfOX6oPicQ7h66yzYS0AjScyF5a26Q6idXhmW+rufdyZgKnQoGdd2iJADUyx48845fEHyH8qgQ
	SmMLl9g5fyQp/MBCORRUwi3ErYJK14BXtdkS7wZH5FvhxAal+O24RQWlyhlWupwfcxnbN5bKbj3P7
	kz/yMMS2ZzTalTRGPQGBeDAefcCZrqp2rc3Mhbx9+2Asl/FK7lfC1TOPM17FsvHHr8/C2D3PxlzSA
	d36+PfkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QMW-00000003SBu-24xl;
	Mon, 14 Apr 2025 20:25:00 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4QMT-00000003SBR-0WnQ
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 20:24:58 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so7316701a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 13:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662295; x=1745267095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2LkNKoJc272ydRzthwkmkOA8tAzFNblF5gb1AnCUMY=;
        b=PnGkbiZYIPh4jw/RPUL5FYTfWLpekAGGfJ8AP7ocrReY04eOqQkujzbissOcmtMet7
         Grv7w+zPF5+Ff9z+NrHyfDTHtFLFS0qyf1FIxZHbeAycOzr+jnjEhofzEsvxRpZ5VVWz
         CSx65ldGCQrrOABEn/G7v8s/DhSv23Oelcif9DSEBDEMt4jaOiXSTMkyxCwo47W1tdLh
         qCXSXFbiz4rMbmM+t/x+2QVIwiBMV7Oe2hQWsH4HhrjPhLyDWWOF87LgllcGjfhk0VTn
         Y5nO5aUV/89y63pcWIcUavY7oUwuMN1AN7yUBpNF2FsQcokwTH1K4xlT9VIcmykh6j+b
         A1jw==
X-Forwarded-Encrypted: i=1; AJvYcCXCW5imUXS8id5g1Axmgi8yuiQnRnLvkZwpFCmUsd1jcd7sbU+xfo8qRhxOArKiVx5IqLX2bybgG9xJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yw21TUbUgIhDVOXiWi5EzWl/nw1LiGyHfp873JGTMYEQL1EfLXd
	X7fkBUbDp6CO3vFBD6Kj++OWTVs4Zn3PhQzaMpIdzhIhbRzBe28e
X-Gm-Gg: ASbGnctvZ7Tbh/JQjx6qwE1RRU9mLW6Ihn7tOuWQW67bDNG5kXIvY7v8UFbyHPWqCCd
	3ZubHSijsuYIohAF7TACkrHCkdxohgtYILScMQ1RFheGn8oCrhy9wFirS4MVd0MF1TnBEEgBpeG
	NsdVj7/sKYE/YT4u/LMp7oRG30X8cSbbaDlb3z8ILWcHqBURNLIKrYKcBRc5hSwEP4ve2H6/ey3
	S0zZdWp+Rq5VPpjAz9zY7UQlqV+EfgRG76E+YNnHv6/nNzZoAME6Uc9XJw03DwmjOurrBXrMuLe
	Da+kQCQSjW3YSiddQgslCNC+ifHsXdvn8FP8wKqZaMDiSAXqvxILtPOFHRri3stzykQufpEc
X-Google-Smtp-Source: AGHT+IHxohZGmSZaj8ggXot0Fybgw4bB7sItRPJMrEy7ou0tonrSVQMKuZ80+8w13XGkrJdYQ6BPtQ==
X-Received: by 2002:a05:6402:3508:b0:5e8:bdb4:2891 with SMTP id 4fb4d7f45d1cf-5f36fefd97cmr10803175a12.30.1744662295123;
        Mon, 14 Apr 2025 13:24:55 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef56e61sm5450346a12.23.2025.04.14.13.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 13:24:54 -0700 (PDT)
Message-ID: <1dc5d8ca-fed8-47f4-80f1-cd2a404384fd@grimberg.me>
Date: Mon, 14 Apr 2025 23:24:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <ee4379d7-53f8-4399-ba94-be9113b11b48@grimberg.me>
 <09aca7f3-4911-4a6f-a49d-25da590bf8c6@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <09aca7f3-4911-4a6f-a49d-25da590bf8c6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_132457_163706_412C89FD 
X-CRM114-Status: GOOD (  24.77  )
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



On 14/04/2025 9:21, Hannes Reinecke wrote:
> On 4/14/25 01:09, Sagi Grimberg wrote:
>>
>>
>> On 03/04/2025 9:55, Hannes Reinecke wrote:
>>> When the socket is busy processing nvme_tcp_try_recv() might
>>> return -EAGAIN, but this doesn't automatically imply that
>>> the sending side is blocked, too.
>>> So check if there are pending requests once nvme_tcp_try_recv()
>>> returns -EAGAIN and continue with the sending loop to avoid
>>> I/O stalls.
>>>
>>> Acked-by: Chris Leech <cleech@redhat.com>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 1a319cb86453..87f1d7a4ea06 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1389,9 +1389,12 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>           result = nvme_tcp_try_recv(queue);
>>>           if (result > 0)
>>>               pending = true;
>>> -        else if (unlikely(result < 0))
>>> +        else if (unlikely(result < 0) && result != -EAGAIN)
>>>               return;
>>
>> The way that the send path was done - is that EAGAIN returns 0 
>> (success returns >0, failure returns <0)
>> Perhaps we can make recv do the same?
>>
> I guess we can.
>
>>> +        if (nvme_tcp_queue_has_pending(queue))
>>> +            pending = true;
>>> +
>>
>> Something is not clear to me, this suggest that try_send was not able 
>> to send data on the socket, shouldn't a .write_space() callback wake 
>> you when
> > the socket send buffer gets some space? Why> do you immediately try 
> more even if you're sendmsg is returning EAGAIN?
>>
> But that's precisely the point: sendmsg() did _not_ return -EAGAIN.
> recvmsg() did.

What did try_send return? Why didn't it set pending?

>
>
> We just imply that nvme_tcp_try_send() will return -EAGAIN once 
> nvme_tcp_try_recv() did.
>
> Which is wrong; -EAGAIN on reception can be due to a number of factors,
> and does _not_ imply in any shape or form that sending will exhibit
> the same error.

I get that recv returning EAGAIN, we should not return from io_work(). 
The second check
is not clear to me. If try_recv got stuff, we set pending=1, if try_send 
was able to send, we set
pending=1. They should be independent. Why is this check in the end of 
the loop correct.

It can be that the queue has pending requests, but there is no room in 
the socket send buffer,
otherwise, it would have set pending=1 no?

I am missing something.

