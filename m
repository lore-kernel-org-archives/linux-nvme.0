Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFD4CCFA03
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pw1mz3Wmkjtz3arI75Z8UisY7e4ejFDGm7ZA+8DIcLQ=; b=fxzp0lSZbJwI76COz4MAGtnQtD
	PWi4EfSICLz9d9bLQsCK/Jrcti0ZqFlB8qA+mtPrVhjpU1AIlP647r6VFNwtUDQKJHJj1wzJGuoWU
	nW4Nw3qkytDs6LXgFf0Dl/6ov/wzzHK91OTVyIYtBF9rQnqofTdyTU2/TDoJw7V7wf1cCJdoQAZcz
	NCX7CHuJ3UhL/FocUp7YAxzeyhfOfOmrXRoNRAv27FodO07ViWCa1n678LGfx16OWcN8LIenHAsP5
	MqVJPdYlXrcd0IXLVWh4qtJr5+0g7FR4pQRgmFM/f0R+V1Ugpu31fWyygW7RnWFgDkXPzGCp5eDlA
	Ob7gKHlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0Es-0000000AXiG-3a4j;
	Mon, 03 Nov 2025 19:29:14 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0Eq-0000000AXhq-3D8p
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 19:29:14 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-47109187c32so24850625e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Nov 2025 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198151; x=1762802951; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw1mz3Wmkjtz3arI75Z8UisY7e4ejFDGm7ZA+8DIcLQ=;
        b=M2lR5YORI+0La15SIcbkLlVXNxnXQQgQU5Vk9B0/YvlJBlXzTZh3dHN5UmdQyX3iff
         u6nFUcNqA1aFisNfwkhkuWPS49Ajh5kLT9HGc0XmPf4UucJHHuzskeGH/I//iUFkF5r2
         aVNn6oVaVczd+ACoe3jsrjNk4bTLCWUds4RUy6n2c+/wTWkrJI1RwlDsm8W0UGrI+e9C
         Lv4VkoMEiVYLTIQlh61Xk3KZn4U31aM0V8Oydv4ZFTrXL5LHdJbFhohpf1KggK67dqG0
         xalYgtA97WY+hQRo/MIy0ZW1UUkT2vagafE7PARgfiuHNYvI/fCm/w+3qpW5dF8Ip7G4
         6fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198151; x=1762802951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw1mz3Wmkjtz3arI75Z8UisY7e4ejFDGm7ZA+8DIcLQ=;
        b=fxCzbq3/uqcs9DMp6Epwt5jcOM0OdR/zzcs6v2Xk8A1EluargAJX/Jvisc4SiJkFHR
         nbWMqQy8zR0yl928xekztlVIYfXsbdXuQZ+fE5t0OxsWhu+GtF7Lnb+7AnC0arHYXjvU
         IFBk6oPmK7pJ/fzSu3zUr9+CaiNKn8KzNQWjPd9BpmInkNGoynucNgDq7bquBOcW8gL5
         69WOMTleut5DbcMhgNa2QteqvZ4OumeIf8NPvbhfN23m4GucfvbsUiG8e8ObokWVYJOA
         zcZ2KS0lVHXS134+fY3EOFCiPg/YqXUpTAy0RazN0CQBZw92kR+fwu4klVgDG/1Q10yo
         0SPw==
X-Forwarded-Encrypted: i=1; AJvYcCUrpO0ybJi222f+axIraNhzLjKUuoEKiktvKy3sVslWcuVmGtYCJcl59jqJLS+DEKBEPbo9oXsqvt7v@lists.infradead.org
X-Gm-Message-State: AOJu0YyU5MWB/6rBYlP9ADAn4E3mya2m1bgFzZHM5Z7oeQmYkD8fP4/7
	rhxhCCLAlG1OddrhA6BH5dR2AYvptW9K9KYBv9dUb86X5/TNjns0PR6C
X-Gm-Gg: ASbGncv6WSUYtB4jvVdSw2e6MhvesmvlQCWZhzo7+3NhSnegZtYLF7T6NbR1pKkHWh7
	Wh7Osj7EL2fhKSYIc23NagOu34zulTNi70tnTSaAmqP3brmvekyoH7OT+JtkFxgHE4yIq4rm6/m
	n+GjhpSaiomLZD2m+T6wbCNbrJkP7AAXDIZjmFbvYPMV4Xl+z6xGk+Jerj6mk3IdXywPSiTSwK2
	ajOQQF+17t8msu8Xx+2OCtGiw65kt7NWk5HtZ6UhIW+UJ9V0DaHptBEnjfHV99aI6RLnfEBOYFl
	3BMBLM6OSMErnAgVUhioa68gs7Doa9UF200vK4WoyBxzpcVrEpoiNV/nBa4FcrPjk4uedEU3hli
	X+kJ52mYoIwDPKMzqdBcOHH4NWRorAMC5WVxczhy+nLl1tlECabTng7aDgyGYSb7ToQmhS40RtQ
	0Yxm59jiOotuDqGRD+AjNuYa+z/LS6bsHv7Asfc7nu7gARIg3nWKC3
