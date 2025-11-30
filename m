Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C29CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmR5QD5XPmIXPMRPoieuZEYevd27cqMDCVSmYG8PKNo=; b=L24ib2jlgvO1sblTmvGEOy1VK6
	35OjZh9aY2D1bgdoYYvb+7EKmS95HiP8R2RIvBiDpgooAjGsY0q082vvuc9g5Et7MWhNoSclCYgRH
	861bENCdnlNVwOLOImAO5p3hnUAesC1Z0Mh7ExrzU9IE2RiI4VIKFtc70A3dP+IJyTB0zfv5gBiFK
	hyvThexbrJafb915bu3DCDvAhbEujbxdBo63hKXQ4IR7nZD7teLccApjv92NCtbtkKSmYo0MlYuEr
	C1Slu7NCIfaPEwdMdZZLD4PUW10r7jfLI18a96yjEIEB/SHk+Ef3+2b27xCQo4TTWZKzqA++pdoD7
	JyDYPr0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPp7w-00000002aTP-07z9;
	Sun, 30 Nov 2025 21:38:40 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPp7u-00000002aSz-0tNK
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 21:38:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso37252365e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 13:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764538716; x=1765143516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmR5QD5XPmIXPMRPoieuZEYevd27cqMDCVSmYG8PKNo=;
        b=PMGW0pWuW4s4EKxsB72a/Rg2r9N5mVKqw6SsQAbs0tepI/f7ly2k+DtJoDZgylWdcg
         cJuvTq+6RqhPfkml+Ws/1WoyfR8sYe5+K+azAQl4WLTs1eja5U8FFue+y1P1vYG6SNEJ
         IGMRrANMS+dcTM0bUyWN5mcAMZBK0IVYnvww0rJWgSb1lqu9cIoxjyE5sgvuIAzpvClK
         D4mYFUQ0vbMaIyyY+oJjX/7FIDAUu8IYvyNgP7Hiwu4GtuyfF7sxpOvkBtulyFliwPXN
         WGLoGjTCfmJdgibp56L3rolpz0qOAVElXNCyInGiomSG6gMC/2eI1uFjn0OURTRSkSld
         C/lw==
X-Forwarded-Encrypted: i=1; AJvYcCWH4RVp28wyhcZRKFMOmOZg4AobZZL9/b3e6CYpDuwwYRKZps1MQ6T9MYu8HPNz2cctIIJEnCMsBa1b@lists.infradead.org
X-Gm-Message-State: AOJu0Yxt4YLGW4UgSCaGlpF50Li6hAcBx2R5+NlJfp+Zk0qANUnklSTw
	VL5pZUpOU67mC5bPwhUNGitWxaCixOSkAFOfduNPh/SPhjlIhqEWQMSw
X-Gm-Gg: ASbGncuuEWhH6EIKsSEoWTg2mENgtftampEd3r87+NdIOutH2aWWRPrBXLQOybANqlg
	1at9TNIBsuJvDbHYo6aBM3mluDm5Q/ZrbyyqvGxYQ4sSikEMyFDUlUUSeWMoLPALmCWQcBncCiZ
	E534Q6nBcg2kxQ75PpF7OaBcJTidxZl7o1hWU4i9EIbm/DVRC0mLIk8IQGg7SBGXvN5RXemHacQ
	WOjJtLQF3m7ksOlGUipp5fBgnFRkiomZxaXIuzoYSzmMlXxgom1qomhiJP5dW+JuvaYUbyoPFFY
	XHxwLBVZcrPxyvGwdEUs8er95v7HcqQztCNt/kijRgI+dX0EKZ/wT1bRtVLSY8tImOIufPrAhzH
	NZKQhKv+iYff1ZGGHP81Skkdu1HXtQ1D7my1ND8ftCwo/mTm++4uWZDQCnhYe3w/W2/Mj6s3ZuH
	TSn0czywo2do3gc6Nos7LOA6TM6zELzNVoNmWaqpkb
X-Google-Smtp-Source: AGHT+IFXyCDi1y9ZkYXnNFPrbkZLQhsuDvPQu4qMhG7WcJ3qYnBN6XSKr6/E/nKvKELrZgEqxoZgZw==
X-Received: by 2002:a05:600c:19cd:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-477c1115febmr280591635e9.21.1764538716261;
        Sun, 30 Nov 2025 13:38:36 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040bd209sm143282595e9.3.2025.11.30.13.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 13:38:35 -0800 (PST)
Message-ID: <bc44fabe-fcf4-4f63-86cf-0188f63cb2df@grimberg.me>
Date: Sun, 30 Nov 2025 23:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
 <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
 <809dc274-939a-436d-8293-37c6246ec3bf@suse.de>
 <3e20b46c-d0a8-454b-9c1d-6d010c2e2e42@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3e20b46c-d0a8-454b-9c1d-6d010c2e2e42@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_133838_299152_BC2E2A47 
X-CRM114-Status: GOOD (  36.00  )
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



