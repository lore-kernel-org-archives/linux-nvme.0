Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19358CCF9E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Oct 2025 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQ7p6xtC28C9VulZxo2oktqaX1uTl7IBrRCBfSYBTAg=; b=HlI71dnSay7DpJds2go6CR86QN
	WUFFtsnlT822xVq9V4R7fKzby7LIl03rBKS33Yhq2DsFzLYVgdJOm3T7twWHAqfO0mDHO0lkfsZat
	zwDqCnkIwhPcs5cLBaq++RwdoY6WRoYgmnsyPjzFuvfc7F2luBc2ntKnxh9p4nTVpvqoju1mnVw4H
	d4yuZVL8g9Apr8vWvQrej9p+zVaE4NdDFtbE5YFzc2bt2MxdinQPzE13XnQrdh+t1G3omt4VAh9Yd
	NE+9Yld/6BBGG51/daHlsTsmLSIrUk+kXM64TZByo8pntwOc2VZBQqxFs7c/XGgGLKqwC/YfGcvmp
	vy9jIbJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDdfO-0000000FNPx-3p0U;
	Tue, 28 Oct 2025 06:58:50 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDdfL-0000000FNPR-2FPB
	for linux-nvme@lists.infradead.org;
	Tue, 28 Oct 2025 06:58:49 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-290d14e5c9aso78362985ad.3
        for <linux-nvme@lists.infradead.org>; Mon, 27 Oct 2025 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761634725; x=1762239525; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQ7p6xtC28C9VulZxo2oktqaX1uTl7IBrRCBfSYBTAg=;
        b=z8JRA3lVHnNmfX+omDU73un4Wvg7HYygtUDWqCtSKiIFId5EACORdfB+gj6pA6jrir
         69lRqJwSAIAQJKc6BS/iBKz8fFcx6bzCNvFMzz8ToFbEHQeL9E2jSpWGgWbnXrIn8noP
         2A7RAit0KrcRjBcA/vS4RmoeRjjL0mLbE0m5C/EINIgjBv4Q0pTc6XNhd6H11l00pkVn
         RfpkTQVxPNJRC3SZ0zwboqGaSy5y07eHN3UK+3Aul1ePK6sJuaO4SelzTzr4iw+beh7D
         SbiQ36jBIDy/ZUJY8ABmBWUprvZ/Gt4hCQExOn1a5WPHgcNT57XpMFQBvIHkkuXOaQsb
         jR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761634725; x=1762239525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ7p6xtC28C9VulZxo2oktqaX1uTl7IBrRCBfSYBTAg=;
        b=RTil0eDeGzz0RQsa33GXbIWMhN10GRqjf060k8Gx14VUABLGF+0NE13YTV2hXuxyxZ
         c2pcWTD6O554lCIvLa6h0Xw0tg01L+6tFqHF2FqHWCeCoLwx6aDR3KBFX65PUTjFcYQR
         WkVAulFBh2kWEMhM9FYRLRUHVnVkxpJa82ScQGnZiFWdUkOVvESw7JEesw9Xct3KSK2v
         tdnwQ/G8WiXVBz24pWkXMOxmMzHLodDn4OM+56wJAyk0dvPXb3PpFfWHdGhyECtmjQzh
         h8CqtH/q/qCnco/Ode3X2ySvqECPGDXLne78s/duj2pKyiba0GJfMbsloi+W7HWpUFT6
         7rVA==
X-Forwarded-Encrypted: i=1; AJvYcCVzyC7QbwWP9EYIGaQesE8u0gsxnKX4gafcDIoGVJvNzsM2lw8NRP51oe45mXAm7GCkph3Gl9rKAYfF@lists.infradead.org
X-Gm-Message-State: AOJu0YyEzD72s5zFPZ7dNifBICq5FSxqlTalG9mJFy+n8o88SxA9z+ex
	UklULqW7mxONr9EYe0TYgYG8w8CUelwJoxIBILXZRn3ubZpnbbUq1+rDsSKGQK5wgYU=
