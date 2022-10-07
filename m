Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A143BC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yZqaicka3IU4vV1MYdOWb5w3mOcfwDVNwAUulPcr27Y=; b=KByawpl2a6m8mrTNOafWJkMZFH
	wMZ4c8iWvGM04WPenPovPEx22SZLCiHnKq3hr40o5iBuNeEsdo4tXR5RwGJDrwzao5ZnwZppOAlEx
	qez4uWEkYFR2ziVZU/HhlBt7sNgGxo+IF0hHOAN4SObRoCojb038WN1hBRaRPTsdNx7NLvT/Kk8Bb
	3ZWBL16/He2EL+TrN/JoSJ1Ovd/lrGZSoPwri7W4YnIAXmFX050sGt5B4GoK8HsTAu4a+MQZFxKDf
	8h3qunnz3CdZf0OYqhz5J6S+s7v6s0W5NVsDYtgYuKmPWn+kMbV2Ug11ORf4Wd3tZZZ+feThat98T
	NnAZq2yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQFN-00F0Ml-RP; Sun, 09 Oct 2022 06:57:13 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogw8D-00AniB-2z
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 22:47:51 +0000
Received: by mail-pg1-x536.google.com with SMTP id 2so5820693pgl.7
        for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZqaicka3IU4vV1MYdOWb5w3mOcfwDVNwAUulPcr27Y=;
        b=iXQ9UvdzaG3zByw2GBNLz3/YVU1qnMbHWTkFhauTR657sXRQGAG+NlE+Q9rJd5luVx
         INuHridXF4858oAPsKtGfjtbkx2VdjBSQCDETBbwUrSMqp7tkUzuQxOHz4Iev7dLesfK
         vpnuiiKohn9Hx+Mnal9EiATSUtY0yZ8+mCOj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZqaicka3IU4vV1MYdOWb5w3mOcfwDVNwAUulPcr27Y=;
        b=kmqe7a8Y3Q7+vnQuZHfDB4WaEvO6pqIAKRulk2EHGKdw+fobPJqI+EY628kHl6G4qL
         Ljq0RnDSLokB3Qbd4Vom71VJbAuXtnyHGGwQrBBsYxrhXGJ9SKel8YDq2HZEJtria+ho
         ILZvOCx8duSz5Sh3xG71BSMEYDeO4fh3Dd0T7k+53liDuctDSntlqnln6nrNqJEY/JFX
         nwVwxVg06ClrQuQfbpFWs7v27E04HBR++MmN3at+avWoo+70Zf31nMZ0/O9zacws8Ih6
         XGzvjkRgW6oB2kfcQoT99jH/Ta3HjpD8NnH2+L1lWchlKm+FH5pXXE8XKjBpBC6a1ua2
         f4zA==
X-Gm-Message-State: ACrzQf3+1Vf4fBdCboYTD/t0vYolp4hhRb7qYLaIOSP3uAbsfeyaVhIT
	3L8EDU//KLEBZYPnwVaRurUbcw==
X-Google-Smtp-Source: AMsMyM6iCBWc/uxIx6z9Rtqnu5DJFDtYNmNoozJCUMl1bWP400YM3aAZ5nfN+Rih1bQNvESsCMLxdQ==
X-Received: by 2002:a63:5a61:0:b0:41b:b021:f916 with SMTP id k33-20020a635a61000000b0041bb021f916mr6209429pgm.387.1665182866043;
        Fri, 07 Oct 2022 15:47:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709027e8c00b0016dbaf3ff2esm2038893pla.22.2022.10.07.15.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:47:45 -0700 (PDT)
Date: Fri, 7 Oct 2022 15:47:44 -0700
From: Kees Cook <keescook@chromium.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
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
Message-ID: <202210071241.445289C5@keescook>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007180107.216067-3-Jason@zx2c4.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_154749_149754_01A8AF17 
X-CRM114-Status: GOOD (  30.87  )
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

On Fri, Oct 07, 2022 at 12:01:03PM -0600, Jason A. Donenfeld wrote:
> Rather than incurring a division or requesting too many random bytes for
> the given range, use the prandom_u32_max() function, which only takes
> the minimum required bytes from the RNG and avoids divisions.

