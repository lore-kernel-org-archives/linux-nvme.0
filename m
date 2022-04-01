Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4BDC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 02:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pK4tyBfA3bEbxgtyBUBSotAlH+ifeflAX1W+Ob8TM00=; b=SIDshdWhbzN6osHBO+lpKFVnxP
	2t1FBHtLNRhf4XkNmEtch1EbrXax1X/AHDX8tUbG9y8PCsHHGCQhbDw1prA4l48DA7kSzNUroR3lu
	Xyx7s/FdHttlc11NxhLv+hCNN7FStUnYu4HgCVrZncAmrwJyouUXJ+OuS7c1vQ9feeSry68uxDyje
	swlDdPh1vQKOmcmZPiP3Qh5JAwpxSARNxUQ0ZSgAcC62KWBJiUiH6xI6P6+YhpLWxU6xZlwUz1V18
	3yLFmK6QJHkgHIZrq8RxSD0Bqkq1/4fvWowGgrtNGm7VvFADWQ1i48My3EPgdvniNsFRDHB8FUFeu
	tFdVePCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na77C-004Hz1-EN; Fri, 01 Apr 2022 02:34:18 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na779-004HxR-TQ
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 02:34:17 +0000
Received: by mail-oi1-x22b.google.com with SMTP id b188so1452231oia.13
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 19:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pK4tyBfA3bEbxgtyBUBSotAlH+ifeflAX1W+Ob8TM00=;
 b=Mt2brRA4775fLEWdpYfxvpvKDDTgy4aNuuCzFnVcSU29F/RTNr6T8WnNggdqbYVogB
 cZcU1nL6X5d7XiYXtnQKr/oAjFLTAgWMAOrj0kUn1yaySiebC5jHuMK5MySQMApOEUqQ
 ar9J+C2MBoGeOmkNN9h5guTko7HZ7wbCt8EA3e0YRENcmvtg29WRcNiqqqRYNmZveCvk
 2MHEF/HcRhtUTGsWM0Ze6RdUT5qkiGbV9aLrZyBNBfIjMZPww5um1ff7NFjJoiMLiTF6
 T08kgYskINDQgvYjetCSqLQka5YFnbnpBI29F3v/lMdZfgQ5U4/yZB5j+z4DrNHvLC0I
 k5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pK4tyBfA3bEbxgtyBUBSotAlH+ifeflAX1W+Ob8TM00=;
 b=5t0a8isP5Q++rzUqsi62jgsGUhStwjwWfsASbJLjMgluOrp7P8CkwyR4WoVJkS1iHE
 uFuOrl+ouueNZts2qznVCO6kcUVxyCGScFiVlzMXBtSKoG+x05CjcU4cRflthXRDivtJ
 f2slcg5LR6oEg7wBlAJutb6bbo2ISBe2LsSGxvmbQKLFpFL8w6OwXiD0uQLR7rloJkmr
 eJfYznZhgKl/S1hAKNsq3vYjDcJNfBEEqiehXE+j2oPNrROX68RPtZTgUFLWXPPJkc8F
 hIRDWTHpwJH/LcDGUHh0pb6ANs7Ka6D5XWofwzU5E+S1mgG3aktZeL83O/JCHII/KaI/
 IHFQ==
X-Gm-Message-State: AOAM532FyUGyBmjEYD7D8Nt+mxb5XkQyUsvykw0ivw60eEeNDRBYI/y0
 EBWRLxrP8Wj3tB6u/GBVu4aIe2+b8GD853coIeY=
X-Google-Smtp-Source: ABdhPJwsuMrJeRG2Xq2Tal7zrithBAIkM9ciuFki8krG7+387XaljgePmf0vfC77RoDc9pO2azGIW8dpokfkuPMuaiA=
X-Received: by 2002:aca:2407:0:b0:2ef:5c86:5a09 with SMTP id
 n7-20020aca2407000000b002ef5c865a09mr3880084oic.160.1648780453322; Thu, 31
 Mar 2022 19:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
 <CA+1E3r+Z9UyiNjmb-DzOpNrcbCO_nNFYUD5L5xJJCisx_D=wPQ@mail.gmail.com>
 <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
In-Reply-To: <a44e38d6-54b4-0d17-c274-b7d46f60a0cf@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 1 Apr 2022 08:03:48 +0530
Message-ID: <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Keith Busch <kbusch@kernel.org>, 
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_193416_013799_DA17E5E5 
X-CRM114-Status: GOOD (  22.65  )
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

On Fri, Apr 1, 2022 at 6:55 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/30/22 7:14 AM, Kanchan Joshi wrote:
> > On Wed, Mar 30, 2022 at 6:32 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
> >>> Ok. If you are open to take new opcode/struct route, that is all we
> >>> require to pair with big-sqe and have this sorted. How about this -
> >>
> >> I would much, much, much prefer to support a bigger CQE.  Having
> >> a pointer in there just creates a fair amount of overhead and
> >> really does not fit into the model nvme and io_uring use.
> >
> > Sure, will post the code with bigger-cqe first.
>
> I can add the support, should be pretty trivial. And do the liburing
> side as well, so we have a sane base.

 I will post the big-cqe based work today. It works with fio.
 It does not deal with liburing (which seems tricky), but hopefully it
can help us move forward anyway .

> Then I'd suggest to collapse a few of the patches in the series,
> the ones that simply modify or fix gaps in previous ones. Order
> the series so we build the support and then add nvme support
> nicely on top of that.

I think we already did away with patches which were fixing only the
gaps. But yes, patches still add infra for features incrementally.
Do you mean having all io_uring infra (async, plug, poll) squashed
into a single io_uring patch?
On a related note, I was thinking of deferring fixed-buffer and
bio-cache support for now.

