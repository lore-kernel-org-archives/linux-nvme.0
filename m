Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A18CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNfZ+THGjVnPfKEQVjfAvTl//pe2jY0CkLSpKpP2yFk=; b=CGLlPPo0oDAoqUmeofX3QKEbUe
	vuAZvkS53+ZMVIG4kRtPt5MNTTceIAk7GBk0OfeG6azhq8oK+92A0sul/r1hfbLRc2wtbbucwMMuf
	i0h0fYEAM3qE5/OoXE2doJDfhyFtKe5FF4WlIBLTjilYmrfdC6hOqCZ2U7RdCTCKoZjbv4QEiXq82
	s90FVEciO9gn14iH2prqgyL1qLjoyhzsV8yOzvV9ku2/sSEsu2sdS60u2ke9SpYA7V+t4bWlF1T7Y
	N2ecKdIOwhXT47ZX8o6GUbJcRiNC+ceZ21vTI9zdg5Kv5j/KTsa1nlKD688ATq9kEbGitaWw0jS1p
	BMDRgW+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkJZ-00000004FwR-2ERi;
	Thu, 11 Sep 2025 16:38:29 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwkJW-00000004FvV-34pK
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 16:38:27 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-24cb39fbd90so8357035ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608706; x=1758213506; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNfZ+THGjVnPfKEQVjfAvTl//pe2jY0CkLSpKpP2yFk=;
        b=l+ArxW0Z5X4Tc6RNor+EL3bRBeJtQoCVeR+pMP3HhMDIJ7fKgYNzMvSSszqGX/2UQ9
         U0JXWypgDvOcjRl7e7Ygf956lo4nQOmVzDQZt8fBjjaIwtdttVvAVtLSrS+EvKT0xJDE
         PWsOVa8iMtC+xds+DDbtccKuX2R2UjnBTI93ZhewaK3UNAzp3MENJ4Cp98SMNKkpqTd6
         0plG/ilTqwNmomsusyGllVU8ADyYUXMTzN0TnOc4aya1DdcSAH3pl5m4qlFbUnikMS6f
         Y2fxPS3b+Z343CVFUgGIrAgSnheeyry74VQdJs7r0aOSFGiPne3yQvhtMk8wGf1k38cE
         Wpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608706; x=1758213506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNfZ+THGjVnPfKEQVjfAvTl//pe2jY0CkLSpKpP2yFk=;
        b=RLib9HVRSSWpIKx4vqiaBed5yMqUPOEpOHJ5ufoVGH/A0WgHvyo76h7COfmKmuYsSQ
         6Ac9ap+64R1s+4JGMhwbeWp+PMohzZNBISyS/1PZaedWSjm1/Lj7RzLzFurOkDcq8NHE
         ZE0E5EHzNFbwvyG3K7xfzJHMPQ2vP1bWoZgyZTdXc9gKhi8ZOyW1LvF3HYFxLTmAAKt7
         fEE//6jXCaPF+A53bhuNpXC5aDUPhtkSZdqdgwm1BxrLtUnQHyt4aDS1rkbTCsSRfWxc
         N/V85bR8NC9LbxqFwVeo6lN7sgo/ARhYt0sd85OYh8JKVkE9w2OIDDPIvo813MhjZDtM
         2iGg==
X-Forwarded-Encrypted: i=1; AJvYcCXxXQWLdV47+E4W83H/9kx38AIIaUkUa8VUvQnFjaISfRetpJ+mPXgofSF+Ck+G4yy+Sx1PRIkGGlMP@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2cuF0EvzI0I3VEw08pcjhX46qswyGrEZCXiqVgC5w5gz9LKAY
	VX62wlZWfEJA3DGsOamr3OYkpNkOdWzRyo9NBXx5cJZ6LN/mRoOR35/j
X-Gm-Gg: ASbGncuCNXv9yK7fZ9jn1ywxzLhCGoaxIVrKxj6AoIrRgKNBRzro+jq43m7PdifC7+b
	FsJpCTNQb3Z95+QHjvoDFq1yZl0z0z7DDSb4s08IRnlCIPt+PEPoLkcEBmTh5cbLzKPHcpijWh1
	iSe56Ow7L2O/TJelciLwJTCWKxSp030jLBD65LVB9hqB6uN1X6pYal2QTxFsDMvPGUmtEAV3Ixy
	AilyCk0zsahayAXTaWXu6eaMLWdSSpWk4jpxU2z0EhxjU8rM5l9/ZEBG7DkHTe1JBmdp0/f4Q77
	b3U5V+Voo81cOydkxdKg/iG8CYFAoaY9WH31ApUZhHmmPb9xXzdCuD0s54+gKVY+BZoqmQrPWab
	2FXd9mIOuLE2g4JxUb3LvP8+eqQtnbnPCKVMisf7XBEOqz0n12t5U1iitBrJPogyssQsgNwY=
