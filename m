Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F52ECCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LkaRIn/NSiNJWnW7QBCmH2dkiWqmxXew9zG5Ks3bGA=; b=SWZCZXxj/6b+0o1ProdTMP1+9Y
	sUb00utfgLe9IWc7US9BKlcMjHVzg82OiAyhMdJ9ZOqU/83gwv6pLHmugO3fBNGy/JaGKY0Zkstfs
	PHrVkD6K0No1TU4Sx2G+Kj58rbGVNJHz/VF2evs0ILrzcFjlgku0j8sObGNe+v4BcTKS25neaCmFI
	nSWDcZ4AsTJEIz4vPMCK++NuPuamomqo7Fmj53Ia6rKmour5dgd7KiRQqG9qUX5RFDn0DxigUNP9h
	+v8l7aLRqgauLxEJuvPsWtO7Eigp2WHj3q8PtDJ2WfMsXv+BdJD+FlzhxVP3avPLpuR+p5+rrCZMC
	7rFkltbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGeea-0000000DrS5-01Hp;
	Wed, 05 Nov 2025 14:38:28 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGeeX-0000000DrRR-0z47
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 14:38:26 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-47756a07b34so9607405e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353503; x=1762958303; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LkaRIn/NSiNJWnW7QBCmH2dkiWqmxXew9zG5Ks3bGA=;
        b=DlTBsWiSFdKNb4Jo+BBSaqQkCP0MiRLRaEp/mMrZQHmQGYjeV+9OUkEw0MzPR72VaS
         NyNCoFFHSaqUhthfSBAgaTTbnHzHhYxPdnYci4eSEoZ42ZXpqTnUPScbcDyT+PndM4F5
         x1+Hk7u9Fl0bShs7amWBMvFQ2dSZtcwtMTewyk41v7HW+aoybKVgTwfZquOujVPDyRlH
         3lSjminpbhcjrkGfF7cg2FKov4/5TM++3V0UbLHh10HFCGBF1zMDey4/nP5NPtrzzHKO
         VBZGr9+isqYok/rcZkqfCQps9+YK7CLD1CnuNfYLeowdSl/l1ICVn1eP5udK/es9/NT2
         dRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353503; x=1762958303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LkaRIn/NSiNJWnW7QBCmH2dkiWqmxXew9zG5Ks3bGA=;
        b=iveDJTfDeNKs/vpmWAx5CxqFy6umKI1mWMm2EhGTggOZB5XfkM6GdygJNliBNXYRFm
         Ou3wGg5vUlTj56FqcBjvn5Je/f9tBpdrWLoaswvOVlHIZOso9EkAmNzNWrnOgn/AqxHh
         tje/sk+y3mWzq9/lOkZQYoIDW4eHp+2+58m/rW2hABFqmrRmAi0/ju3EH+nfwi8ZUCeA
         0OCXCa9MT2kXL8tEyKVc3ZRd0wjuXWB3fUxoAPrcR00t5I7sTebiMf8/Q2Ml7v7fRCwR
         B66heceDFqcxYliIayA9HfGwY8GYLEJKX/S2Ia3nRuM+tqeP6g8Iq7EVyO9M0R5wknud
         N0kw==
X-Forwarded-Encrypted: i=1; AJvYcCUOW1YakO0mjsicMJ8CZVJqYNAdTWhYDDWvIF4Gens3ONV2MegT3AyS5X1Zb0KwWZg7WbdF2dK2oW2P@lists.infradead.org
X-Gm-Message-State: AOJu0YyYbTWvJ5eQqIk7vHJewY9AT/AjJCc7RbFt4LWpGD8jS52VrVVQ
	9YwZ9Rmxo3CtM4FX/wZH++wAIZq3MPihxnHdrrOMdppfWSmNkddqworV
