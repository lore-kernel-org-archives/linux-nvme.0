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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9DCC6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:24:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1245861285
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1245861285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=l1vY9EGydLQIY1+gYJqhfZO47luA8DCHVY5HwV+j4IM=; b=GLa4F9a/PG8B0VCKOCRn3mmI6O
	HD9VAHS79SYBnwdQoJ0bxb1tQJ72qo8Fiv9114J7/y6tu/5ofs2n0bGW3iV2gtqiSmKX+Ftbk2EDl
	xBwLpgyCQ0XifbGfjQXZw5lL3ImoQ2gWIa/m/KDRrXFUwoiqJO1r1n3BmaqWZIwKIjVbzLU39xlYS
	XLAe8ec5qnvIHj78L83TiiG8Nqi0b5Bf8+I1j1zUsjEXmupVmrwBYLNqKAAxzxeybUuaWEH7cjbvp
	DsHAvfoTAaD0auZutmQBPmarWeUngrrCwBAj+QsJUanpIwQlV8bmtxK+qiqM8uAyPkSEXTKeVB6S5
	M2j0f8JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6YgA-001eAk-JM; Thu, 22 Jul 2021 13:23:58 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Xer-001TCK-GO
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 12:18:34 +0000
Received: by mail-ed1-x52d.google.com with SMTP id ee25so6524815edb.5
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=07cpZ8YXhgBRoS8i+yJRb4ht/zHLP6T8D2WCZ5P2C8w=;
 b=Ymgq6CwnPbOe24khedsPWCtBiZiih7YgXzefpp98rM13Yz5GGB1MiSKpLTxwA12ITF
 9du7IKiMPg+ZQsrDh6GfxqorPgbqC42ZkXKY7D3dh7GV295xy3yPKkyewPQ2Urp7QS5g
 Ig82gj/y2Bim0yXXR7bCcVu6SQESoMUbMuyW8fNgM1DJI4HGGsOwO9IumdX5N+dqCW/v
 7XOS222PbhSsi2Vs71Udp2y+nYK+QuSdAguNhpnpCmcqtdC/pi6ogBVvt2l4H0MZ+3wt
 kxRhFidcrCAzisjYhtK9sYdEfCl3EhBDMgDap/7e3OmEupF840A6acclV2RL6rIuoNnb
 JS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=07cpZ8YXhgBRoS8i+yJRb4ht/zHLP6T8D2WCZ5P2C8w=;
 b=UhTED0RM7OeylRj0p733YTXa5V6zHIecQJ3WqZUp6zO8Bbu3+kMZ94f6C/0BhMMA7W
 Jg5gqqv9yzcZhs3/Jy5lBgkEQS6vqozlk43HIpbQYhyYVoZZGWcsTLzHfBhrnfYefDSg
 UYOW9ItF5APBilmmTAq1RH+97LB6+OAWwqYre/tP0BHOM5pag7Y0Z4ms8BbrfquZjDIh
 m/Nbbw/q27+HwK+zxWg1eaNmkGxEXtufozuqP82eW14tXYkOL4RRme4+fXntlsbywALK
 ViXnBrg2p+XfhL/kph+y4OY9Wr9NnfAOYbhSmUnaP7QJV+T4bDqiqThdvAe8BzB2I74n
 DdDw==
X-Gm-Message-State: AOAM5309RxZqsPp/Yeuzb3w0+i1rONTf32KYjy/lBswIdkxLrM467doB
 K+LSgWDtvG9qXv6xDqbRYZM=
X-Google-Smtp-Source: ABdhPJz0X1+vAR9/jhOxqLG8dGit74B4LTXootW0dP5dyUrRd7lr5d0LJACQh/fR7CLLJRjGAWsNYQ==
X-Received: by 2002:a05:6402:152:: with SMTP id
 s18mr53622221edu.221.1626956311075; 
 Thu, 22 Jul 2021 05:18:31 -0700 (PDT)
Received: from [132.68.43.152] ([132.68.43.152])
 by smtp.gmail.com with ESMTPSA id q26sm5184390ejs.115.2021.07.22.05.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 05:18:30 -0700 (PDT)
Subject: Re: [PATCH v5 net-next 01/36] net: Introduce direct data placement
 tcp offload
To: Eric Dumazet <edumazet@google.com>, Boris Pismenny <borisp@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, smalin@marvell.com,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
 <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
Date: Thu, 22 Jul 2021 15:18:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_051833_653545_FCCF1DFE 
X-CRM114-Status: GOOD (  21.39  )
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

On 22/07/2021 14:26, Eric Dumazet wrote:
> On Thu, Jul 22, 2021 at 1:04 PM Boris Pismenny <borisp@nvidia.com> wrote:
>>
>> From: Boris Pismenny <borisp@mellanox.com>
>>
>>
> ...
> 
>>  };
>>
>>  const char
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index e6ca5a1f3b59..4a7160bba09b 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -5149,6 +5149,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>>  #ifdef CONFIG_TLS_DEVICE
>>                 nskb->decrypted = skb->decrypted;
>> +#endif
>> +#ifdef CONFIG_ULP_DDP
>> +               nskb->ddp_crc = skb->ddp_crc;
> 
> Probably you do not want to attempt any collapse if skb->ddp_crc is
> set right there.
> 

Right.

>>  #endif
>>                 TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>>                 if (list)
>> @@ -5182,6 +5185,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>>  #ifdef CONFIG_TLS_DEVICE
>>                                 if (skb->decrypted != nskb->decrypted)
>>                                         goto end;
>> +#endif
>> +#ifdef CONFIG_ULP_DDP
>> +
>> +                               if (skb->ddp_crc != nskb->ddp_crc)
> 
> This checks only the second, third, and remaining skbs.
> 

Right, as we handle the head skb above. Could you clarify?

>> +                                       goto end;
>>  #endif
>>                         }
>>                 }
> 
> 
> tcp_collapse() is copying data from small skbs to pack it to bigger
> skb (one page of payload), in case
> of memory emergency/pressure (socket queues are full)
> 
> If your changes are trying to avoid 'needless'  copies, maybe you
> should reconsider and let the emergency packing be done.
> 
> If the copy is not _possible_, you should rephrase your changelog to
> clearly state the kernel _cannot_ access this memory in any way.
> 

The issue is that skb_condense also gets called on many skbs in
tcp_add_backlog and it will identify skbs that went through DDP as ideal
for packing, even though they are not small and packing is
counter-productive as data already resides in its destination.

As mentioned above, it is possible to copy, but it is counter-productive
in this case. If there was a real need to access this memory, then it is
allowed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
