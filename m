Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3280C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=htnKwTBpaZzkYcIip0l+gvKsTEcHUHQEkX4OJ+WhFAo=; b=RRSXQu9Gd0jeHw8vDhuiC6WEDd
	ZS3HUhm6/lBEXCgWVLaluho9Gx4QsmGSJp12cQzj8JOT4oK/dehPJ3m1RqLZaPNLAEgG4MDdweA9V
	kEfKyBvf2x9BOV8tRGKS2O0yuyYpbpwETmmnUJPwZlW73tgEpD2khiaBuTktyaNhAg+NKPvwCjFaz
	5+si61r1mt53BR+PwbaOJ6seUFcWeOPJAQJv86D6k0YP9EYXCsG6JjLeMWIPk0HKm6uy1k/6aC9iL
	3XwrFjkL69lrppFGc3F3j9zQ96TXmKkzVtntld7qOeZr+yQzTYySlzJWCW99gcVNxdcncu8Re921G
	n2bK3E+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewUT-00FkRy-0o;
	Wed, 22 Mar 2023 11:18:49 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewUQ-00FkQn-2q
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:18:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id n19so1011568wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679483923; x=1682075923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htnKwTBpaZzkYcIip0l+gvKsTEcHUHQEkX4OJ+WhFAo=;
        b=uYBVMcz0w4l7baQXS5/kbQYBtUjaqPYRBQ/SmvJqqzD/P69knV0gwPUM73uUGQVt81
         GXU1ahbvlfuAlsAI6i79O7l0NCzYHh7gdB9nSs6539GYc3Z7rfRqJ3rUj/oxj5VQXzj9
         R49RV0GvsweIC/uuB3z9vI+q8XjOkFnyuW4o97jN1sZwoyexSule0ZEYUs6uIY04V3uO
         RGL/NojaKeCvtuXgvM7TJFaITWgsWV/3qY5olqZ5eqrGtFpeGW91Jyps5vO6vfk9ZiMP
         JaE7emTPMjxsSYh++MKH0ZjazpodmiCT4MJi+zZX6L7oQ7nOvcoPdJ1Xz1ZevCBdOptp
         cN/A==
X-Gm-Message-State: AO0yUKW/smQZZt7LhJmFkz3qqoUAlQTWNIPlGtqaLV9Z5/F7r1q6dfZC
	rDicXMbqnlJ4iFPlzSNVx09J/M3WdM4=
X-Google-Smtp-Source: AK7set++o1ca6aGHTmOmaOaTrb/TYh7GTWDWnn7d4bMIDsJXPKtPwB6ZafUz/ySUzYG/t9nnRHlhsA==
X-Received: by 2002:a05:600c:4504:b0:3ed:d119:df27 with SMTP id t4-20020a05600c450400b003edd119df27mr5815404wmo.3.1679483922938;
        Wed, 22 Mar 2023 04:18:42 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003ed2987690dsm16407381wmr.26.2023.03.22.04.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:18:42 -0700 (PDT)
Message-ID: <c97a8ac1-255a-4a54-1bb5-0bedf22a6774@grimberg.me>
Date: Wed, 22 Mar 2023 13:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-11-hare@suse.de>
 <e189b779-8621-bfa6-4c7a-1eb38bd1c29d@grimberg.me>
 <3b0f2af5-5dfa-ed76-a6a6-2715d9e05e70@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3b0f2af5-5dfa-ed76-a6a6-2715d9e05e70@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_041846_917574_C28D5620 
X-CRM114-Status: GOOD (  31.41  )
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



