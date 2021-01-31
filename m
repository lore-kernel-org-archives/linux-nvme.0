Return-Path: <SRS0=pTPU=HC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF7AC433E0
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 09:27:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCF064E11
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Jan 2021 09:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCF064E11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gMK7+BWRabYIjgHuqGhrpVzbnF1JY0Xh2pgvVNMz880=; b=m3soq5SGEpyx37/fF09j6+Igf
	3ky9Ec60PBSEG0uRtOKDD7CvVKCtAIjHVbDfDm+O3bhQg4CeAoj7KT1U7a53fxCjFZKeBoiM9ivad
	obyklKBTYWUu3Rr97E/z9XtivOs/pT7TB9vjAbEct6H32eiq0fgUm7Z+KT3qQg3NbWRNPDlAA8unT
	KvRnX/6fnV2UyXHFQx9jTNoSkubFYAruInbukXURrAFcGla76jWixmkJtT769zrAy953/FN8Tj5BQ
	h96KPGsXOVf8663zENVfL3l8FESXwe84JSMnXY3YsCLPJZSu2W/6tZM3Wwt8+EzUmFS+YdfUiyaB6
	aeZExGWwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6918-0001F2-IV; Sun, 31 Jan 2021 09:27:38 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6915-0001Ei-3Z
 for linux-nvme@lists.infradead.org; Sun, 31 Jan 2021 09:27:35 +0000
Received: by mail-ej1-x62c.google.com with SMTP id g12so19492850ejf.8
 for <linux-nvme@lists.infradead.org>; Sun, 31 Jan 2021 01:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DQuz1pa9GvbRd37vkQ2NVh0PZw3uNiGrjR2cuG/k2HM=;
 b=iSxoOmK/bHvymVhs7lEGzAKWPsXzqb96+fBQfcqEz7TWjaRPk/F9y/jNqZmVOM7azD
 uW9kLQidLFRP8nuTbveE+8KZMrFwHiIIeGTE61I1UCAiK4nu70RoMDE83i9WE8WMpAEp
 gBeiKmW06lxxXm/jmyfoggAgPtmQKPOBh1Pw3+rgmmE71Z3TzJNljhxO2QbPJo5uImCk
 T+UQL8TwdO+B3XivVvGloYo64c5tBzJX43OSe3J9RgJEqFMZ9H+Aw/9uFfmygqC9gwSB
 W9OeVyU2c781b1XM/Ve84o2nR4xUE87cnXqbXk6NRtdo5rWRki7SSSszLTtTtm9QXuJ0
 MLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DQuz1pa9GvbRd37vkQ2NVh0PZw3uNiGrjR2cuG/k2HM=;
 b=LA5KDlZPJ1Z0rHvSm7w9WApHdLsNgZzzerSTd9NKhZVKGRdT26B8InSKAoRwsCrX/P
 7KLtt2qGqkDei4EjUE+57rJznmrLDxiFZi7xn6TEfYR93/sM2iHKKHX6EgPX9WUav6yP
 0MuHjFt1Tt4ZjeAqZR+D7413Phdr6fLWCU0hln7Ii3i2iRtgv/ZUw16aXmmGgxc8PZfX
 bHMeDGzz8nGsA5tbD3MTnU9MhDAEYcoAomvdyNzgYtE5sQs8OYe8O/RzLVIRMBAe3ksM
 yC4wP7DvlsRstbwX14D8q1b/3ILHTclMnyo7phb/32NrA9l064F3FmnO8EAvukS9Lwpl
 5KcQ==
X-Gm-Message-State: AOAM533vANUBizv2zqkD389Cr6V6YSHrNZ7xrMkJOdd/LW9cuzI3eImY
 l3/KLJ9td3/ttzbDYSV9IGk=
X-Google-Smtp-Source: ABdhPJxEegalHxQS/egMrax4TUygJ9kqmPPYFJMTrCxpod0Wg/kZYUvmjVWfXpHsq8edhR3KRWHGZg==
X-Received: by 2002:a17:906:a149:: with SMTP id
 bu9mr12692150ejb.185.1612085253859; 
 Sun, 31 Jan 2021 01:27:33 -0800 (PST)
Received: from [132.68.43.126] ([132.68.43.126])
 by smtp.gmail.com with ESMTPSA id r22sm6983019edp.9.2021.01.31.01.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Jan 2021 01:27:33 -0800 (PST)
Subject: Re: [PATCH v2 net-next 19/21] net/mlx5e: NVMEoTCP, data-path for DDP
 offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-20-borisp@mellanox.com>
 <10c28b01-49e5-c512-8670-bf8332b24b1b@gmail.com>
 <15248743-82bf-4283-d8c6-99f2210e42ae@gmail.com>
 <2a0bfce0-6226-7b9a-95b1-15f4f1f321e8@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <f376794c-568b-9b87-7467-dfe433053a4d@gmail.com>
Date: Sun, 31 Jan 2021 11:27:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2a0bfce0-6226-7b9a-95b1-15f4f1f321e8@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_042735_192217_99B21EDE 
X-CRM114-Status: GOOD (  17.52  )
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
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 19/01/2021 6:36, David Ahern wrote:
> On 1/17/21 1:42 AM, Boris Pismenny wrote:
>> This is needed for a few reasons that are explained in detail
>> in the tcp-ddp offload documentation. See patch 21 overview
>> and rx-data-path sections. Our reasons are as follows:
> 
> I read the documentation patch, and it does not explain it and really
> should not since this is very mlx specific based on the changes.
> Different h/w will have different limitations. Given that, it would be
> best to enhance the patch description to explain why these gymnastics
> are needed for the skb.
> 

The text in the documentation that describes this trade-off:
''We remark that a single TCP packet may have numerous PDUs embedded
inside. NICs can choose to offload one or more of these PDUs according
to various trade-offs. Possibly, offloading such small PDUs is of little
value, and it is better to leave it to software. ``

Indeed, different HW may have other additional trade-offs. But, I
suspect that this one will be important for all.

>> 1) Each SKB may contain multiple PDUs. DDP offload doesn't operate on
>> PDU headers, so these are written in the receive ring. Therefore, we
>> need to rebuild the SKB to account for it. Additionally, due to HW
>> limitations, we will only offload the first PDU in the SKB.
> 
> Are you referring to LRO skbs here? I can't imagine going through this
> for 1500 byte packets that have multiple PDUs.
> 
> 

No, that is true for any skb, and non-LRO skbs in particular. Most SKBs
do not contain multiple PDUs, but the ones that do are handled
gracefully in this function.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
