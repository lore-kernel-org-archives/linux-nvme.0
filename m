Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A919EC433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Oct 2022 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKkERMB1M9xOEPNfE3IrAsq0mJwwY0seKkU7oCng9qc=; b=1mXKMt0U0qQcOTHv73hbfr+Xum
	tvDXjSwte1DbKI6Zm2K3YrbrfKir7F0BGRa1U8qtXwXJrQYC8fk3uyyY7idFwGsjNpiFauTuHGO6e
	BFzcGcP2zfyNfEruBOs9Bq0LQhREOIeCOfO69S/hbq8wFvktAOMCnsZBVgeUr/f95yTPKyNJd6lr4
	/DCaoEPvLncJpdzhp6tQ9flZf6C7q6nazystgJg+rzzFY5lwMrxQuYSZU2fzvGzvrYQDnN1/ERdu3
	zXfq9sn4JPRmbGN2h92VCO0FcHN4ePZARmKSl3fxuJy79nQgJZLUBxAbozQ+eTndA56jO2XVt9hc/
	TYR/eWnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohQOs-00F35c-8S; Sun, 09 Oct 2022 07:07:02 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohENH-00Dx8Q-6w; Sat, 08 Oct 2022 18:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665252995; x=1696788995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7YlJwn22ePcF+UsrTEOpg8IcVNJxX9fgtN3uSim9/E=;
  b=nmrnNvC4+8vyRyLwigolCMDVOR2rxzFuISY7b9WRlf5FEqVTJh/3Ziun
   3MEFBherXCMisBNOFfLZ0yWE+zPyzGWbeUnEkDK+tXqnAHnr9hhKH0OZC
   4jZt1zklk6DOXF3sPx8JngVisI+jSb9W81obJik1sSnU1YDBRABxCtQ3m
   UKSu2ICX1W4EGmqwvZv1SKDNMxm/y/iz0ETqnqq5a+3zk55yPmTzygGP7
   FbZmmbA0Jr0KuP3v1079WwVexN+mYwuStqwp7LIVnABst8XY0Tr/LikMF
   2TeXEeF1g/8YEdKwz9CtMlJ8JcJG9NvdWp4nxzHgTGv7vCGiW0V6ERZbs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="365920528"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="365920528"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2022 11:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10494"; a="750899918"
X-IronPort-AV: E=Sophos;i="5.95,170,1661842800"; 
   d="scan'208";a="750899918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 08 Oct 2022 11:16:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ohEN3-0048ft-0Q;
	Sat, 08 Oct 2022 21:16:21 +0300
Date: Sat, 8 Oct 2022 21:16:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
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
Message-ID: <Y0G+dP9uGaYHSa9y@smile.fi.intel.com>
References: <53DD0148-ED15-4294-8496-9E4B4C7AD061@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53DD0148-ED15-4294-8496-9E4B4C7AD061@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221008_111635_338741_739F85AF 
X-CRM114-Status: GOOD (  16.41  )
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

On Fri, Oct 07, 2022 at 08:50:43PM -0700, Kees Cook wrote:
> On October 7, 2022 7:21:28 PM PDT, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> >On Fri, Oct 07, 2022 at 03:47:44PM -0700, Kees Cook wrote:
> >> On Fri, Oct 07, 2022 at 12:01:03PM -0600, Jason A. Donenfeld wrote:

...

> >> These are more fun, but Coccinelle can still do them with a little
> >> Pythonic help:
> >> 
> >> // Find a potential literal
> >> @literal_mask@
> >> expression LITERAL;
> >> identifier randfunc =~ "get_random_int|prandom_u32|get_random_u32";
> >> position p;
> >> @@
> >> 
> >>         (randfunc()@p & (LITERAL))
> >> 
> >> // Add one to the literal.
> >> @script:python add_one@
> >> literal << literal_mask.LITERAL;
> >> RESULT;
> >> @@
> >> 
> >> if literal.startswith('0x'):
> >>         value = int(literal, 16) + 1
> >>         coccinelle.RESULT = cocci.make_expr("0x%x" % (value))
> >> elif literal[0] in '123456789':
> >>         value = int(literal, 10) + 1
> >>         coccinelle.RESULT = cocci.make_expr("%d" % (value))
> >> else:
> >>         print("I don't know how to handle: %s" % (literal))

Wouldn't Python take care about (known) prefixes itself?

	try:
		x = int(literal)
	except ValueError as ex:
		print(..., ex.error)

> >> // Replace the literal mask with the calculated result.
> >> @plus_one@
> >> expression literal_mask.LITERAL;
> >> position literal_mask.p;
> >> expression add_one.RESULT;
> >> identifier FUNC;
> >> @@
> >> 
> >> -       (FUNC()@p & (LITERAL))
> >> +       prandom_u32_max(RESULT)
> >
> >Oh that's pretty cool. I can do the saturation check in python, since
> >`value` holds the parsed result. Neat.
> 
> It is (at least how I have it here) just the string, so YMMV.

...

> >Thanks a bunch for the guidance.
> 
> Sure thing! I was pleased to figure out how to do the python bit.

I believe it can be optimized

-- 
With Best Regards,
Andy Shevchenko



