Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61544C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 02:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWtyih8igr9N3NwexuJxuDSMFSnT6hvHzlu33VdYUJk=; b=KBr5+lKLxCyRNCWuN4IbKOLpR+
	5VNPBzV7yz7eOPEMV7v2HMsmkAp6XSBxhE4KzU7Lh3sq3I6f4/KgcMS68fiVM5WX1pntD9/SGeBQ5
	Ne7GdLMSS08CwV0BfyNsNZWT1A7Kc0CT0celchJbm0Fz1HbxZ4lB+CC7cKt3guivThyIaw2Nu0Idn
	ekgRvizaH2Njd+oTBVzjDhe+9JGRr5XQyCqmWoIPVXbeeDg+HVTKxfUrbcPNMn74WzXV55mLka0fx
	PlBlbGl3br/Drr5UV83GL+6nvBoHeN83fequjLWSwGHgPsAFX9EhDsQhHwHu2lFRHrcjqnu1Rs65G
	PRBnwh5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na7Gk-004Jmr-AH; Fri, 01 Apr 2022 02:44:10 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na7Gg-004JlP-Tf
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 02:44:09 +0000
Received: by mail-pj1-x1030.google.com with SMTP id
 mp11-20020a17090b190b00b001c79aa8fac4so4311351pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 19:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HWtyih8igr9N3NwexuJxuDSMFSnT6hvHzlu33VdYUJk=;
 b=CrRSqUR2tTuhZv2izdc3Hwy1yVmoJale25fz+zC/RZ/47NWGIH0+nPvfkWE+2d8q8Q
 RNtrm4qNKYkIHBJpoj9TNbHjtECePEn2l09fu683uFurKZvIloqxiewaQEykEctwvOzU
 hlNKZiD5e0OhKMauNuSbUOlw2D0wWLTAtJkCn8fLH4dpoxKoqvk1+L77VL73gCxhKjX4
 1rBIIFaMufDL3LIsz/YRl1AxZCywLohlBW0dUNMgPjUXJGRs7m+Pb7eqybOi/FmNKui2
 tabf/Ll4ewQqDGYo8LXBtZ3UXJWgtAJE+X/538GpyNSAt8uJBdgB0Po0EzmESHFsnaeG
 KLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=HWtyih8igr9N3NwexuJxuDSMFSnT6hvHzlu33VdYUJk=;
 b=2vf/v8QK6fpJdrAKSvkb7Quf48JkgdwyQaGQt3hvY+CNHCyN+B3VxIFz1rbmHisJlH
 CcwjFFdVDoC1EH94mimXN0R3kpEnCKW7c1FMfIHmpbs5OfCNLIN+Gt1+D4fKnhckrelN
 AYcJNf5fgDmVh5YDbpqfJkMT54V+S2ISlAQSeCW2BPN/Aebr+/eqCwC6OFqn6U5Jlfqu
 pNcrNWB2KUbrKPybCrvLSZrV/oEmzp8EGQTlQFRLtz+A1BMWSIOoLDyBVfsBWrpqw8Ae
 DNg2hiqNt2GLFBdQsoBBLEmepFZKeooqYu0QY0iuwvqK5jzmROASE9GSLondGAg02T4+
 duow==
X-Gm-Message-State: AOAM531Hpe5UG8uq36cnAACdUd7bQkiVYIChSHevEievhlW+NwGmfQ07
 MwY7umbO/7F7HRkceqSTfTME/w==
X-Google-Smtp-Source: ABdhPJw6EzVnlWTDGXWHyAme/hHYmcfZjrGv8JJhxPhRcvIW5tOYienAotqz9breF+R4C2Grr37duA==
X-Received: by 2002:a17:90a:8d08:b0:1c6:5ada:9920 with SMTP id
 c8-20020a17090a8d0800b001c65ada9920mr9482799pjo.126.1648781045575; 
 Thu, 31 Mar 2022 19:44:05 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a056a0022cf00b004fb32b9e000sm852809pfj.1.2022.03.31.19.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 19:44:04 -0700 (PDT)
Message-ID: <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
Date: Thu, 31 Mar 2022 20:44:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_194407_174723_92100510 
X-CRM114-Status: GOOD (  26.16  )
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

On 3/31/22 8:33 PM, Kanchan Joshi wrote:
> On Fri, Apr 1, 2022 at 6:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/30/22 7:14 AM, Kanchan Joshi wrote:
>>> On Wed, Mar 30, 2022 at 6:32 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
>>>>> Ok. If you are open to take new opcode/struct route, that is all we
>>>>> require to pair with big-sqe and have this sorted. How about this -
>>>>
>>>> I would much, much, much prefer to support a bigger CQE.  Having
>>>> a pointer in there just creates a fair amount of overhead and
>>>> really does not fit into the model nvme and io_uring use.
>>>
>>> Sure, will post the code with bigger-cqe first.
>>
>> I can add the support, should be pretty trivial. And do the liburing
>> side as well, so we have a sane base.
> 
>  I will post the big-cqe based work today. It works with fio.
>  It does not deal with liburing (which seems tricky), but hopefully it
> can help us move forward anyway .

Let's compare then, since I just did the support too :-)

Some limitations in what I pushed:

1) Doesn't support the inline completion path. Undecided if this is
super important or not, the priority here for me was to not pollute the
general completion path.

2) Doesn't support overflow. That can certainly be done, only
complication here is that we need 2x64bit in the io_kiocb for that.
Perhaps something can get reused for that, not impossible. But figured
it wasn't important enough for a first run.

I also did the liburing support, but haven't pushed it yet. That's
another case where some care has to be taken to avoid makig the general
path slower.

Oh, it's here, usual branch:

https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe

and based on top of the pending 5.18 bits and the current 5.19 bits.

>> Then I'd suggest to collapse a few of the patches in the series,
>> the ones that simply modify or fix gaps in previous ones. Order
>> the series so we build the support and then add nvme support
>> nicely on top of that.
> 
> I think we already did away with patches which were fixing only the
> gaps. But yes, patches still add infra for features incrementally.
> Do you mean having all io_uring infra (async, plug, poll) squashed
> into a single io_uring patch?

At least async and plug, I'll double check on the poll bit.

> On a related note, I was thinking of deferring fixed-buffer and
> bio-cache support for now.

Yes, I think that can be done as a round 2. Keep the current one
simpler.

-- 
Jens Axboe


