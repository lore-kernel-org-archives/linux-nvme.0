Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64173CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXSGQrsA1EUiXoEZEA4Kjb0uHmbp7FPBFD1yws5VI/w=; b=slDtOCwg2JNin1mfZxzjoB0wkv
	zDwVk+5paaXt6c+tXVfZsRimaVJJby9ZLa7fGQTW8NxbBJJ9jmcWwcK2BJwgtVr8jO5xiFt6RaJil
	fyxVJ3qXfON3nHYEO0y10N2UxkoNmOe8lH3bNYirRHFY4+PIpAPKYrT9EnTNg1NVC3AfOf8tHjy+G
	cUh0mSiFAPe40V1+H9SEVfKQH5WJNpblT9cgSVPsvi9DeRIsowOQa+3kDx2q/AVj7GjEsK6RRfbWM
	Gr/ddrRbJ3OS2x+CjVYZw8y1VSNIbRZvFxepNVSUC57qjVXJVOknFmfUA4IGiZYrN7hoccUnwT7Xu
	tuZtNmYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0Mt-0000000AYAu-30bW;
	Mon, 03 Nov 2025 19:37:31 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0Mr-0000000AYAV-0JwD
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 19:37:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762198649; x=1793734649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgEOeQ/NAx7WrRk1gHE8VihYRMACDTSdXchi5b7f89Q=;
  b=OiCwAPOMpzh/PIf2gcXm0dH7NHAO8X6KuaoGzwqI/5PHhvm49eKiLp/n
   qEWhILJM2Od1BMEqzgLc9nVnvXC7d20FvsKMYuyiwHspJMhAgflumSgTF
   rmq1c1R4qHpEH8Tdtq2uAkewxdmuVW4l/RFFuXqUzkRivqj6y8grXXACs
   jiOBS1g2HraLFxnauD94abSGlZIAYq3oBXfbx7BwLPwq2m9Bym78Z1bDn
   Sk5sOwUB1HUnmf8IrvxDPGeP69bKi0i1gDtrCpWLZx0DDqIkw3KxKNJbG
   LrgMuhS42Vt+H1PY0tcg2XblaFy3YKsfiP7pIqHvopQImFvHn0DJpVDAG
   w==;
X-CSE-ConnectionGUID: mJ2pyU83Q4yMbY/gh0jKsw==
X-CSE-MsgGUID: vS1deAOwRzO2frIjZWTP7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66896524"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="66896524"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:37:28 -0800
X-CSE-ConnectionGUID: IkgWZNzwSI6gCDkNlx30xg==
X-CSE-MsgGUID: A5QP/6+iRmurKpAVKqzaQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187674793"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:37:25 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vG0Mg-00000005FeO-1lqu;
	Mon, 03 Nov 2025 21:37:18 +0200
Date: Mon, 3 Nov 2025 21:37:17 +0200
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
Message-ID: <aQkEbZrabOzPBClg@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251103132213.5feb4586@pumpkin>
 <aQi_JHjSi46uUcjB@smile.fi.intel.com>
 <aQjxjlJvLnx_zRx8@smile.fi.intel.com>
 <20251103192908.1d716a7b@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103192908.1d716a7b@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_113729_156576_1CCC02DF 
X-CRM114-Status: GOOD (  27.23  )
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

On Mon, Nov 03, 2025 at 07:29:08PM +0000, David Laight wrote:
> On Mon, 3 Nov 2025 20:16:46 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Nov 03, 2025 at 04:41:41PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:  

...

> > > Pragma will be hated.
> 
> They have been used in a few other places.
> and to disable more 'useful' warnings.

You can go with pragma, but even though it just hides the potential issues.
Not my choice.

> > > I believe there is a better way to do what you want. Let me cook a PoC.  
> > 
> > I tried locally several approaches and the best I can come up with is the pre-generated
> > (via Python script) pieces of C code that we can copy'n'paste instead of that shortened
> > form. So basically having a full 256 tables in the code is my suggestion to fix the build
> > issue. Alternatively we can generate that at run-time (on the first run) in
> > the similar way how prime_numbers.c does. The downside of such an approach is loosing
> > the const specifier, which I consider kinda important.
> > 
> > Btw, in the future here might be also the side-channel attack concerns appear, which would
> > require to reconsider the whole algo to get it constant-time execution.
> 
> The array lookup version is 'reasonably' time constant.

The array doesn't fit the cacheline.

> One option is to offset all the array entries by 1 and subtract 1 after reading the entry.

Yes, I was thinking of it, but found a bit weird.

> That means that the 'error' characters have zero in the array (not -1).
> At least the compiler won't error that!
> The extra 'subtract 1' is probably just measurable.

> But I'd consider raising a bug on gcc :-)

And clang? :-)

> One of the uses of ranged designated initialisers for arrays is to change the
> default value - as been done here.
> It shouldn't cause a warning.

This is prone to mistakes when it's not the default rewrite. I fixed already
twice such an issue in drivers/hid in the past few months.

-- 
With Best Regards,
Andy Shevchenko



