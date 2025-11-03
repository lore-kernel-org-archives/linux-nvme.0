Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D4CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0XhJhFM7QGwzEnaZEmOqa1pFgyR5xzJH04JKPTfFs4=; b=oedFY4qNlqrIg2UJvvmndX/C5i
	HqFtX1DP2z4NchHhJ/wR1geR+YYx5yRB+LwBcLz5mEfw/zjddEitemaSVzHq0OmxfmXVtXeCNSlu9
	2nB46Y4t7d1vhMHrJ9qa8XNhcHD3a3LR6Uh/4sAuN30Kmv6xu97+SMefnqrZ5WMvBToHA567OFyJH
	5eTHK/5VRk1nFjWc6yFGQZel7p5o5QHojrRLGmn8hpaGHFvO8uotm8TrjuBs7kfz0uRWVYTS+TlnL
	7is7QyUhYNhKAvzGPA5JkzqpOYaatvAEd8nw9s5z0JYiut8hYQUEs+h2loix3yAxw2K/+F+r1Ftdo
	p+ZYt0xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvkp-0000000A2Fr-2LqG;
	Mon, 03 Nov 2025 14:41:55 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvkm-0000000A2FI-1ZiP
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 14:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762180912; x=1793716912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQ59v64epT75p54714TkgekaP2S42YjoI4BmxMoCpCM=;
  b=mKbfMqwyKFSl95dvwECoUT4JsSJyptZ9k4m+FR28PUBPUZw8/agsMbsk
   FuxrVytB0jSr4oBtq9HGyCQ90GzvCzdiVoDFRo+rdIQ8aISkdDElKliH/
   bz82RQpZmReNY+8c6UjlNZ6zxv3Mm2gP2jpSDSyNhEryxFvy68oIOj5WY
   XHJEReknzvks9xyooMNV7MY1AMdXIHNcRUNYiBnuiuN/Uiy0xfjQc19uP
   CgYmcRQozrcccbUFu9WEO206QF1esBXsMWugIKxXLMJzhVnOKPd9h+ho5
   Sc+GzACY7VDcCFuoF5R7TMYgCgm+PSxDNrLgP7qU3YZpMfRWDZ8GwpP0M
   A==;
X-CSE-ConnectionGUID: Hudf3crWQi2iDMJyyQPCTw==
X-CSE-MsgGUID: OhRjyWRNQnGZ/U+vxqqsTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="81885293"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="81885293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:41:51 -0800
X-CSE-ConnectionGUID: 0zAEEE0mQ46SUaPeP5Avdw==
X-CSE-MsgGUID: 1Pdepk/aQmO00uwm4FBN2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="191208571"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 06:41:48 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vFvkb-00000005B1n-37cg;
	Mon, 03 Nov 2025 16:41:41 +0200
Date: Mon, 3 Nov 2025 16:41:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	Andrew Morton <akpm@linux-foundation.org>, ebiggers@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
	idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, home7438072@gmail.com,
	linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <aQi_JHjSi46uUcjB@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251103132213.5feb4586@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103132213.5feb4586@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_064152_429648_0CDF7E52 
X-CRM114-Status: GOOD (  37.90  )
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

On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:
> On Mon, 3 Nov 2025 19:07:24 +0800
> Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:
> > > On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:  
> > > > On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

...

> > > > Looks like wonderful work, thanks.  And it's good to gain a selftest
> > > > for this code.
> > > >   
> > > > > This improves throughput by ~43-52x.  
> > > > 
> > > > Well that isn't a thing we see every day.  
> > > 
> > > I agree with the judgement, the problem is that this broke drastically a build:
> > > 
> > > lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
> > >    26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > >       |                  ^
> > > lib/base64.c:35:17: note: previous initialization is here
> > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
> > >    25 |         [0 ... 255] = -1, \
> > >       |                       ^~
> > > ...
> > > fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > > 20 errors generated.
> > >   
> > Since I didn't notice this build failure, I guess this happens during a
> > W=1 build? Sorry for that. Maybe I should add W=1 compilation testing
> > to my checklist before sending patches in the future. I also got an
> > email from the kernel test robot with a duplicate initialization
> > warning from the sparse tool [1], pointing to the same code.
> > 
> > This implementation was based on David's previous suggestion [2] to
> > first default all entries to -1 and then set the values for the 64
> > character entries. This was to avoid expanding the large 256 * 3 table
> > and improve code readability.
> > 
> > Since I believe many people test and care about W=1 builds,
> 
> Last time I tried a W=1 build it failed horribly because of 'type-limits'.
> The kernel does that all the time - usually for its own error tests inside
> #define and inline functions.
> Certainly some of the changes I've seen to stop W=1 warnings are really
> a bad idea - but that is a bit of a digression.
> 
> Warnings can be temporarily disabled using #pragma.
> That might be the best thing to do here with this over-zealous warning.
> 
> This compiles on gcc and clang (even though the warnings have different names):
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Woverride-init"
> int x[16] = { [0 ... 15] = -1, [5] = 5};
> #pragma GCC diagnostic pop
> 
> > I think we need to find another way to avoid this warning?
> > Perhaps we could consider what you suggested:
> > 
> > #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> > 	[ 0 ... '+'-1 ] = -1, \
> > 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > 	[ '9'+1 ... 'A'-1 ] = -1, \
> > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > 	[ 'Z'+1 ... '_'-1 ] = -1, \
> > 	[ '_' ] = val_under, \
> > 	[ '_'+1 ... 'a'-1 ] = -1, \
> > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > 	[ 'z'+1 ... 255 ] = -1 \
> > }
> 
> I just checked, neither gcc nor clang allow empty ranges (eg [ 6 ... 5 ] = -1).
> Which means the coder has to know which characters are adjacent as well
> as getting the order right.
> Basically avoiding the warning sucks.
> 
> > Or should we just expand the 256 * 3 table as it was before?
> 
> That has much the same issue - IIRC it relies on three big sequential lists.
> 
> The #pragma may be best - but doesn't solve sparse (unless it processes
> them as well).

Pragma will be hated. I believe there is a better way to do what you want. Let
me cook a PoC.

> > [1]: https://lore.kernel.org/oe-kbuild-all/202511021343.107utehN-lkp@intel.com/
> > [2]: https://lore.kernel.org/lkml/20250928195736.71bec9ae@pumpkin/

-- 
With Best Regards,
Andy Shevchenko



