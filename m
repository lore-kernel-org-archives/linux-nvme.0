Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33B6C001B0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6nDfshqGjfSU1LQvNk/0CiyR68GvY2EUpy3tDNk00eQ=; b=IdDbnA9IXVfZw8HskwCM53kirl
	R6m+mY8lRz4I4JFSmE86SA4kIdWyWUUpRRlfbTdtBZsB6IO/jfYQfFY+h/GVV4rLqdG43t4owazzT
	5hIjIWQgUb5Db3jnJ1213ghdMpw3JQ1pZchk1bDZ2+4wMimQSfks5rwSotFwvXs1bC4ZbMPOgVsQ+
	lfpROVdbCvPEh5dETfyFgQLto766VNHSCbWhnpwrQ9Ht0/Exd72iTWK6TkFJeNs3J7HD/TmZk4LWn
	q6W9jX19uSiClEzDxbWdUxZU6ajrdQvlVRxwn77q6d8+hqhWurztjMLB0D+R3VYvO8FaZGhLU63Gy
	tu32RYeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIHU-0023m3-0f;
	Tue, 08 Aug 2023 08:41:32 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTIHR-0023lL-0H
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 08:41:30 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94ea38c90ccso138822866b.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Aug 2023 01:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691484083; x=1692088883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nDfshqGjfSU1LQvNk/0CiyR68GvY2EUpy3tDNk00eQ=;
        b=YC8+xHxaQteimV36X1dSoksaQLRifcgoyWVYa7eD2i7jypYNOmTfoo+Sez5NnugVfC
         x+TpwNbe0+TFwmEMzcQVmYTIyxWSU3b4R5JvkkPvnv9zur/gvXuK+qaOhHqFqQqFKoe4
         2NmzrSWIT0offkFbXxVbSJXO8ZCm5gx1COHw9rCmvjEXsoyjVtAZttBDmRcY5VukLwQl
         trjZKUpZ6wvgk/gKyCIAJcu6qIQjJIMnHurv4JvLeyCpaJqlbRi4hpzSeuO47xcMCXvC
         0RhAAD596IpDs0ojepab9ATKyZeHL+Owi4gFvANvyTAEZKAGwlbLjfehAAwhFHn1uCu1
         iZgw==
X-Gm-Message-State: ABy/qLZ+PllwoESF+iUXcpshZGcSqvPgiUc3F5dT8vwMv+LtZu0oU9b5
	VfyszgoCAiofhAhcM1Z06Y4YYcSwCiY=
X-Google-Smtp-Source: APBJJlEL7kvznQxIW2G1Csk6xzP0KJxzYrXhm/PsyZrzCPBAWliABfB3ZE8U0Uutr3fHboNc9N93Tg==
X-Received: by 2002:a17:906:20ce:b0:994:539d:f98b with SMTP id c14-20020a17090620ce00b00994539df98bmr20012496ejc.6.1691484083274;
        Tue, 08 Aug 2023 01:41:23 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090612c700b009937dbabbdasm6243631ejb.217.2023.08.08.01.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:41:22 -0700 (PDT)
Message-ID: <41f9e217-374e-2cfa-b912-147686fe7ee6@grimberg.me>
Date: Tue, 8 Aug 2023 11:41:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-10-hare@suse.de>
 <5c12f391-c5cb-2d1a-40b3-b93f45292c6c@grimberg.me>
 <5127f18a-7a15-71d0-4ae3-b7caa62e5d80@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5127f18a-7a15-71d0-4ae3-b7caa62e5d80@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_014129_125714_96604AAA 
X-CRM114-Status: GOOD (  18.70  )
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



On 8/8/23 09:39, Hannes Reinecke wrote:
> On 8/7/23 10:22, Sagi Grimberg wrote:
>>
>>
>> On 8/3/23 13:50, Hannes Reinecke wrote:
>>> kTLS is sending TLS ALERT messages as control messages for recvmsg().
>>> As we can't do anything sensible with it just abort the connection
>>> and let the userspace agent to a re-negotiation.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>   drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 98400ad5f969..4d0e3de39c26 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -14,6 +14,7 @@
>>>   #include <net/sock.h>
>>>   #include <net/tcp.h>
>>>   #include <net/tls.h>
>>> +#include <net/tls_prot.h>
>>>   #include <net/handshake.h>
>>>   #include <linux/blk-mq.h>
>>>   #include <crypto/hash.h>
>>> @@ -1369,6 +1370,10 @@ static int nvme_tcp_init_connection(struct 
>>> nvme_tcp_queue *queue)
>>>   {
>>>       struct nvme_tcp_icreq_pdu *icreq;
>>>       struct nvme_tcp_icresp_pdu *icresp;
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    char cbuf[CMSG_LEN(sizeof(char))] = {};
>>> +    u8 ctype;
>>> +#endif
>>>       struct msghdr msg = {};
>>>       struct kvec iov;
>>>       bool ctrl_hdgst, ctrl_ddgst;
>>> @@ -1406,11 +1411,22 @@ static int nvme_tcp_init_connection(struct 
>>> nvme_tcp_queue *queue)
>>>       memset(&msg, 0, sizeof(msg));
>>>       iov.iov_base = icresp;
>>>       iov.iov_len = sizeof(*icresp);
>>> +#ifdef CONFIG_NVME_TCP_TLS
>>> +    msg.msg_control = cbuf;
>>> +    msg.msg_controllen = sizeof(cbuf);
>>> +#endif
>>>       ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>>>               iov.iov_len, msg.msg_flags);
>>>       if (ret < 0)
>>>           goto free_icresp;
>>
>> Is the cmsg passed unconditionally? meaning this does not
>> impact non-tls?
>>
>> If so, why is the ifdef needed?
>>
> Passing in a cmsg (and a controllen) always enables the use of
> control messages, irrespective of the type.
> As we never enabled control messages prior to this we would
> change the implementation when TLS is not enabled; who knows,
> someone might have been sending us control messages all along,
> but we never checked. So I thought it prudent to only enable
> it for TLS where we know that we might be getting control messages.

But you are doing this only based on the compile-time config option, not
based on a runtime setting. I am not sure I follow your logic.

