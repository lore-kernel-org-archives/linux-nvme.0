Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF4DCCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HciD2tZg5AxEwB/L+8KmAmhPZBSsmYldsKxcEvJNVyg=; b=KsH/s77OQPUJnVTSy+HOyNqaRi
	9wSq8J48JPZ6QujLeICTKguIxnKi65hFpxOZFmxnZHQnpXN3uEO6X9vBL+kYjh4n1Tef6rAs7F1zb
	u1KqGJttVzXfLkEZDBTMdurjtO92qOtSTqHMh1SNVfcBqTNVq2vDHi3gJ40z55N7mJSph18dy4grp
	w1Wf53t9nzdrWFxj6jHiUs3+z6b2igigYwYvcZ2rBpTTv7oxRGZrZ3Xm0VW3y6pnPImrUmB+Gifqb
	LG5gkHt//EjIMI8L5y8hc+k9dORtbbmIeZFHCaL8q7xN77vasNSVxGTeV6muAuymmT4NVmNnKRoN4
	Jg6fRHNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGDf4-0000000BYcU-0Nv4;
	Tue, 04 Nov 2025 09:49:10 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGDf1-0000000BYc9-1pio
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 09:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762249747; x=1793785747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFNn8R9GSgOtgVVbPwExTDvjsAaEeew2m/fOM1y0PDQ=;
  b=RKPOqNTou/5KZEXnotu7beksrTiX3EtXV5ODgK/Q+RInkcUHtelrpG9y
   lHd08IumbbpyOhr55nJodJk3vB4Cdv6SKVWVV8vQPhd2RiMQFS7aZd69M
   o0l0JSCxUWF4JLjjdObp0tvMKPme/G37w3jNj8QFLaqN2CskETZcnFdEK
   EUiCnptLhIKzdF3nbxX26fXir+e+uCj+f2thgctMf8gv6nqpKBenbfkNv
   d0eV82J1IKNme5erHSjmUlRnuR5gA8yydEjN2S37kx3ZTbQpmMYYDFkdG
   HjDUif80jQd3hxxuJihf/HU2szfuVd/Ax0tAQGNWL0WP8AA2BL3k98ZzX
   g==;
X-CSE-ConnectionGUID: Z6x18YI3RHWOEDjivq6ZbA==
X-CSE-MsgGUID: EMpE8OjwTdGYkDJMSlHDfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63351111"
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="63351111"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:49:05 -0800
X-CSE-ConnectionGUID: DTpau+4xQrGHRDFrDVtjaQ==
X-CSE-MsgGUID: bFPa4gb+TrCyIeBrHQLKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="186804197"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:49:01 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGDer-00000005QLT-1Zbv;
	Tue, 04 Nov 2025 11:48:57 +0200
Date: Tue, 4 Nov 2025 11:48:57 +0200
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
Message-ID: <aQnMCVYFNpdsd-mm@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251104090326.2040fa75@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104090326.2040fa75@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_014907_512844_A4C865B3 
X-CRM114-Status: GOOD (  23.03  )
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

On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:
> On Mon, 3 Nov 2025 19:07:24 +0800
> Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:

...

> > Since I believe many people test and care about W=1 builds, I think we
> > need to find another way to avoid this warning? Perhaps we could
> > consider what you suggested:
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
> I've a slightly better version:
> 
> #define INIT_62_63(ch, ch_62, ch_63) \
> 	[ ch ] = ch == ch_62 ? 62 : ch == ch_63 ? 63 : -1
> 
> #define BASE64_REV_INIT(ch_62, ch_63) { \
> 	[ 0 ... '0' - 6 ] = -1, \
> 	INIT_62_63('+', ch_62, ch_63), \
> 	INIT_62_63(',', ch_62, ch_63), \
> 	INIT_62_63('-', ch_62, ch_63), \
> 	INIT_62_63('.', ch_62, ch_63), \
> 	INIT_62_63('/', ch_62, ch_63), \
> 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> 	[ '9' + 1 ... 'A' - 1 ] = -1, \
> 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> 	[ 'Z' + 1 ... '_' - 1 ] = -1, \
> 	INIT_62_63('_', ch_62, ch_63), \
> 	[ '_' + 1 ... 'a' - 1 ] = -1, \
> 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> 	[ 'z' + 1 ... 255 ] = -1 \
> }
> 
> that only requires that INIT_62_63() be used for all the characters
> that are used for 62 and 63 - it can be used for extra ones (eg '.').
> If some code wants to use different characters; the -1 need replacing
> with INIT_62_63() but nothing else has to be changed.
> 
> I used '0' - 6 (rather than '+' - 1 - or any other expression for 0x2a)
> to (possibly) make the table obviously correct without referring to the
> ascii code table.

Still it's heavily depends on the values of '+,-./_' as an index that
makes it not so flexible.

Moreover this table is basically a dup of the strings in the first array.
Which already makes an unnecessary duplication. That's why I prefer to
see a script (one source of data) to generate the header or something like
this to have the tables and strings robust against typos.

The above is simply an unreadable mess.

-- 
With Best Regards,
Andy Shevchenko



