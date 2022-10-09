Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2B4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oirLAgHKzqbm2tDuRRRruxvBPFu6OuA1m1Bdo0JewVo=; b=WsnTAzNZ5FXUQaObF5ZWW4z5N3
	epD3+kOr8xs5hxZ+2JsG0SxJCUjF/2hdFX7LbrQ/IyblRvXfDKHkMQN+OI+tvBXpXX+g3cF9WTBBU
	vIEDjhZ8mRYqYwauDXo61iaVrWa4eeLidVXIVD5KBcRRae4RbfbOsc4kXXN+apUNiqTZXm3EHbXeh
	sxBXpb2tgOtEg4eFdCOB/ywEPEx/k20AF1Mn7ssYuvxYS60FF0buTu+fLSV41LMjYab8Lb6dUT6sV
	Mkg54tb/fzy+bd0IEMThg1xL/sDfDu1fg6COT+PmsEXfxl8Ad64OHNcuY0F4gXTldVTNYj89KwJgb
	eiua1IqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oho3i-00HZg5-Cn; Mon, 10 Oct 2022 08:22:46 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohX85-00Fh5T-B0; Sun, 09 Oct 2022 14:18:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9F728B80C91;
	Sun,  9 Oct 2022 14:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659D2C433D6;
	Sun,  9 Oct 2022 14:17:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YgHbN0I0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665325077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oirLAgHKzqbm2tDuRRRruxvBPFu6OuA1m1Bdo0JewVo=;
	b=YgHbN0I0lUsk61F/tkacjTtELz9m0jTOee92icnhvNyHJrs9iBf1nxk5rIk4LCzkioh8sG
	190YFxxX+8obr4IDytSpJV/y+LGJPtZT2kSp6+N5MRfHp0a/WJLUeHRU53NaAsEmu2d/gM
	WcwjBCYWAwT/EnbHfbZZP/9zFIVJmUM=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 76b4077f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 9 Oct 2022 14:17:57 +0000 (UTC)
Date: Sun, 9 Oct 2022 08:17:41 -0600
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
	sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 0/7] treewide cleanup of random integer usage
Message-ID: <Y0LYBaooZKDbL93G@zx2c4.com>
References: <20221008055359.286426-1-Jason@zx2c4.com>
 <202210082028.692DFA21@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210082028.692DFA21@keescook>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221009_071809_676931_23FD7966 
X-CRM114-Status: GOOD (  19.85  )
X-Mailman-Approved-At: Mon, 10 Oct 2022 01:22:45 -0700
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

On Sat, Oct 08, 2022 at 08:41:14PM -0700, Kees Cook wrote:
> On Fri, Oct 07, 2022 at 11:53:52PM -0600, Jason A. Donenfeld wrote:
> > This is a five part treewide cleanup of random integer handling. The
> > rules for random integers are:
> 
> Reviewing the delta between of my .cocci rules and your v5, everything
> matches, except for get_random_int() conversions for files not in
> your tree:
> [...]
> So, I guess I mean to say that "prandom: remove unused functions" is
> going to cause some pain. :) Perhaps don't push that to -next, and do a
> final pass next merge window to catch any new stuff, and then send those
> updates and the removal before -rc1 closes?

Ooof. Actually I think what I'll do is include a suggested diff for the
merge commit that fixes up the remaining two thankfully trivial cases.

Jason

