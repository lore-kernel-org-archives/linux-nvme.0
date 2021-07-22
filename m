Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6343C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:42:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA0360FED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA0360FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6M1HPKvFhprOhWhIEvNurUbqwjC2xKjy4USPLSvsDqk=; b=HyXeuGVvX7HygqB9HVA7sXJmvG
	CliCt017SSEZAHJMEipLSFAkecg+vwsWk3QmA7AG6FBYrnno9wHXcuqTn9+uvP2969J9V6nh6FpK8
	K2M9aXQiLaakuvF9g6cDCnKD9Qxkx4vtoXVEAGVlYfQqlYhrOlfoJAjdrm5Re8GNFabpCGez3LJm+
	DdzmgriUutTIElo4K+yB0/izKCkRYPPVF8I4hWlxnTaK1yK/uruMNlBih7zf0wfscOBOX2dyBAdxj
	jCyq3dlRUYu0TtHkFYI3ncrhFo2AZlmiG0CYNfXLquBcS7IiKhxz9EATiLbVSDT3G/Q1dXqC+BkSD
	E7rdvJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Yxh-001ipO-FD; Thu, 22 Jul 2021 13:42:05 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Ypf-001gXC-B9
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 13:33:49 +0000
Received: by mail-ej1-x632.google.com with SMTP id qb4so8361291ejc.11
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=krrqgDtyw8KyZc9tOOCwvqdlmRgO5LxhC2Fe0jBFQAE=;
 b=n9qhiPberPYMoFgKThp1cazMwGPhWHUZFwcjRMh8GW8fOU8s5XLT6bpsJ9+dUHKn5K
 zrPoRUd9wfxtjNwW5ktz0S310SoYKIxTx6tbxNAtRoeqUOtpiM1I0BtFmLyNVTyNyoap
 ImzaWTuJFuqPKLLLZnZYLOmLfy+fRSS9aRTtEfksUZtxx5PCTDWHhEglg7TZ6/Nq7nkm
 /K4pJj6gUAlIdq5Kp1HNaIWfjlg1ND4O/sG4DVjeAjZ0oBl8OBqEfogkLCJ99p1ioUP1
 R/N31cx9CYheAToWqlQxG3qk4DB05oDys0ZX2gQqMiganbPCGNaGf6pydwfpOWJ3b5Em
 1QWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=krrqgDtyw8KyZc9tOOCwvqdlmRgO5LxhC2Fe0jBFQAE=;
 b=ZSEB+Vcdccf33MFdB3DK1LxJg3rN/qgonsludaWKumfcsNMfODOuzl3xdyqTcGGWWb
 4kq6qjSemUZsZW9/ia0uHgM5sgv8Z39aYGfgRvz2CRh7dpCzj0c98Cia5WevaZX2eWJi
 4dOpp2krGaFiqYOeTmcwHeKTk82JfnmT5viX7/oQIahDEN+87wwYFpe3dbCSdv5cCd94
 qK7P+H1lIZhoMcXkpsKUmn05dJ68xFfr4AbAamd0EE9RToIH+gHhpLxaBTdmKlUtKVcG
 D3nR1RH0mENh0YMp00wCaLZSCXWJ6AeubJPV9txi/88l4euutp6YKjLIzZgyib+L6pv/
 GVUg==
X-Gm-Message-State: AOAM532ueXspQLhU7H7HWw52BSuAa51M2homKNgo9nq4UjY1Npiexvj+
 eFJltJEDDAMOGsZ+dd1y/vc=
X-Google-Smtp-Source: ABdhPJwPaHRoep32wwHtCL5/yQfL2z4xOi+q4UAgZPYHxVTMLfFaTpY6ZtEzUQrFI+9uOgPgHZsjhw==
X-Received: by 2002:a17:907:3581:: with SMTP id
 ao1mr2242936ejc.85.1626960825449; 
 Thu, 22 Jul 2021 06:33:45 -0700 (PDT)
Received: from [132.68.43.152] ([132.68.43.152])
 by smtp.gmail.com with ESMTPSA id n14sm12434398edo.23.2021.07.22.06.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 06:33:44 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 01/36] net: Introduce direct data placement
 tcp offload
To: Eric Dumazet <edumazet@google.com>
Cc: Boris Pismenny <borisp@nvidia.com>, David Ahern <dsahern@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, smalin@marvell.com,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
 <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
 <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
 <CANn89iLUDcL-F2RvaNz5+b8oQPnL1DnanHe0vvMb8QkM26whCQ@mail.gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <ba72f780-840e-de73-31b3-137908c52868@gmail.com>
