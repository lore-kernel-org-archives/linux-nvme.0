Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E29CCFA13
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Nov 2025 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJmBqFwSZPTgeDdxxWga7QZHqD9dNuDtkCKsKlOxCRA=; b=ohbq+3g7CHZ3pZD2oIXqn2Z/kj
	5zgz/tO/+h6oaEwZF4dvMH2KeiKy1HmS9/h0vJFMCJ/Ms6qFeYaQJkGOSKOr60sYLtBUXQ+W4vZtH
	5BssoUkMyhVJkH/j811FANxSHT0fWEBIYtXHxDsLM/XEEwcdj8TJAlrhIGdH/M3uqk73fEdrEtIex
	kfhHHpPhGmweQwTKhKyM8wqXTBOgMakDn/IJYu793Jy+Sbi9jiUATaCojYpcc9BrNae6sPrh9kbRx
	zK8yabtLRWyANAmvdsiZKTrhKlQxewOfnrteARjjHfWI4x38nq6yosyeRCdsolnvbFzgAe1Pdjdjq
	F+RGNI/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI4ef-000000040FV-3vg0;
	Sun, 09 Nov 2025 12:36:25 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vI4ec-000000040Ex-17xX
	for linux-nvme@lists.infradead.org;
	Sun, 09 Nov 2025 12:36:24 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-34372216275so1020049a91.2
        for <linux-nvme@lists.infradead.org>; Sun, 09 Nov 2025 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1762691780; x=1763296580; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KJmBqFwSZPTgeDdxxWga7QZHqD9dNuDtkCKsKlOxCRA=;
        b=D93Hyk14nncJp1ROK94MZPEpbtLz4ogfi6rysUkeNGjRvE8YXnFuyVZknVSUK0Ak5o
         nQ7itttNs5zbEpneC9ZyjXqwNwNb1rjHkPkuFkTrnl8S4gc3RzHPXo9CV3Sx9NUJ3xlu
         sq5z74v9sEfKJq5aehOnYP0m35Cy0tI4Rag5YMdrj1Or1WjlW91sBPJfYDQrRaCFqc7H
         rFM/Bz1nHihNmQ9tA1hG5D2qP8XFDu2eUUjFf0lzNdNvatuJ9diqZehIzgpHoNHFjUS1
         5Wj2Apd0MfvVGGwCyJu3cw4GKceaWzImIJWOS/BhvCLGO6cFjVEjQUYj9I1aNf5wQBm2
         Jx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691780; x=1763296580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJmBqFwSZPTgeDdxxWga7QZHqD9dNuDtkCKsKlOxCRA=;
        b=jCH+5pcyBPfTqQ6r52W4Wq69CXu1vJjpT5895uOs0XZ7j54iLWJHEIxgFOT9WLwdaa
         rA/7nA3zYdqrUf5uNbdJQi+SJ41lH7Wz7lwBtCLk0ybIMnURJPk71TZA7YGJUlDdHaBV
         AL2luQ1G7gvmlRtn+U/GipgkXgVJ+98HJsLm3N2NA9itFY6eaFzXqMk2LoYKPR2RkIcl
         zTTzZRuLUsHyhuFb/2WlbTRTwEMHIHQh5si4NvBiG/KAnAqSoZsU8aVRPf4JyhO2dPlh
         xbYkSBhLys4rLLaS/FK2g8RbWdzJn33qdbCoCLMZ+Rb5RaSs9ZkD+psS58/F4hYigrVH
         WH9g==
X-Forwarded-Encrypted: i=1; AJvYcCUAVNv9n2AH3Vr5xfmBqeuoRD/Ht4KbbqQVdDAofI7KqPRe0r9UauHybcv+LISSHWwWisugG183HmbS@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+QcUWxkMWT3RI+Pl1yQ+AE9xcEFnJe5sNAh78gRggtWmJ0V/Y
	l8clGpTNJ/ln2bgILxpjzogNhbznlmb3n9dlimL/MBQohJPgC0MiBXRI5CtmrsOVIOE=
X-Gm-Gg: ASbGnctufHZjnI833qnY32RwW7uCRILeTJq7XTL2zbmZXBNHIHE81yb6ghwOI7lIQ7W
	AFsnI53zJK02ENtFehTm+anLnxbfV2vZW5zrPcuxY8ePznrFpK16e3gQyjkZUa8e/Jd2ZZiwfCs
	Z2KP3F/Hd7ss1BgwlG5ryGYDqEC3ieBMTTiqSDzbjy8crto74ej7eMA1dHDHTtMiNnI38uf13bm
	6RP27oyEesUMyrLoJONp8zqS1QyYvWHngb7EdWcEa4P4V6TpUFLrRmHQSDIpHDwveuVt3rcDAhF
	nuvdyAoci2fEIVT3AxkY8bUOAfSjFCDuQotUI5ww86wwgAPeokLA0ZCAquIeXs2pbx6N3GaeOyz
	scm3HzPuHgt/hcsBlp3rcW/JvUo2bLo+Rn4BsDJqluxlt3KhC9+1TAnhqhqSysaDl9/xSzyE5ao
	K2ExV3tfUJ6IRT4wqOjlbmwWfa8e/7WKM=