X-Google-Smtp-Source: AGHT+IE0FiJZ1Xof1YnqAKXUYRLvK9Rwr7P7SSvXPPnTPHIg+AFxKr0A7VxsEXWSG4uIu8QKuqN0+Q==
X-Received: by 2002:a17:902:e38a:b0:248:cd0b:3434 with SMTP id d9443c01a7336-25d26e43dc6mr435495ad.36.1757608705609;
        Thu, 11 Sep 2025 09:38:25 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3786807fsm24328675ad.62.2025.09.11.09.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:38:25 -0700 (PDT)
Date: Fri, 12 Sep 2025 00:38:20 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, ebiggers@kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
 <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_093826_775637_37ACBEA8 
X-CRM114-Status: GOOD (  37.52  )
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

On Fri, Sep 12, 2025 at 12:26:02AM +0800, Kuan-Wei Chiu wrote:
> Hi Caleb,
> 
> On Thu, Sep 11, 2025 at 08:50:12AM -0700, Caleb Sander Mateos wrote:
> > On Thu, Sep 11, 2025 at 12:33 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> > >
> > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > >
> > > The base64 decoder previously relied on strchr() to locate each
> > > character in the base64 table. In the worst case, this requires
> > > scanning all 64 entries, and even with bitwise tricks or word-sized
> > > comparisons, still needs up to 8 checks.
> > >
> > > Introduce a small helper function that maps input characters directly
> > > to their position in the base64 table. This reduces the maximum number
> > > of comparisons to 5, improving decoding efficiency while keeping the
> > > logic straightforward.
> > >
> > > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > > over 1000 runs, tested with KUnit):
> > >
> > > Decode:
> > >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> > >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > >
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > ---
> > >  lib/base64.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/base64.c b/lib/base64.c
> > > index b736a7a43..9416bded2 100644
> > > --- a/lib/base64.c
> > > +++ b/lib/base64.c
> > > @@ -18,6 +18,21 @@
> > >  static const char base64_table[65] =
> > >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > 
> > Does base64_table still need to be NUL-terminated?
> > 
> Right, it doesn't need to be nul-terminated.
> 
> > >
> > > +static inline const char *find_chr(const char *base64_table, char ch)
> > 
> > Don't see a need to pass in base64_table, the function could just
> > access the global variable directly.
> > 
> > > +{
> > > +       if ('A' <= ch && ch <= 'Z')
> > > +               return base64_table + ch - 'A';
> > > +       if ('a' <= ch && ch <= 'z')
> > > +               return base64_table + 26 + ch - 'a';
> > > +       if ('0' <= ch && ch <= '9')
> > > +               return base64_table + 26 * 2 + ch - '0';
> > > +       if (ch == base64_table[26 * 2 + 10])
> > > +               return base64_table + 26 * 2 + 10;
> > > +       if (ch == base64_table[26 * 2 + 10 + 1])
> > > +               return base64_table + 26 * 2 + 10 + 1;
> > > +       return NULL;
> > 
> > This is still pretty branchy. One way to avoid the branches would be
> > to define a reverse lookup table mapping base64 chars to their values
> > (or a sentinel value for invalid chars). Have you benchmarked that
> > approach?
> > 
> We've considered that approach and agree it could very likely be faster.
> However, since a later patch in this series will add support for users to
> provide their own base64 table, adopting a reverse lookup table would also
> require each user to supply a corresponding reverse table. We're not sure
> whether the extra memory overhead in exchange for runtime speed would be
> an acceptable tradeoff for everyone, and it might also cause confusion on
> the API side as to why it's mandatory to pass in a reverse table.
> 
> By contrast, the simple inline function gives us a clear performance
> improvement without additional memory cost or complicating the API. That
> said, if there's consensus that a reverse lookup table is worthwhile, we
> can certainly revisit the idea.
> 
Or I just realized that since different base64 tables only differ in the
last two characters, we could allocate a 256 entry reverse table inside
the base64 function and set the mapping for those two characters. That
way, users wouldn't need to pass in a reverse table. The downside is that
this would significantly increase the function's stack size.

Regards,
Kuan-Wei

> 
> > 
> > > +}
> > > +
> > >  /**
> > >   * base64_encode() - base64-encode some binary data
> > >   * @src: the binary data to encode
> > > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> > >         u8 *bp = dst;
> > >
> > >         for (i = 0; i < srclen; i++) {
> > > -               const char *p = strchr(base64_table, src[i]);
> > > +               const char *p = find_chr(base64_table, src[i]);
> > >
> > >                 if (src[i] == '=') {
> > >                         ac = (ac << 6);
> > > --
> > > 2.34.1
> > >
> > >

