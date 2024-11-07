Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B218BD5AE73
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 08:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTcYDh6w3WSbtss1ZztiWPAsLIjMqzVuMVfuZwTMWrs=; b=k7BhLeOIJ4ufki+hlBGHl4XY7Y
	KYplEJzAMT2n5FTTHNNZQdWWed5S+chZlhVO75CxzU91ijFUdCaVWCm0Ujau6xtU7e4keR2pZC9Cr
	fgrNPSeoHxPLvRZqE0SVtazCyDEKZdXQj7Bg/q2dvrrTLDSeAc93xmE9kB8JvJpWYwXOcHbdqwAuv
	nU5z0xr3Wir1+t+a7IdJ/hD4aj/O51OZqY9pZsS0HYryJVDiF/PVzvKtQQTgH0BaGNtFNhF44o/Xe
	OHXdwbxwf8pq6qhKLLYdVG5rYeSlGnPEE9XlwRLF10ED1TWgmvG6k2TLTuUrsiu0TsCFLutPjLhwJ
	9FFrk8cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8yA7-00000006B2N-1GI0;
	Thu, 07 Nov 2024 08:46:43 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wuh-00000005z7r-1uPo
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 07:26:44 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so762043a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 Nov 2024 23:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730964401; x=1731569201; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTcYDh6w3WSbtss1ZztiWPAsLIjMqzVuMVfuZwTMWrs=;
        b=UeTJQoomXrGYbnr8c7VggBT4UOaOMzWWdNx9GJrfNTWpBfLgCQjzZyB8B71NQqtoJu
         TrloxAM871CSTQ87pGlmsqDqxck6BfpdH9bu1cnLVimGSe4pBEMAONfbx+ZV+49CZJSr
         Gb3Zz6kIgLJ8ffjIdob1UGWu1s77RXhNGIGG78mVolyhF7X2RZzDw0wiAszG8jd2V9+8
         QvAgowwHqLzKU+zitWhxKt8aZRynLM0EGwx4KyvFmtn4wIefjQ+YaQSdYhTVoAcmPyWw
         zdmX7R68xtztXVm1TpXmitWxykx3wJRWGtObaVkz5TArfLEM8TYtBIRCZx3O7PweA/98
         MQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730964401; x=1731569201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTcYDh6w3WSbtss1ZztiWPAsLIjMqzVuMVfuZwTMWrs=;
        b=U0UZsaSwy9cJFaAbU1wdoyhaCySfFI/FVWz8vDoIO1eBjr8GPb16QGypEKyd/2TyHm
         w4w0Ef1IbHHSzE2pu0Il+9/0WSa02n+8hXShvgTIZfxjg6IRcnvkI3eEA5tGE1W/95ph
         +ouUX5UGR85eYS9zVKJKcu7ZRA1fFZXeFk1iDLosqcCgYz+21t4cns29xCxmNTe9sLLf
         UUci+bifwY7tfwAWkTSVZlBBwg6YZdRSWMSUo4sP6GCzFuYuUk21fi4g17PFl4fXJJZY
         1r1VYWU0BNdfC4ZIyucpaMIgvpMItJ5QrbKUVsniaVRBuErenpIJSDlVbSUzapBaMdjT
         YZCg==
X-Forwarded-Encrypted: i=1; AJvYcCUsLBfoUUnHdDLZMrfJnTtU8TgnhudOdRfMqp+fAjAUJCNld1jJ4Zc7wMTzGK2kzbr6bpM/yhE5hT8i@lists.infradead.org
X-Gm-Message-State: AOJu0YyfY6AnmfP8QXOS5JqQ6IeC+dATTALq65YfgZ55pu53bK/tlDO0
	1rpc5X2ayWpNl5ZgWV/yJhj1guoh1C9VKp+vUdeG29hs5vHym35IeIuINkkZYJR6ynq2FghQJaD
	VWHGNUsIpTZFs4GaqMTOEW9lgSA==
