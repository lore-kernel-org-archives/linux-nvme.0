Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED84C388F2
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 07:28:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0860220719
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 07:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zq0UxSz1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7ZFF6MM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0860220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=227JacVUxXWP0EZPe04c6Eg/7QuZK08bc7NEn78kBSo=; b=zq0UxSz1hpQ2zlMkO27qYLI/H
	UdLluiHOec5BQue/GF8AV/sQJti7mm3hp8QqE7lGPU0QTscAu9fnV7PAI+1JErWWQtg19Z0nkZU9B
	sBccPrda4gJ2ZSktXNhkRosti7qvFJEReJRGgQpzminbBWyDRrQH98d0FLFdw98Qlq5UbG4sN4MCj
	A2/jiKpWdIbEmgJA7V5exmoUA80PWdyK8HpoVhirWwlZrK0M5AvgrKHYbySQVOAU0+S6FDH3mfgwn
	kClOHo8O8JRP64p7bJK1DuI5ay4R2hQiuuDyEXfMA9rM/zHwGhWTUZmEEUSmmhXhM9mAhdVGB1Lna
	bvlMl4Asg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbf7z-0007al-GN; Sun, 08 Nov 2020 07:28:43 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbf7w-0007aL-9t
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 07:28:41 +0000
Received: by mail-wr1-x443.google.com with SMTP id p8so4688649wrx.5
 for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2020 23:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LF8+xdOvr6XY27NLXGIrhH9dQ/W4uX2IFzyOsBPTrJU=;
 b=X7ZFF6MM5Q+UGnYq4zHa7fwjRKtEaBI1ihQ7Yf3lcgIl0idDe4JEydau9CpyV4A+Vk
 K/QCJ3BLeF1xO6+RN/+A7s8+4bfhEmvhUpiHHQFuoygMqN4l+cdph/mJp7WSL3VsDjh9
 Cft3Ef/8d4IjSSrvS+UBDaElRMDKL9YD5vfwn0BPWUBOeF3YaZyZcC56FpdYMVZCIrPy
 tLMKkdMJPzMyrYn3mOrmtuUVXi00mKgvp2kVzg9yi80B4CUYLyQ1vdxm58oX2UnuHMeI
 05al8bWy4LzdaGGsQITTc+0RXVXWQIjZGntYwWq1Xu2qV9uofsgii7zqdsNXaKjnPBzs
 pFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=LF8+xdOvr6XY27NLXGIrhH9dQ/W4uX2IFzyOsBPTrJU=;
 b=skvfv9NwTpJB9tA695OyHhNLdMdovLeM8D9Skft6fD09dosGVcFEXkngDcV1/Hv054
 sszxfVu5Fz2oUEIb9kIUN+PJNcNSKXhLdCQ81YXpgNA4SBqGMIZLjKUvHnom10d/kTNr
 yBg5NsAXod+rjm++QoIzJDOJvfJvLIgOGHE+CAh+8m7Tj42tPNEmfBripma1/HBnE4vg
 QJ4BtvvyfiJeOSKFOfmzFhcSP03hpjk5fP0B86/2uJPc6evObWt3t7GRomZcwtR/M2VZ
 hJEYO0tbz4l3aG86+g47+mgPuwMZIzJOsCRYl5xGefrOk+ejpIkE10Wot3ImgbyhPIwF
 Ueog==
X-Gm-Message-State: AOAM5311wHz7EG9P9AY9tsFn9t1sGhIPQ0aWoMP26vZtV5uel8aXI5XY
 3rv2BmiGxpasYbV2lZoFBds=
X-Google-Smtp-Source: ABdhPJxyzVaXtjY3y/amwyu0+AcZfR3L/uD7hKjMITwUKi1Vwi2FVIKiPCBWwondvFqnews3UENOKQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr10617928wrm.285.1604820517766; 
 Sat, 07 Nov 2020 23:28:37 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id n10sm9079013wrx.9.2020.11.07.23.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 23:28:36 -0800 (PST)
Subject: Re: [PATCH net-next RFC v1 07/10] nvme-tcp : Recalculate crc in the
 end of the capsule
To: Shai Malin <smalin@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-8-borisp@mellanox.com>
 <a17cf1ca-4183-8f6c-8470-9d45febb755b@grimberg.me>
 <PH0PR18MB3845764B48FD24C87FA34304CCED0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB38458FD325BD77983D2623D4CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <PH0PR18MB3845FDA1C8E6063A03ECCE14CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <5dcbb7b1-f1e2-f436-f211-8f4ef6712e52@gmail.com>
Date: Sun, 8 Nov 2020 09:28:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB3845FDA1C8E6063A03ECCE14CCEB0@PH0PR18MB3845.namprd18.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_022840_362084_B145D8AD 
X-CRM114-Status: GOOD (  17.36  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 08/11/2020 8:59, Shai Malin wrote:
> On 09/10/2020 1:44, Sagi Grimberg wrote:
>> On 9/30/20 7:20 PM, Boris Pismenny wrote:
>>
>>> crc offload of the nvme capsule. Check if all the skb bits are on, 
>>> and if not recalculate the crc in SW and check it.
>> Can you clarify in the patch description that this is only for pdu 
>> data digest and not header digest?
>>
> Not a security expert, but according to my understanding, the NVMeTCP data digest is a layer 5 CRC,  and as such it is expected to be end-to-end, meaning it is computed by layer 5 on the transmitter and verified on layer 5 on the receiver.
> Any data corruption which happens in any of the lower layers, including their software processing, should be protected by this CRC. For example, if the IP or TCP stack has a bug that corrupts the NVMeTCP payload data, the CRC should protect against it. It seems that may not be the case with this offload.

If the TCP/IP stack corrupts packet data, then likely many TCP/IP consumers will be effected, and it will be fixed promptly.
Unlike with TOE, these bugs can be easily fixed/hotpatched by the community.

>
>>> This patch reworks the receive-side crc calculation to always run at 
>>> the end, so as to keep a single flow for both offload and non-offload.
>>> This change simplifies the code, but it may degrade performance for 
>>> non-offload crc calculation.
>> ??
>>
>>  From my scan it doeesn't look like you do that.. Am I missing something?
>> Can you explain?
>>
>>> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
>>> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
>>> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
>>> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
>>> ---
>>>   drivers/nvme/host/tcp.c | 66
>> ++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
>>> 7bd97f856677..9a620d1dacb4 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -94,6 +94,7 @@ struct nvme_tcp_queue {
>>>   	size_t			data_remaining;
>>>   	size_t			ddgst_remaining;
>>>   	unsigned int		nr_cqe;
>>> +	bool			crc_valid;
> I suggest to rename it to ddgst_valid.
>
Sure

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
