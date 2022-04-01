Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8799C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gK4aGIYEgAhXDfx1cDepQ0HM6CbjsNwz+Xvd4R4OCLM=; b=nO70ZbcyPeGRgL/DwEW+G55k7e
	ZtlrlZYtGVxPYTP+oK8O34iVtgnRNGnP/DUUSOkDU7R8nrTqQq4czS1zAZjbrKiC0vSfRRWzOhWv0
	8vqczO83guKFGHamc8ZfE2aBF9d8kyMOP1Ttj5goucHdbN5YcsJAROEunAwJJdwHKkm2ZQfLxEazS
	oemKf0l+q662CJDPWc/SvPpk4ucV103rOLjWsALWoMxfuRqSpoH1+ZVcS8xg5N9a+1H3BCF4aFcHz
	hCLJKBkXby6S4bNhBYcpDC9SrE7/jirtDugQUdzmLtYGiBNdqe4wfxqW9uEeLENhm0xDDERowOgwx
	Qwba1KNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naAq0-004f3U-98; Fri, 01 Apr 2022 06:32:48 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naApx-004f1c-Jj
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 06:32:47 +0000
Received: by mail-oi1-x233.google.com with SMTP id v75so1928380oie.1
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gK4aGIYEgAhXDfx1cDepQ0HM6CbjsNwz+Xvd4R4OCLM=;
 b=VTta7BHgoG/FRAGIVOU4RMsh/ihKCZYnDPyCSQVY5CdQUnLvIjZRhVmOrDvdomVR2p
 n9tCXXSnQVgRIlwBgHQLjWdGqBbS1Xk4+TYyYJO/ZfxlNkeFRVPx/dAVMHgCRIn17mGR
 aL+ohpd5ha0c58kJQXvmYvRJ5Y/uOYhtlqRWwQ14Rgy1rfuHzXtNzof2LeCqAd5JPEtX
 cc53yHhZ2GrloGI1tnTHiQF7tuaakavRDOpd1LgJkidyaA2MACVyJFiX5ekHLMSh7IRz
 V/9rYJFDD2ZrzRJYIyFhzJPnL+VziDaUyZCEJAl8lCSeFUWhue6rSINy6m1XFnN07VCf
 oBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gK4aGIYEgAhXDfx1cDepQ0HM6CbjsNwz+Xvd4R4OCLM=;
 b=iY6qAS6bDpUPIyMK3V8RXPNUiSU54QmaEANrFqYGmiqLU5pOR98wz30vQLQWuLflm+
 3PBxlK6uwBlSF9GS2kjTjvOURCDxIiip7ZdKmAqGxhNE3Zk1dW7COCQ6pGuXRFm5mSSx
 OYMmSH5huc4uyshC53bBOFe41KpI67CST+lrCFeds1+zr+owQF/3BiSetmwoLsOj6OUy
 3WvHMYKctnZ+YlKOlxd46J/E0WOmnqeTL1rM8YJOH9yLb2Hu/PQLjnn5owevXNBZXy2p
 Py0uYR6spRAmaiYBVH0NujnLh9qUa/2rokrIBkf2bi7p1LdAl1+L9fx6XbaP9rNEJfTb
 9ZVA==
X-Gm-Message-State: AOAM533BVXRjtHr6EYsveRyTRSM42qaaYCOclk1WxjQrehG9SF0bKpU3
 pKeEoM02koBTr2Ysodnk54CYj1I59r703agRGWNCXZJYcdVqcg==
X-Google-Smtp-Source: ABdhPJyl6sH5UieKP62jvxcmEFGr5+PCOf1hUKaBxMgKOisnVDIjfo1v3QE5lzXugafhF9mZkkAmfnBk9mN6d5T5aqw=
X-Received: by 2002:aca:2407:0:b0:2ef:5c86:5a09 with SMTP id
 n7-20020aca2407000000b002ef5c865a09mr4154475oic.160.1648794762589; Thu, 31
 Mar 2022 23:32:42 -0700 (PDT)
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
 <CA+1E3r+CSC6jaDBXpxQUDnk8G=RuQaa=DPJ=tt9O9qydH5B9SQ@mail.gmail.com>
 <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
In-Reply-To: <f3923d64-4f84-143b-cce2-fcf8366da0e6@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 1 Apr 2022 12:02:17 +0530
Message-ID: <CA+1E3rL+=h3enUGGe_4m++-NztfT-t84foiDVK4QZ4AfSxGPfQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20220331_233245_709271_3D9F57D4 
X-CRM114-Status: GOOD (  31.20  )
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

On Fri, Apr 1, 2022 at 8:14 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>> Ok. If you are open to take new opcode/struct route, that is all we
> >>>>> require to pair with big-sqe and have this sorted. How about this -
> >>>>
> >>>> I would much, much, much prefer to support a bigger CQE.  Having
> >>>> a pointer in there just creates a fair amount of overhead and
> >>>> really does not fit into the model nvme and io_uring use.
> >>>
> >>> Sure, will post the code with bigger-cqe first.
> >>
> >> I can add the support, should be pretty trivial. And do the liburing
> >> side as well, so we have a sane base.
> >
> >  I will post the big-cqe based work today. It works with fio.
> >  It does not deal with liburing (which seems tricky), but hopefully it
> > can help us move forward anyway .
>
> Let's compare then, since I just did the support too :-)

:-) awesome

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

We have the handling in my version. But that part is not tested, since
that situation did not occur naturally.
Maybe it requires slowing down completion-reaping (in user-space) to
trigger that.

> I also did the liburing support, but haven't pushed it yet. That's
> another case where some care has to be taken to avoid makig the general
> path slower.
>
> Oh, it's here, usual branch:
>
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe
>
> and based on top of the pending 5.18 bits and the current 5.19 bits.
>
> >> Then I'd suggest to collapse a few of the patches in the series,
> >> the ones that simply modify or fix gaps in previous ones. Order
> >> the series so we build the support and then add nvme support
> >> nicely on top of that.
> >
> > I think we already did away with patches which were fixing only the
> > gaps. But yes, patches still add infra for features incrementally.
> > Do you mean having all io_uring infra (async, plug, poll) squashed
> > into a single io_uring patch?
>
> At least async and plug, I'll double check on the poll bit.

Sounds right, the plug should definitely go in the async one.

