Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968ACCCFA05
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 11:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vd+5KBI+DcPHKtaahVWDgGYJD9ObtH7hyDt+uX2+Cpo=; b=u7c0fpLMMII8zJ+m7b6BK2ZCz+
	Wmv3iNleHRlSzlervZZh+PvMPhj5/G80aqSeYzbv2G3euD+8r4gWOuidkOMY+fcPgHJfRWqDhQVDx
	9xoGm4f+pbmRowkFNBWkpuR590YLxN+T9XdvXkgdSp29Pd5DwqOA/zdX+6shCIzgPMgc11gRUgtxl
	RFfFjXg057zBaMTflVJR0+CJmlqUqD3BYmBsUyiWqIC2/g6WgllXoqF0s/iiMsUVuDE1pQpZNQXMa
	5me1zRZqg3qvoGFSOCKzIb7efJRGATaGfkMxJpbj6tICkLiWGGRs5J4MliX4vjDfhIo/RrnLLMo8R
	/s67BlQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsPN-00000009hLn-3aPV;
	Mon, 03 Nov 2025 11:07:33 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFsPL-00000009hLP-1tiv
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 11:07:32 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3401314d845so5621512a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Nov 2025 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762168050; x=1762772850; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vd+5KBI+DcPHKtaahVWDgGYJD9ObtH7hyDt+uX2+Cpo=;
        b=mkIDv/tb3z6axoS8Nx8hNKREMZYp34SEoptZpDoV2GUKC9+XoxFrx/3XsHZpQJ3wxQ
         DCKNuEQ30jpgApXNr0GUGWeUveqoXwA4TD4HUgRCAB48xadTbQnUBgW3eRr4i9VMo0Xs
         jhTDrkITpEn6Il4g3YMwh8CrlhCveg8Qb3ft/JY+5ampvFA+w9xy7YPDMF3Fge9SYqPc
         fjxHeU5eD/Z3/h+Bpyhxsy1ALtSMUBVTlpCZqI4fQjUpsmhzdbb6ifmMK1NmsAOLybYb
         JRMREt4FduVnEnPpXpplfxS8uF4sKcQ3Z+c7fDV3mjIaBy34VvRMkfiJrFhPo2nxSGFt
         mD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168050; x=1762772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd+5KBI+DcPHKtaahVWDgGYJD9ObtH7hyDt+uX2+Cpo=;
        b=vD2dbSutZKWSdV7+UGnWzbK/nEsCQLu5nhv2hiqW73zfkPcQrLjT1DREO8+B8xwTDE
         AsUzGIJNl8V0Jkb/wfh6YNmi+a63G2u/kIJkn09hj/JkpHfyvCSWC6U2NBNL6F/FOc+5
         rDfsoEN4Pa30NJD5jVy1xQ2C9iqNTa8gX+8KoyBq9MnfepRg6acPs0QZ/4SizPmDud5C
         r2Sr0FmpP66Hgu7jLmO6ntlsn8KVtiPHBAziTK1B5JfDSZ9XnjfDhbYG8dcupf9PqOyd
         Q/iYvJyD/cE68CmQlaZI105ZuEJZH05jg/dufFkOp7XmZKfGS99nUMCjSMZ4tQApt4k/
         oMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUKTdIr4fVIgdVD9NGKvgcIsjtJlhCJ4FRwtoP2GO6jjoCncgBXYsAig3p2QGjdT2GIGnnVNt6NIaJj@lists.infradead.org
X-Gm-Message-State: AOJu0YzZ4gK5LJHepNe3uGm3MWtM8I1eUFePXbqfGyvFdrvdSbwSK7vw
	VPltQkDYDIMSLcw966Q3G/JNl/pTDXi/xAojqmJGtCX79eN1QZq/66hK
X-Gm-Gg: ASbGncvOFHavX4IXO/XrXDorfcnKd0XbzaYmWiyRHyTVDp999WTxMQhBqwDLYMbDEef
	mO9G3KWgpekaqlgde/BQJxgU4onOya00Gj/00mRMTUMRT70WK2RKf3grZlUVUkwgTyPUxCqobMO
	BcFoE/TrPYSjTify26I2fL1lrf52sDRtIFgQPe6KpMrngSdR+b/JguguXhrCqzI0l+O6D6e9hJ1
	Vb47ne/jW6xw9vX8HOOj6DiY1RFGw62PL3CzUCv8gAktu1VDRcWPC/hPuul3irzb7+0ymZaWGAb
	H6X5s77ES//yT/CyE/eJRxaffKv5losyNzlA3GvcMzSdI9yj0VfCnS+8OQ1gIJg9xpK0z69dt2j
	qF5XjMRgwPi1app4IFMkQZ8OwOfpUXflTnehHlS3srzc7rAhHnTvZGTdnChwvAhmLzCjxGRJw/A
	N8bgYvlmyjol0jf6ixwk8oPqJWQ5KLhtugIiH9BrVTb5aglIzpMprI/5x7rKR9+dcrfrk=