I actually meant splitting the by-hand stuff by subsystem, but nearly
all of these can be done mechanically too, so it shouldn't be bad. Notes
below...

> 
> [...]
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 92bcc1768f0b..87203429f802 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -595,7 +595,7 @@ unsigned long __get_wchan(struct task_struct *p)
>  unsigned long arch_align_stack(unsigned long sp)
>  {
>  	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
> -		sp -= get_random_int() & ~PAGE_MASK;
> +		sp -= prandom_u32_max(PAGE_SIZE);
>  	return sp & ~0xf;
>  }
>  

@mask@
expression MASK;
@@

- (get_random_int() & ~(MASK))
+ prandom_u32_max(MASK)

> diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
> index f32c38abd791..8c9826062652 100644
> --- a/arch/loongarch/kernel/vdso.c
> +++ b/arch/loongarch/kernel/vdso.c
> @@ -78,7 +78,7 @@ static unsigned long vdso_base(void)
>  	unsigned long base = STACK_TOP;
>  
>  	if (current->flags & PF_RANDOMIZE) {
> -		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
> +		base += prandom_u32_max(VDSO_RANDOMIZE_SIZE);
>  		base = PAGE_ALIGN(base);
>  	}
>  

@minus_one@
expression FULL;
@@

- (get_random_int() & ((FULL) - 1)
+ prandom_u32_max(FULL)

> diff --git a/arch/parisc/kernel/vdso.c b/arch/parisc/kernel/vdso.c
> index 63dc44c4c246..47e5960a2f96 100644
> --- a/arch/parisc/kernel/vdso.c
> +++ b/arch/parisc/kernel/vdso.c
> @@ -75,7 +75,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
>  
>  	map_base = mm->mmap_base;
>  	if (current->flags & PF_RANDOMIZE)
> -		map_base -= (get_random_int() & 0x1f) * PAGE_SIZE;
> +		map_base -= prandom_u32_max(0x20) * PAGE_SIZE;
>  
>  	vdso_text_start = get_unmapped_area(NULL, map_base, vdso_text_len, 0, 0);
>  

These are more fun, but Coccinelle can still do them with a little
Pythonic help:

// Find a potential literal
@literal_mask@
expression LITERAL;
identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
position p;
@@

        (randfunc()@p & (LITERAL))

// Add one to the literal.
@script:python add_one@
literal << literal_mask.LITERAL;
RESULT;
@@

if literal.startswith('0x'):
        value = int(literal, 16) + 1
        coccinelle.RESULT = cocci.make_expr("0x%x" % (value))
elif literal[0] in '123456789':
        value = int(literal, 10) + 1
        coccinelle.RESULT = cocci.make_expr("%d" % (value))
else:
        print("I don't know how to handle: %s" % (literal))

// Replace the literal mask with the calculated result.
@plus_one@
expression literal_mask.LITERAL;
position literal_mask.p;
expression add_one.RESULT;
identifier FUNC;
@@

-       (FUNC()@p & (LITERAL))
+       prandom_u32_max(RESULT)

> diff --git a/drivers/mtd/tests/stresstest.c b/drivers/mtd/tests/stresstest.c
> index cb29c8c1b370..d2faaca7f19d 100644
> --- a/drivers/mtd/tests/stresstest.c
> +++ b/drivers/mtd/tests/stresstest.c
> @@ -45,9 +45,8 @@ static int rand_eb(void)
>  	unsigned int eb;
>  
>  again:
> -	eb = prandom_u32();
>  	/* Read or write up 2 eraseblocks at a time - hence 'ebcnt - 1' */
> -	eb %= (ebcnt - 1);
> +	eb = prandom_u32_max(ebcnt - 1);
>  	if (bbt[eb])
>  		goto again;
>  	return eb;

This can also be done mechanically:

@multi_line@
identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
identifier RAND;
expression E;
@@

-       RAND = randfunc();
        ... when != RAND
-       RAND %= (E);
+       RAND = prandom_u32_max(E);

@collapse_ret@
type TYPE;
identifier VAR;
expression E;
@@

 {
-       TYPE VAR;
-       VAR = (E);
-       return VAR;
+       return E;
 }

@drop_var@
type TYPE;
identifier VAR;
@@

 {
-       TYPE VAR;
        ... when != VAR
 }

> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 998dd2ac8008..f4944c4dee60 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -277,8 +277,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
>  		int best_ndir = inodes_per_group;
>  		int best_group = -1;
>  
> -		group = prandom_u32();
> -		parent_group = (unsigned)group % ngroups;
> +		parent_group = prandom_u32_max(ngroups);
>  		for (i = 0; i < ngroups; i++) {
>  			group = (parent_group + i) % ngroups;
>  			desc = ext2_get_group_desc (sb, group, NULL);

Okay, that one is too much for me -- checking that group is never used
after the assignment removal is likely possible, but beyond my cocci
know-how. :)

> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index f73e5eb43eae..36d5bc595cc2 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -463,10 +463,9 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
>  			hinfo.hash_version = DX_HASH_HALF_MD4;
>  			hinfo.seed = sbi->s_hash_seed;
>  			ext4fs_dirhash(parent, qstr->name, qstr->len, &hinfo);
> -			grp = hinfo.hash;
> +			parent_group = hinfo.hash % ngroups;
>  		} else
> -			grp = prandom_u32();
> -		parent_group = (unsigned)grp % ngroups;
> +			parent_group = prandom_u32_max(ngroups);
>  		for (i = 0; i < ngroups; i++) {
>  			g = (parent_group + i) % ngroups;
>  			get_orlov_stats(sb, g, flex_size, &stats);

Much less easy mechanically. :)

> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index 0927f44cd478..41a0321f641a 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -208,7 +208,7 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
>  static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
>  {
>  	unsigned int i = 0;
> -	int rs = (prandom_u32_max(2) + 1) * 16;
> +	int rs = prandom_u32_max(2) + 1 * 16;
>  
>  	do {
>  		int gs = 1 << i;

This looks wrong. Cocci says:

-       int rs = (get_random_int() % 2 + 1) * 16;
+       int rs = (prandom_u32_max(2) + 1) * 16;

> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 4f2f2d1bac56..56ffaa8dd3f6 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -151,9 +151,7 @@ static int random_size_alloc_test(void)
>  	int i;
>  
>  	for (i = 0; i < test_loop_count; i++) {
> -		n = prandom_u32();
> -		n = (n % 100) + 1;
> -
> +		n = prandom_u32_max(n % 100) + 1;
>  		p = vmalloc(n * PAGE_SIZE);
>  
>  		if (!p)

This looks wrong. Cocci says:

-               n = prandom_u32();
-               n = (n % 100) + 1;
+               n = prandom_u32_max(100) + 1;

> @@ -293,16 +291,12 @@ pcpu_alloc_test(void)
>  		return -1;
>  
>  	for (i = 0; i < 35000; i++) {
> -		unsigned int r;
> -
> -		r = prandom_u32();
> -		size = (r % (PAGE_SIZE / 4)) + 1;
> +		size = prandom_u32_max(PAGE_SIZE / 4) + 1;
>  
>  		/*
>  		 * Maximum PAGE_SIZE
>  		 */
> -		r = prandom_u32();
> -		align = 1 << ((r % 11) + 1);
> +		align = 1 << (prandom_u32_max(11) + 1);
>  
>  		pcpu[i] = __alloc_percpu(size, align);
>  		if (!pcpu[i])
> @@ -393,14 +387,11 @@ static struct test_driver {
>  
>  static void shuffle_array(int *arr, int n)
>  {
> -	unsigned int rnd;
>  	int i, j;
>  
>  	for (i = n - 1; i > 0; i--)  {
> -		rnd = prandom_u32();
> -
>  		/* Cut the range. */
> -		j = rnd % i;
> +		j = prandom_u32_max(i);
>  
>  		/* Swap indexes. */
>  		swap(arr[i], arr[j]);

Yup, agrees with Cocci on these.

-- 
Kees Cook

