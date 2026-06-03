Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C6ACD6E4A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Iynfz1W1N4GfIpEnhSfMfTKqIz/C/8nZcfTGa23ppGE=; b=gN8BOXPCfgWvNsL6Z0TMHORfsq
	fdY3V2QlBfLCpGqTtW0aLFd7FeC7IHFvUkIDTzsu8BwswI59EtMtkFS1ILWlDl29KwQe9AiROgh+X
	gDP+PeY617eVQdmaS9akGpiubxSQpN7Kro9eUwLmrKtEDzA7BRWTSQs6Bp5pSSZYj6pazIKvlq75e
	qu42jLg89aicFxJ0avy+63AYt/Jg9Sq8xj0k8Eqf7z1Z7ECteZIywvMkwyTvkCNjQBe3KyLMdGk29
	HPosc5jVu9S3ncN8U/mPmR7BRRIDUS0TeQES/kz0tUJjHEF48Rpn1CD2e4Rq33iZuWkCvjzsD8V+Q
	8yL+REDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUk2f-0000000EyEV-0oNO;
	Wed, 03 Jun 2026 11:45:49 +0000
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUk2c-0000000EyDa-2L5J
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 11:45:47 +0000
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-7e6d991991dso1447558a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jun 2026 04:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780487145; cv=none;
        d=google.com; s=arc-20240605;
        b=WbMEsIJjnVL/exwuElw9eIbkzNo2SoJDdSawLFw7xzIIBAeC/d7TAA5tEwt3mjgM1L
         Za8LXy2CBK9lb+OTpE9Mld2cFvSjY34Lpv36RyZ6/LLjgyeiRf1UVOvrINtKtrZ0iXbP
         MW56S6ogjfQt+Blf5tD/Slsb4U+pAx5qRNKrxRO1YZ7ChwKnWsoPjM9JJcaZTwuDw932
         J+p5Xr6UtpJc0F53uYDupgo00BzDYygl1vZoksFpZVYNhqDRhS/Zrc4uY/KqnJdytrQC
         PEmk2nxxLIZFz4kpDkWGiPf3dekYU9iHSk8tkIl5ErZ/KBfAj9qJJFWSaxKxQBp3SwIU
         I5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iynfz1W1N4GfIpEnhSfMfTKqIz/C/8nZcfTGa23ppGE=;
        fh=Dgbj3EBcfdLCLF3s+jpr94lLa5N4H7N/Vi3pWmOCaJs=;
        b=HSVmmgt1gUNczQhjW/xEnNWGbjLg7jpjojsurpq94lSIKNgGHKF7a6vmlzaoCvl+nS
         m71ZcsHBx1B0AKtplIeII1I48Q1YcIQb76uOB+02flAdZ5Y97rwr1CACueev77DM9r9w
         Srr/3twVxg5Ch+G48pDYKGDj6+A16uB8tZvxnLoFFl2YKmIlxMQv5yf0hk/DTA2K1Xr3
         DoJCchQWpvYHUBuQbdkmp8FVWeWXDraiWnuRCtz8J7tZcjjvmfMYnJVJUQKhT4wKsh8k
         1a4eN+QR24/qWXZA4/hDP/duKKyIAXprFTy+GqjaL+MThELd+B/O56XSI1+NN0K2ZEpJ
         4h4Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780487145; x=1781091945; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iynfz1W1N4GfIpEnhSfMfTKqIz/C/8nZcfTGa23ppGE=;
        b=KN6xKPuL4Y841FmR0A79bGsCgZBarPt6jAx8OevkH6qUUMkq+evzQ2HkLfBkfyyY7B
         roEGjc0pRf0mwlTHxah3qwr4SUOROqYA5xHGYrTGqHn5A9AOuGAHpgitPB85J1fuwP6z
         UZMnWe4QvyL9ybHsNgy0BEtgT4AyghJ3E4+CWM0Pt8ZuuSD01rwznUbA3URW1BBxN+wq
         KnQA1Cur22B0iNSod1qwY2pm5fSrVFcGPsXrh5tri7iMmpq7gveXQluFx3qe6ssFhkIa
         CK7kV2t+M8bNIP2S3MGPV6ckBVOBURJCvsvRoJRZp2YGxvIhgoKVyoDUzidf7EBkbuIe
         yFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487145; x=1781091945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iynfz1W1N4GfIpEnhSfMfTKqIz/C/8nZcfTGa23ppGE=;
        b=RojAVraSqQCm7EAGcGR2pDJeu8jr/Zgilbsz8NefzCeLuFpKc4yOqs4hFL1kiFC8W6
         ZRPhp+8sm9NTFvUvM02ex+SsI4/Waxh9c3ztsGv1AjkpeE1I1LLncejqEJqOPJ39sbl+
         Q1FMIp1HBlU5LBNeDYtHwT5/kqDg/OA3mC2NxxiHd+EYW6FjH59tEsRvcbEL5VO1TP0i
         nDYL6vRVtNXkKGsnly8GtDOIQLWkHpsfvurqKye2h+CLTVvQLbLfs44dbRoSMHcvPczG
         8lkbIlyAO1MFOzgFLOzeiTBYLS0GUXo3IrtpLOxLZTop5BUmTJIy9t+S7QJW44I/TU7s
         Pl8Q==