X-Gm-Gg: ASbGncs1bnOngT8CV6viwjpffqYsFM5dVKlpWsqb4nB7W9az1cDotGI0mncTIxZHLJf
	hWfnFTiaodQmGutcX60CPW77qTitn4uZAcEOk6mzdi253TYFrGftGAjKsd/oWgbmyl08Kh/HxOV
	V6X5Qqis8Ng8Km2y68cWx8VD5wvHlvcIMkV5rR6gw5N0WYl7i+U+5WhoBBxf3bvYiHunDs8URuZ
	Bx0WDcFX5HdLPWT26F+3ApXJhSaU9F4WCrw7+ZmxFGakleDUDlFmT4eXFvC06zCXWevVek3dpOx
	En+LAnr6ccw0TfwKtJ7BzHRc/cUCu0GZIipNl5Xb1YBk79ihbhxHrNKfyR8sMh61LYjGKSVKuku
	0Nh9x97zo4O0A4RpRn1PU+BMjb80XFJ9RNidZyrYUe8ZtbgCNbGIUAb7ChUDOBp9CLyeoGGs156
	G7BZRiSix8/i3K9rE5nFGCwQ==
X-Google-Smtp-Source: AGHT+IEQUls0hQ7f0z+eHUlXVig3EP8vmtgVoNPcCaAzKcFm3wz2AgyR/G6DDFlaIKDkK5sA6SsRRQ==
X-Received: by 2002:a17:902:ea0c:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-294cb5196eamr33134075ad.46.1761634725462;
        Mon, 27 Oct 2025 23:58:45 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:d6d5:e94f:6bb8:7d7f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42558sm104262595ad.69.2025.10.27.23.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:58:45 -0700 (PDT)
Date: Tue, 28 Oct 2025 14:58:40 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: David Laight <david.laight.linux@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	akpm@linux-foundation.org, axboe@kernel.dk,
	ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com,
	xiubli@redhat.com
Subject: Re: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse
 lookup tables
Message-ID: <aQBpoI+93UZg1SqN@wu-Pro-E500-G6-WS720T>
References: <20251005181803.0ba6aee4@pumpkin>
 <aOTPMGQbUBfgdX4u@wu-Pro-E500-G6-WS720T>
 <CADUfDZp6TA_S72+JDJRmObJgmovPgit=-Zf+-oC+r0wUsyg9Jg@mail.gmail.com>
 <20251007192327.57f00588@pumpkin>
 <aOeprat4/97oSWE0@wu-Pro-E500-G6-WS720T>
 <20251010105138.0356ad75@pumpkin>
 <aOzLQ2KSqGn1eYrm@wu-Pro-E500-G6-WS720T>
 <20251014091420.173dfc9c@pumpkin>
 <aP9voK9lE/MlanGl@wu-Pro-E500-G6-WS720T>
 <20251027141802.61dbfbb2@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027141802.61dbfbb2@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_235847_683059_593EEB2A 
X-CRM114-Status: GOOD (  23.74  )
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

On Mon, Oct 27, 2025 at 02:18:02PM +0000, David Laight wrote:
> On Mon, 27 Oct 2025 21:12:00 +0800
> Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> 
> ...
> > Hi David,
> > 
> > I noticed your suggested approach:
> > val_24 = t[b[0]] | t[b[1]] << 6 | t[b[2]] << 12 | t[b[3]] << 18;
> > Per the C11 draft, this can lead to undefined behavior.
> > "If E1 has a signed type and nonnegative value, and E1 × 2^E2 is
> > representable in the result type, then that is the resulting value;
> > otherwise, the behavior is undefined."
> > Therefore, left-shifting a negative signed value is undefined behavior.
> 
> Don't worry about that, there are all sorts of places in the kernel
> where shifts of negative values are technically undefined.
> 
> They are undefined because you get different values for 1's compliment
> and 'sign overpunch' signed integers.
> Even for 2's compliment C doesn't require a 'sign bit replicating'
> right shift.
> (And I suspect both gcc and clang only support 2's compliment.)
> 
> I don't think even clang is stupid enough to silently not emit any
> instructions for shifts of negative values.
> It is another place where it should be 'implementation defined' rather
> than 'undefined' behaviour.
>

Hi David,

Thanks for your explanation. I'll proceed with the modification according
to your original suggestion.

Best regards,
Guan-Chun

> > Perhaps we could change the code as shown below. What do you think?
> 
> If you are really worried, change the '<< n' to '* (1 << n)' which
> obfuscates the code.
> The compiler will convert it straight back to a simple shift.
> 
> I bet that if you look hard enough even 'a | b' is undefined if
> either is negative.
> 
> 	David
> 
> 
> 
> 	David

