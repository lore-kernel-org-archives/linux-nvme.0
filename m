Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313AC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 05:19:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497D922287
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 05:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497D922287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+H1SiaHBFIJmiTzBU0FFRDqC9N8hinUIu+CoQJuB4W8=; b=Uv2q1wJ2TueK199OsJBZsaM+T
	Znw3IeZNR5+vxvQ1beAty1q8qBasJvwustZvE1iA6ST3ru0SNAiIr5qrJ9SPXknSpBNHak1A/3t0q
	o09tjlhjf059GYMqRa2p6m4kkZhQxFay4Jqly16PyeqSOO0XtfwZ9tMkXEqIeRICRJ5QbaYnu3c/o
	guWw7nvZmXpkmX1lJmGwi6wZomqrq+k2KwJZ8EtndD7DtZzl6o11dp6cPQEVff680EJ9MEoqL/Gda
	BkKJiIIo3N6CbXoeKpcL9JIf9ZmSDXDhOV3WuM9QzZ8fbrKtHHN00cMwf4Sl8Qir/4m7cQ1itf2he
	D3mMvBhsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kp2kB-0004ct-17; Tue, 15 Dec 2020 05:19:27 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kp2k8-0004cX-CC
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 05:19:25 +0000
Received: by mail-ot1-x343.google.com with SMTP id a109so18204234otc.1
 for <linux-nvme@lists.infradead.org>; Mon, 14 Dec 2020 21:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TFo6pAamw/C8vc/02hjCiGROhwkSZktycdxG10y7qZ0=;
 b=mVpXqXVxZtcE6fCuBJPyeNUdFd4DPDGHfpJ6BjipAl9/7Gx0LvOTMriLLRFH44Y43C
 xlyhS0qagPyyOvRtlMbVEShJLhgVmoLx1OgLJx/IcA1utBUBSZwpdg6Xxqf7iintVXpZ
 3fn3p3mxyTOtDeJBBHe1SyV/Uv923f470YtbfdsS36dnBrD6zY3oh4UI7cEB7Gd8dyYM
 Ausm0t80bfB+XqFKWW64s5FHZcX8CGN16yPkIrIGKpwlcOnCigAPhVjVmbrMX/YT94zT
 X9VsZXFfonVx32BHmvEbEze1cyb5t9p+udJLvXW6UHsOE3Dv7qPQgcQuJC6NNtCYzCK3
 Xusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TFo6pAamw/C8vc/02hjCiGROhwkSZktycdxG10y7qZ0=;
 b=C4jJeTDl3HBLeAHyJtDkW3kI77teVU7DFUXXbmT8bIkluK1HSNy6hcBVkLSIL8Zg8R
 M5EbxMU8ga1ko69xILvC3bd775BH5msk3nXi+KY01Uov9nFqSObst4iNeZ4rBox16TAJ
 dy35tKzBrtiZnk2BQtZegPUYQi+CmULnJw3x7vBw4wj/wOJmEfy3f6FiC+3UlDsiABzK
 mlCXLEd7DEzpCIGOzshKfnj/+/C9kX/zFL8O30RGemwLxtVXKJ0u29MdtzeIwBoTWDyB
 v39baJF+IMx29aZuMKT7X49jYs8u4Fml8868byxBc970WWZGnDM0EJUakE50eCKcWm+J
 0rPQ==
X-Gm-Message-State: AOAM530vs5PvCaY0Q9jy/4GFWhE5RFgzBTHcjBh5wAHaflQ+GsLsS31x
 XvItrg8noNIWKZkBj9Q5r/E=
