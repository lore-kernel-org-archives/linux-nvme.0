Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C20CCFA05
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6oU/T5nNyfq8t3z/6aX8Pq77WNXNGQPZda7D2dIXoYg=; b=rqhtZhgMYeYNwt+PYq3PtGb3Wb
	v3KwQ5eYKJvG/sA4H9gxpmNMbI7sEBxI6hdn52XLrU66qbSdRIRBB5DRShPfTmiEp2Dv+JhIXIK/T
	WwS4EIMG9aS6C0LbCGLQu517wL8lB/spFMo3NemOcAf91GxmnEsEauw22WlxZbVNraD6KMYKKTH2n
	P913GpZ86Te/LDBt+bfAr9Lk39MuaVEh7E6ZyNHeamRbGLuMYrnJSnO/wF0nwx/G6Zsua991WF7Q/
	X2Miy49wV9nF1NeQvL45xrWDW2EQ4kmLu+bMM3LpnXk2FWv6f7B8HknmGPn7rJ/oMW7PsixtuBfBy
	IfDviElw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuVq-00000009t70-21au;
	Mon, 03 Nov 2025 13:22:22 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuVn-00000009t6e-10tE
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:22:20 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4711b95226dso56307305e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Nov 2025 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762176137; x=1762780937; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oU/T5nNyfq8t3z/6aX8Pq77WNXNGQPZda7D2dIXoYg=;
        b=AlicK6kbmPg8ZBVCJSjhqgBE6DjmDd5x7OvxKoL6izeImlqwTtcg2UbAAzMwm9BHUE
         iUZaUcogMJo0Iul4BQxUwoVhXL+3L89pVSSZsQ6JfCrlmUS7YfNHx1T/2FqJ4keLnmms
         5fwUnxx0WwhFAK7aZMRX1FEhzjblI6+VVbtUzZJ7PNPI5c3/7KvVo3Qq4ymzeK/Uu0Zi
         qEsTPhzDymLDk7dlt84V783aO159gyoTTfHGyU8hpOpo4O901XqqLPbdQC1tr5gjpAFl
         enGpzQMdFEpGUBW5ZC99nOKLfjUZwawlO4lOXO4gaHnHyPtq04wLkLtP1TNWXAjUV6Jy
         5qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176137; x=1762780937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oU/T5nNyfq8t3z/6aX8Pq77WNXNGQPZda7D2dIXoYg=;
        b=lPxuqMXOlAklGzlvKwQLrGOkjw9QwJ0PFDGL01yNAb56FXvb/SpcPVsO1VHUh2rORT
         O6CGkr7Q+YArbmOQsN6KScwqlL/H+01mkm9XekjMF2qEYkMr5FPwoFCO6w0hmU8odxsH
         6Wi1uFqfBRfyV670XyNfF56SpBf+t3c47JLFJaryoYpSw27hJqKyOHoPuC1tYrbAeA06
         coAE1UW+n5q6VmhZYelreYcRZ3vKrz4CZ+uBpHfzQuo6FlGfLwllA58pA6qa7AW6Kt6+
         JuFd+7mIPIL22F9zPk2m5xon7FxZ/ThRyV8d3wy4WANkG+oloEb8W89VUP52NCxqpbbJ
         NyAA==
X-Forwarded-Encrypted: i=1; AJvYcCXSgotHXLwRytQdjDI30vcAP+PvJJKUW3QNUbXs7OrgvzGWCAARHn4dWVogI8PDZqdwZLavd3lVspRd@lists.infradead.org
X-Gm-Message-State: AOJu0YyIXExic79KzVNVmK5gYlT+ovv/Z9EFEdIauESjgyBSopWMQIMf
	OF6WbR6PGoiIPd6i9iU480fqdh8Auctj24mrJp1MittVhjXmMp+r6YIP
X-Gm-Gg: ASbGnctg1i+Zgzit+Ew7tl3BEl4AF5G37+QGJMcYpOOkQ5bUhyVX5NwYwCq1j3hBjHY
	yIfZr/WgxuypRfnO/4JwEWHyFE2xDM5YMowOR+656719LDbP3GO3O4KizEMogBN2IKh6nImPCAa
	ELKpp9OvhB4YMlWBqWDRLKlLRUBmR4nsMHOaK5dwghZldw+fQr9TvqFOaspkD2imhgVj9+6+f5t
	WHF2Yo/aILEKSQVWnPqgpE1Y1cLHFctfgy1zz6z295Bggu8b5oZ1TF3fOB8v/9ZpOSeklf/6Xob
	lRRRKpH1yhve1Hjy3IVQbZyGGgCD5IqC2PmbBCNfOoButrtiOmgA0huDZW78SX1dpiVCku5zAbA
	njJVtbhNIV4V2PzUdyA6WFrGnEqeAyvICwrWJWkrWXPGfSJkyY0l9SRjMUr1tagv13tstGGViod
	u5G+JyU43TVQxraems2yewu5ASWgfnz3YAudoFgqPr9A7bQtA0G4uP
