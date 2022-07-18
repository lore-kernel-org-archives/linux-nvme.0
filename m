Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1D4CCA479
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=awB3IScCM82ThTtG2SFehRsEwEakyzEv6teXUnsFMUA=; b=oFLmcTgCg1lHkZJuiBXOXGrfIn
	1L1gRMq32mmt5H/VjGMChd2F69304xMn2hxVoyW+MAd1z3IttdRhRfPXsHwicclZZpOKmEhO/JkRD
	OOcfYXQixt6DjwTCLKDP2ZFCQWNNGKq7FsqC41r0kERuWW5jpDHeBTG8H0eMsfdMMg7bOHvOKodoL
	H/NBQV22WzDCEZxvLOqdnykQ9Von06CXLAv9xSk2YPD2OlcScmQYB0vfilwDwgLLhuGJjUd7ihlqU
	OxeKU/881k+AAzyQK0hDK0YVZkjYwLhhKHmoN71pcHsHvLHD0jdHuDT/WLCBFB/E9lj13wXc/RQp9
	ZFqImMkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDS9x-00FxIu-35; Mon, 18 Jul 2022 14:55:45 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDS9t-00FxEn-RW
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 14:55:43 +0000
Received: by mail-wm1-x333.google.com with SMTP id o8so7299026wms.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 Jul 2022 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awB3IScCM82ThTtG2SFehRsEwEakyzEv6teXUnsFMUA=;
        b=xpExZ3kZCdk2WKHRKvNTZvS7M91X0EEJtGhiw331LmrtUZOYjX68OUTX0PXvRoq9Mg
         rqRaN2pueOU9+e0THRE0dnpvpdRcP3K01m4gEUfL1uPoqfF0O0ihsPtN58yxHoc7voDY
         1cQFrVWgDcoMgZ2WmrmEL8uzt0DB4SWAnFV2j4Taehtrz8/xQLX0L0ptEmEwFjp60GVk
         0S5wr44rR8pwrLJpegsNUKKkLGK+MuKZxkjnEkCS7p+fYa7uxUteoCgcGecUQA0ED3RN
         YE1oRr4rJnXM+3ZYpfeYSI/rtdPEpucaIulaDfXRio1x4Wkz9vHEqUBu5M1jnvusK3wR
         CITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awB3IScCM82ThTtG2SFehRsEwEakyzEv6teXUnsFMUA=;
        b=v4KSPzlcSJAY5hJOLXt0Eck9sdzAmjKtDXChXUtyfNrYxnsU2uQWGlt/Qtf6QZBviN
         3BE2PtI2dmySXhZL2+lmzSoii5ccxV8Z+hS1k1X/1ObMNWS7dlC+umYndpYTgii9oPxe
         NCf3wnm6PDqGxCX2GRJL/WqynGQDY33zQeX9qN4o5kQapZYTfs2mQGs1Hn+QF5atqPSu
         8Yp3w3LbyoGrwxWNn/K0Xlb6puZqBi8zEcy6ZMRcNgWPbDHHVYKUDFLVdZResdf+xwza
         c+z3NjHMqs7NyU6PaQXYz/TjK5/XdJBe5FYi1kJgdMpekWCtqS/n7SwlwAnM0YIKKdbb
         mQOA==
X-Gm-Message-State: AJIora/JGmyyaga6Ze865rYiRwuLrRK2oFpAOl07HsVn+EwbmIUoFp0c
	LUQrQgTm49wOYstSpsKoSUvhiIY2+Am7V7zQKoJB
X-Google-Smtp-Source: AGRyM1tH7+KDgIRxNaY2LGntFQMixVhfjpDqcUF6WGCiIIg9/YcIi0aQwTC6+2UR286rXvWRV6cy1fT2sqKQ7U2WyyY=
X-Received: by 2002:a7b:c3cc:0:b0:3a3:8ec:d69 with SMTP id t12-20020a7bc3cc000000b003a308ec0d69mr17787022wmj.78.1658156135929;
 Mon, 18 Jul 2022 07:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220714000536.2250531-1-mcgrof@kernel.org> <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org> <CGME20220715184632epcas5p36bd157d36a2aed044de40264911bec05@epcas5p3.samsung.com>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com> <20220716032041.GB25618@test-zns>
In-Reply-To: <20220716032041.GB25618@test-zns>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 18 Jul 2022 10:55:24 -0400
Message-ID: <CAHC9VhQKeufrqN=dVZ74wEFgd3K=KY-aEZafYembT738juzWUw@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file op
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, casey@schaufler-ca.com, axboe@kernel.dk, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_075541_920222_4B8BE4A4 
X-CRM114-Status: GOOD (  31.71  )
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

On Fri, Jul 15, 2022 at 11:26 PM Kanchan Joshi <joshi.k@samsung.com> wrote:
> On Fri, Jul 15, 2022 at 02:46:16PM -0400, Paul Moore wrote:
> >On Thu, Jul 14, 2022 at 9:00 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> On Wed, Jul 13, 2022 at 11:00:42PM -0400, Paul Moore wrote:
> >> > On Wed, Jul 13, 2022 at 8:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >> > >
> >> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> >> > > add infrastructure for uring-cmd"), this extended the struct
> >> > > file_operations to allow a new command which each subsystem can use
> >> > > to enable command passthrough. Add an LSM specific for the command
> >> > > passthrough which enables LSMs to inspect the command details.
> >> > >
> >> > > This was discussed long ago without no clear pointer for something
> >> > > conclusive, so this enables LSMs to at least reject this new file
> >> > > operation.
> >> > >
> >> > > [0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com
> >> >
> >> > [NOTE: I now see that the IORING_OP_URING_CMD has made it into the
> >> > v5.19-rcX releases, I'm going to be honest and say that I'm
> >> > disappointed you didn't post the related LSM additions
> >>
> >> It does not mean I didn't ask for them too.
> >>
> >> > until
> >> > v5.19-rc6, especially given our earlier discussions.]
> >>
> >> And hence since I don't see it either, it's on us now.
> >
> >It looks like I owe you an apology, Luis.  While my frustration over
> >io_uring remains, along with my disappointment that the io_uring
> >developers continue to avoid discussing access controls with the LSM
> >community, you are not the author of the IORING_OP_URING_CMD.   You
>
> I am to be shot down here. Solely.
> My LSM understanding has been awful. At a level that I am not clear
> how to fix if someone says - your code lacks LSM consideration.
> But nothing to justify, I fully understand this is not someone else's
> problem but mine. I intend to get better at it.
> And I owe apology (to you/LSM-folks, Luis, Jens) for the mess.

Thanks for your honesty.  If it is any consolation, my understanding
of io_uring remains superficial at best, and it's one of the reasons
I've asked the io_uring devs to ack/review the LSM io_uring hooks and
their placement in the io_uring code.  Developing a deep understanding
of one kernel subsystem is often very difficult, doing the same across
multiple subsystems requires a *lot* of time and effort.  We have to
rely on our combined expertise to help each other fill in the gaps :)

If you are ever unsure about something in the LSM layer, or how a
change to io_uring (or any other subsystem) might impact the LSMs,
please don't hesitate to ask us.  It might take all of us a little
while to sort it out, but we can usually get it working in the end.

There shouldn't be harm in asking for help/clarification, the harm
usually comes when assumptions are made.

-- 
paul-moore.com

