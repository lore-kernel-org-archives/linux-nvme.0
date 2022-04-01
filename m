Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E0BC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 03:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7khBnonEiFThq13FqiG7LKVSQ+MeKxonEXk60vTiZk=; b=0yiFMJeQFu5M1WEIMrH2ujZMg/
	DVaHxdIiNzuAsTrvvGRzR4oAYkVAg1nX+UJokMsSLi8bq2dYeOn/MrlcMh82UitLO1kdekvCX5CGh
	6vn6+MGPe1W5Aj+TYmkilm47aSKMrnHY+33PkL4gwln/DNs1nR7oT9mBLtuOQnLw+BjPjYZUPAfAb
	WfkJTBCUaoy+kstGCkbR8GmACAiwE/V/M8VTLWKpt+yLhotOMGxYCTy3I6eB54G6ofYEl6v75Atmo
	n2RoMEM15C9eZt7lys1zideANPfiV/+fd9EtUhCAro/ImrVEFK0/hc8l0V9XOATtsodlOcE75WbxV
	gy7Aq2wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na7bE-004Lvf-Nh; Fri, 01 Apr 2022 03:05:20 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na7bB-004Lv6-4C
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 03:05:18 +0000
Received: by mail-pg1-x52a.google.com with SMTP id k14so1387927pga.0
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=r7khBnonEiFThq13FqiG7LKVSQ+MeKxonEXk60vTiZk=;
 b=TAg1e9zBJTGmVQlIFL6G6CAqhYDbb5339K7GUDokxjlYMqdwqoz8hphzJUz6vFyzZp
 cBgh7/mOFVp2zT5x90Jr3DZ8JCaY90NURmqmn0Hzl1k9C934soglkbvMvJufqGHACvFs
 JYLLrnAunOVL6MNaKUdtNyh9xbWUVIELUeL62O3Si8bzhS05OWGwUiFQQAvOSI6QtNHx
 cFq/PJrXJzZTa0cwKj5Lx9JM8qfUAOG8uyPzjf/H9eeICIbDnWy8aBvV+OLCxX0cjt/t
 9qH4BGFylh1FGR1l6hX8FIAxJ6i7wfgWG9jalSIiOTKsA+Z5BV0bW4qOUtPSA7Y3m57t
 FJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=r7khBnonEiFThq13FqiG7LKVSQ+MeKxonEXk60vTiZk=;
 b=lj3x7rSIpDJVTO5xT1HIIMbfsbXace/3v7vwPmh8vt40TlttTu6sl83pqhKDCKN4gA
 eep+6coJzE+L2bh+2yegh4kYRqdY58zaWnJp6NPniasbYb5v1k7LVnqxgU23tsuwihLr
 +4cI00qjA2dI2C405bur69VerL3Cm6+qE4RAd3NM7eWrPsTCtZXGN4dEvKDuhYc71RTV
 oZNeVC8glsSulf+F2CKrJcDTDtViYfOo9YIj6TJjWlfUsi2o2SJa+T/ftEVM+DIDi95z
 5tKxR++MN6SUv8dVY/Zi4wW0e3yFrjXExAJFkW7E4ZIDy1JXfwFC5ypWbUlpRlxH5U4c
 wjBA==
X-Gm-Message-State: AOAM5302lWZQ/TGddpWbES6QY1eyoxzPjaR3nwjmL8jOwb8NNyDTSPk5
 bbeIUcgydQxSZq9M+UFDW/9KNsX3MBNpq6ss
X-Google-Smtp-Source: ABdhPJwf62CCz6zDtBAJs+C2QiuuIuYi30RJGbEXPrLs61j0DQUYOxVD0TojYqnwKOjPNvTYR/PrGQ==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id
 c16-20020a056a000ad000b004e12d962ab0mr8542870pfl.3.1648782315250; 
 Thu, 31 Mar 2022 20:05:15 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 ds15-20020a17090b08cf00b001c6a4974b45sm11003304pjb.40.2022.03.31.20.05.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 20:05:14 -0700 (PDT)
Message-ID: <f082f9e9-5ebb-48df-cfca-01cd1770c886@kernel.dk>
Date: Thu, 31 Mar 2022 21:05:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
 <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
 <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
 <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
 <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
In-Reply-To: <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_200517_220450_EB74F962 
X-CRM114-Status: GOOD (  27.02  )
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

On 3/31/22 8:44 PM, Jens Axboe wrote:
> On 3/31/22 8:33 PM, Kanchan Joshi wrote:
>> On Fri, Apr 1, 2022 at 6:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 3/30/22 7:14 AM, Kanchan Joshi wrote:
>>>> On Wed, Mar 30, 2022 at 6:32 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>>
>>>>> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
>>>>>> Ok. If you are open to take new opcode/struct route, that is all we
>>>>>> require to pair with big-sqe and have this sorted. How about this -
>>>>>
>>>>> I would much, much, much prefer to support a bigger CQE.  Having
>>>>> a pointer in there just creates a fair amount of overhead and
>>>>> really does not fit into the model nvme and io_uring use.
>>>>
>>>> Sure, will post the code with bigger-cqe first.
>>>
>>> I can add the support, should be pretty trivial. And do the liburing
>>> side as well, so we have a sane base.
>>
>>  I will post the big-cqe based work today. It works with fio.
>>  It does not deal with liburing (which seems tricky), but hopefully it
>> can help us move forward anyway .
> 
> Let's compare then, since I just did the support too :-)
> 
> Some limitations in what I pushed:
> 
> 1) Doesn't support the inline completion path. Undecided if this is
> super important or not, the priority here for me was to not pollute the
> general completion path.
> 
> 2) Doesn't support overflow. That can certainly be done, only
> complication here is that we need 2x64bit in the io_kiocb for that.
> Perhaps something can get reused for that, not impossible. But figured
> it wasn't important enough for a first run.
> 
> I also did the liburing support, but haven't pushed it yet. That's
> another case where some care has to be taken to avoid makig the general
> path slower.
> 
> Oh, it's here, usual branch:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe
> 
> and based on top of the pending 5.18 bits and the current 5.19 bits.

Do post your version too, would be interesting to compare. I just wired
mine up to NOP, hasn't seen any testing beyond just verifying that we do
pass back the extra data.

Added inline completion as well. Kind of interesting in that performance
actually seems to be _better_ with CQE32 for my initial testing, just
using NOP. More testing surely needed, will run it on actual hardware
too as I have a good idea what performance should look like there.

I also think it's currently broken for request deferral and timeouts,
but those are just minor tweaks that need to be made to account for the
cq head being doubly incremented on bigger CQEs.

-- 
Jens Axboe