X-Google-Smtp-Source: AGHT+IGmfb0M4Cm7RDj+H+Xzo+z1lsCQ6IyOZoyheCRQy3wOXge1WeLvunZiTMuWXTbYqWvedDGTjw==
X-Received: by 2002:a05:600c:530e:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-47751697433mr13329465e9.30.1762176136522;
        Mon, 03 Nov 2025 05:22:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110e77esm20067573f8f.10.2025.11.03.05.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:22:15 -0800 (PST)
Date: Mon, 3 Nov 2025 13:22:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251103132213.5feb4586@pumpkin>
In-Reply-To: <aQiM7OWWM0dXTT0J@google.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_052219_329002_268EA1F0 
X-CRM114-Status: GOOD (  39.80  )
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

On Mon, 3 Nov 2025 19:07:24 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> +Cc David
> 
> Hi Guan-Chun,
> 
> If we need to respin this series, please Cc David when sending the next
> version.
> 
> On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:
> > On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:  
> > > On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > >   
> > > > This series introduces a generic Base64 encoder/decoder to the kernel
> > > > library, eliminating duplicated implementations and delivering significant
> > > > performance improvements.
> > > > 
> > > > The Base64 API has been extended to support multiple variants (Standard,
> > > > URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
> > > > a variant parameter and an option to control padding. As part of this
> > > > series, users are migrated to the new interface while preserving their
> > > > specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
> > > > and NVMe is updated to BASE64_STD.
> > > > 
> > > > On the encoder side, the implementation processes input in 3-byte blocks,
> > > > mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
> > > > streaming and reduces loop overhead, achieving about a 2.7x speedup compared
> > > > to previous implementations.
> > > > 
> > > > On the decoder side, replace strchr() lookups with per-variant reverse tables
> > > > and process input in 4-character groups. Each group is mapped to numeric values
> > > > and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
> > > > rejecting invalid '=' usage and enforcing tail rules.  
> > > 
> > > Looks like wonderful work, thanks.  And it's good to gain a selftest
> > > for this code.
> > >   
> > > > This improves throughput by ~43-52x.  
> > > 
> > > Well that isn't a thing we see every day.  
> > 
> > I agree with the judgement, the problem is that this broke drastically a build:
> > 
> > lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
> >    26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> >       |                  ^
> > lib/base64.c:35:17: note: previous initialization is here
> >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
> >    25 |         [0 ... 255] = -1, \
> >       |                       ^~
> > ...
> > fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > 20 errors generated.
> >   
> Since I didn't notice this build failure, I guess this happens during a
> W=1 build? Sorry for that. Maybe I should add W=1 compilation testing
> to my checklist before sending patches in the future. I also got an
> email from the kernel test robot with a duplicate initialization
> warning from the sparse tool [1], pointing to the same code.
> 
> This implementation was based on David's previous suggestion [2] to
> first default all entries to -1 and then set the values for the 64
> character entries. This was to avoid expanding the large 256 * 3 table
> and improve code readability.
> 
> Hi David,
> 
> Since I believe many people test and care about W=1 builds,

Last time I tried a W=1 build it failed horribly because of 'type-limits'.
The kernel does that all the time - usually for its own error tests inside
#define and inline functions.
Certainly some of the changes I've seen to stop W=1 warnings are really
a bad idea - but that is a bit of a digression.

Warnings can be temporarily disabled using #pragma.
That might be the best thing to do here with this over-zealous warning.

This compiles on gcc and clang (even though the warnings have different names):
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Woverride-init"
int x[16] = { [0 ... 15] = -1, [5] = 5};
#pragma GCC diagnostic pop

> I think we need to find another way to avoid this warning?
> Perhaps we could consider what you suggested:
> 
> #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> 	[ 0 ... '+'-1 ] = -1, \
> 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> 	[ '9'+1 ... 'A'-1 ] = -1, \
> 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> 	[ 'Z'+1 ... '_'-1 ] = -1, \
> 	[ '_' ] = val_under, \
> 	[ '_'+1 ... 'a'-1 ] = -1, \
> 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> 	[ 'z'+1 ... 255 ] = -1 \
> }

I just checked, neither gcc nor clang allow empty ranges (eg [ 6 ... 5 ] = -1).
Which means the coder has to know which characters are adjacent as well
as getting the order right.
Basically avoiding the warning sucks.

> Or should we just expand the 256 * 3 table as it was before?

That has much the same issue - IIRC it relies on three big sequential lists.

The #pragma may be best - but doesn't solve sparse (unless it processes
them as well).

	David

> 
> [1]: https://lore.kernel.org/oe-kbuild-all/202511021343.107utehN-lkp@intel.com/
> [2]: https://lore.kernel.org/lkml/20250928195736.71bec9ae@pumpkin/
> 
> Regards,
> Kuan-Wei


