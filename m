Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE18C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:36:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9708823A69
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9708823A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SaVnI7rCOQG6c3VWpDMvmWrGUz7RIGQ9du41Gvp6AIg=; b=Ixf51pJSxrwBaarDpDnFfIiYm
	Ps0Y2Bh2cZe/8SBTjXJr1VmNfky+NrD+lS2F0OyQrbGmu8wTF3XxZ6WN+8skZawqHSjxnTfNL677H
	MEiRIek9FdWpCy+QcAYNvFP0wOO5CF3VAeSS8j8PwxudXy/LIIqzvVQKdvflLKZZ6mt83F3XVuEch
	1QNm2x1dorNBVHdn8Ml+wEEFkPFblRWIPDUa6OJxJq3PhqZt2feEwZj03Cr4A27imvj3X//PjNHDP
	5xU2XAY9F7HcnBATvfi1+GMhPJDsvW5kkWSdqlSoOn2tI6F+TLzNqqZX52X12UoB3cz5i2kvNnPXC
	+hdtCcfvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kme6D-0000ke-Hk; Tue, 08 Dec 2020 14:36:17 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kme6B-0000kG-L6
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 14:36:16 +0000
Received: by mail-ej1-x644.google.com with SMTP id ga15so24911306ejb.4
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 06:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=btMPDftTIvTi3KHyYXrRdDfnWUrWosnPALX+QuJ+h6k=;
 b=TEIc/ZuthpNYb8jLLQIX9mL26v2oAqhlee+/c6DeR2XZLmo+8DQ9nEVcTeP5adiXEr
 75efyZ/m+o49252TWtwlltAI7avXnXvnns0cyygqM0eMOlqaV3jIBu8AmFaoBk0fA8K+
 GVV49dQ6+iTZqCEx4ZsUbgShcY1xQyZA0sr6XEg5sAVyMpCsrXP+TnVQaqbwlcwZW1vB
 Idufx6TDlXpzW7necDo/gatjVs3+cDdMVtynf8ySFEg4YHQFjOxY/h5v+ffeTnXYKd5c
 zsKR15+khazrjiv/sG5c70MwOxs0wHoqtsIj4ZYTvcwK9PjXmBAgLv8i63Z7iMTRohbq
 sMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=btMPDftTIvTi3KHyYXrRdDfnWUrWosnPALX+QuJ+h6k=;
 b=ZOkij1a2y2Uzwks7DKxsRzLOjcWK6H1R+w87bjPrWoscL4tYaZQpl8N/uxAqHdk00m
 JrDLRj48E385SK7RGyhzMCvRxif05odOOJEwcGutNY2JORNa9zfPt6ZqJIuCbR46jf+j
 +eo/eOWCj58KvzTx/UVL1YSl+rsePjlss6JYxYNXU0Op7sOyXBQsANFmqgFh0EmngiCO
 HJY5oZJUMwVALDgPdzcM109wuvGXQIkvskXMjD2jZxy4Pscs1jOiogYlYsTdPmxTzD/z
 KHcAOU+MXP7bnrAkisriWi63+O0k3FIWr4yvnoWmmJHDCteB3oU1BXjx/Xus4mTsBmru
 KVJA==
X-Gm-Message-State: AOAM530+HETj5SIVcn5zjCyg0DHvOms2LjL/pJYcaz3eeddmDqtf6LKR
 pAHqTCNTgX7QnnLCttfkz1I=
X-Google-Smtp-Source: ABdhPJwUIJFYocbJ/wJYB8M2rOIgkF29KnygLBbgBhV/tQfNUN4N36wxDdKR0gjoC3rSDq/XVBkBMQ==
X-Received: by 2002:a17:906:a8f:: with SMTP id
 y15mr13296557ejf.552.1607438173783; 
 Tue, 08 Dec 2020 06:36:13 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id cc8sm16989409edb.17.2020.12.08.06.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 06:36:12 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
Date: Tue, 8 Dec 2020 16:36:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_093615_707170_9A6EC0D8 
X-CRM114-Status: GOOD (  22.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 08/12/2020 2:42, David Ahern wrote:
> On 12/7/20 2:06 PM, Boris Pismenny wrote:
>> This commit introduces direct data placement offload for TCP.
>> This capability is accompanied by new net_device operations that
>> configure
>> hardware contexts. There is a context per socket, and a context per DDP
>> opreation. Additionally, a resynchronization routine is used to assist
>> hardware handle TCP OOO, and continue the offload.
>> Furthermore, we let the offloading driver advertise what is the max hw
>> sectors/segments.
>>
>> Using this interface, the NIC hardware will scatter TCP payload directly
>> to the BIO pages according to the command_id.
>> To maintain the correctness of the network stack, the driver is expected
>> to construct SKBs that point to the BIO pages.
>>
>> This, the SKB represents the data on the wire, while it is pointing
>> to data that is already placed in the destination buffer.
>> As a result, data from page frags should not be copied out to
>> the linear part.
>>
>> As SKBs that use DDP are already very memory efficient, we modify
>> skb_condence to avoid copying data from fragments to the linear
>> part of SKBs that belong to a socket that uses DDP offload.
>>
>> A follow-up patch will use this interface for DDP in NVMe-TCP.
>>
> 
> You call this Direct Data Placement - which sounds like a marketing name.
> 

[Re-sending as the previous one didn't hit the mailing list. Sorry for the spam]

Interesting idea. But, unlike SKBTX_DEV_ZEROCOPY this SKB can be inspected/modified by the stack without the need to copy things out. Additionally, the SKB may contain both data that is already placed in its final destination buffer (PDU data) and data that isn't (PDU header); it doesn't matter. Therefore, labeling the entire SKB as zerocopy doesn't convey the desired information. Moreover, skipping copies in the stack to receive zerocopy SKBs will require more invasive changes.

Our goal in this approach was to provide the smallest change that enables the desired functionality while preserving the performance of existing flows that do not care for it. An alternative approach, that doesn't affect existing flows at all, which we considered was to make a special version of memcpy_to_page to be used by DDP providers (nvme-tcp). This alternative will require creating corresponding special versions for users of this function such skb_copy_datagram_iter. Thit is more invasive, thus in this patchset we decided to avoid it.

> Fundamentally, this starts with offloading TCP socket buffers for a
> specific flow, so generically a TCP Rx zerocopy for kernel stack managed
> sockets (as opposed to AF_XDP's zerocopy). Why is this not building in
> that level of infrastructure first and adding ULPs like NVME on top?
> 

We aren't using AF_XDP or any of the Rx zerocopy infrastructure, because it is unsuitable for data placement for nvme-tcp, which reordes responses relatively to requests for efficiency and requires that data reside in specific destination buffers.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