X-Gm-Gg: ASbGncucVygHj7fEhmYZBp/lFSPVP1ZTdp/i3tqwZipZYdzUSYqIhp2jEEfoF4vs5OI
	ViZTyZFB+VOCmDBv5sIB7Yd6jfEKF2AoY5Eyn3Hl4wrxzrMdCnvorEz99IhaifK7v4YeqUhSCHe
	Mc6zv969eck423ZMF5v12SoZ+vxv7Mb8yD3puUTpN3OLUB+7xxq18YBeaB8XO/GsCFAbQBrOULt
	ulXxDBjQp4vbzzHngTvE17mPeqgM5Aj60LzpwhfLpdyVy4muk7TIaDbWdrcnzpCzIZ9iqKKOnTR
	VOJEa1xHQe4WF0fNlkJAbhEdW1mztAONkw4dbf8C/Gh5mhWpFHTYTq1iTZRoUWC9Lzjwj+BvcKr
	TsjRSfR/Wt7qMPQ7DTbYWadddCJ07E1NegEd4KLQVHhDaki01nkKuimoWtY6jtTh7DL48cWVs8h
	Vpv/BXIyZTvJHMY7fqFr8xBci6222A7w/VbYJk9RP+zbKu7XTh3Ptb
X-Google-Smtp-Source: AGHT+IEHIwFXlJwm0yt3wS2IwhGgmlEW/3ZYotu2V04LIxWOLcO6w3z/6QAwxlyH+LxvfC1sir4Grw==
X-Received: by 2002:a05:600c:348f:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-4775cd3bec8mr38687765e9.0.1762353502780;
        Wed, 05 Nov 2025 06:38:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cde39f9sm54314335e9.14.2025.11.05.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:38:22 -0800 (PST)
Date: Wed, 5 Nov 2025 14:38:20 +0000
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
Message-ID: <20251105143820.11558ca8@pumpkin>
In-Reply-To: <aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251104090326.2040fa75@pumpkin>
	<aQnMCVYFNpdsd-mm@smile.fi.intel.com>
	<20251105094827.10e67b2d@pumpkin>
	<aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_063825_315777_B8576EE3 
X-CRM114-Status: GOOD (  28.82  )
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

On Wed, 5 Nov 2025 16:13:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 05, 2025 at 09:48:27AM +0000, David Laight wrote:
> > On Tue, 4 Nov 2025 11:48:57 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:  
> > > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:    
> > > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:    
> 
...
> > How about this one?  
> 
> Better than previous one(s) but quite cryptic to understand. Will need a
> comment explaining the logic behind, if we go this way.

My first version (of this version) had all three character ranges in the define:
so:
#define INIT_1(v, ch_62, ch_63) \
	[ v ] = (v) >= '0' && (v) <= '9' ? (v) - '0' \
		: (v) >= 'A' && (v) <= 'Z' ? (v) - 'A' + 10 \
		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 36 \
		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
Perhaps less cryptic - even if the .i line will be rather longer.
It could be replicated for all 256 bytes, but I think the range
initialisers are reasonable for the non-printable ranges.

I did wonder if the encode and decode lookup tables count be interleaved
and both initialisers generated from the same #define.
But I can't think of a way of generating 'x' and "X" from a #define parameter.
(I don't think "X"[0] is constant enough...)

	David

> 
> > #define INIT_1(v, ch_lo, ch_hi, off, ch_62, ch_63) \
> > 	[ v ] = ((v) >= ch_lo && (v) <= ch_hi) ? (v) - ch_lo + off \
> > 		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
> > #define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
> > #define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
> > #define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
> > #define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
> > #define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
> > 
> > #define BASE64_REV_INIT(ch_62, ch_63) { \
> > 	[ 0 ... 0x1f ] = -1, \
> > 	INIT_32(0x20, '0', '9', 0, ch_62, ch_63), \
> > 	INIT_32(0x40, 'A', 'Z', 10, ch_62, ch_63), \
> > 	INIT_32(0x60, 'a', 'z', 26, ch_62, ch_63), \
> > 	[ 0x80 ... 0xff ] = -1 }
> > 
> > which gets the pre-processor to do all the work.
> > ch_62 and ch_63 can be any printable characters.
> > 
> > Note that the #define names are all in a .c file - so don't need any
> > kind of namespace protection.  
> 
> > They can also all be #undef after the initialiser.  
> 
> Yes, that's too.
> 
> > > Moreover this table is basically a dup of the strings in the first array.
> > > Which already makes an unnecessary duplication.  
> > 
> > That is what the self tests are for.
> >   
> > > That's why I prefer to
> > > see a script (one source of data) to generate the header or something like
> > > this to have the tables and strings robust against typos.  
> > 
> > We have to differ on that one.
> > Especially in cases (like this) where generating that data is reasonably trivial.
> >   
> > > The above is simply an unreadable mess.  
> 