X-Forwarded-Encrypted: i=1; AFNElJ92qdRtbjUe4gZngIUELuBUp4AO+6Yepw7E7RlRA1udjjLc1D27w9GpZPcI0uW7iS1xfJftnmnKqNR3@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9uIKjBUozlDUUjAhSxryUNbhPwDIPypM4o74EyMUdHNHJpw17
	LzdnfyMemhD9n46BZfkZ3QtR9GM4lMTrOctMdiNXa1GUH2uQvYqwpMqvGYeJv21XqZVjKIJZsRY
	D0xoRSB5WUxaW5osS2UcJJEF0WlveaB8=
X-Gm-Gg: Acq92OGqmJKqJIlMIHgf3A1zEPiO7sIvKQCf1wxyYETC7UzD5OzMbt94nxMs3i5g/Ny
	XkEepq8me37+5MoAd0znsc5ZyjzpwVRsfxl4dWd3IBfAMySwX0KAPuo79VP9FWyR6LAY6XyU/vn
	HU0Uy4VMvr/iT5wRMMPox2weP3gyqCMXnbZ4CTqiJzjEWol5vbnGnwkXZ9CNgXyqEhyhtgTcIQH
	7iYqVvM3p2clLT08JIg4XO0mdMQfFIkbQjrHwgE6aD2ie5uA70CG5KUnLAzfwgg2XKH7Y+7ydTg
	bRcIu8yHWm0BDNaOUeuxLtJD4K4wFET6Gj3YYLmAaUs2zKV633ChtsB0V7U1x1h2InvOwwtBk88
	O2AyyouSiIX+gRciUF8BrGwpG8tOvBPE=
X-Received: by 2002:a05:6830:448a:b0:7e6:c734:94a with SMTP id
 46e09a7af769-7e6e9df435cmr1717770a34.23.1780487145503; Wed, 03 Jun 2026
 04:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260603072205.3291888-1-hanguidong02@gmail.com> <ah_5utfy2oJbUCw7@kbusch-mbp>
In-Reply-To: <ah_5utfy2oJbUCw7@kbusch-mbp>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 3 Jun 2026 19:45:35 +0800
X-Gm-Features: AVHnY4LflgzL8o28wk732XkC7u2yUcX4Dke1kxTIgi6mAtBN5-lOxr2Un6SRfDE
Message-ID: <CALbr=LbQPZNiztjqTCmw3J+iNcXuQRjNgHpbM7TJD1ib+wTZvw@mail.gmail.com>
Subject: Re: [PATCH] nvme-apple: Use acquire/release for queue enabled state
To: Keith Busch <kbusch@kernel.org>
Cc: sven@kernel.org, linux-nvme@lists.infradead.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, j@jannau.net, neal@gompa.dev, 
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_044546_601719_773F121C 
X-CRM114-Status: GOOD (  18.09  )
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

On Wed, Jun 3, 2026 at 5:54=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Wed, Jun 03, 2026 at 03:22:05PM +0800, Gui-Dong Han wrote:
> > apple_nvme_init_queue() initializes queue state and then marks the queu=
e
> > enabled. The interrupt and request paths check enabled before using tha=
t
> > queue state.
> >
> > The existing wmb() after WRITE_ONCE(enabled, true) orders the enabled
> > store before later queue use, but it does not publish the earlier
> > initialization before enabled becomes visible.
> >
> > Use a release store when enabling the queue and acquire loads when
> > testing it. Keep the existing wmb() in place for the
> > store-before-later-use ordering.
>
> Doesn't smp_store_release() already get you those semantics?

Yes, smp_store_release() is enough for the ordering intended by that
comment.

The old wmb() after the store does not really provide that ordering.  I
kept it only because it is not identical to a release store, and I was
worried it might have some other ordering effect with later queue-start
operations.

If you prefer, I can drop the wmb() in v2.

>
> Also, there are a few other places doing the READ/WRITE_ONCE() calls in
> apple_nvme_disable. Do you want to update those too for consistency?

For apple_nvme_disable(), I left those READ_ONCE()/WRITE_ONCE() users
unchanged because they are used for the shutdown path rather than for
publishing queue initialization.

The READ_ONCE(anv->ioq.enabled) only decides whether to issue delete
SQ/CQ commands.  It does not consume the queue state initialized before
enabled is set.

The WRITE_ONCE(false) users are followed by mb(), which orders the
shutdown/quiesce path.  A release store would not replace that.

If you prefer the consistency, I can update them in v2 too.

Thanks.

