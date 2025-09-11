Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F614CAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tF1OTr2rtCxy3jTEKLVALatHVlDvvfc6+FzIrMIIxc4=; b=pPqYhATZXnGD3XSpWEUw0fUsrN
	tXChtoEqUAi5qUg51GolfoRJAocQLsfq5EHwQTYVy8YvNmFNRnoAKkQd7pPi0T0hAhAjKvYpktP/F
	jZJb/JTqX7ux5UuVUc47XC1XJuhfvItM5LgKaiPcJI8E8bc8NUPvPS893nTJH9htPGSE3VoWDE4+F
	oURV7VtwYsDlUyFpDD2d3cOcjq1j1VRY3qPwDJS+/V59Qw9Hg1c7QSM29PFpfnrdu+xKMAI0WWtVw
	3MYYlR8RPkWstCYnZsdsbjVGjOFNKzVOtUdkiQ4hLpGtZM7O1PLmW1kqBajf/e16OVWTTrOdwP2fu
	PTAqFo8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmXP-00000004sxB-2Vom;
	Thu, 11 Sep 2025 19:00:55 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmXM-00000004swh-3OKc
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 19:00:53 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7722f2f2aa4so1339831b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617252; x=1758222052; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tF1OTr2rtCxy3jTEKLVALatHVlDvvfc6+FzIrMIIxc4=;
        b=LtjNiwIUS19nVdi0dFHQdPy+9AT+Q2DJCuTXrTTiufn46ft1CzubZxEHc4KQ6hXlNJ
         iXQaQkuA/Iut8Cs1Q3jL2xfMZ7bYhTncydDZVUvHE3I6/yTjSZG7gCvr+5qKw1WzdSDM
         x71FWKwj6Bhh5nKx+HefsJcnJGmZfBgB3M8UjI9zjpQnK+KHhntkIHwWI0ahnYlA/IPh
         +Q6fFFRc6G/AX0rdqANzRGte3AFT490atbY0pK4OQhajIqUNnfCA0vAouOn3XPXozSlr
         bWHLESb8Myukp3xPaQpt8tZ9+fsNKntN4N2rlxdykH9u2edCx8gtY0crGWvLP7kgjhY/
         Aq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617252; x=1758222052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF1OTr2rtCxy3jTEKLVALatHVlDvvfc6+FzIrMIIxc4=;
        b=hMzDriv4OUdKkFJY0Iv4Qa4pYoFkVgCUgmmwCmNvd7UJlFx1oN+78QjXn3iQymTtxK
         j7ch2tItQg1qvKAcRvYfM9JoGLHGQlHj+THcYLfkI7Hu5ATJ4SYAube3M1lssgK7vTZc
         EpkFEiEBlHdX/P/p8OzySe+y93PMrT5QF5fYiThDQ9VKnEUMODZaU5E4X61TPWryMP9L
         /N4M4NCTnalqYbieLzeAkocrhCf2HuxdrmGyPAPrKnQDPiyGqWCiAPo1HRpBO0BpBoWH
         KrdTi+mvE5OxmyN73lkvk0YVUkhTZf58ibiK5WNOAYCOFkCLLqODjyMGRMx2TdFVP74r
         8i6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL6YWQvhpDjInXrg3AF/LfgxGp+RZJ6PbhgVkbOPHg4sLco7TEnYf5e/4d5nhYGUJgOVvXgeAKMn9s@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5zoE+cdWojHgmdhQc6rts0ZfKSFoeId3O9cXzUWwCeKpFStrz
	Qbdjxi0FMJXY4u83EdekBx4VndVPUGQkTxUTgHTgd3kFz4di80lSqs3S
X-Gm-Gg: ASbGncukGf0FRoRBKbiKkr4DLIKMJm5g/+5kGbVZJGLNUyEi1pNS2Kq1LFIJab3fJJE
	AxgXDnM3VTq0j15Q72lwLXyv4vy2/+F5GPaTCAV/XlyvYQhXW/P2/Qk6Rs8CKxanueIy3EwsCxr
	7OXN0DElk5BN6vsdVaWvmDi9SX2VOETO22UChF1mWsDPCMeC3vbDrBduiRKfxRc1q9xVfQXSaPD
	G79gx3M36qivbdUBgFjTNoHfdKtyBsBKyZ+H+7VP6z6tAurD4quYST19iVTE9Sh87OL+xlOFqa0
	DsN7aXWmFLfHKe0dAzMAnlMc1xe0pv6iTyhLG77LWKS7ncQB/ymE9dBhEl7PL5HvSrz6844P0JM
	W8AjjtwT6w9PhRtWZEFvrSt3U7/eaUwLtAE2cqjRFfIr/OLy4YzLRgP16L33PtLyM0M8mYUjLSN
	KtPn2eLA==
