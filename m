Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93982C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2a2X1YlfkZ0pGgKe1BT3qPauqYJUuDonzfwdbODwUj0=; b=fbJh8Pbsw0Y6yQ1l6kEXLk0DdQ
	l9zNSw5blstegSLd4TfHUHImWmlgGCSFH4e20Z30H/ieQn6SunZio2DMSaPq0g1FqKjJlc/sIue5N
	hzQ7v4pEaPV+5BYZcuInRVUNGXwSC+yNRNC81qrbKaNoIc3heJnCr4FLOpRtBDMC3I3TruuG1dZ0I
	13SB0YyYmY4OheqSvDm/dAlJyOE9/fuVjHPbTlVZyPbSdKostLVdFBSNZ0rtwGWsh0nFGjugf3Ezm
	75LMJSyBaEZ5+UKQN3RMUx8uARcR565M6Lb+iHLF28og94lEWTCdrp10ZBwvCR/65o2rub1MCXnMh
	5l6Hlugw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQFd-00F0SV-DR; Sun, 09 Oct 2022 06:57:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogyeb-00BHtR-HJ; Sat, 08 Oct 2022 01:29:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 880ACCE1926;
	Sat,  8 Oct 2022 01:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C01C433C1;
	Sat,  8 Oct 2022 01:29:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F0WFV840"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665192550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2a2X1YlfkZ0pGgKe1BT3qPauqYJUuDonzfwdbODwUj0=;
	b=F0WFV8408bfDyb840yWHYb2sS5Uszq0PMkkmtmrVRBUNL2FY49DLuZ3A8VZX01cjH92PRw
	963/yLDTfSbPjK9v/cSx6ClQtvwOaP31xlyhs5+LtAOzyMXtRqv5atZ8HOk8wnFIOFKYJl
	weXSG5WPTsM48QIVGdJf4b19sbZPAzo=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 08b122db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 8 Oct 2022 01:29:09 +0000 (UTC)
Date: Fri, 7 Oct 2022 19:28:59 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Darrick J. Wong" <djwong@kernel.org>
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
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
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
Message-ID: <Y0DSW4AAX/yA3CdI@zx2c4.com>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-3-Jason@zx2c4.com>
 <Y0CXYjV8qMpJxxBa@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0CXYjV8qMpJxxBa@magnolia>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_182925_941137_D0C9E976 
X-CRM114-Status: GOOD (  29.64  )
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

On Fri, Oct 07, 2022 at 02:17:22PM -0700, Darrick J. Wong wrote:
> On Fri, Oct 07, 2022 at 12:01:03PM -0600, Jason A. Donenfeld wrote:
> > Rather than incurring a division or requesting too many random bytes for
> > the given range, use the prandom_u32_max() function, which only takes
> > the minimum required bytes from the RNG and avoids divisions.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> # for drbd
> > Reviewed-by: Jan Kara <jack@suse.cz> # for ext2, ext4, and sbitmap
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> 
> <snip, skip to the xfs part>
> 
> > diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> > index e2bdf089c0a3..6261599bb389 100644
> > --- a/fs/xfs/libxfs/xfs_alloc.c
> > +++ b/fs/xfs/libxfs/xfs_alloc.c
> > @@ -1520,7 +1520,7 @@ xfs_alloc_ag_vextent_lastblock(
> >  
> >  #ifdef DEBUG
> >  	/* Randomly don't execute the first algorithm. */
> > -	if (prandom_u32() & 1)
> > +	if (prandom_u32_max(2))
> 
> I wonder if these usecases (picking 0 or 1 randomly) ought to have a
> trivial wrapper to make it more obvious that we want boolean semantics:
> 
> static inline bool prandom_bool(void)
> {
> 	return prandom_u32_max(2);
> }
> 
> 	if (prandom_bool())
> 		use_crazy_algorithm(...);
> 

Yea, I've had a lot of similar ideas there. Part of doing this (initial)
patchset is to get an intuitive sense of what's actually used and how
often. On my list for investigation are a get_random_u32_max() to return
uniform numbers by rejection sampling (prandom_u32_max() doesn't do
that uniformly) and adding a function for booleans or bits < 8. Possible
ideas for the latter include:

   bool get_random_bool(void);
   bool get_random_bool(unsigned int probability);
   bool get_random_bits(u8 bits_less_than_eight);

With the core of all of those involving the same batching as the current
get_random_u{8,16,32,64}() functions, but also buffering the latest byte
and managing how many bits are left in it that haven't been shifted out
yet.

So API-wise, there are a few ways to go, so hopefully this series will
start to give a good picture of what's needed.

One thing I've noticed is that most of the prandom_u32_max(2)
invocations are in debug or test code, so that doesn't need to be
optimized. But kfence does that too in its hot path, so a
get_random_bool() function there would in theory lead to an 8x speed-up.
But I guess I just have to try some things and see.

Anyway, that is a long way to say, I share you curiosity on the matter
and I'm looking into it.

Jason

