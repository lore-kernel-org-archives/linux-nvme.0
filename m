Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08417C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:39:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9533C23AA8
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9533C23AA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Gbbq0L72VgjTIQZ9Ijba5AYEqfQbIcxXMt8Z7tFRJgM=; b=PnKHZ/SQ+Jqh4sbyl2GzA/jId
	Ch1CTqLFoKF+CGFtAIVl6PDbJ7MFBxk9+1gEKPYsYHjebZuz4j8eszul2lAwoaMyxL+aoNw7fboVW
	1Fa7M08dfJSlGeMhp+FreAdLfKnEtxxjv8B7shOs8bvuTgQIPVxHIBsk9Aa4YsEmNfOkIHGt939Zt
	QwP4nR/nCwo/+MuR3ikA1UMn4XFgZPPp/oakX5RjU+cGTHqchXww4LjLhC1zHhxzuxrLJUxS+PzQ6
	CDnUWt6iLHKBvpWanz5dVXGlHXReRRPUPudx6LcRtHMRgxLe2oOngXmXo2DKQXeiYIBq8L96KGL39
	iQiWY4EJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmnVV-0000FH-FX; Wed, 09 Dec 2020 00:39:01 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmnVR-0000EK-Uu
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 00:38:59 +0000
Received: by mail-ot1-x343.google.com with SMTP id j12so586578ota.7
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kmk2YI7GQKC1QQuseSoGeIYfygPzB7Y5vXtGgunzq1g=;
 b=WkMlaLkCJH7vyvlOeixVsnfgK0mh6dOe3+HtKwabHPmXvrwgvap7IqTRDTz/gFC4Ij
 NgV4Isn6rhdFVRtyQPq0S9S346lFxBdjw0gVTCIhioYYEKA8UaJDjN9hmJKnB0Vbt0jr
 IVdArmNbvqivMA0Cum8tn+WJcjtPChpo3ij7ncRwJVEfaqWj2k84iREySGWM9ITgb76+
 VttrNXfOZY0lxr2W2QFdCmB3k0jWQ3FUE78upJlSxJUR4I8GOSxOkf/9JxV4mD5ZumiB
 uw6FTeUQEaGCbR+YnP37ynwywXfM3vxHGWXNSI2C98KQHbP+Qs1JlFME6qhrV6J7sKAh
 AhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kmk2YI7GQKC1QQuseSoGeIYfygPzB7Y5vXtGgunzq1g=;
 b=Ij0NQhhu+C8Wk9B8GnDL9Wwaa8yyKgqXZ45j3R2P82jMAK1tI8itO2EM3scu3I3N5j
 n7uHReu2TG64Ba7Sh5hIZcCB1+VMtAiz9nfYwXxfXLaAklvizfy2t99VVHMA7cesQ535
 qTE0Cwp30yxlF+L+csLpEYtzp09rxlKqqGnhRb3Lmkfl5sMWM7JXGuinQspaiIe+d29F
 2lr+/PZdZwpfM1xC3NSLpkM5xWEFZ4rgUPivB9GOSxWW+I8raOAMmlnFd65NfaWIZP7S
 0dPdNapCehd3w2vD/KJNPpmV3tl28u6rDOFgyJs7GXPISGbRONd2f6mXRwkm4pk7BwiV
 +Q4Q==
X-Gm-Message-State: AOAM531qQ3+bp1c2CXLqgOA4GXlR64aAXo8SQRGjSiSuyNCL3s0Z9grZ
 u5V30w68Sy5p+17o9vt8XVg=
X-Google-Smtp-Source: ABdhPJwm1JwMtli/qsn+3L8ZydaJFHj/WP3suRCiRxghdzjyRC5HquTekV8QNuIhMfmwHIz1c4dd5Q==
X-Received: by 2002:a9d:6317:: with SMTP id q23mr613356otk.251.1607474336008; 
 Tue, 08 Dec 2020 16:38:56 -0800 (PST)
