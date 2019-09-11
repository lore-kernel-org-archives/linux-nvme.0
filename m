Return-Path: <SRS0=M8F8=XG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01880C5ACAE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 22:18:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69B02085B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2019 22:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DVfwIVnk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKf+Bx2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I7b5TrmztJ9uuaxMAEilA/wdpzfeEJuZWaooUZjeANY=; b=DVfwIVnk7nDqPD
	XpR5dp5qDEP3oujadBJRi5dqCapy7lPXn9S6M2eAo0F1rz8SWnhUBg/PQbPeK4t5OfBaAhQh/h4pQ
	tuNsRUqZ3JCaQMcJ/e8uwnaQTycjBfOE9HVwUsNwg3aMCpCwfftrzI/pjPQBKwU3+LZKJuQLfcBd6
	Ohjh/sfUFslsbjLLBXQhQjbZ/iOE4eKNhSAG6FUl3XrghL96NY6kvXsyIgoUivR0HgeDSDDeYQgsH
	XsBoNAEgUFpXcfx63KphZ/+PbKkCouPqQX6ZRRMBkbbtfLi6NfJ/SZ7Oj24sY/0x9pFuQX/dllfBe
	e5u9a4bOxPxeXcVak3pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8Awp-0007rQ-Ud; Wed, 11 Sep 2019 22:18:47 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8Awl-0007qv-Nk
 for linux-nvme@lists.infradead.org; Wed, 11 Sep 2019 22:18:46 +0000
Received: by mail-lj1-x244.google.com with SMTP id y23so21315180ljn.5
 for <linux-nvme@lists.infradead.org>; Wed, 11 Sep 2019 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YYPZjqVFeTKtC5fFBJy5p2xhCEzihUmpj3JugWAlHQc=;
 b=DKf+Bx2Mm7PKVq3sa6xruXc32c1xCVB9cgUxbSD/cezevVPHYtu67U93s3lL2jdvPM
 LoN8IUOa4JhmpsA+Uu+ZQPZ2qQgX4+TBrHpnMxN4t3Bs8o62m9uhwQMVdgHEpDpzywv0
 1tGCczjkYO4NhTJnWLP51NBeir3eAwCRcjQZUqvUmngkM8y0PtvoT4xNccwI33N2ZKQA
 HEVmu3ldRwqhBdGjPeykuBArqowntCgD7SqMWOYwyG2y6YtzXMdDAl41zcaCFHSzIjRL
 VSglC0PrgQ2xUsP2iL8MoEIjkSxyy47HvnKExeh0GZ0R2LyX+9iZYqXm7PHFEYt5sC2q
 MlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YYPZjqVFeTKtC5fFBJy5p2xhCEzihUmpj3JugWAlHQc=;
 b=OewBEIe1EwbjlwimMxuP6duEgmx+rAOZP4TsOLCdcaKnF98d50ep/Az+Cc8v4/Wbsz
 f/xrg8gj4WRt3ZcvwmX5BUmZhLKDo70LoAuhVVYMQfdJOVZlv+R1oGEzwp/p3lZuPS/6
 lq1r3iNXiy3YNhUTaTldQeMO5TiiIl130lfT49aDyHkzJpNY+oHauCf6IB4CG9/MfY18
 20CIKdO2oljrhJKwLgbLqE9R3MCcnoUsM3nVkeeuHBWaz2zHVHOl8wi+uR/KTgDeOByv
 14JNEyEyEnXeTgGStxBJ4f0PhCu53QltwrrjOgDI/1rUhv1xTUPYYeTmlgoVHzjSgYN5
 zsQw==
X-Gm-Message-State: APjAAAWnXdUxfrGQhV9avkSIm3DBQTnr9NDjuKHmsDZjZvyk5zi88jXO
 HJX7eD6ZsILpPQow1UV/dr2F9pNO5O921xK2aw==
X-Google-Smtp-Source: APXvYqy41t37T+leAmtkmNzYYvqmCCXlVPxMlzOZ/lNcbnh/UNjp/OXUUlj1Kl89C6uklAVHDh9iZl/ODTY4arlQqbc=
X-Received: by 2002:a2e:9cd7:: with SMTP id g23mr24585040ljj.25.1568240321866; 
 Wed, 11 Sep 2019 15:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkgjJEHmTT3N42BXkeb+2mDbteE1YwW25cgUpMk7A_sOWzg@mail.gmail.com>
 <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
In-Reply-To: <6a47a06d-f8f1-1865-1919-5ede359d0b10@kernel.dk>
From: Gabriel C <nix.or.die@gmail.com>
Date: Thu, 12 Sep 2019 00:18:15 +0200
Message-ID: <CAEJqkgguW183DsU+JUPcV193HtDXzVsyUa4JEgVKrhumYTzpAg@mail.gmail.com>
Subject: Re: [PATCH v2] Added QUIRKs for ADATA XPG SX8200 Pro 512GB
To: Jens Axboe <axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190911_151843_799203_FF80682A 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Mi., 11. Sept. 2019 um 23:33 Uhr schrieb Jens Axboe <axboe@kernel.dk>:
>
> On 9/11/19 3:21 PM, Gabriel C wrote:
> >   Booting with default_ps_max_latency_us >6000 makes the device fail.
> >   Also SUBNQN is NULL and gives a warning on each boot/resume.
> >    $ nvme id-ctrl /dev/nvme0 | grep ^subnqn
> >      subnqn    : (null)
> >
> >   I use this device with an Acer Nitro 5 (AN515-43-R8BF) Laptop.
> >   To be sure is not a Laptop issue only, I tested the device on
> >   my server board too with the same results.
> >   ( with 2x,4x link on the board and 4x on a PCI-E card ).
> >
> >   Signed-off-by: Gabriel Craciunescu <nix.or.die@gmail.com>
> >   Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> For some reason your commit message is indented. Additionally, your
> patch is whitespace damaged. So this won't apply anywhere.

Gmail hates me it seems. Sry but I don't have an proper setup on that
box right now.
My Laptop died and I try to fix the usual issue for new Laptops on
this one right now.
I uploaded the git patch, if you accept it like this. If not I will
re-send as soon I fix
this laptop and have git* and other things proper set up.

http://crazy.dev.frugalware.org/0001-Added-QUIRKs-for-ADATA-XPG-SX8200-Pro-512GB.patch

Best Regards,

Gabriel C

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