Date: Thu, 22 Jul 2021 16:33:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANn89iLUDcL-F2RvaNz5+b8oQPnL1DnanHe0vvMb8QkM26whCQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_063347_503451_C8483D10 
X-CRM114-Status: GOOD (  32.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 22/07/2021 16:10, Eric Dumazet wrote:
> On Thu, Jul 22, 2021 at 2:18 PM Boris Pismenny <borispismenny@gmail.com> wrote:
>>
>> On 22/07/2021 14:26, Eric Dumazet wrote:
>>> On Thu, Jul 22, 2021 at 1:04 PM Boris Pismenny <borisp@nvidia.com> wrote:
>>>>
>>>> From: Boris Pismenny <borisp@mellanox.com>
>>>>
>>>>
>>> ...
>>>
>>>>  };
>>>>
>>>>  const char
>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>> index e6ca5a1f3b59..4a7160bba09b 100644
>>>> --- a/net/ipv4/tcp_input.c
>>>> +++ b/net/ipv4/tcp_input.c
>>>> @@ -5149,6 +5149,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>>>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>>>>  #ifdef CONFIG_TLS_DEVICE
>>>>                 nskb->decrypted = skb->decrypted;
>>>> +#endif
>>>> +#ifdef CONFIG_ULP_DDP
>>>> +               nskb->ddp_crc = skb->ddp_crc;
>>>
>>> Probably you do not want to attempt any collapse if skb->ddp_crc is
>>> set right there.
>>>
>>
>> Right.
>>
>>>>  #endif
>>>>                 TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>>>>                 if (list)
>>>> @@ -5182,6 +5185,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>>>  #ifdef CONFIG_TLS_DEVICE
>>>>                                 if (skb->decrypted != nskb->decrypted)
>>>>                                         goto end;
>>>> +#endif
>>>> +#ifdef CONFIG_ULP_DDP
>>>> +
>>>> +                               if (skb->ddp_crc != nskb->ddp_crc)
>>>
>>> This checks only the second, third, and remaining skbs.
>>>
>>
>> Right, as we handle the head skb above. Could you clarify?
> 
> I was simply saying you missed the first skb.
> 

But, the first SKB got handled in the change above. The code here is the
same for TLS, if it is wrong, then we already have an issue here.

>>
>>>> +                                       goto end;
>>>>  #endif
>>>>                         }
>>>>                 }
>>>
>>>
>>> tcp_collapse() is copying data from small skbs to pack it to bigger
>>> skb (one page of payload), in case
>>> of memory emergency/pressure (socket queues are full)
>>>
>>> If your changes are trying to avoid 'needless'  copies, maybe you
>>> should reconsider and let the emergency packing be done.
>>>
>>> If the copy is not _possible_, you should rephrase your changelog to
>>> clearly state the kernel _cannot_ access this memory in any way.
>>>
>>
>> The issue is that skb_condense also gets called on many skbs in
>> tcp_add_backlog and it will identify skbs that went through DDP as ideal
>> for packing, even though they are not small and packing is
>> counter-productive as data already resides in its destination.
>>
>> As mentioned above, it is possible to copy, but it is counter-productive
>> in this case. If there was a real need to access this memory, then it is
>> allowed.
> 
> Standard GRO packets from high perf drivers have no room in their
> skb->head (ie skb_tailroom() should be 0)
> 
> If you have a driver using GRO and who pulled some payload in
> skb->head, it is already too late for DDP.
> 
> So I think you are trying to add code in TCP that should not be
> needed. Perhaps mlx5 driver is doing something it should not ?
> (If this is ' copybreak'  this has been documented as being
> suboptimal, transports have better strategies)
> 
> Secondly, tcp_collapse() should absolutely not be called under regular
> workloads.
> 
> Trying to optimize this last-resort thing is a lost cause:
> If an application is dumb enough to send small packets back-to-back,
> it should be fixed (sender side has this thing called autocork, for
> applications that do not know about MSG_MORE or TC_CORK.)
> 
> (tcp_collapse is a severe source of latencies)
> 


Sorry. My response above was about skb_condense which I've confused with
tcp_collapse.

In tcp_collapse, we could allow the copy, but the problem is CRC, which
like TLS's skb->decrypted marks that the data passed the digest
validation in the NIC. If we allow collapsing SKBs with mixed marks, we
will need to force software copy+crc verification. As TCP collapse is
indeed rare and the offload is opportunistic in nature, we can make this
change and submit another version, but I'm confused; why was it OK for
TLS, while it is not OK for DDP+CRC?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
