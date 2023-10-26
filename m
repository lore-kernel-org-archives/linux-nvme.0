Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D54C25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OYvhj3NsRwxf9LMmZ5qla14Lm3aJRVjqWShJ7+elEfI=; b=x9Xk+f38bG8xpD56TEzVjXpQsU
	+5a7Y69LU/1hgo2KCCQHpaqPaTqWdAoysb6dau6S7+FxL0aqHoXPrQskg5g+B3b/ydwqYgghep9Og
	yCgiCpLCTtoIUTK8sFAcWGAs8eXvdPZE5EULQiCWn9RieYBOWOEJoU18xnEXa6S/ZI+DRHOAwbvGE
	NEo4DszZaVZmp/0SwHbxiLheg7qO2B9zWdovvL1QRYiM0lF5kJBJyMaSfU0EJlZDOIxwSAmOBGlYl
	4a6kUfonGpvmELfRyeYZ6X+nFEFjSN5RHZrFObYqmBaeHVd2Q27+LF9e9C61CAI6C1NiGjxWaoRuz
	yr8T9u2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvxBo-00E7mX-0K;
	Thu, 26 Oct 2023 10:02:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvxBj-00E7in-0W
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 10:02:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3711867373; Thu, 26 Oct 2023 12:01:49 +0200 (CEST)
Date: Thu, 26 Oct 2023 12:01:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <20231026100148.GA26941@lst.de>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com> <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook> <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com> <202310201127.DA7EDAFE4D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310201127.DA7EDAFE4D@keescook>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_030203_372829_1A484BCF 
X-CRM114-Status: GOOD (  20.01  )
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

On Fri, Oct 20, 2023 at 11:30:49AM -0700, Kees Cook wrote:
> I'm curious where you looked and didn't find documentation -- perhaps
> there is an improvement to be made to aim one to where the existing
> documentation lives?

My order was the following:

 - look for kernel doc on the main function implementation in
   lib/string.c (as found by a grep for an EXPORT_SYMBOL for it)
 - after not finding it there, but seeing that it has an ifdef for
   an arch override, which turns out to be unused
 - then I grepped the Documentation/ directory for it, and while
   there are quite a few matches for strscpy, they are largely
   in examples, with the only text referring to strscpy being
   Documentation/process/deprecated.rst that tells you to use it
   instead of strcpy, but not how it actually works
 - after that I realized that some people put the kerneldoc on
   the declaration, so I looked at that in string.h, but couldn't
   find it.

> > There's some docs at [1]. Perhaps there could be more?
> > 
> > [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> Right, And it's even valid kern-doc, which gets rendered in the kernel
> API docs, along with all the other string functions:
> https://docs.kernel.org/core-api/kernel-api.html#c.strscpy

Well, I never use the generated kerneldoc because it's much harder than
just grepping the tree, but indeed it exists even if it's hidden in
the most obsfucated way.  But at least I know now!


