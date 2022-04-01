Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36802C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1dhsfiSnHarafc+SmeCxyhyUIwSltgVfiy2Auaw7XY=; b=YWyfhbb5UQLHxYBb52XQGfmcup
	Hofsc0lFQhJ2ssowyYIjtZdHsH4PwbGshW6IidT6kCrSrUVOFFwkGuq32KlwKw88qeUJJ+rREEsUv
	jiXiwzDfh2Atjwq9E6Z3U+qi6GCXifs0w2Rlhpbe+IPYSsxQWsRx/6bdf921QJCQUL3rr0Frv+mYi
	NVajsFCy6FqXt8JKmNNSJOzR/K6nzbfL3epTqqGBkxRV/x4/Q/POUzqHwwNGVB/wgz2mFa0q8ee8s
	HQDZtiqc/psHpKk+cm33FozlRgo1tpqjYAL8a2bsqDS0QumtoIYqJF2FLPvtgaYHCXaYJMt45ntbV
	Iaqr7T/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na62R-004A0M-1c; Fri, 01 Apr 2022 01:25:19 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na62O-0049yk-Jl
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 01:25:17 +0000
Received: by mail-pj1-x102a.google.com with SMTP id
 o68-20020a17090a0a4a00b001c686a48263so4001902pjo.1
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 18:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=R1dhsfiSnHarafc+SmeCxyhyUIwSltgVfiy2Auaw7XY=;
 b=fQMNa0zR50WmR1S4nBEbfURpZV/PZqj5G/FooiuFfLFx/oSbL6TAO1RmchiopvRUYc
 lRutC+dyKymrdUYXiFz6oX5FW2enISjhKnXTxnce9fBUgsU2EzJ2JAxcy94OjJZyD7sn
 OnK9u+Vn1G6BrK1XubK95JXY7dYXcCOVZn8tDWtT9bGxFbjiE7ajdEO8gV9DYlXdhxnI
 8amhNJFaBdkbukTk88vIooQWmT1w9MMPtDeNAyTG05/fQvSMr3mErWuw4Msdxd6KU2ZO
 3TXMrtiJukjn6feeJpgztxBaTZtHEokjO3ECTzfJLk03IuiGfrbVqMmOuFvfxae+Wy06
 foBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=R1dhsfiSnHarafc+SmeCxyhyUIwSltgVfiy2Auaw7XY=;
 b=VgxSGW8o1ASlzWRsjeNiByzDG3GjUB0t05mTIi83FQf1G8tW4Chs6LanDwMY90sCcL
 9zJWpw2P50bnS8JzVNV8jaFU8lQ4G1k18mW02v9d/F00QY4PGFL3eGnRWewhTNHkEJfC
 feuk0Y+FOC2JbmZlKBaQTlzH2MOQrjk3D4eAifyNEz3cJhr6QXVAnMmkoHyUkDs8rddZ
 Pgn/N3hMhVz/sw4IuUEnyd8U3LanrNFyo7kRSIQKLLhye9xznxtS2EFaaYTisrOGIw2B
 IEtuo3EP5lIv17QVCH2MT2iw/TaNpMwFGzNyK/1GwpVaPDYPAfuEsgoWllPOJ1spfgxm
 GRaw==
X-Gm-Message-State: AOAM531Lbz7x9H2NrLw9YScPYq+OOQ3RQci9kGMXw691sD/0PfNiMCVy
 7e7+kCQ1tw0fzMJyqapPoOPklQ==
X-Google-Smtp-Source: ABdhPJy8855lS5pun2goImSU2Yk45LqwFkuwCtNplt7chwm3MS44jEbh+GGvioT7BUI4sTCb+BnA2Q==
X-Received: by 2002:a17:902:f551:b0:153:b179:291a with SMTP id
 h17-20020a170902f55100b00153b179291amr43675464plf.13.1648776313690; 
 Thu, 31 Mar 2022 18:25:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a056a00245000b004f771b48736sm700240pfj.194.2022.03.31.18.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 18:25:13 -0700 (PDT)
Message-ID: <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
Date: Thu, 31 Mar 2022 19:25:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
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
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_182516_696105_99AE7956 
X-CRM114-Status: GOOD (  16.53  )
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

On 3/30/22 7:14 AM, Kanchan Joshi wrote:
> On Wed, Mar 30, 2022 at 6:32 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
>>> Ok. If you are open to take new opcode/struct route, that is all we
>>> require to pair with big-sqe and have this sorted. How about this -
>>
>> I would much, much, much prefer to support a bigger CQE.  Having
>> a pointer in there just creates a fair amount of overhead and
>> really does not fit into the model nvme and io_uring use.
> 
> Sure, will post the code with bigger-cqe first.

I can add the support, should be pretty trivial. And do the liburing
side as well, so we have a sane base.

Then I'd suggest to collapse a few of the patches in the series,
the ones that simply modify or fix gaps in previous ones. Order
the series so we build the support and then add nvme support
nicely on top of that.

I'll send out a message on a rebase big sqe/cqe branch, will do
that once 5.18-rc1 is released so we can get it updated to a
current tree as well.

-- 
Jens Axboe


