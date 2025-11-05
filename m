Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F1CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 09:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/eC1//SZtzXCJ9VDP38XGpX45I3TMA2WSmv1Cg2gDD4=; b=IgbhxjQp07HgW7XgqpkspzRQ4q
	HQD7oZv+UvIPmFHK6id72XgLoDRdyMvPmo5VHiZs72BDdeWxCWTa6kVP8PHpfQMNf9nZA/Ii3Xi3+
	SSn/Hp9mrDXaKzTH9G0mo6waHjs9ni0MFz7Ma0v7aj5ZmRtSZSuU+IG/HKzKZeeWUWUwE4AbWBoDG
	QaUj749sHrgPqYjHhBE0MDTWnfSrRb69ZjzjqbGYKPNgu5fhUW4yqywtNgYpWs4dg5fZ+ktx7ifsK
	0X+fEegcUx+52dXWcL58hqs5B7neM/XUo4fQjpnO3AE09uonaxhoLMvbMwm/wLxH2pSWhzExDS1Gw
	+cs3r5EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGa85-0000000DQFU-04ss;
	Wed, 05 Nov 2025 09:48:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGa84-0000000DQFL-2PUn
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Nov 2025 09:48:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/eC1//SZtzXCJ9VDP38XGpX45I3TMA2WSmv1Cg2gDD4=; b=kdsoz5lev+M5yFGHJ3b20PcXtN
	CVr2BNPA4g/BMFPaaW8fcbSd+GoeQJH+/soQ0nCIidKUunTzIsWf9yH+f7jj7yrZkUHB43a67c3RJ
	UfJR2OJ/aiZu/4B9EQQaFMmofxAv7qK7EXRV2FwmaSHchSAJev2KEaRnHb1PqDGDWcI0aNBpaYAsD
	k8Y89HHOCIwHfFcfxjdpgHiM0c0zGuAJZcZeaVFkwYw2dISMIT8/8+xaVmud257tq69SFCaetRd7X
	aeHH5d258nfA3S6K7FuF5+dZhmT+JrJ38XtozX2Fgadej3ZBJspRk0cgBfLoUlq3PahgQII5RKT+l
	EcRLdAVg==;
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZGK-00000001mxq-06CP
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 08:53:06 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-429b7ba208eso4042834f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 01:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336111; x=1762940911; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eC1//SZtzXCJ9VDP38XGpX45I3TMA2WSmv1Cg2gDD4=;
        b=JeQTBSxZN0oVfnl8CI5AUwhm480aDP6Vja+HvcISgjTk6ivvl6AuC12N/SsVn+havX
         uqBAknbx4myT1big/yVYu3jXgj5Bsnl67DE7sugc8H8oixsURodNIZToGPQEL4aL0HtI
         B5rgxP+jpb55g5P0SzByAzIuKNokxUcUx5e7V402OxJtnCHB5nf+Ghxe3WKFlph/kjl4
         s/9JtKVxc5H72hD3JwYelB0pmqZ/inbIVg9VHSBjTGc9fy645ns2wJ/Rp/tHYyDuTvzx
         JEdjrXZ997GDOAy4X4vu0C3/NIzCpFrqY3TgkFAUqXPdft+hvoEnx4XV+u88aYUe2ZR5
         Za+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336111; x=1762940911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eC1//SZtzXCJ9VDP38XGpX45I3TMA2WSmv1Cg2gDD4=;
        b=nCUIfNS8KOsR6/nXtwg+VmxKVXUkVpsvJYiBIQL8S9PfTfXQC+UaLxpit7UPKlI5Ll
         vLmJ/H/OEvxFfxTYJSL/jMIvCNpq5U7vCZQsKZ62H/JIkBbqwut3uWb4or+Wuk1GCV2N
         mfbvBbW7RrpV4rNmDBqMJQVnTA63iR48jhcZO1hlPu1vYCfKNRmFZpxUzgoPciDOeNEI
         N6vLdpbGoBVzasqVMXvNVG/5oDN4WyHtjZn+sOilrj4SbpyOOD9nFzLPacU30DjzGjX6
         Xmg8kDE2zw9ntokuJtHRirWtmLII5hYynujUMgDlm4RSI/jQfCd1F98sObxKfLzxo9LK
         VvHg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ47PTSismd53YAIPdCdZaQRMQcywlBeHXrRbVirzaCg6C7+jXi0Uyd/d0ZJNvt9IlvIYHDq1x4GMS@lists.infradead.org
X-Gm-Message-State: AOJu0YzYLWxCtU5UYZs8Hr7khqYUDpUKQf2QuP3bSACV/AcZdX1KGYkJ
	tlPQkQrWnjzt/lSaiEewvpwSJCf3SWgZLiDMrZl4lJwY00CqrDUEY75M
