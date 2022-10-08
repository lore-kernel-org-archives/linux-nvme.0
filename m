Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E319C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZQ88pPgtouR86lBpg+x1aw/csf1v9uxp8peXKk1cb0=; b=xjPv+j+88qSeqc/toXCU0ymMT5
	c9RCerWV7F1czjTn0WMRaTVpQ6g9I3g0mcRsN5tgaIX5kQU+fcixMXf2XWaQzopUI5v0IBzO/FE+L
	ECh7pkdvEQae5Bbj4/LaUsWLArRyfkR/KjmTQp54MZaq5RxYwgbpAQTsiSYO5VLTY91fxdAdehy7p
	MIFQm88+k9uub0bNk5oRy+cLnh/priH4uUZ9ChMi2NIi44KXGvElJjTOTDdXeJYNCHY5yOXDFm1Xo
	oaXy6at7Q5EfGmtROlc0dzGgB+K2FCcfnkCG9tgZCqVoStQJIi31LxBHkSLRJ6Rvl4kG4KVNL0VPQ
	MxS+hbtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQNU-00F2jF-N5; Sun, 09 Oct 2022 07:05:36 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oh4Kl-00CHCf-GV; Sat, 08 Oct 2022 07:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zZQ88pPgtouR86lBpg+x1aw/csf1v9uxp8peXKk1cb0=;
  b=j3ST7SGnTYT/Y5wi6lWHZVyoTN6fTohW3n4oD0o9maLZmdhUccDAwXNB
   CrIK4oBY5dqegOsWJRE3rrwkzrofbuFPsdX2RZ0LPGmouitc76P+QhHmS
   HaFrH+aHq9cCtdo04t374NKt8+gA8QS7/hDJOozImMV5dxKm1CxmPsJ2W
   U=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,169,1661810400"; 
   d="scan'208";a="56593050"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 09:33:09 +0200
Date: Sat, 8 Oct 2022 09:33:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
    patches@lists.linux.dev, Andreas Noever <andreas.noever@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
    =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>, 
    Christoph Hellwig <hch@lst.de>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>, 
    Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, 
    Dave Hansen <dave.hansen@linux.intel.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, 
    Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
    Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, 
    Jakub Kicinski <kuba@kernel.org>, 
    "James E. J. Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Berg <johannes@sipsolutions.net>, 
    Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
    KP Singh <kpsingh@kernel.org>, Marco Elver <elver@google.com>, 
    Mauro Carvalho Chehab <mchehab@kernel.org>, 
    Michael Ellerman <mpe@ellerman.id.au>, 
    Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, 
    Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, 
    Ulf Hansson <ulf.hansson@linaro.org>, 
    Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, 
    Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
    dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com, 
    kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
    linux-mm@kvack.org, linux-mmc@vger.kernel.org, 
    linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, 
    linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-um@lists.infradead.org, 
    linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
    netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, 
    Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 2/6] treewide: use prandom_u32_max() when possible
In-Reply-To: <53DD0148-ED15-4294-8496-9E4B4C7AD061@chromium.org>
Message-ID: <alpine.DEB.2.22.394.2210080925390.2928@hadrien>
References: <53DD0148-ED15-4294-8496-9E4B4C7AD061@chromium.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221008_003319_853216_04489235 
X-CRM114-Status: GOOD (  17.68  )
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

> >> @minus_one@
> >> expression FULL;
> >> @@
> >>
> >> - (get_random_int() & ((FULL) - 1)
> >> + prandom_u32_max(FULL)
> >
> >Ahh, well, okay, this is the example I mentioned above. Only works if
> >FULL is saturated. Any clever way to get coccinelle to prove that? Can
> >it look at the value of constants?
>
> I'm not sure if Cocci will do that without a lot of work. The literals trick I used below would need a lot of fanciness. :)

If FULL is an arbitrary expression, it would not be easy to automate.  If
it is a constant then you can use python/ocaml to analyze its value.  But
if it's a #define constant then you would need a previous rule to match the
#define and find that value.

For LITERAL, I think you could just do constant int LITERAL; for the
metavariable declaration.

julia

