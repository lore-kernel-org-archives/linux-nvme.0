Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB06C433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hw+hnIMvKUNp0lwyCAgNJh72KYkKEhg87FRQTBs88Es=; b=TJai/l0JljIvhBmetsjv8u4yE0
	xdgF1WICgfBq7JM4uCCr03au+6LNC5OyhKjY20q9pGhLtzggiW5/TXTugQH3IhPvcgl1AGgYBA8Z3
	UzGOe/fMI6SD1CXqz0v4sdMpWAgTIU21lt4oOMBr0Y9s4MpsZMtKkCKSXwY3BpcNXde1kfVRXMFSz
	VUms9ctMvi8EijThVHPTkRl38TLsr5614O7hxiDWXr76G8Kjy4vTFLq9BIxFsF4RvdKyPd8+yAnbl
	dEXnGrLU3tBCocERg+NIpgdm84ZEFuWuTr645FaR3UdaqeMsypzjlBFpLC4POzoptvYBVKcJYOuPq
	XBOGo4jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oggOE-007T3j-CC; Fri, 07 Oct 2022 05:59:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogUc4-0049ZA-VS; Thu, 06 Oct 2022 17:24:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC9361A3E;
	Thu,  6 Oct 2022 17:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A25C433D7;
	Thu,  6 Oct 2022 17:24:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nePovel1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665077082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hw+hnIMvKUNp0lwyCAgNJh72KYkKEhg87FRQTBs88Es=;
	b=nePovel1Lrwv8E5tqLRFnGFwiBxZ2n7/W/dtDooIL7+DqvFmVm/jtXBYpVHjty/NEZ8aCk
	oxvu6PHIjOnVPY0KsxiuHL31B6Zt2u2Br+FRrADatX9MrN91+oy0kpWf4AY4e4utheKw7f
	zZ5QYQpj8zDsC3zJybqaF78JFqPcgIE=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79bb2e53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Oct 2022 17:24:42 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id p89so860906uap.12;
        Thu, 06 Oct 2022 10:24:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf1MnG4ingLIKvXEeY+KsyU/atBRuWVBVwmpGmWqHjXyyEn+NA68
	mE55IwakwcBcijDE00sVsvw4ofcEU3MzAF4cT3w=
X-Google-Smtp-Source: AMsMyM5KG2gwBNORWG5lbntrblDeF/IiEaNCtjq1xHSusLtpHfgrAAJFtzxp/82W985F9k39J/OxSFTwH+6dW+Mrfqw=
X-Received: by 2002:ab0:6cb0:0:b0:3d7:1184:847f with SMTP id
 j16-20020ab06cb0000000b003d71184847fmr777504uaa.49.1665077067240; Thu, 06 Oct
 2022 10:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221006165346.73159-1-Jason@zx2c4.com> <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
In-Reply-To: <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 6 Oct 2022 11:24:16 -0600
X-Gmail-Original-Message-ID: <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
Message-ID: <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, 
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
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_102449_109424_3AA00E37 
X-CRM114-Status: GOOD (  24.35  )
X-Mailman-Approved-At: Thu, 06 Oct 2022 22:57:31 -0700
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

Hi Christophe,

On Thu, Oct 6, 2022 at 11:21 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 06/10/2022 =C3=A0 18:53, Jason A. Donenfeld a =C3=A9crit :
> > The prandom_u32() function has been a deprecated inline wrapper around
> > get_random_u32() for several releases now, and compiles down to the
> > exact same code. Replace the deprecated wrapper with a direct call to
> > the real function. The same also applies to get_random_int(), which is
> > just a wrapper around get_random_u32().
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> # for sch_cak=
e
> > Acked-by: Chuck Lever <chuck.lever@oracle.com> # for nfsd
> > Reviewed-by: Jan Kara <jack@suse.cz> # for ext4
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
>
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 0fbda89cd1bb..9c4c15afbbe8 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -2308,6 +2308,6 @@ void notrace __ppc64_runlatch_off(void)
> >   unsigned long arch_align_stack(unsigned long sp)
> >   {
> >       if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_s=
pace)
> > -             sp -=3D get_random_int() & ~PAGE_MASK;
> > +             sp -=3D get_random_u32() & ~PAGE_MASK;
> >       return sp & ~0xf;
>
> Isn't that a candidate for prandom_u32_max() ?
>
> Note that sp is deemed to be 16 bytes aligned at all time.

Yes, probably. It seemed non-trivial to think about, so I didn't. But
let's see here... maybe it's not too bad:

If PAGE_MASK is always ~(PAGE_SIZE-1), then ~PAGE_MASK is
(PAGE_SIZE-1), so prandom_u32_max(PAGE_SIZE) should yield the same
thing? Is that accurate? And holds across platforms (this comes up a
few places)? If so, I'll do that for a v4.

Jason