X-Google-Smtp-Source: AGHT+IFJcX4kraEUbC8VOW05T7p2FeSFYukhwLNqfkAsi9st8xXB4csrxqTW846Kb3/6J4WQhJ7aog==
X-Received: by 2002:a17:90a:da8b:b0:33b:dec9:d9aa with SMTP id 98e67ed59e1d1-3436cbb171cmr5487179a91.25.1762691779910;
        Sun, 09 Nov 2025 04:36:19 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:519d:1960:dc93:9d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm7781832a91.13.2025.11.09.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:36:18 -0800 (PST)
Date: Sun, 9 Nov 2025 20:36:12 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, ebiggers@kernel.org,
	tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
	idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, home7438072@gmail.com,
	linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <aRCKvJnJxmaDYKvI@wu-Pro-E500-G6-WS720T>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
 <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
 <aQiC4zrtXobieAUm@black.igk.intel.com>
 <aQiM7OWWM0dXTT0J@google.com>
 <20251104090326.2040fa75@pumpkin>
 <aQnMCVYFNpdsd-mm@smile.fi.intel.com>
 <20251105094827.10e67b2d@pumpkin>
 <aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
 <20251105143820.11558ca8@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105143820.11558ca8@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251109_043622_573444_EA721DC8 
X-CRM114-Status: GOOD (  34.58  )
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

On Wed, Nov 05, 2025 at 02:38:20PM +0000, David Laight wrote:
> On Wed, 5 Nov 2025 16:13:45 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Wed, Nov 05, 2025 at 09:48:27AM +0000, David Laight wrote:
> > > On Tue, 4 Nov 2025 11:48:57 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:  
> > > > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:    
> > > > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:    
> > 
> ...
> > > How about this one?  
> > 
> > Better than previous one(s) but quite cryptic to understand. Will need a
> > comment explaining the logic behind, if we go this way.
> 
> My first version (of this version) had all three character ranges in the define:
> so:
> #define INIT_1(v, ch_62, ch_63) \
> 	[ v ] = (v) >= '0' && (v) <= '9' ? (v) - '0' \
> 		: (v) >= 'A' && (v) <= 'Z' ? (v) - 'A' + 10 \
> 		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 36 \
> 		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
> Perhaps less cryptic - even if the .i line will be rather longer.
> It could be replicated for all 256 bytes, but I think the range
> initialisers are reasonable for the non-printable ranges.
> 
> I did wonder if the encode and decode lookup tables count be interleaved
> and both initialisers generated from the same #define.
> But I can't think of a way of generating 'x' and "X" from a #define parameter.
> (I don't think "X"[0] is constant enough...)
> 
> 	David
>

Thanks for your reply!
We’ll adopt the approach you suggested in the next version.

Best regards,
Guan-Chun

> > 
> > > #define INIT_1(v, ch_lo, ch_hi, off, ch_62, ch_63) \
> > > 	[ v ] = ((v) >= ch_lo && (v) <= ch_hi) ? (v) - ch_lo + off \
> > > 		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
> > > #define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
> > > #define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
> > > #define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
> > > #define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
> > > #define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
> > > 
> > > #define BASE64_REV_INIT(ch_62, ch_63) { \
> > > 	[ 0 ... 0x1f ] = -1, \
> > > 	INIT_32(0x20, '0', '9', 0, ch_62, ch_63), \
> > > 	INIT_32(0x40, 'A', 'Z', 10, ch_62, ch_63), \
> > > 	INIT_32(0x60, 'a', 'z', 26, ch_62, ch_63), \
> > > 	[ 0x80 ... 0xff ] = -1 }
> > > 
> > > which gets the pre-processor to do all the work.
> > > ch_62 and ch_63 can be any printable characters.
> > > 
> > > Note that the #define names are all in a .c file - so don't need any
> > > kind of namespace protection.  
> > 
> > > They can also all be #undef after the initialiser.  
> > 
> > Yes, that's too.
> > 
> > > > Moreover this table is basically a dup of the strings in the first array.
> > > > Which already makes an unnecessary duplication.  
> > > 
> > > That is what the self tests are for.
> > >   
> > > > That's why I prefer to
> > > > see a script (one source of data) to generate the header or something like
> > > > this to have the tables and strings robust against typos.  
> > > 
> > > We have to differ on that one.
> > > Especially in cases (like this) where generating that data is reasonably trivial.
> > >   
> > > > The above is simply an unreadable mess.  
> > 
> 