X-Google-Smtp-Source: AGHT+IH4+9frysi9DNFV/2/WAly7wk4mYQWIlTpjWZue0G81QDWwZ4rfIb4hTAprNc33o6VQINfi4w==
X-Received: by 2002:a17:90b:314e:b0:340:d511:e15f with SMTP id 98e67ed59e1d1-340d511e56fmr7617741a91.18.1762168050210;
        Mon, 03 Nov 2025 03:07:30 -0800 (PST)
Received: from google.com (114-39-189-33.dynamic-ip.hinet.net. [114.39.189.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf44e233sm10126135a12.34.2025.11.03.03.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:07:29 -0800 (PST)
Date: Mon, 3 Nov 2025 19:07:24 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>, ebiggers@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
	idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, home7438072@gmail.com,
	linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <aQiM7OWWM0dXTT0J@google.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiC4zrtXobieAUm@black.igk.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_030731_500238_8FE8E66F 
X-CRM114-Status: GOOD (  29.76  )
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

+Cc David

Hi Guan-Chun,

If we need to respin this series, please Cc David when sending the next
version.

On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:
> On Fri, Oct 31, 2025 at 09:09:47PM -0700, Andrew Morton wrote:
> > On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > 
> > > This series introduces a generic Base64 encoder/decoder to the kernel
> > > library, eliminating duplicated implementations and delivering significant
> > > performance improvements.
> > > 
> > > The Base64 API has been extended to support multiple variants (Standard,
> > > URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
> > > a variant parameter and an option to control padding. As part of this
> > > series, users are migrated to the new interface while preserving their
> > > specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
> > > and NVMe is updated to BASE64_STD.
> > > 
> > > On the encoder side, the implementation processes input in 3-byte blocks,
> > > mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
> > > streaming and reduces loop overhead, achieving about a 2.7x speedup compared
> > > to previous implementations.
> > > 
> > > On the decoder side, replace strchr() lookups with per-variant reverse tables
> > > and process input in 4-character groups. Each group is mapped to numeric values
> > > and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
> > > rejecting invalid '=' usage and enforcing tail rules.
> > 
> > Looks like wonderful work, thanks.  And it's good to gain a selftest
> > for this code.
> > 
> > > This improves throughput by ~43-52x.
> > 
> > Well that isn't a thing we see every day.
> 
> I agree with the judgement, the problem is that this broke drastically a build:
> 
> lib/base64.c:35:17: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
>    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> lib/base64.c:26:11: note: expanded from macro 'BASE64_REV_INIT'
>    26 |         ['A'] =  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, \
>       |                  ^
> lib/base64.c:35:17: note: previous initialization is here
>    35 |         [BASE64_STD] = BASE64_REV_INIT('+', '/'),
>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> lib/base64.c:25:16: note: expanded from macro 'BASE64_REV_INIT'
>    25 |         [0 ... 255] = -1, \
>       |                       ^~
> ...
> fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 20 errors generated.
> 
Since I didn't notice this build failure, I guess this happens during a
W=1 build? Sorry for that. Maybe I should add W=1 compilation testing
to my checklist before sending patches in the future. I also got an
email from the kernel test robot with a duplicate initialization
warning from the sparse tool [1], pointing to the same code.

This implementation was based on David's previous suggestion [2] to
first default all entries to -1 and then set the values for the 64
character entries. This was to avoid expanding the large 256 * 3 table
and improve code readability.

Hi David,

Since I believe many people test and care about W=1 builds, I think we
need to find another way to avoid this warning? Perhaps we could
consider what you suggested:

#define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
	[ 0 ... '+'-1 ] = -1, \
	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
	[ '9'+1 ... 'A'-1 ] = -1, \
	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
	[ 'Z'+1 ... '_'-1 ] = -1, \
	[ '_' ] = val_under, \
	[ '_'+1 ... 'a'-1 ] = -1, \
	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
	[ 'z'+1 ... 255 ] = -1 \
}

Or should we just expand the 256 * 3 table as it was before?

[1]: https://lore.kernel.org/oe-kbuild-all/202511021343.107utehN-lkp@intel.com/
[2]: https://lore.kernel.org/lkml/20250928195736.71bec9ae@pumpkin/

Regards,
Kuan-Wei