Received: from Davids-MacBook-Pro.local
 ([2601:282:800:dc80:64fc:adeb:84f9:fa62])
 by smtp.googlemail.com with ESMTPSA id j62sm17564otc.49.2020.12.08.16.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 16:38:55 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
Date: Tue, 8 Dec 2020 17:38:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_193858_593338_8E1B0DFE 
X-CRM114-Status: GOOD (  25.20  )
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

On 12/8/20 7:36 AM, Boris Pismenny wrote:
> On 08/12/2020 2:42, David Ahern wrote:
>> On 12/7/20 2:06 PM, Boris Pismenny wrote:
>>> This commit introduces direct data placement offload for TCP.
>>> This capability is accompanied by new net_device operations that
>>> configure
>>> hardware contexts. There is a context per socket, and a context per DDP
>>> opreation. Additionally, a resynchronization routine is used to assist
>>> hardware handle TCP OOO, and continue the offload.
>>> Furthermore, we let the offloading driver advertise what is the max hw
>>> sectors/segments.
>>>
>>> Using this interface, the NIC hardware will scatter TCP payload directly
>>> to the BIO pages according to the command_id.
>>> To maintain the correctness of the network stack, the driver is expected
>>> to construct SKBs that point to the BIO pages.
>>>
>>> This, the SKB represents the data on the wire, while it is pointing
>>> to data that is already placed in the destination buffer.
>>> As a result, data from page frags should not be copied out to
>>> the linear part.
>>>
>>> As SKBs that use DDP are already very memory efficient, we modify
>>> skb_condence to avoid copying data from fragments to the linear
>>> part of SKBs that belong to a socket that uses DDP offload.
>>>
>>> A follow-up patch will use this interface for DDP in NVMe-TCP.
>>>
>>
>> You call this Direct Data Placement - which sounds like a marketing name.
>>
> 
> [Re-sending as the previous one didn't hit the mailing list. Sorry for the spam]
> 
> Interesting idea. But, unlike SKBTX_DEV_ZEROCOPY this SKB can be inspected/modified by the stack without the need to copy things out. Additionally, the SKB may contain both data that is already placed in its final destination buffer (PDU data) and data that isn't (PDU header); it doesn't matter. Therefore, labeling the entire SKB as zerocopy doesn't convey the desired information. Moreover, skipping copies in the stack to receive zerocopy SKBs will require more invasive changes.
> 
> Our goal in this approach was to provide the smallest change that enables the desired functionality while preserving the performance of existing flows that do not care for it. An alternative approach, that doesn't affect existing flows at all, which we considered was to make a special version of memcpy_to_page to be used by DDP providers (nvme-tcp). This alternative will require creating corresponding special versions for users of this function such skb_copy_datagram_iter. Thit is more invasive, thus in this patchset we decided to avoid it.
> 
>> Fundamentally, this starts with offloading TCP socket buffers for a
>> specific flow, so generically a TCP Rx zerocopy for kernel stack managed
>> sockets (as opposed to AF_XDP's zerocopy). Why is this not building in
>> that level of infrastructure first and adding ULPs like NVME on top?
>>
> 
> We aren't using AF_XDP or any of the Rx zerocopy infrastructure, because it is unsuitable for data placement for nvme-tcp, which reordes responses relatively to requests for efficiency and requires that data reside in specific destination buffers.
> 
> 

The AF_XDP reference was to differentiate one zerocopy use case (all
packets go to userspace) from another (kernel managed TCP socket with
zerocopy payload). You are focusing on a very narrow use case - kernel
based NVMe over TCP - of a more general problem.

You have a TCP socket and a design that only works for kernel owned
sockets. You have specialized queues in the NIC, a flow rule directing
packets to those queues. Presumably some ULP parser in the NIC
associated with the queues to process NVMe packets. Rather than copying
headers (ethernet/ip/tcp) to one buffer and payload to another (which is
similar to what Jonathan Lemon is working on), this design has a ULP
processor that just splits out the TCP payload even more making it
highly selective about which part of the packet is put into which
buffer. Take out the NVMe part, and it is header split with zerocopy for
the payload - a generic feature that can have a wider impact with NVMe
as a special case.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