X-Google-Smtp-Source: AGHT+IFKgGjLknGkp8jc1chBYIIHFKqurKXfUj4cl8o1arPPk6MKDJNmBOPLMnF+vJ6NN+q1YLvRog==
X-Received: by 2002:a05:6a00:2307:b0:772:4b05:78c1 with SMTP id d2e1a72fcca58-77612079eeamr536333b3a.3.1757617251633;
        Thu, 11 Sep 2025 12:00:51 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b340ffsm2810127b3a.76.2025.09.11.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 12:00:51 -0700 (PDT)
Date: Fri, 12 Sep 2025 03:00:47 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <aMMcX8jEoBjBUeyj@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <20250911181418.GB1376@sol>
 <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
 <20250911184935.GE1376@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911184935.GE1376@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_120052_852566_125CD5A5 
X-CRM114-Status: GOOD (  36.43  )
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

On Thu, Sep 11, 2025 at 11:49:35AM -0700, Eric Biggers wrote:
> On Fri, Sep 12, 2025 at 02:44:41AM +0800, Kuan-Wei Chiu wrote:
> > Hi Eric,
> > 
> > On Thu, Sep 11, 2025 at 11:14:18AM -0700, Eric Biggers wrote:
> > > On Thu, Sep 11, 2025 at 03:32:04PM +0800, Guan-Chun Wu wrote:
> > > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > 
> > > > The base64 decoder previously relied on strchr() to locate each
> > > > character in the base64 table. In the worst case, this requires
> > > > scanning all 64 entries, and even with bitwise tricks or word-sized
> > > > comparisons, still needs up to 8 checks.
> > > > 
> > > > Introduce a small helper function that maps input characters directly
> > > > to their position in the base64 table. This reduces the maximum number
> > > > of comparisons to 5, improving decoding efficiency while keeping the
> > > > logic straightforward.
> > > > 
> > > > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > > > over 1000 runs, tested with KUnit):
> > > > 
> > > > Decode:
> > > >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> > > >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > > > 
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > > ---
> > > >  lib/base64.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/lib/base64.c b/lib/base64.c
> > > > index b736a7a43..9416bded2 100644
> > > > --- a/lib/base64.c
> > > > +++ b/lib/base64.c
> > > > @@ -18,6 +18,21 @@
> > > >  static const char base64_table[65] =
> > > >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > > >  
> > > > +static inline const char *find_chr(const char *base64_table, char ch)
> > > > +{
> > > > +	if ('A' <= ch && ch <= 'Z')
> > > > +		return base64_table + ch - 'A';
> > > > +	if ('a' <= ch && ch <= 'z')
> > > > +		return base64_table + 26 + ch - 'a';
> > > > +	if ('0' <= ch && ch <= '9')
> > > > +		return base64_table + 26 * 2 + ch - '0';
> > > > +	if (ch == base64_table[26 * 2 + 10])
> > > > +		return base64_table + 26 * 2 + 10;
> > > > +	if (ch == base64_table[26 * 2 + 10 + 1])
> > > > +		return base64_table + 26 * 2 + 10 + 1;
> > > > +	return NULL;
> > > > +}
> > > > +
> > > >  /**
> > > >   * base64_encode() - base64-encode some binary data
> > > >   * @src: the binary data to encode
> > > > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> > > >  	u8 *bp = dst;
> > > >  
> > > >  	for (i = 0; i < srclen; i++) {
> > > > -		const char *p = strchr(base64_table, src[i]);
> > > > +		const char *p = find_chr(base64_table, src[i]);
> > > >  
> > > >  		if (src[i] == '=') {
> > > >  			ac = (ac << 6);
> > > 
> > > But this makes the contents of base64_table no longer be used, except
> > > for entries 62 and 63.  So this patch doesn't make sense.  Either we
> > > should actually use base64_table, or we should remove base64_table and
> > > do the mapping entirely in code.
> > > 
> > For base64_decode(), you're right. After this patch it only uses the last
> > two entries of base64_table. However, base64_encode() still makes use of
> > the entire table.
> > 
> > I'm a bit unsure why it would be unacceptable if only one of the two
> > functions relies on the full base64 table.
> 
> Well, don't remove the table then.  But please don't calculate pointers
> into it, only to take the offset from the beginning and never actually
> dereference them.  You should just generate the offset directly.
> 
Agreed. Thanks for the review.
I'll make that change in the next version.

Regards,
Kuan-Wei


