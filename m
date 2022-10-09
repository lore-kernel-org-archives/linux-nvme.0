Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4D7C433FE
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7zZXtzJcFLYkSrXJJYKIVFffp4v7t60F00p3NU1sSks=; b=R8wQClaXffS2v1n/Ptm+UkVnLn
	oCZvA2CU55iCb4xseMRu9wBKc9Sqh3oCp6BRrBBNojBLz637iMATeGVlIbNuSp+NyWXRKp1OiCem4
	GFQqnmg5bRyTgBs+tFy5YCWOEoQ3eLmoNSXEzw1tUj17Av9/QzjNZpMhN1PTTwQ/ue9XlVg1Jd05e
	PVecDxCqqvwFS8/0w3va9ucJq5HHbdpV7MepVZhkr6uk7eS7VJ4WQIvLg+Pw/roiP9SN0COW3guSu
	g4y6Bpng2BcrFSVUNssWvBau4QsiJHgXVTSFkIFZkPo1BfRwboCVCaa+uX4zlL1cmU866JvT1ph5t
	HEk3tqHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQVV-00F4s5-KN; Sun, 09 Oct 2022 07:13:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohK9P-00EfhF-RF; Sun, 09 Oct 2022 00:26:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 55CDE60AF7;
	Sun,  9 Oct 2022 00:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADE6C433B5;
	Sun,  9 Oct 2022 00:26:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eXcn74ON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665275187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7zZXtzJcFLYkSrXJJYKIVFffp4v7t60F00p3NU1sSks=;
	b=eXcn74ONvMPA9ryxT/a7aYIuja8VAvsA7PuDEGzhdmUJfRXYr75ikGVRouYkjysBLHUqM6
	bmtziGf54vTRtEdjIHOQYcbNdVpfP7hpYiyLhRuXMv/QimXPGPuUWPxNUtYVovTrbZM9V8
	8mlE3AMCNacUB8Fh8IylFdp9kN3UapQ=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b033b494 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 00:26:27 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id n74so9537509yba.11;
        Sat, 08 Oct 2022 17:26:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf0KETrw6m99b+XWVqF5Sovj+0XzOzD6VmTLCi4EAwnislIyi/eR
	gzIZtRevgfkhPYjmtDlkuCQUBTxo77XhMYJ2iz8=
X-Google-Smtp-Source: AMsMyM7Ghd+rNLLkdUe772S1SZ8rADl1G6UAF0aO2TFON1i86eRArx6SOwts50zdZDWmmLpyXWt8nLKkLulPCRn4G5w=
X-Received: by 2002:ab0:70b9:0:b0:3d7:84d8:35ae with SMTP id
 q25-20020ab070b9000000b003d784d835aemr6771029ual.24.1665275171232; Sat, 08
 Oct 2022 17:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221007180107.216067-1-Jason@zx2c4.com> <20221007180107.216067-5-Jason@zx2c4.com>
 <f1ca1b53bc104065a83da60161a4c7b6@AcuMS.aculab.com> <Y0H7rcJ3/JOyDYU8@zx2c4.com>
In-Reply-To: <Y0H7rcJ3/JOyDYU8@zx2c4.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 8 Oct 2022 18:26:00 -0600
X-Gmail-Original-Message-ID: <CAHmME9ojgUnrp+Mys3pzJZ=0C7RHbgsm-wOkWk-GdW2dnJwf8g@mail.gmail.com>
Message-ID: <CAHmME9ojgUnrp+Mys3pzJZ=0C7RHbgsm-wOkWk-GdW2dnJwf8g@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] treewide: use get_random_u32() when possible
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Christoph Hellwig <hch@lst.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, 
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221008_172639_966112_92F450D0 
X-CRM114-Status: GOOD (  26.32  )
X-Mailman-Approved-At: Sat, 08 Oct 2022 23:55:42 -0700
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

On Sat, Oct 8, 2022 at 4:37 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Sat, Oct 08, 2022 at 10:18:45PM +0000, David Laight wrote:
> > From: Jason A. Donenfeld
> > > Sent: 07 October 2022 19:01
> > >
> > > The prandom_u32() function has been a deprecated inline wrapper around
> > > get_random_u32() for several releases now, and compiles down to the
> > > exact same code. Replace the deprecated wrapper with a direct call to
> > > the real function. The same also applies to get_random_int(), which is
> > > just a wrapper around get_random_u32().
> > >
> > ...
> > > diff --git a/net/802/garp.c b/net/802/garp.c
> > > index f6012f8e59f0..c1bb67e25430 100644
> > > --- a/net/802/garp.c
> > > +++ b/net/802/garp.c
> > > @@ -407,7 +407,7 @@ static void garp_join_timer_arm(struct garp_applicant *app)
> > >  {
> > >     unsigned long delay;
> > >
> > > -   delay = (u64)msecs_to_jiffies(garp_join_time) * prandom_u32() >> 32;
> > > +   delay = (u64)msecs_to_jiffies(garp_join_time) * get_random_u32() >> 32;
> > >     mod_timer(&app->join_timer, jiffies + delay);
> > >  }
> > >
> > > diff --git a/net/802/mrp.c b/net/802/mrp.c
> > > index 35e04cc5390c..3e9fe9f5d9bf 100644
> > > --- a/net/802/mrp.c
> > > +++ b/net/802/mrp.c
> > > @@ -592,7 +592,7 @@ static void mrp_join_timer_arm(struct mrp_applicant *app)
> > >  {
> > >     unsigned long delay;
> > >
> > > -   delay = (u64)msecs_to_jiffies(mrp_join_time) * prandom_u32() >> 32;
> > > +   delay = (u64)msecs_to_jiffies(mrp_join_time) * get_random_u32() >> 32;
> > >     mod_timer(&app->join_timer, jiffies + delay);
> > >  }
> > >
> >
> > Aren't those:
> >       delay = prandom_u32_max(msecs_to_jiffies(xxx_join_time));
>
> Probably, but too involved and peculiar for this cleanup.
>
> Feel free to send a particular patch to that maintainer.

I guess the cocci patch looks like this, so maybe I'll put that in 1/7
if I respin this.

@@
expression E;
identifier get_random_u32 =~ "get_random_int|prandom_u32|get_random_u32";
typedef u64;
@@
- ((u64)(E) * get_random_u32() >> 32)
+ prandom_u32_max(E)

