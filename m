Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69D4CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqj3UmKHIrhFaljOqUOkNl87o8COXU1Lnrph9Q9AGMo=; b=cpR6lkHMXy3G84wI0ihH/1sqCB
	Inm1e//DBnUTEr51u0KV6Xz/rwkrqnSnVI+cdTzynhQ4q2d7q5wSKPF6dHMVp5mm4HuOaDL9m+dls
	0LYUW36p3LszOZtAgPHy79OEXNAFZrP6L88uWRs73vGWf4qkoMUbWK9+Y0sOtUhLI5IvA7njOoRrk
	yYQe0Z2WJ80LuNdCsdM/+pZfYz8gNpkT+gLKO9XdEmvLn6+LduwYeDOAp7j3HwPUnSxSAQC0ewSN0
	NnLaWQc7rXQYJWrcqvy9p9h9VaiJCS5t/nNXzMH4YdV5VD0jcWhv8b2oteoBacibvzZYAboeGxsz+
	/JlxAbSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCIZ-0000000BPVC-2m68;
	Tue, 04 Nov 2025 08:21:51 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCIW-0000000BPUT-27yH
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:21:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762244509; x=1793780509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dP/Hm1oMz6SLtDZykC/Igqm1vfSgO20yu/vJJ9qLRMo=;
  b=DVoGWki7qK8q97pn87vNdo2LeLuzrjWDUQyWjvU/loOGa+3woZMt6Pvb
   3WKG/NXAsEER5wK5VRgrwJrzejFHZVI6+vkXlYMpN2eNtBX4+f1PT17wF
   hGNeSLq4XE0ZwStRP8NSBZXsgt9YgEP6ZI+AVlL8mlSsTOu73MII1NG+f
   HWT8yCbLP/rZxCGhTzINihDzoVGdNzlzsZ0Dj0Bz0ulptPIFmNolcU9kq
   T/LLXxSBgkkdc5gneh3WxvLcZJm/kt0PVHojdA/AXHz0nUdgvUb507yWA
   qJDCuX2PAeRVF3acGroDsSq6MOOzUBd2zynoqQFLjUJJ87KnLf14A+RST
   Q==;
X-CSE-ConnectionGUID: a5o+jnR6Tmy/J0C5Uc4CKg==
X-CSE-MsgGUID: DOc7Cq8hSq6RpdJL2iiZJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="74624574"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="74624574"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:21:48 -0800
X-CSE-ConnectionGUID: WovW5LIVSY26PgrjKgcFmQ==
X-CSE-MsgGUID: hY8UqPEpSLKpogQ7xIGJsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="186338170"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 00:21:44 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGCIO-00000005P6i-3Hb3;
	Tue, 04 Nov 2025 10:21:40 +0200
Date: Tue, 4 Nov 2025 10:21:40 +0200
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
Message-ID: <aQm3lHgM-M7ZRdVT@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251103132213.5feb4586@pumpkin>
 <aQi_JHjSi46uUcjB@smile.fi.intel.com>
 <aQjxjlJvLnx_zRx8@smile.fi.intel.com>
 <20251103192908.1d716a7b@pumpkin>
 <aQkEbZrabOzPBClg@smile.fi.intel.com>
 <20251103223255.3de9f9d7@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103223255.3de9f9d7@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_002148_588019_1756A492 
X-CRM114-Status: GOOD (  44.54  )
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

On Mon, Nov 03, 2025 at 10:32:55PM +0000, David Laight wrote:
> On Mon, 3 Nov 2025 21:37:17 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Nov 03, 2025 at 07:29:08PM +0000, David Laight wrote:
> > > On Mon, 3 Nov 2025 20:16:46 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Mon, Nov 03, 2025 at 04:41:41PM +0200, Andy Shevchenko wrote:  
> > > > > On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:    

...

> > > > > Pragma will be hated.  
> > > 
> > > They have been used in a few other places.
> > > and to disable more 'useful' warnings.  
> > 
> > You can go with pragma, but even though it just hides the potential issues.
> > Not my choice.
> 
> In this case you really want the version that has '[ 0 .. 255 ] = -1,',
> everything else is unreadable and difficult to easily verify.

No, if it's a generated via a helper script.

> > > > > I believe there is a better way to do what you want. Let me cook a PoC.    
> > > > 
> > > > I tried locally several approaches and the best I can come up with is the pre-generated
> > > > (via Python script) pieces of C code that we can copy'n'paste instead of that shortened
> > > > form. So basically having a full 256 tables in the code is my suggestion to fix the build
> > > > issue. Alternatively we can generate that at run-time (on the first run) in
> > > > the similar way how prime_numbers.c does. The downside of such an approach is loosing
> > > > the const specifier, which I consider kinda important.
> > > > 
> > > > Btw, in the future here might be also the side-channel attack concerns appear, which would
> > > > require to reconsider the whole algo to get it constant-time execution.  
> > > 
> > > The array lookup version is 'reasonably' time constant.  
> > 
> > The array doesn't fit the cacheline.
> 
> Ignoring all the error characters it is 2 (64 byte) cache lines (if aligned
> on a 32 byte boundary).
> They'll both be resident for any sane input, I doubt an attacker can determine
> when the second one is loaded.
> In any case you can load both at the start just to make sure.

> > > One option is to offset all the array entries by 1 and subtract 1 after reading the entry.  
> > 
> > Yes, I was thinking of it, but found a bit weird.
> > 
> > > That means that the 'error' characters have zero in the array (not -1).
> > > At least the compiler won't error that!
> > > The extra 'subtract 1' is probably just measurable.  
> > 
> > > But I'd consider raising a bug on gcc :-)  
> > 
> > And clang? :-)
> 
> clang is probably easier to get fixed.
> The warning can be disabled for 'old' compilers - only one build 'tool'
> needs to detect errors.
> 
> One solution is to disable the warnings in the compilers, but get sparse
> (which I think is easier to change?) to do a sane check that allows
> the entire array to default to non-zero while still checking for
> other errors.
> 
> > > One of the uses of ranged designated initialisers for arrays is to change the
> > > default value - as been done here.
> > > It shouldn't cause a warning.  
> > 
> > This is prone to mistakes when it's not the default rewrite. I fixed already
> > twice such an issue in drivers/hid in the past few months.
> 
> I was thinking that if the first initialiser is [ low ... high ] = value
> then it should be valid to change any value.
> I'm not sure what you fixed, clearly [ 4 ] = 5, [ 4 ] = 6, is an error,
> but it might be sane to allow any update of a 'range' initialiser.

You can check a Git history for that.

-- 
With Best Regards,
Andy Shevchenko



