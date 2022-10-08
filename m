Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492DBC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+M2MWnKezzvwUdnzvMnzBe5u7rJCxF/Jt+qZLDkYO0=; b=4kXP7uh7BQhCbLLflK7FxUyqeO
	gjHyEH6iBF929lOGLMXTuBSXXCvb0y10tbQOG3EbyoTsoAl/v2t8uancw3JKGw7AkyMbwir1KQ1kE
	fF63DDuPMisnZ1q5drEJw64iIihBDNt4VoQyq5fwChh/pQZb1J35uxLGhyn86OD1xEmuP7iY0XQif
	zIRL1bJZF+E+vhcpYxGKJb+lgMqnk/pKUr1GBGW75Gc+bvO8t8cB8+jfNfUDUViN14HOG3ifHUzyq
	bKhpDvp5vCE1XXp99qgqOAQTF5DwZAcj3VsINA7jpcOE7ThzHOcV+UwO7oL7mKttJ8Go0OcffsFsz
	fLIDWZkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQHH-00F0yS-Aw; Sun, 09 Oct 2022 06:59:11 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oh0rR-00BfR1-OF
	for linux-nvme@lists.infradead.org; Sat, 08 Oct 2022 03:50:52 +0000
Received: by mail-pg1-x533.google.com with SMTP id e129so6175253pgc.9
        for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 20:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+M2MWnKezzvwUdnzvMnzBe5u7rJCxF/Jt+qZLDkYO0=;
        b=FTiUCKipmqUFH72GOvNGAiS4z04PbOMknPHSePECxyT+NR1MKehdmNkDokls+RTwtz
         36ZKjqvAgPt8zH/PagzHgUWgsK7jRV+Fodw+XGTQ49lxGfaN2UCRznQ1vjEUvfGAJQxE
         GFWrUL9ion4oE/GNeI8pk6ab24JqoBKXYgp6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+M2MWnKezzvwUdnzvMnzBe5u7rJCxF/Jt+qZLDkYO0=;
        b=6kHUyaasvG0ReBfQJB1h2wHei1xS8L07Zpk62Bdj5E/QLUr4T3woyddfOMQq++xbP4
         AFGgPOG9XmJX6O3Wu5M2/7tFOEgrZypDHgeVwGrHU+Ms9l1IOzu82MHlHog3CaoJ+VcX
         mpSG8PoMtXUZRbkfdqmnipuMFGlXYI754/6NNKdAcmEofnRy6sfodMj4DtyHhC1QVD4r
         JBJ83n8ebyeIlnlt1YCGfHVEyO9Ex1KpXojAaqgTpaVVyg80r3900YHeBNEJlXK4OVPf
         ye7mMzP4/fcDI+qywGCbQE10Rrq1FzGs9NmXS/erioFUWdXCohuz4adD7SwvOTkw9zDl
         gSiQ==
X-Gm-Message-State: ACrzQf0DnNxqjJLfTbmp4fpdQ9FVw7sGHGbehzcX89AdAGNDgjb4GLdK
	HQbrmPS++gRUpq+sazPQoesNYA==
X-Google-Smtp-Source: AMsMyM4VVDsl7sTfR6BuaZGaWhNrchqMetZXBFqCtxdCKjUBjOregElVi6yPdvP6PdPNshZGkoA99Q==
X-Received: by 2002:a63:f806:0:b0:439:d86e:1f6e with SMTP id n6-20020a63f806000000b00439d86e1f6emr7461413pgh.46.1665201045645;
        Fri, 07 Oct 2022 20:50:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0017f5ba1fffasm2217544plk.297.2022.10.07.20.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:50:44 -0700 (PDT)
Date: Fri, 7 Oct 2022 20:50:43 -0700
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Huacai Chen <chenhuacai@kernel.org>,
	Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"James E. J. Bottomley" <jejb@linux.ibm.com>,
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
Message-ID: <53DD0148-ED15-4294-8496-9E4B4C7AD061@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_205049_890300_246EB3B4 
X-CRM114-Status: GOOD (  42.07  )
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

[resending because I failed to CC]