X-Google-Smtp-Source: AGHT+IEmztZiX9RvL4Wp4cYy/lRffLhfZBQFee2u3aKQ+DQ0b5UOxznkRmoqhvkZAmXI8iHH6cBqc6s06Vm3nCEkFPk=
X-Received: by 2002:a05:6402:3591:b0:5cb:ae1b:4bd9 with SMTP id
 4fb4d7f45d1cf-5cbbf888505mr32855258a12.6.1730964400802; Wed, 06 Nov 2024
 23:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20241106121842.5004-1-anuj20.g@samsung.com> <CGME20241106122710epcas5p2b314c865f8333c890dd6f22cf2edbe2f@epcas5p2.samsung.com>
 <20241106121842.5004-7-anuj20.g@samsung.com> <20241107055542.GA2483@lst.de>
In-Reply-To: <20241107055542.GA2483@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 7 Nov 2024 12:56:03 +0530
Message-ID: <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com>
Subject: Re: [PATCH v8 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org, 
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org, 
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_232643_520322_6DF375F4 
X-CRM114-Status: GOOD (  25.30  )
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

On Thu, Nov 7, 2024 at 11:25=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +enum io_uring_sqe_ext_cap_bits {
> > +     EXT_CAP_PI_BIT,
> > +     /*
> > +      * not a real extended capability; just to make sure that we don'=
t
> > +      * overflow
> > +      */
> > +     EXT_CAP_LAST_BIT,
> > +};
> > +
> > +/* extended capability flags */
> > +#define EXT_CAP_PI   (1U << EXT_CAP_PI_BIT)
>
> This is getting into nitpicking, but is the a good reason to have that
> enum, which is never used as a type and the values or only defined to
> actually define the bit positions below?  That's a bit confusing to
> me.

The enum is added to keep a check on the number of flags that can
be added, and make sure that we don't overflow.

>
> Also please document the ABI for EXT_CAP_PI, right now this is again
> entirely undocumented.
>

We are planning to document this in man/io_uring_enter.2 in the liburing
repo, right after this series goes in. Or should it go somewhere else?

> > +/* Second half of SQE128 for IORING_OP_READ/WRITE */
> > +struct io_uring_sqe_ext {
> > +     __u64   rsvd0[4];
> > +     /* if sqe->ext_cap is EXT_CAP_PI, last 32 bytes are for PI */
> > +     union {
> > +             __u64   rsvd1[4];
> > +             struct {
> > +                     __u16   flags;
> > +                     __u16   app_tag;
> > +                     __u32   len;
> > +                     __u64   addr;
> > +                     __u64   seed;
> > +                     __u64   rsvd;
> > +             } rw_pi;
> > +     };
>
> And this is not what I though we discussed before.  By having a
> union here you imply some kind of "type" again that is switched
> on a value, and not flags indication the presence of potential
> multiple optional and combinable features.  This is what I would
> have expected here based on the previous discussion:

The attempt here is that if two extended capabilities are not known to
co-exist then they can be kept in the same place. Since each extended
capability is now a flag, we can check what combinations are valid and
throw an error in case of incompatibility. Do you see this differently?

>
> struct io_uring_sqe_ext {
>         /*
>          * Reservered for please tell me what and why it is in the beginn=
ing
>          * and not the end:
>          */
>         __u64   rsvd0[4];

This space is reserved for extended capabilities that might be added down
the line. It was at the end in the earlier versions, but it is moved
to the beginning
now to maintain contiguity with the free space (18b) available in the first=
 SQE,
based on previous discussions [1].

[1] https://lore.kernel.org/linux-block/ceb58d97-b2e3-4d36-898d-753ba69476b=
e@samsung.com/

>
>         /*
>          * Only valid when EXT_CAP_PI is set:
>          */
>         __u16   pi_flags; /* or make this generic flags, dunno? */
>         __u16   app_tag;
>         __u32   pi_len;
>         __u64   pi_addr;
>         __u64   pi_seed;
>
>         __u64   rsvd1;
> };
>

