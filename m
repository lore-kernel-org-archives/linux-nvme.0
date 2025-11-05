Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17DBCCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 14:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Gf8V7ftC/MDBz565M4YSpf4pg/ZIof6sKom+0eLV40=; b=x2GbUc3fg57Qrqi16PpLWb+iMe
	U3XaenIV1AzkQg5sw4uiQ1W8KYP8ayLcbkhn60qSxrMLGn59pLRT/p/HZmG3Fht7TxGoesCWXHROd
	zE4u8FlkM2vXEV8dqf/d2k8QIZFf9+XRjUa/Ox8ei+NYvzw0FgdXTfqWyky3qyh1a+btvVmD43sKc
	t1N8Vt8nmWAs4jCXMMowjmFMaOmfUr0xKLaVkUu3mFSIBSONg9C05JTRRDoJilk4TazhyyduC2ieZ
	qhrkTXvPt/d1MacoeBA+DO6voIVkfpi14qee+Q0QTBFqR3UWxWnluCFOt9j2AsfDFG1ZMrhpP5WZ/
	ABUVz+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGeGv-0000000Dpmz-3hsX;
	Wed, 05 Nov 2025 14:14:01 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGeGt-0000000DpmT-0YZI
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 14:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762352039; x=1793888039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mhXbtiEH6qAblJDcaGWY99bememKt2hAAILJX1XxmYg=;
  b=aydsZisRU0g6oJS9uhndUgSCvmakVufgUboSWLko7bfAJMjs9FyvRa91
   EZCZ7/DIeqrJT7q8sMD84yO5E5Izv+nAohFON8NMYxiiBY28f8HcSam8b
   8qPJRMAkcYsIXLhTlmpfzVQ7+lEJu9RkjlRAdJ/4TZpUBQ5AXH3zb3RKv
   i8qAnd3wDND7pPJoFfi0jh5Emv1GDxBWs8dGFs+jx3Fo1IVeEPRiLURRy
   zg+RAeKT5ksdgYSJpeBBcy1Wm+qaTZfOnhcBpqEKjntMXk/tV4YiR4f/0
   l0EDOLOTcmhG334ckNdD3MYtDyMNj3B8zpGfkBdbnp1Bp0vhW8W1F7Qaj
   Q==;
X-CSE-ConnectionGUID: Hv0daDKPSBO/ScJQisOvwA==
X-CSE-MsgGUID: UqoVW2TLSoCkEb32oL7yYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75146944"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="75146944"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:13:57 -0800
X-CSE-ConnectionGUID: 8B3OwV01QkO7mVC115Q7Xg==
X-CSE-MsgGUID: jJyAflNhTJaCLLWk+18wPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186753396"
Received: from ldmartin-desk2.corp.intel.com (HELO ashevche-desk.local) ([10.124.221.135])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:13:53 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGeGg-00000005nwh-2EoW;
	Wed, 05 Nov 2025 16:13:46 +0200
Date: Wed, 5 Nov 2025 16:13:45 +0200
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
Message-ID: <aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251104090326.2040fa75@pumpkin>
 <aQnMCVYFNpdsd-mm@smile.fi.intel.com>
 <20251105094827.10e67b2d@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105094827.10e67b2d@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_061359_189898_BCCAFF88 
X-CRM114-Status: GOOD (  35.38  )
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

On Wed, Nov 05, 2025 at 09:48:27AM +0000, David Laight wrote:
> On Tue, 4 Nov 2025 11:48:57 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:
> > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:  
> > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:  

...

> > > > Since I believe many people test and care about W=1 builds, I think we
> > > > need to find another way to avoid this warning? Perhaps we could
> > > > consider what you suggested:
> > > > 
> > > > #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> > > > 	[ 0 ... '+'-1 ] = -1, \
> > > > 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> > > > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > > > 	[ '9'+1 ... 'A'-1 ] = -1, \
> > > > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > > > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > > > 	[ 'Z'+1 ... '_'-1 ] = -1, \
> > > > 	[ '_' ] = val_under, \
> > > > 	[ '_'+1 ... 'a'-1 ] = -1, \
> > > > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > > > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > > 	[ 'z'+1 ... 255 ] = -1 \
> > > > }  
> > > 
> > > I've a slightly better version:
> > > 
> > > #define INIT_62_63(ch, ch_62, ch_63) \
> > > 	[ ch ] = ch == ch_62 ? 62 : ch == ch_63 ? 63 : -1
> > > 
> > > #define BASE64_REV_INIT(ch_62, ch_63) { \
> > > 	[ 0 ... '0' - 6 ] = -1, \
> > > 	INIT_62_63('+', ch_62, ch_63), \
> > > 	INIT_62_63(',', ch_62, ch_63), \
> > > 	INIT_62_63('-', ch_62, ch_63), \
> > > 	INIT_62_63('.', ch_62, ch_63), \
> > > 	INIT_62_63('/', ch_62, ch_63), \
> > > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > > 	[ '9' + 1 ... 'A' - 1 ] = -1, \
> > > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > > 	[ 'Z' + 1 ... '_' - 1 ] = -1, \
> > > 	INIT_62_63('_', ch_62, ch_63), \
> > > 	[ '_' + 1 ... 'a' - 1 ] = -1, \
> > > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > 	[ 'z' + 1 ... 255 ] = -1 \
> > > }
> > > 
> > > that only requires that INIT_62_63() be used for all the characters
> > > that are used for 62 and 63 - it can be used for extra ones (eg '.').
> > > If some code wants to use different characters; the -1 need replacing
> > > with INIT_62_63() but nothing else has to be changed.
> > > 
> > > I used '0' - 6 (rather than '+' - 1 - or any other expression for 0x2a)
> > > to (possibly) make the table obviously correct without referring to the
> > > ascii code table.  
> > 
> > Still it's heavily depends on the values of '+,-./_' as an index that
> > makes it not so flexible.
> 
> How about this one?

Better than previous one(s) but quite cryptic to understand. Will need a
comment explaining the logic behind, if we go this way.

> #define INIT_1(v, ch_lo, ch_hi, off, ch_62, ch_63) \
> 	[ v ] = ((v) >= ch_lo && (v) <= ch_hi) ? (v) - ch_lo + off \
> 		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
> #define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
> #define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
> #define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
> #define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
> #define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
> 
> #define BASE64_REV_INIT(ch_62, ch_63) { \
> 	[ 0 ... 0x1f ] = -1, \
> 	INIT_32(0x20, '0', '9', 0, ch_62, ch_63), \
> 	INIT_32(0x40, 'A', 'Z', 10, ch_62, ch_63), \
> 	INIT_32(0x60, 'a', 'z', 26, ch_62, ch_63), \
> 	[ 0x80 ... 0xff ] = -1 }
> 
> which gets the pre-processor to do all the work.
> ch_62 and ch_63 can be any printable characters.
> 
> Note that the #define names are all in a .c file - so don't need any
> kind of namespace protection.

> They can also all be #undef after the initialiser.

Yes, that's too.

> > Moreover this table is basically a dup of the strings in the first array.
> > Which already makes an unnecessary duplication.
> 
> That is what the self tests are for.
> 
> > That's why I prefer to
> > see a script (one source of data) to generate the header or something like
> > this to have the tables and strings robust against typos.
> 
> We have to differ on that one.
> Especially in cases (like this) where generating that data is reasonably trivial.
> 
> > The above is simply an unreadable mess.

-- 
With Best Regards,
Andy Shevchenko