On October 7, 2022 7:21:28 PM PDT, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
>On Fri, Oct 07, 2022 at 03:47:44PM -0700, Kees Cook wrote:
>> On Fri, Oct 07, 2022 at 12:01:03PM -0600, Jason A. Donenfeld wrote:
>> > Rather than incurring a division or requesting too many random bytes for
>> > the given range, use the prandom_u32_max() function, which only takes
>> > the minimum required bytes from the RNG and avoids divisions.
>> 
>> I actually meant splitting the by-hand stuff by subsystem, but nearly
>> all of these can be done mechanically too, so it shouldn't be bad. Notes
>> below...
>
>Oh, cool, more coccinelle. You're basically giving me a class on these
>recipes. Much appreciated.

You're welcome! This was a fun exercise. :)

>
>> > [...]
>> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> > index 92bcc1768f0b..87203429f802 100644
>> > --- a/arch/arm64/kernel/process.c
>> > +++ b/arch/arm64/kernel/process.c
>> > @@ -595,7 +595,7 @@ unsigned long __get_wchan(struct task_struct *p)
>> >  unsigned long arch_align_stack(unsigned long sp)
>> >  {
>> >  	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>> > -		sp -= get_random_int() & ~PAGE_MASK;
>> > +		sp -= prandom_u32_max(PAGE_SIZE);
>> >  	return sp & ~0xf;
>> >  }
>> >  
>> 
>> @mask@
>> expression MASK;
>> @@
>> 
>> - (get_random_int() & ~(MASK))
>> + prandom_u32_max(MASK)
>
>Not quite! PAGE_MASK != PAGE_SIZE. In this case, things get a litttttle
>more complicated where you can do:
>
>get_random_int() & MASK == prandom_u32_max(MASK + 1)
>*only if all the top bits of MASK are set* That is, if MASK one less

Oh whoops! Yes, right, I totally misread SIZE as MASK.

>than a power of two. Or if MASK & (MASK + 1) == 0.
>
>(If those top bits aren't set, you can technically do
>prandom_u32_max(MASK >> n + 1) << n. That'd be a nice thing to work out.
>But yeesh, maybe a bit much for the time being and probably a bit beyond
>coccinelle.)
>
>This case here, though, is a bit more special, where we can just rely on
>an obvious given kernel identity. Namely, PAGE_MASK == ~(PAGE_SIZE - 1).
>So ~PAGE_MASK == PAGE_SIZE - 1.
>So get_random_int() & ~PAGE_MASK == prandom_u32_max(PAGE_SIZE - 1 + 1).
>So get_random_int() & ~PAGE_MASK == prandom_u32_max(PAGE_SIZE).
>
>And most importantly, this makes the code more readable, since everybody
>knows what bounding by PAGE_SIZE means, where as what on earth is
>happening with the &~PAGE_MASK thing. So it's a good change. I'll try to
>teach coccinelle about that special case.

Yeah, it should be possible to just check for the literal.

