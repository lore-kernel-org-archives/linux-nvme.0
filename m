Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7038C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIJpNvML3YX7uIaVTpaXASpU1f/l/qg7fPMbSwAxkus=; b=rBUMcQEgHZOARs/TYT67I5X6il
	lvlCx7Pn+BqApRMbHXGhz7oNwzO3CQZ32w+GZY65Y3x5ljdAecg7x7KqAJLUj0kcZ+FIMg//t7cJ4
	U0glYaRV30+0oLhvoGKwHoxn7ZqRji4qcL+VTsQ8wPPN3wZwjfZXS794j/baTwFYG4zYD2jwgNVOo
	gQP8WCsIRRS+5MENaEYcK3C+fqxUm18kuderH2wfyTYAxfY1XRumZRhhSOplLeug/QAkNMKbb9Dqy
	OSbZHXjMcSG5iUHWUhWqpJkWK5EPKs62aeue69dox8CZlEsKkJsDFPCZfDvoyGCGDxQ5SwJSEEQDM
	R8wSm14Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poioU-001oU2-1u;
	Tue, 18 Apr 2023 10:43:54 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poioR-001oPq-2m
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:43:53 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so11759305e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 03:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681814628; x=1684406628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIJpNvML3YX7uIaVTpaXASpU1f/l/qg7fPMbSwAxkus=;
        b=a1CgbGFcXt+RahaPI74YIWVpic0lTrS/90Yakia5QTiy+e3o9q9l4hm6+PRVTSNmK/
         F0LUaMSMbnhlzNEAn7kXdl7O/tp9CdBf6GIjRlwxmZHbGPZ4nbrwkPFANKw31Cf/N4Nd
         SoDe0s39ReaBBY5rRUsGGrIabd4vZL7/a9hMpaew06m4cR/9cm8kcuWK1q5hfqxhwJ8N
         A0v8IsmfW5qWoobRM4dj0kijrF9dGEmiMKNItb2dBFbnxXNsYsHGB+c0tFmp3Tf3UW3p
         gIsV7FSPT85o5itLQTML/83KRF3xfznOImJOMl4pYT2QaUAICojnhiFn+dLGCn2Q7yVk
         Wq8g==
X-Gm-Message-State: AAQBX9f2js7Spk9ICFpScs6sTg4HVjqC3M5iT9wYX578oe6DznZkMyNl
	okpm9B+lD8Ef0rkxImC51Do=
X-Google-Smtp-Source: AKy350Z/zDFFhCKd1myeWHAkWaXMQnNgLu7z7GgWkktTiFAuMKS99iPktIgkriL8hQ4rDdCGNEJ5nA==
X-Received: by 2002:a05:600c:3b24:b0:3f1:7490:e58e with SMTP id m36-20020a05600c3b2400b003f17490e58emr4039306wms.2.1681814627652;
        Tue, 18 Apr 2023 03:43:47 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y1-20020a1c4b01000000b003ef5f77901dsm14521986wma.45.2023.04.18.03.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:43:47 -0700 (PDT)
Message-ID: <392cfcc6-c4c7-da94-4e00-f6961c548867@grimberg.me>
Date: Tue, 18 Apr 2023 13:43:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/18] net/tls: sanitize MSG_EOR handling
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-8-hare@suse.de>
 <20af9713-8d64-77de-dfbe-e9e732776d3c@grimberg.me>
 <20230417131048.66b6b3a0@kernel.org>
 <beb7b0e8-2cb5-0c0e-63f9-6a13b9dfb787@grimberg.me>
 <db39fd2d-6da2-852e-70aa-7499fedf8b48@suse.de>
 <b313144b-f510-f3d5-6066-6123c27039ed@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b313144b-f510-f3d5-6066-6123c27039ed@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_034351_905255_401AA954 
X-CRM114-Status: GOOD (  19.81  )
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



On 4/18/23 13:39, Hannes Reinecke wrote:
> On 4/18/23 12:24, Hannes Reinecke wrote:
>> On 4/18/23 12:07, Sagi Grimberg wrote:
>>>
>>>>>> The TLS stack is using MSG_EOR internally, so the flag cannot be
>>>>>> set for sendmsg()/sendpage(). But to avoid having the caller to
>>>>>> check whether TLS is active modify the code to clear the MSG_EOR
>>>>>> flag. And blank out MSG_MORE / MSG_SENDPAGE_NOTLAST, too, as they
>>>>>> conflict with MSG_EOR anyway.
>>>>>
>>>>> This looks like a temporary workaround to me.
>>>>>
>>>>> The networking folks really need to be CC'd on this (same for patch 
>>>>> 6).
>>>>
>>>> Thanks, when I said "we can support EOR" I obviously meant support
>>>> not ignore it :(  No ack.
>>>
>>> Obviously neither Hannes or I have sufficient tls knowledge to properly
>>> support it... It needs to be done by someone who knows the
>>> implementation.
>>>
>>> Is this a large scope to add support for it? Because if it is, I'd
>>> simply change nvme to clear MSG_EOR when tls is used (despite my
>>> preference to not do special things for tls).
>>
>> There's a rather simple patch for tls_sw. It already paces the data 
>> internally by an 'eor' variable, which is currently set to !MSG_MORE.
>> So evaluating MSG_EOR here is really trivial, and doesn't seem to 
>> cause any issues.
>>
>> Or, at least, none which would show up with NVMe-over-TLS :-)
>>
> Suggestion is to change it like this (sendpage follows suit):
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 827292e29f99..7b28b11ff611 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr 
> *msg, size_t size)
>          int pending;
> 
>          if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> -                              MSG_CMSG_COMPAT))
> +                              MSG_EOR | MSG_CMSG_COMPAT))
>                  return -EOPNOTSUPP;
> 
> +       if (MSG_EOR)

You probably meant if (msg->msg_flags & MSG_EOR)...