X-Google-Smtp-Source: ABdhPJxL6Hi5P/uULO+noA7VRc6fjnRSGZdaXTLpVC3WOXw1MnUy+i70A+TZNvPN4LKWcpBATTEcdg==
X-Received: by 2002:a9d:da3:: with SMTP id 32mr18505468ots.337.1608009560925; 
 Mon, 14 Dec 2020 21:19:20 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([2601:282:800:dc80:1f6:1ed:9027:4e75])
 by smtp.googlemail.com with ESMTPSA id w131sm4872004oif.8.2020.12.14.21.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 21:19:20 -0800 (PST)
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
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <ca9f42e5-fa4b-1fa0-c2a8-393e577cb6c9@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <128d5ddc-ef46-1125-c27e-381f78a49a96@gmail.com>
Date: Mon, 14 Dec 2020 22:19:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ca9f42e5-fa4b-1fa0-c2a8-393e577cb6c9@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_001924_444236_63BA7D41 
X-CRM114-Status: GOOD (  27.95  )
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

On 12/13/20 11:21 AM, Boris Pismenny wrote:
>>> as zerocopy for the following reasons:
>>> (1) The former places buffers *exactly* where the user requests
>>> regardless of the order of response arrivals, while the latter places packets
>>> in anonymous buffers according to packet arrival order. Therefore, zerocopy
>>> can be implemented using data placement, but not vice versa.
>>
>> Fundamentally, it is an SGL and a TCP sequence number. There is a
>> starting point where seq N == sgl element 0, position 0. Presumably
>> there is a hardware cursor to track where you are in filling the SGL as
>> packets are processed. You abort on OOO, so it seems like a fairly
>> straightfoward problem.
>>
> 
> We do not abort on OOO. Moreover, we can keep going as long as
> PDU headers are not reordered.

Meaning packets received OOO which contain all or part of a PDU header
are aborted, but pure data packets can arrive out-of-order?

Did you measure the affect of OOO packets? e.g., randomly drop 1 in 1000
nvme packets, 1 in 10,000, 1 in 100,000? How does that affect the fio
benchmarks?

>> Similarly for the NVMe SGLs and DDP offload - a more generic solution
>> allows other use cases to build on this as opposed to the checks you
>> want for a special case. For example, a split at the protocol headers /
>> payload boundaries would be a generic solution where kernel managed
>> protocols get data in one buffer and socket data is put into a given
>> SGL. I am guessing that you have to be already doing this to put PDU
>> payloads into an SGL and other headers into other memory to make a
>> complete packet, so this is not too far off from what you are already doing.
>>
> 
> Splitting at protocol header boundaries and placing data at socket defined
> SGLs is not enough for nvme-tcp because the nvme-tcp protocol can reorder
> responses. Here is an example:
> 
> the host submits the following requests:
> +--------+--------+--------+
> | Read 1 | Read 2 | Read 3 |
> +--------+--------+--------+
> 
> the target responds with the following responses:
> +--------+--------+--------+
> | Resp 2 | Resp 3 | Resp 1 |
> +--------+--------+--------+

Does 'Resp N' == 'PDU + data' like this:

 +---------+--------+---------+--------+---------+--------+
 | PDU hdr | Resp 2 | PDU hdr | Resp 3 | PDU hdr | Resp 1 |
 +---------+--------+---------+--------+---------+--------+

or is it 1 PDU hdr + all of the responses?

> 
> I think that the interface we created (tcp_ddp) is sufficiently generic
> for the task at hand, which is offloading protocols that can re-order
> their responses, a non-trivial task that we claim is important.
> 
> We designed it to support other protocols and not just nvme-tcp,
> which is merely an example. For instance, I think that supporting iSCSI
> would be natural, and that other protocols will fit nicely.

It would be good to add documentation that describes the design, its
assumptions and its limitations. tls has several under
Documentation/networking. e.g., one important limitation to note is that
this design only works for TCP sockets owned by kernel modules.

> 
>> ###
>>
>> A dump of other comments about this patch set:
> 
> Thanks for reviewing! We will fix and resubmit.

Another one I noticed today. You have several typecasts like this:

cqe128 = (struct mlx5e_cqe128 *)((char *)cqe - 64);

since cqe is a member of cqe128, container_of should be used instead of
the magic '- 64'.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