>
>
>
>> > diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
>> > index f32c38abd791..8c9826062652 100644
>> > --- a/arch/loongarch/kernel/vdso.c
>> > +++ b/arch/loongarch/kernel/vdso.c
>> > @@ -78,7 +78,7 @@ static unsigned long vdso_base(void)
>> >  	unsigned long base = STACK_TOP;
>> >  
>> >  	if (current->flags & PF_RANDOMIZE) {
>> > -		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
>> > +		base += prandom_u32_max(VDSO_RANDOMIZE_SIZE);
>> >  		base = PAGE_ALIGN(base);
>> >  	}
>> >  
>> 
>> @minus_one@
>> expression FULL;
>> @@
>> 
>> - (get_random_int() & ((FULL) - 1)
>> + prandom_u32_max(FULL)
>
>Ahh, well, okay, this is the example I mentioned above. Only works if
>FULL is saturated. Any clever way to get coccinelle to prove that? Can
>it look at the value of constants?

I'm not sure if Cocci will do that without a lot of work. The literals trick I used below would need a lot of fanciness. :)

>
>> 
>> > diff --git a/arch/parisc/kernel/vdso.c b/arch/parisc/kernel/vdso.c
>> > index 63dc44c4c246..47e5960a2f96 100644
>> > --- a/arch/parisc/kernel/vdso.c
>> > +++ b/arch/parisc/kernel/vdso.c
>> > @@ -75,7 +75,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
>> >  
>> >  	map_base = mm->mmap_base;
>> >  	if (current->flags & PF_RANDOMIZE)
>> > -		map_base -= (get_random_int() & 0x1f) * PAGE_SIZE;
>> > +		map_base -= prandom_u32_max(0x20) * PAGE_SIZE;
>> >  
>> >  	vdso_text_start = get_unmapped_area(NULL, map_base, vdso_text_len, 0, 0);
>> >  
>> 
>> These are more fun, but Coccinelle can still do them with a little
>> Pythonic help:
>> 
>> // Find a potential literal
>> @literal_mask@
>> expression LITERAL;
>> identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
>> position p;
>> @@
>> 
>>         (randfunc()@p & (LITERAL))
>> 
>> // Add one to the literal.
>> @script:python add_one@
>> literal << literal_mask.LITERAL;
>> RESULT;
>> @@
>> 
>> if literal.startswith('0x'):
>>         value = int(literal, 16) + 1
>>         coccinelle.RESULT = cocci.make_expr("0x%x" % (value))
>> elif literal[0] in '123456789':
>>         value = int(literal, 10) + 1
>>         coccinelle.RESULT = cocci.make_expr("%d" % (value))
>> else:
>>         print("I don't know how to handle: %s" % (literal))
>> 
>> // Replace the literal mask with the calculated result.
>> @plus_one@
>> expression literal_mask.LITERAL;
>> position literal_mask.p;
>> expression add_one.RESULT;
>> identifier FUNC;
>> @@
>> 
>> -       (FUNC()@p & (LITERAL))
>> +       prandom_u32_max(RESULT)
>
>Oh that's pretty cool. I can do the saturation check in python, since
>`value` holds the parsed result. Neat.

It is (at least how I have it here) just the string, so YMMV.

>
>> > diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
>> > index 998dd2ac8008..f4944c4dee60 100644
>> > --- a/fs/ext2/ialloc.c
>> > +++ b/fs/ext2/ialloc.c
>> > @@ -277,8 +277,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
>> >  		int best_ndir = inodes_per_group;
>> >  		int best_group = -1;
>> >  
>> > -		group = prandom_u32();
>> > -		parent_group = (unsigned)group % ngroups;
>> > +		parent_group = prandom_u32_max(ngroups);
>> >  		for (i = 0; i < ngroups; i++) {
>> >  			group = (parent_group + i) % ngroups;
>> >  			desc = ext2_get_group_desc (sb, group, NULL);
>> 
>> Okay, that one is too much for me -- checking that group is never used
>> after the assignment removal is likely possible, but beyond my cocci
>> know-how. :)
>
>Yea this is a tricky one, which I initially didn't do by hand, but Jan
>seemed fine with it, and it's clear if you look at it. Trixy cocci
>indeed.

I asked on the Cocci list[1], since by the time I got to the end of your "by hand" patch I *really* wanted to have it work. I was so close!


>
>> > diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
>> > index 0927f44cd478..41a0321f641a 100644
>> > --- a/lib/test_hexdump.c
>> > +++ b/lib/test_hexdump.c
>> > @@ -208,7 +208,7 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
>> >  static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
>> >  {
>> >  	unsigned int i = 0;
>> > -	int rs = (prandom_u32_max(2) + 1) * 16;
>> > +	int rs = prandom_u32_max(2) + 1 * 16;
>> >  
>> >  	do {
>> >  		int gs = 1 << i;
>> 
>> This looks wrong. Cocci says:
>> 
>> -       int rs = (get_random_int() % 2 + 1) * 16;
>> +       int rs = (prandom_u32_max(2) + 1) * 16;
>
>!! Nice catch.
>
>Alright, I'll give this a try with more cocci. The big difficulty at the
>moment is the power of 2 constant checking thing. If you have any
>pointers on that, would be nice.
>
>Thanks a bunch for the guidance.

Sure thing! I was pleased to figure out how to do the python bit.

-Kees

[1] actually, I don't see it on lore... I will resend it

-- 
Kees Cook

