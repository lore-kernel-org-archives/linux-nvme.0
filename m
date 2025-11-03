Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074D7CCFA06
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8SKO8imzC4y46g5z2bvmeEnlE0hb6dUFm2OcrvWdnw=; b=CTm4QFBk7LRFODGwq24tXPguVS
	AHBiMrRN2M5Vv183YuVGcaEbisbSVqOAcOWW5gdqcl79if3NfGn2HSR2EYhdw64NkzBFHY/1SMQtY
	tZ4gFi17TfAwNJejCS/YnyVOHByuCQ3nfi7kuc2kMVyIvxyZG52s0ApVl4lmSceTQ5sk1n6E3v4pM
	mvcIG0Fz8MCAgolz+scsP8FHgC8CWCvMbfkd2KYCw9XDuOn2NeKbrZAELkgyPl6uGgoe0Vl7tGI5P
	4zWxv5IpM7YsIv6pjlqR5GhD+BlWOA6UNdmpUVVzWsMluSAUXjJLOPdoytOAnpdp136Y2Z7VfUjAD
	zB+w3+6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFrjw-00000009cZp-152L;
	Mon, 03 Nov 2025 10:24:44 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFrjt-00000009cYd-2Zyd
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 10:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762165482; x=1793701482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mMwseOtfch0WkUGPSpFwAXRTLyTjgl9zM2KFRVdOVDg=;
  b=dYk36ZASxZZjP2H4+gDj7ai7fmdnAE24G0RXh/mdkx3hAX/BdGh3feNT
   IBfBjFeTGC5wTsLI4bCE207AtEd0ACZWO2g8+2NZig0cscjLggpwLq58B
   6sAcWvdOEDsmwrUPigZtQoW8qHtGa9a2B3u1kGnN3/8DB43LbQaX/2kqr
   Hy916+Bk4Ixzsc+YMmvpOzcAcitzxL9MKlNPvnO04E01vXO+Df0F3NtDb
   UBTrnmoEcuJdIwGXRjfiKPHeUN3328zUmBmHD3V1xIF7maxwBWcI8BgsH
   IWNh9Cw53x44OfbLjLOhDn+DsIiISnLm33f2ffwuaYP5O5o6YOhMoqIRI
   A==;
X-CSE-ConnectionGUID: jJ9wXqbQROSv+FB7FegKFA==
X-CSE-MsgGUID: ftmEQ5rNT8KTFqxsS9rB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="74839904"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="74839904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 02:24:40 -0800
X-CSE-ConnectionGUID: GSkOX9xmStqEMunUgyEZ7g==
X-CSE-MsgGUID: 0qHH5bPeSHCjgFcT4iPTOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; 
   d="scan'208";a="186705439"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 03 Nov 2025 02:24:36 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8D05495; Mon, 03 Nov 2025 11:24:35 +0100 (CET)
Date: Mon, 3 Nov 2025 11:24:35 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, ebiggers@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
	idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, visitorckw@gmail.com, home7438072@gmail.com,
	linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <aQiC4zrtXobieAUm@black.igk.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_022441_664573_05B17C45 
X-CRM114-Status: GOOD (  25.64  )
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

On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:
> On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> > This series introduces a generic Base64 encoder/decoder to the kernel
> > library, eliminating duplicated implementations and delivering significant
> > performance improvements.
> > 
> > The Base64 API has been extended to support multiple variants (Standard,
> > URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
> > a variant parameter and an option to control padding. As part of this
> > series, users are migrated to the new interface while preserving their
> > specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
> > and NVMe is updated to BASE64_STD.
> > 
> > On the encoder side, the implementation processes input in 3-byte blocks,
> > mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
> > streaming and reduces loop overhead, achieving about a 2.7x speedup compared
> > to previous implementations.
> > 
> > On the decoder side, replace strchr() lookups with per-variant reverse tables
> > and process input in 4-character groups. Each group is mapped to numeric values
> > and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
> > rejecting invalid '=' usage and enforcing tail rules.
> 
> Looks like wonderful work, thanks.  And it's good to gain a selftest
> for this code.
> 
> > This improves throughput by ~43-52x.
> 
> Well that isn't a thing we see every day.

I agree with the judgement, the problem is that this broke drastically a build:

lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
   35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
   26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
      |                  ^
lib/base64.c:35:17: note: previous initialization is here
   35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
   25 |         [0 ... 255] = -1, \
      |                       ^~
...
fatal error: too many errors emitted, stopping now [-ferror-limit=]
20 errors generated.


> : Decode:
> :   64B   ~1530ns  ->  ~80ns    (~19.1x)
> :   1KB  ~27726ns  -> ~1239ns   (~22.4x)
> 
> 
> : Encode:
> :   64B   ~90ns   -> ~32ns   (~2.8x)
> :   1KB  ~1332ns  -> ~510ns  (~2.6x)
> : 
> : Decode:
> :   64B  ~1530ns  -> ~35ns   (~43.7x)
> :   1KB ~27726ns  -> ~530ns  (~52.3x)
> 
> 
> : This change also improves performance: encoding is about 2.7x faster and
> : decoding achieves 43-52x speedups compared to the previous implementation.
> 
> : This change also improves performance: encoding is about 2.7x faster and
> : decoding achieves 43-52x speedups compared to the previous local
> : implementation.
> 
> 
> Do any of these callers spend a sufficient amount of time in this
> encoder/decoder for the above improvements to be observable/useful?
> 
> 
> I'll add the series to mm.git's mm-nonmm-unstable branch to give it
> linux-next exposure.  I ask the NVMe, ceph and fscrypt teams to check
> the code and give it a test in the next few weeks, thanks.  
> 

-- 
With Best Regards,
Andy Shevchenko



