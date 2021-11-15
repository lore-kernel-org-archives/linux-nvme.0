Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3DFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 08:12:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41B661361
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 08:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A41B661361
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/QzN6P66QKCtajlhiyazBvCk1jl4A3JCWzz8ZWJWmi0=; b=VqTnoi+xxPXQmcd5KOwpm3g9Df
	7Qb6lGTGn933k29KswNuQBfLqubmb8znMZp9Qdy0sCgU/1/NnkVEJA5MTFrWhxUbBdgYV1Clyx6Wq
	Mau2kBUrT7CVrC5XBhJATBUVawUoFoeHDZn9y3iSodp04zobXLSPdGqkj8mizBV5fwxV3m1OphHcq
	5ghJPoAsDFSD6wmhf/Z29C+99WMZlyn4p3JVVZup9nO3wW6eKRgg2rEnbFJ7SxvZaIzhUAOE9IJ8z
	BYGnXo2B9iSJiiKWwyFe6CsnVg2KdZC/Gd7gPn+bLbP8NvcTw+Y99VO1ybehiAgNoLmniTuOZ/nXt
	uQQCUR8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmX6G-00Ee9a-M5; Mon, 15 Nov 2021 08:12:24 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmX6E-00Ee8s-Gz
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 08:12:24 +0000
Received: by mail-wr1-f50.google.com with SMTP id b12so28939936wrh.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Nov 2021 00:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/QzN6P66QKCtajlhiyazBvCk1jl4A3JCWzz8ZWJWmi0=;
 b=Dd3Gna16FitLE3/0BVNYyh5LwRtidLHOHQ784R0iNRQImTVf2Ubcib6w+aanv+N87f
 6XHnxC8IWZZcmJH4DTak0JICkppE0s3izOt7UH0QqqwROeW8t8R9MZK5HdHq79bDixoI
 UW2I5h7VAD6OBNPmN0JQp/Q/FcMssBPsKhkaaU2uyD2xfn5ZRTMVhVpV5Qr5XhbJULtr
 qw44bvMub6ESlpsii1IpzBql9JTIoDajrEGQWu9fIbI/NKmFIt/bclyZ7Ew10PCPceel
 hXgQYKdMcUrcjJC2MLgSgD//V9DQuiRY+tKAeFXC2faD+rM0mttVngwJ/Uzj3Vi3sgXi
 pbsw==
X-Gm-Message-State: AOAM531ZbRkCSokeKLiUaEwoDM7gM5wCFsyANh6Yn4EVZKeON9WUBgAa
 ql7rE14AzXoeOk5x+ZIgSkbWX//nmTo=
X-Google-Smtp-Source: ABdhPJyOCVifzqIyERcNgIQAm4aCQW1Jcw5A1A6A2N03Hy+ORlxCjwACB+MJw4sw9ShnhM8rirLynQ==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr1661335wrr.27.1636963940444;
 Mon, 15 Nov 2021 00:12:20 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id j19sm13658806wra.5.2021.11.15.00.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Nov 2021 00:12:20 -0800 (PST)
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
 <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
 <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
 <0d3e494e-aba0-0c70-4b1f-91887820ff86@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8f3c6dd9-104e-8f0f-78c4-374684743cd5@grimberg.me>
Date: Mon, 15 Nov 2021 10:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0d3e494e-aba0-0c70-4b1f-91887820ff86@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_001222_602213_10571E22 
X-CRM114-Status: GOOD (  28.25  )
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


>> It is unclear to me why the separate directory is needed. But at least
>> call it something else if you must have it.
>>
>>> Especially as I still fail to see the actual use-case for using 
>>> in-band authentication _without_ encryption.
>>
>> Not sure what you mean. For the same use-case that iscsi chap exists
>> for. The secrets are pre-shared.
>>
> And that's the use case I don't really get; the authentication is done 
> only once during connection establishment, and then completely ignored
> for the remainder of the session.

I have a different view on this. Authentication isn't really related to
the datapath, but really only relevant to the queue establishment.

> 
>> Perhaps you can explain? My understanding is that the extension for
>> nvme-tcp TLS based auth is to avoid maintaining two sets of pre-shared
>> keys, i.e just maintain the TLS ones and not the dhchap ones. But maybe
>> I am missing something.
>>
> Yes, and no.
> Technically TLS is independent from authentication, and as such you can 
> 'just' use encryption.
> But if you want to have both there is the so-called secure 
> concatenation, which allows you to use the negotiated shared key from 
> authentication as PSK for TLS.

Well, TLS is a longer journey for a number of reasons which I won't
elaborate here.

> And that's where I think the real value lies for authentication; you 
> precisely do _not_ have to maintain two sets of keys.

I can't say I completely agree with you. There are means today to
encrypt data over the wire. Granted, it will negate possible data
reduction gains, but still a mitigation exists.

On the other hand, today any unauthenticated host can connect to
any fabrics controller, which is a problem. I don't think you should
minimize the magnitude of your contribution as this is a real issue
with nvmeof acceptance in enterprise environments.

I do agree that when TLS is used, it is indeed very useful to not
have to maintain two sets of pre-shared secrets, but I don't think
that there is no use-case for inband authentication in the absence
of TLS.

> 
>>> We could rename it to nvmeof-auth, though.
>>
>> or just add it as more tests under nvme (or create a subdirectory).
>>
> Sure we can. I just found it easier to create my own directory, 
> especially seeing that the nvme subdir has the largest number of tests 
> already.
> But if you prefer I can move it under the 'nvme' directory.

I think that it would definitely be an improvement, also because people
usually run the nvme directory tests which is nice and simple, we should
strive to keep it this way.