On 27/11/2025 13:47, Hannes Reinecke wrote:
> On 11/27/25 08:52, Hannes Reinecke wrote:
>> On 11/26/25 08:32, Sagi Grimberg wrote:
>>>
>>>
>>> On 20/10/2025 11:58, Hannes Reinecke wrote:
>>>> The nvme-tcp code is using the ->read_sock() interface to
>>>> read data from the wire. While this interface gives us access
>>>> to the skbs themselves (and so might be able to reduce latency)
>>>> it does not interpret the skbs.
>>>> Additionally for TLS these skbs have to be re-constructed from
>>>> the TLS stream data, rendering any advantage questionable.
>>>> But the main drawback for TLS is that we do not get access to
>>>> the TLS control messages, so if we receive any of those message
>>>> the only choice we have is to tear down the connection and restart.
>>>> This patch switches the receive side over to use recvmsg(), which
>>>> provides us full access to the TLS control messages and is also
>>>> more efficient when working with TLS as skbs do not need to be
>>>> artificially constructed.
>>>
>>> Hannes,
>>>
>>> I generally agree with this approach. I'd like to point out though
>>> that this is going to give up running RX from directly from softirq 
>>> context.
>>
>> Yes.
>>
>>> I've gone back and forth on weather nvme-tcp should do that, but never
>>> got to do a thorough comparison between the two. This probably shuts
>>> the door on that option.
>>>
>> The thing with running from softirq context is that it would only
>> make sense if we could _ensure_ that the softirq context is running
>> on the cpu where the blk-mq hardware context is expecting it to.
>> Not only would that require fiddling with RFS contexts, but we also
>> found that NVMe-over-fabrics should _not_ try to align with hardware
>> interrupts but rather rely on the driver to abstract things away.
>>
>>> Having said that, I am fine with this approach. recvmsg is a saner 
>>> interface.
>>>
>> Thanks!
>>
>>
>> [ .. ]>> @@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct
>>>> nvme_tcp_queue *queue,
>>>>       return 0;
>>>>   }
>>>> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct 
>>>> sk_buff *skb,
>>>> -                 unsigned int offset, size_t len)
>>>> +static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
>>>>   {
>>>> -    struct nvme_tcp_queue *queue = desc->arg.data;
>>>> -    size_t consumed = len;
>>>> -    int result;
>>>> +    char *ddgst = (char *)&queue->recv_ddgst;
>>>> +    off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
>>>> +    struct msghdr msg = {
>>>> +        .msg_flags = MSG_WAITALL,
>>>> +    };
>>>
>>> I don't think we want to use MSG_WAITALL ever. Why are you opting to 
>>> do that?
>>>
>> Hmm. You are right, it's not needed.
>>
>> [ .. ]>> @@ -1356,20 +1355,38 @@ static int nvme_tcp_try_send(struct
>>>> nvme_tcp_queue *queue)
>>>>       return ret;
>>>>   }
>>>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>>>> +static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>>>>   {
>>>> -    struct socket *sock = queue->sock;
>>>> -    struct sock *sk = sock->sk;
>>>> -    read_descriptor_t rd_desc;
>>>> -    int consumed;
>>>> +    int result;
>>>> +    int nr_cqe = queue->nr_cqe;
>>>> +
>>>> +    if (unlikely(!queue->rd_enabled))
>>>> +        return -EFAULT;
>>>> +
>>>> +    do {
>>>> +        switch (nvme_tcp_recv_state(queue)) {
>>>> +        case NVME_TCP_RECV_PDU:
>>>> +            result = nvme_tcp_recvmsg_pdu(queue);
>>>> +            break;
>>>> +        case NVME_TCP_RECV_DATA:
>>>> +            result = nvme_tcp_recvmsg_data(queue);
>>>> +            break;
>>>> +        case NVME_TCP_RECV_DDGST:
>>>> +            result = nvme_tcp_recvmsg_ddgst(queue);
>>>> +            break;
>>>> +        default:
>>>> +            result = -EFAULT;
>>>> +        }
>>>> +    } while (result >= 0);
>>>> +
>>>> +    if (result < 0 && result != -EAGAIN) {
>>>> +        dev_err(queue->ctrl->ctrl.device,
>>>> +            "receive failed:  %d\n", result);
>>>> +        queue->rd_enabled = false;
>>>> + nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>>> +    }
>>>> -    rd_desc.arg.data = queue;
>>>> -    rd_desc.count = 1;
>>>> -    lock_sock(sk);
>>>> -    queue->nr_cqe = 0;
>>>> -    consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>>> -    release_sock(sk);
>>>> -    return consumed == -EAGAIN ? 0 : consumed;
>>>> +    return result < 0 ? result : (queue->nr_cqe = nr_cqe);
>>>
>>> This is changing the semantics of the retcode - can you please 
>>> document in the commit msg
>>> the change?
>>>
>> That was done to be compatible with the polling interface.
>> I'll check if it's needed after all.
>>
> Actually, I don't think I'm changing the interface.
> The original interface would return either a negative number on error,
> '0' if no PDUs have been processed, or the number of processed PDUs.
> And the new recvmsg interface does the same (I think).
> The only change which I did was to _not_ map out -EAGAIN, as this will
> be handled by the 'data_ready' callback.

Which is a change that needs to be documented.

> (Reasoning: -EAGAIN is returned when there is no (or not enough) data
> to be read, and the network layer will call ->data_ready once the
> situation improves. If we continue with the loop we will race/compete
> with the networking layer, causing us to do duplicated work as the
> io_work thread will be picking up the new data _and_ the data_ready
> callback will be scheduling the io_work callback to pick up the new
> data. So we can safely stop on -EAGAIN knowing that we'll be woken
> up once we can continue to read data.).

There is TX work that may be pending as well, IIRC there is an 
assumption that
io_work will NOT return if there is any TX work pending (we've seen 
stalls in the
past due to issues like that).

> (And arguably this was an issue with the original code, too.).
>
> So where is the change in semantics?

Exactly where you described it.