On 3/22/23 12:08, Hannes Reinecke wrote:
> On 3/22/23 10:31, Sagi Grimberg wrote:
>>
>>
>> On 3/21/23 14:43, Hannes Reinecke wrote:
>>> kTLS does not support MSG_EOR flag for sendmsg(), and the ->sendpage()
>>> call really doesn't bring any benefit as data has to be copied
>>> anyway.
>>> So use sock_no_sendpage() or sendmsg() instead, and ensure that the
>>> MSG_EOR flag is blanked out for kTLS.
>>>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/tcp.c | 33 +++++++++++++++++++++------------
>>>   1 file changed, 21 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index bbff1f52a167..007d457cacf9 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1034,13 +1034,19 @@ static int nvme_tcp_try_send_data(struct 
>>> nvme_tcp_request *req)
>>>           bool last = nvme_tcp_pdu_last_send(req, len);
>>>           int req_data_sent = req->data_sent;
>>>           int ret, flags = MSG_DONTWAIT;
>>> +        bool do_sendpage = sendpage_ok(page);
>>> -        if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
>>> +        if (!last || queue->data_digest || nvme_tcp_queue_more(queue))
>>> +            flags |= MSG_MORE;
>>> +        else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
>>>               flags |= MSG_EOR;
>>> -        else
>>> -            flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
>>
>> I think its time to move the flags setting to a helper.
>>
>>> -        if (sendpage_ok(page)) {
>>> +        if (test_bit(NVME_TCP_Q_TLS, &queue->flags))
>>> +            do_sendpage = false;
>>> +
>>> +        if (do_sendpage) {
>>
>> The do_sendpage looks redundant to me.
>>
>>> +            if (flags & MSG_MORE)
>>> +                flags |= MSG_SENDPAGE_NOTLAST;
>>>               ret = kernel_sendpage(queue->sock, page, offset, len,
>>>                       flags);
>>
>> I think that the SENDPAGE_NOLAST should be set together with MSG_MORE
>> regardless.
>>
>>>           } else {
>>> @@ -1088,19 +1094,22 @@ static int nvme_tcp_try_send_cmd_pdu(struct 
>>> nvme_tcp_request *req)
>>>       bool inline_data = nvme_tcp_has_inline_data(req);
>>>       u8 hdgst = nvme_tcp_hdgst_len(queue);
>>>       int len = sizeof(*pdu) + hdgst - req->offset;
>>> -    int flags = MSG_DONTWAIT;
>>> +    struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>>> +    struct kvec iov = {
>>> +        .iov_base = (u8 *)req->pdu + req->offset,
>>> +        .iov_len = len,
>>> +    };
>>>       int ret;
>>>       if (inline_data || nvme_tcp_queue_more(queue))
>>> -        flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
>>> -    else
>>> -        flags |= MSG_EOR;
>>> +        msg.msg_flags |= MSG_MORE;
>>> +    else if (!test_bit(NVME_TCP_Q_TLS, &queue->flags))
>>> +        msg.msg_flags |= MSG_EOR;
>>>       if (queue->hdr_digest && !req->offset)
>>>           nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>>> -    ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>>> -            offset_in_page(pdu) + req->offset, len,  flags);
>>> +    ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>>
>> I'd prefer to do kernel_sednpage/sock_no_sendpage similar to how we do
>> it for data and data pdu.
>>
>>>       if (unlikely(ret <= 0))
>>>           return ret;
>>> @@ -1131,7 +1140,7 @@ static int nvme_tcp_try_send_data_pdu(struct 
>>> nvme_tcp_request *req)
>>>       if (queue->hdr_digest && !req->offset)
>>>           nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>>> -    if (!req->h2cdata_left)
>>> +    if (!test_bit(NVME_TCP_Q_TLS, &queue->flags) && !req->h2cdata_left)
>>>           ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
>>>                   offset_in_page(pdu) + req->offset, len,
>>>                   MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
>>
>> Something is unclear to me. Is kernel_sendpage unsupported with tls? (I
>> think it is). I understand the motivation to add more checks in the code
>> for kernel_sendpage vs. sock_no_sendpage given that it should be
>> perfectly fine to use either.
>>
>> Did you see any regressions with using kernel_sendpage? If so, isn't
>> that a bug in the tls code?
> 
> The actual issue with the tls code is the 'MSG_EOR' handling.
> Problem is that tls is using MSG_EOR internally, and bails out on 
> unknown MSG_ settings:

That is fine, lets separate MSG_EOR for TLS, and any change from
kernel_sendpage to kernel_sendmsg to a different patch (or eliminate
it altogether if it is unneeded).

> 
> int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
> {
> [ .. ]
>          if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>                                 MSG_CMSG_COMPAT))
>                  return -EOPNOTSUPP;
> 
> I would _vastly_ prefer to blank out unsupported flags (like MSG_EOR) 
> from the TLS code, because to all intents and purposes MSG_EOR is just 
> the opposite of MSG_MORE.

Not exactly. But ok.

> Or drop MSG_EOR usage from the nvme tcp code.

Possible to do. But MSG_EOR hints the network stack that no other
payload is expected, so it can send it down the wire asap and avoid
any batching heuristics.

> But then I'm not _that_ into the networking code to make a judgement here.
> And as we're using sendmsg() already I had been switching to use it for 
> ktls, too (as I know that the sendmsg() flow worked).
> But in the end I guess we could use sendpage going forward.

I'd prefer not to change that at this point if it is supported properly.

