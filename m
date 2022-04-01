Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B65EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 06:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oY5lxseEYvVi/FJqL+ODr3hkFa+xrcTeRJyj7dlR1ww=; b=O5R0iKGVx6vTW/1sI/5KjcJq0R
	FJEOf8TlWfRVScQCl4KbAFalf3HpQcwgHYUUmgwv+aYD4l+7u8hlNEtlM39Wadgbm+ZLu9fb7fJyp
	lp2+GYIbW8Qj5lATyMZjy5ahpZl20nNRSycMNyT97aWHIIs/ID47h+P9Ts8uVyk8z1117DSZNbbbK
	f+weGddLpBT6zSMhZvxqc01KyzT4wvR3jqvVPb85vMcuu89OUiVaPIy7c+e6XZw1VJEw/oW7xjG6K
	tkbTzFxmw7VCpPunNPscheoA10JTSbrNfO4IoXiqh5tGdjUtQFPIpFKZ6AcTCiA4h1d39986A1UhI
	PucSSqqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naAnc-004eci-8P; Fri, 01 Apr 2022 06:30:20 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naAnZ-004ebV-Ne
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 06:30:19 +0000
Received: by mail-ot1-x336.google.com with SMTP id
 y3-20020a056830070300b005cd9c4d03feso1505818ots.3
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oY5lxseEYvVi/FJqL+ODr3hkFa+xrcTeRJyj7dlR1ww=;
 b=ArKGrA8IHpSZpGyk7d2dNujVyXNYuBtmPHXI5+93f64a3hkNVDs7C9VdJaglQySAvW
 KrikZDmbySZcRnPeU4o5yIuUsbWqgJ4kHmzYxUWJrvt5s36wtJxPadxTBiCi867wFyJN
 UC+5MDr5YgO5CYJ/xIfPIGx3sO15MXEwzxXfypm9GYZBlwymTlDwoFuKb0dPvwnhlIz5
 Y2+b+wVztK72SxHNRtaBU5hWSRNzGEH0DcnDT1o83yYZbG+yVxx9SOiCHSvEPMR9ws57
 8xpjrbsgioYiZeQuMIPjePThaYagXTafJtHKdr+sN0oxV3h99yBMxZodir/1LwWbqGi8
 3Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oY5lxseEYvVi/FJqL+ODr3hkFa+xrcTeRJyj7dlR1ww=;
 b=rbK987wJlQX34LRC2+K9uSSV4VTrSjyqddCBU0kJvVq00TBbtLsdAGcKyzW1dhOMul
 zfdUWfo0HCROQUU8HJ69Na/1gl8DoFa7jyLUdf56juW6DKATn6CTd/LfFveXr870dysq
 5ACSb5wr3LfKcs0YyJjHT4bhcTxL26N07wxQwtjFJO10/lGmaYsfb2bfDjaLZ0lSpVd0
 MI6LYpuLZEEGjpTDJ0/H+tamywSTwW9n5Sjsu3GK84FC9DRaLZzFBNEBWU6ob7JlsosV
 vZHYdZkueYXM4RqqCfecQjJYHjLKU0X4RDNxnkT+2FAK5eGgUgD0Gt8eD2caNkK1Wkvp
 CNqw==
X-Gm-Message-State: AOAM530t4YfzzFa7ekZYW+yBcgIdthnUTMihEd+Q5DywR8dFBvsgOXWX
 N5jwBjMMdUOKlDQkDBtP3NJd87VJkwsgkH3sjt4=
X-Google-Smtp-Source: ABdhPJyUj9XIGjZCaZawYpyZ+T0i4GQnMMiMyV1w8XVN5XehPlnlO15JMAguEsmtRTIwsCX5KS8+D2zqe8yny8OcM44=
X-Received: by 2002:a9d:6c8e:0:b0:5af:5113:1bd9 with SMTP id
 c14-20020a9d6c8e000000b005af51131bd9mr7063558otr.86.1648794614797; Thu, 31
 Mar 2022 23:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com> <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <910afdf8-ec01-90b2-b7ec-a7644e53259e@kernel.dk>
In-Reply-To: <910afdf8-ec01-90b2-b7ec-a7644e53259e@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 1 Apr 2022 11:59:49 +0530
Message-ID: <CA+1E3r+6BgUCEu_7DYrN-+wnz9MU5x7S1u8-W2H5GwVS1y4Gbg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20220331_233017_806595_262A354E 
X-CRM114-Status: GOOD (  20.22  )
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

On Fri, Apr 1, 2022 at 6:52 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/22/22 11:10 AM, Kanchan Joshi wrote:
> >> We need to decouple the
> >> uring cmd properly.  And properly in this case means not to add a
> >> result pointer, but to drop the result from the _input_ structure
> >> entirely, and instead optionally support a larger CQ entry that contains
> >> it, just like the first patch does for the SQ.
> >
> > Creating a large CQE was my thought too. Gave that another stab.
> > Dealing with two types of CQE felt nasty to fit in liburing's api-set
> > (which is cqe-heavy).
> >
> > Jens: Do you already have thoughts (go/no-go) for this route?
>
> Yes, I think we should just add support for 32-byte CQEs as well. Only
> pondering I've done here is if it makes sense to manage them separately,
> or if you should just get both big sqe and cqe support in one setting.
> For passthrough, you'd want both. But eg for zoned writes, you can make
> do with a normal sized sqes and only do larger cqes.

I had the same thought. That we may have other use-cases returning a
second result.
For now I am doing 32-byte cqe with the same big-sqe flag, but an
independent flag can be done easily.

Combinations are:
(a) big-sqe with big-cqe  (for nvme-passthru)
(b) big-sqe without big-cqe (inline submission but not requiring second result)
(c) regular-sqe with big-cqe (for zone-append)
(d) regular-sqe with regular-cqe (for cases when inline submission is
not enough e.g. > 80 bytes of cmd)

At this point (d) seems rare. And the other three can be done with two flags.

