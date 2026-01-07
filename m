Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF876CFD65D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=; b=vtqEYGPQMqwHFbmLY97L93wTA3
	Msg3gBdsVERJIKPG6ZObsEoqF79N5A32w0aA6+thTMWEFwAgKC39Wm9ABcqfOvF/rTOoxMWYPnlEc
	r9hzOI/anRT13FJbwt8ujwuJq4VGK3Q+bszpEy3SIBYBxUJH1xdN1k/bNvL3sQcF+wc52i+xWK7zw
	OIVKrYVay2q/VSJxRrXWc4ZZBy9wlYy01ij49NFnHhL0iJQvkUicdEdGQHOwlGSGoDJ554hPbN4z3
	fImnaqTbeeb0sI0OdQL5jz536pbDVcOPs1ytJp5j7Nv79D1pJqWOCNq+7sPHtQpzk6vSWUqR/rbtx
	GkRXkeSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWI7-0000000FFwa-090p;
	Wed, 07 Jan 2026 16:21:47 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdWI1-0000000FFvA-116t
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 16:21:44 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso702459241.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Jan 2026 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767802900; x=1768407700; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=;
        b=SjO9LURo1f2jXrogTeyG2A0XaHFA6ev3f84vYXsNfl9sBd34D01UcG6g8+HeTw53ja
         eKPPZzL7Tf9CjZtYw6ZexsfFfH0HjC0UDzzT90zpi4TI8tL80jNBOW+25pQLRqw3olzc
         2CdnlDUqg2yXz9eg1RDi7r7MFxUvShcu6dW7uhuAEfd2Kh8X8mikwxJGQQ598gPKNcvq
         L26diO3aYHQPUcYZ1BRlrceq+nOE2QO/UIX2xDA0TIUxgzOGSO1Cm1sdO1B7el6jT6EM
         4lvxi6GXXIykfnRK84mjbACHrCUWfkgi/XDpxgVrfblmBm42vcy9/MVj0wIklokvudCm
         fZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802900; x=1768407700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9pAsVdOshxg/UeXDrjL8KK7Kf5c9vGq1ci5vjH9hrY=;
        b=ejLvs5juVjwxUZvJqO+aTZZSLCt/4L5USs34HHFS6OMb+kxpJeohWuZ9YYNTa7Mhdt
         pfd/MpvrRCv7SOpkOvemDbWdP9og/Q3QmlH+V29SQfWqy3LwS0MAIGmqjAtIWheSEmW9
         vfrI3LsVi91UX5VjWKh5YGkv8gAelhPUYBE7J5YolVVR0ds/s1yZa0/CgAYX0RfbZgiv
         z3IejnoSC9T0q66u5E+xWl6yPX0E/zpzHU6GFOiEj/cifgoWTLCsFMHCp8yQ5jp+qIQH
         Vq4W4z9+kk/WHU00wmP5p+J+G3NGZAj5eaIpneF2NUyKTYZRu7d2ZPc3uat2Oe5G0uQN
         Vf6w==
X-Forwarded-Encrypted: i=1; AJvYcCUgm8NId7mmuirJ043bAJsPdEjsY+STxamjNZlAe4ljM96zbbKujgrb3oFT2YuetFGwS7Q8ccZ0EFuj@lists.infradead.org
X-Gm-Message-State: AOJu0YwFbVgklmCUvWjaOxcaCzIuAjRtv0k5/dTxT5i9Gm/23bX5TdLZ
	lrSZgTFEZL2mKLmKsnr0yP/wwSiMF0jfl/zUKercPY3Raa9AWQ7E5OFETdg5A2QdRaj6yMICOtE
	EAj0smlI1x1vNOgx9l3Eltu9PnaoDIPs=
X-Gm-Gg: AY/fxX7NEE5HQeJ1zLAI828OgBfskId3qnWBRO650fBrgvPKgEyOdJqRHk18bnuGr/b
	CraC8J/MCy44kXmSlHbRI8dC0WuojjGGZ9eimXzXW5vu0pzyfYgCKc/p/4dxRyqxziCL4mSnK+K
	zlv/wwGaXvu4advQvffZOGznmqcx8S4FyZ3HWvbEdiQJgMpeist63AMTHCNax5SessYbTvfd8XX
	5KjsGCebKUOdNHE8eyihT74u+Ji9dlTZ+xrcEZMPYTWy7p2viq5nEVV7/t5RuCW3HeQukZkGBRf
	IwY1MiJxATaRA8HMFGDQYFdXOgcfw7f+7DCwX8o=
X-Google-Smtp-Source: AGHT+IGxbu5trMeA+bbczjoGPXEJxl0y5C2nnwMIra3RoM/ysryOPmMUaafKF3MGWC+Mlo0zy/QE8hqC9UWzjs48l10=
X-Received: by 2002:a05:6102:4412:b0:5de:8933:9d0f with SMTP id
 ada2fe7eead31-5ecb5cba9dbmr1165795137.9.1767802899668; Wed, 07 Jan 2026
 08:21:39 -0800 (PST)
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Wed, 7 Jan 2026 19:21:28 +0300
X-Gm-Features: AQt7F2pv0c-1qcRtTOwSATyr9cBPwXJeCV-fecbO2zRlGG6igeybP32a0NVn8OA
Message-ID: <CAPqjcqrjNCmnV2JP1Mdezwr0ij0ic4KxH=MVUisHt12QkBNmYQ@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_082143_431015_19822D06 
X-CRM114-Status: GOOD (  12.12  )
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

> Note that the alignment rule is not just for atomic HW boundaries. We
> also support atomic writes on stacked devices, where this is relevant -
> specifically striped devices, like raid0. Doing an unaligned atomic
> write on a striped device may result in trying to issue an atomic write
> which straddles 2x separate devices, which would obviously be broken.

Ok, then I'd also add atomic boundary checks and
atomic_write_boundary_bytes = stripe size to /sys/block/**/queue for
md devices. Not 2^N and length-alignment checks, just the boundary.

> It seems that you just want to take advantage of the block layer code to
> handle submission of an atomic write bio, i.e. reject anything which
> cannot be atomically written. In essence, that would be to just set
> REQ_ATOMIC. Maybe that could be done as a passthrough command, I'm not sure.

Of course. I thought it was the whole point of RWF_ATOMIC - REQ_ATOMIC
for userspace.

I don't want passthrough commands, I want to use normal kernel I/O.