X-Gm-Gg: ASbGnctWcDZvOf8OTZ+yHjVLqcrn5ur3PfMoOC08lEsHQlWh3w3IigPNQ4L6s/NpDlH
	Ojhx9eFUmZkqlUrSI8HEWcaq5JDu4PwRy3JSK4K1YpnQH8XG68+NBNpJAcC8ZTUSoil7uhOoiTR
	jXxLnHOjaCYqj0LPhUGgqHx5DcYZDSdeefeQ5yw8Q/8CkGJDo+A7bu1pzbkakfkPl1LiIdH+Ynp
	b7z0aJe8t6rpMn0UveSekNeESvodIMNO7qoWdTW75wuV8aOtR+8Y8gTfN79sZwqXvq12DyYZVEJ
	Eii1e1mOeLsYwzjrfOOYoEpXvFnZn5xM2I28O6ujC5Vppakwf37BjPdUjlyt9ldz4Ou4iMbISQE
	Mx5aRKXKeHhoTgVurFiGlzOzLHYtHjk8NdijdhqkG7/3jx9PruhYb04y0ww6NeRpmhilU9ONR9d
	3oCImBcoPO5LdBFQxVfLIl4E717SdYktlxTGzi5EoIbQ==
X-Google-Smtp-Source: AGHT+IEkpFxLVpMLxH+nTe91ZvHCIlFgTDwSuHknsPOjs1KqbNBabtxkQXZcHtDrGMnxK6gDuS+BvQ==
X-Received: by 2002:a05:600c:34d0:b0:471:6f4:601f with SMTP id 5b1f17b1804b1-4775cdf54aemr21466965e9.19.1762336110467;
        Wed, 05 Nov 2025 01:48:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdee965sm38069125e9.17.2025.11.05.01.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:48:29 -0800 (PST)
Date: Wed, 5 Nov 2025 09:48:27 +0000
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
Message-ID: <20251105094827.10e67b2d@pumpkin>
In-Reply-To: <aQnMCVYFNpdsd-mm@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251104090326.2040fa75@pumpkin>
	<aQnMCVYFNpdsd-mm@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_085304_336495_ECA59AC0 
X-CRM114-Status: GOOD (  29.20  )
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

On Tue, 4 Nov 2025 11:48:57 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:
> > On Mon, 3 Nov 2025 19:07:24 +0800
> > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:  
> > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:  
> 
> ...
> 
> > > Since I believe many people test and care about W=1 builds, I think we
> > > need to find another way to avoid this warning? Perhaps we could
> > > consider what you suggested:
> > > 
> > > #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> > > 	[ 0 ... '+'-1 ] = -1, \
> > > 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> > > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > > 	[ '9'+1 ... 'A'-1 ] = -1, \
> > > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > > 	[ 'Z'+1 ... '_'-1 ] = -1, \
> > > 	[ '_' ] = val_under, \
> > > 	[ '_'+1 ... 'a'-1 ] = -1, \
> > > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > > 	[ 'z'+1 ... 255 ] = -1 \
> > > }  
> > 
> > I've a slightly better version:
> > 
> > #define INIT_62_63(ch, ch_62, ch_63) \
> > 	[ ch ] = ch == ch_62 ? 62 : ch == ch_63 ? 63 : -1
> > 
> > #define BASE64_REV_INIT(ch_62, ch_63) { \
> > 	[ 0 ... '0' - 6 ] = -1, \
> > 	INIT_62_63('+', ch_62, ch_63), \
> > 	INIT_62_63(',', ch_62, ch_63), \
> > 	INIT_62_63('-', ch_62, ch_63), \
> > 	INIT_62_63('.', ch_62, ch_63), \
> > 	INIT_62_63('/', ch_62, ch_63), \
> > 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> > 	[ '9' + 1 ... 'A' - 1 ] = -1, \
> > 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> > 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> > 	[ 'Z' + 1 ... '_' - 1 ] = -1, \
> > 	INIT_62_63('_', ch_62, ch_63), \
> > 	[ '_' + 1 ... 'a' - 1 ] = -1, \
> > 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> > 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> > 	[ 'z' + 1 ... 255 ] = -1 \
> > }
> > 
> > that only requires that INIT_62_63() be used for all the characters
> > that are used for 62 and 63 - it can be used for extra ones (eg '.').
> > If some code wants to use different characters; the -1 need replacing
> > with INIT_62_63() but nothing else has to be changed.
> > 
> > I used '0' - 6 (rather than '+' - 1 - or any other expression for 0x2a)
> > to (possibly) make the table obviously correct without referring to the
> > ascii code table.  
> 
> Still it's heavily depends on the values of '+,-./_' as an index that
> makes it not so flexible.

How about this one?
#define INIT_1(v, ch_lo, ch_hi, off, ch_62, ch_63) \
	[ v ] = ((v) >= ch_lo && (v) <= ch_hi) ? (v) - ch_lo + off \
		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
#define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
#define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
#define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
#define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
#define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)

#define BASE64_REV_INIT(ch_62, ch_63) { \
	[ 0 ... 0x1f ] = -1, \
	INIT_32(0x20, '0', '9', 0, ch_62, ch_63), \
	INIT_32(0x40, 'A', 'Z', 10, ch_62, ch_63), \
	INIT_32(0x60, 'a', 'z', 26, ch_62, ch_63), \
	[ 0x80 ... 0xff ] = -1 }

which gets the pre-processor to do all the work.
ch_62 and ch_63 can be any printable characters.

Note that the #define names are all in a .c file - so don't need any
kind of namespace protection.
They can also all be #undef after the initialiser.

> Moreover this table is basically a dup of the strings in the first array.
> Which already makes an unnecessary duplication.

That is what the self tests are for.

> That's why I prefer to
> see a script (one source of data) to generate the header or something like
> this to have the tables and strings robust against typos.

We have to differ on that one.
Especially in cases (like this) where generating that data is reasonably trivial.

	David

> 
> The above is simply an unreadable mess.
> 