X-Google-Smtp-Source: AGHT+IEIOBDfz+HBIHDphP6uzoI17aYjvF3ZSriDyVBLsupCrmaZDmFmWse/BayuXmJV7U9EbfA7ug==
X-Received: by 2002:a05:6000:2411:b0:427:928:789e with SMTP id ffacd0b85a97d-429bd6d583dmr12073376f8f.61.1762198150371;
        Mon, 03 Nov 2025 11:29:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4af7c7sm175165915e9.7.2025.11.03.11.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:29:10 -0800 (PST)
Date: Mon, 3 Nov 2025 19:29:08 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251103192908.1d716a7b@pumpkin>
In-Reply-To: <aQjxjlJvLnx_zRx8@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251103132213.5feb4586@pumpkin>
	<aQi_JHjSi46uUcjB@smile.fi.intel.com>
	<aQjxjlJvLnx_zRx8@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_112912_855297_1937B90D 
X-CRM114-Status: GOOD (  48.40  )
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

On Mon, 3 Nov 2025 20:16:46 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Nov 03, 2025 at 04:41:41PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 03, 2025 at 01:22:13PM +0000, David Laight wrote:  
> > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:  
> > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:  
> > > > > On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:    
> > > > > > On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:  
> 
> ...
> 
> > > > > > Looks like wonderful work, thanks.  And it's good to gain a selftest
> > > > > > for this code.
> > > > > >     
> > > > > > > This improves throughput by ~43-52x.    
> > > > > > 
> > > > > > Well that isn't a thing we see every day.    
> > > > > 
> > > > > I agree with the judgement, the problem is that this broke drastically a build:
> > > > > 
> > > > > lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
> > > > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
> > > > >    26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
> > > > >       |                  ^
> > > > > lib/base64.c:35:17: note: previous initialization is here
> > > > >    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
> > > > >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
> > > > >    25 |         [0 ... 255] = -1, \
> > > > >       |                       ^~
> > > > > ...
> > > > > fatal error: too many errors emitted, stopping now [-ferror-limit=]
> > > > > 20 errors generated.
> > > > >     
> > > > Since I didn't notice this build failure, I guess this happens during a
> > > > W=1 build? Sorry for that. Maybe I should add W=1 compilation testing
> > > > to my checklist before sending patches in the future. I also got an
> > > > email from the kernel test robot with a duplicate initialization
> > > > warning from the sparse tool [1], pointing to the same code.
> > > > 
> > > > This implementation was based on David's previous suggestion [2] to
> > > > first default all entries to -1 and then set the values for the 64
> > > > character entries. This was to avoid expanding the large 256 * 3 table
> > > > and improve code readability.
> > > > 
> > > > Since I believe many people test and care about W=1 builds,  
> > > 
> > > Last time I tried a W=1 build it failed horribly because of 'type-limits'.
> > > The kernel does that all the time - usually for its own error tests inside
> > > #define and inline functions.
> > > Certainly some of the changes I've seen to stop W=1 warnings are really
> > > a bad idea - but that is a bit of a digression.
> > > 
> > > Warnings can be temporarily disabled using #pragma.
> > > That might be the best thing to do here with this over-zealous warning.
> > > 
> > > This compiles on gcc and clang (even though the warnings have different names):
> > > #pragma GCC diagnostic push
> > > #pragma GCC diagnostic ignored "-Woverride-init"
> > > int x[16] = { [0 ... 15] = -1, [5] = 5};
> > > #pragma GCC diagnostic pop
> > >   
> > > > I think we need to find another way to avoid this warning?
> > > > Perhaps we could consider what you suggested:
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
> > > I just checked, neither gcc nor clang allow empty ranges (eg [ 6 ... 5 ] = -1).
> > > Which means the coder has to know which characters are adjacent as well
> > > as getting the order right.
> > > Basically avoiding the warning sucks.
> > >   
> > > > Or should we just expand the 256 * 3 table as it was before?  
> > > 
> > > That has much the same issue - IIRC it relies on three big sequential lists.
> > > 
> > > The #pragma may be best - but doesn't solve sparse (unless it processes
> > > them as well).  
> > 
> > Pragma will be hated.

They have been used in a few other places.
and to disable more 'useful' warnings.

> > I believe there is a better way to do what you want. Let me cook a PoC.  
> 
> I tried locally several approaches and the best I can come up with is the pre-generated
> (via Python script) pieces of C code that we can copy'n'paste instead of that shortened
> form. So basically having a full 256 tables in the code is my suggestion to fix the build
> issue. Alternatively we can generate that at run-time (on the first run) in
> the similar way how prime_numbers.c does. The downside of such an approach is loosing
> the const specifier, which I consider kinda important.
> 
> Btw, in the future here might be also the side-channel attack concerns appear, which would
> require to reconsider the whole algo to get it constant-time execution.

The array lookup version is 'reasonably' time constant.
One option is to offset all the array entries by 1 and subtract 1 after reading the entry.
That means that the 'error' characters have zero in the array (not -1).
At least the compiler won't error that!
The extra 'subtract 1' is probably just measurable.

But I'd consider raising a bug on gcc :-)
One of the uses of ranged designated initialisers for arrays is to change the
default value - as been done here.
It shouldn't cause a warning.

	David

> 
> > > > [1]: https://lore.kernel.org/oe-kbuild-all/202511021343.107utehN-lkp@intel.com/
> > > > [2]: https://lore.kernel.org/lkml/20250928195736.71bec9ae@pumpkin/  
> 


