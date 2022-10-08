Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA05C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 06:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9NKrsR7tTYpbn5X6JuYO0fYdKTzEIaHBiFinguj7aw=; b=YviN8bhR241b+BZBBpetYgRDF1
	KlUbo7x7aHlKWvEVmpfn/sAlunz5w9GWzo8/DIw1p3DRDidMeVHE1L+ZAS0PTv3udcTtTNKHGlZyK
	pe4qkcVG9x6q2u+sI7C0k4gD3BaEoMqkw6yi85oIXXPTG2VfwO6CKw2dMRuWwyGBWgBFrcS4q/5k1
	Nd+P5Y0Tr6ViQGUVlzcQ4mKFBBqRSAYBq8WJXDHnosJaV5ZXOflQsZ3+NEKS/8d+PzaWQgjhqk38J
	PIMFMXe1ZVF1FG3EGWTTUHUaHjKGQRX1D7Ol2Ajf51eQQjoUei2yYpBJCbh6dEyxltL2r9ajEmIng
	Vwseqo4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQGt-00F0r8-T2; Sun, 09 Oct 2022 06:58:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oh0PD-00Bcex-AR; Sat, 08 Oct 2022 03:21:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC9D60DE1;
	Sat,  8 Oct 2022 03:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5142DC433C1;
	Sat,  8 Oct 2022 03:21:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QJwXB42z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665199288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9NKrsR7tTYpbn5X6JuYO0fYdKTzEIaHBiFinguj7aw=;
	b=QJwXB42zql9DO3ci56fK0qdt3KETO02OTgln46NrLRebl+kAFg75irZufDkHzEZwB29CpM
	Ubvcrjo1Rpn2o0HxsDqhv3cZBSXnbxayqkMXN0QW7oMK5AxmGenYUT0yhLgOQDZCQVHQgc
	pmnnlQLP6smI8ZrGrciXPoRUntBuJe8=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ea268ade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 8 Oct 2022 03:21:28 +0000 (UTC)
Date: Fri, 7 Oct 2022 21:21:20 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Airlie <airlied@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Huacai Chen <chenhuacai@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	KP Singh <kpsingh@kernel.org>, Marco Elver <elver@google.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, dri-devel@lists.freedesktop.org,
	kasan-dev@googlegroups.com, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, x86@kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 2/6] treewide: use prandom_u32_max() when possible
Message-ID: <Y0DssPFp2rY+TrPp@zx2c4.com>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-3-Jason@zx2c4.com>
 <202210071241.445289C5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210071241.445289C5@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_202139_453438_206BC72D 
X-CRM114-Status: GOOD (  18.18  )
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

On Fri, Oct 07, 2022 at 03:47:44PM -0700, Kees Cook wrote:
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index 4f2f2d1bac56..56ffaa8dd3f6 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -151,9 +151,7 @@ static int random_size_alloc_test(void)
> >  	int i;
> >  
> >  	for (i = 0; i < test_loop_count; i++) {
> > -		n = prandom_u32();
> > -		n = (n % 100) + 1;
> > -
> > +		n = prandom_u32_max(n % 100) + 1;
> >  		p = vmalloc(n * PAGE_SIZE);
> >  
> >  		if (!p)
> 
> This looks wrong. Cocci says:
> 
> -               n = prandom_u32();
> -               n = (n % 100) + 1;
> +               n = prandom_u32_max(100) + 1;

I agree that's wrong, but what rule did you use to make Cocci generate
that?

Jason

