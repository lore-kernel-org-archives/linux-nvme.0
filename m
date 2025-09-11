Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C62CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWvv0dO99lFH0+UcixSCK2Xe0maLZGpO3NhcPA2OOyE=; b=cC5QS8bGq71zjzCTh9nWXP7Ows
	8lIp4sCJ1D4rlycpkAXikCWqgOCoODSo44UJ6iYhU7rXT/fywiPyDJRQz5JOgx0X/566NB2w6CcyB
	P74kgFU72sfu1GWe5PHDfnhfeLM7MS7xhjVARMjlGe+teFKJabmoEXhYKRlDR0lcFhtuydJdms/PJ
	TqtpN1EbM7w5KSVZZR/T3MqKUutrP1nDXOvWjZUjc4JPx6tvqZru0S2xLfsOCWK6BvXIrCAOV6gW+
	PPuOJ6S/UbMKR8DLkftlKxFLAkP2ntEQPlzbkW+1T9lWNs3ANisJ3/xQEUNsxqKT1MTblcHdmeSof
	/X/Q1DUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmHo-00000004o3i-3QCJ;
	Thu, 11 Sep 2025 18:44:48 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmHm-00000004o2P-1LPB
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 18:44:47 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-77269d19280so1011300b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616285; x=1758221085; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWvv0dO99lFH0+UcixSCK2Xe0maLZGpO3NhcPA2OOyE=;
        b=OThfg86jX/4ozTvy4q5ITjMtXcyDDeTETNdgzIjNb50mlIHcaLFNiFcQllB9y5/LGt
         wrkqzmKiETTTB4IatbmgT0Lb5H7kZbgLS8sHX8ROzORn6eGvod0F7RxKL2JFv/BQoh43
         5hGruUDV6nLJyZvTVQJ1lUuR4nolTZEmGsdekY3dGJR1VtuLrw1cXxMSgHlBaxi2Bp7E
         yPZs+ytVdR19b9fwXopefjB8ZWZn6Dsbw6aIM0/f3qCTdUQYAbSM8VUoHP/F9w/iw7aa
         NMNQXyLlCB7gHiBSchvdG1t2q3RZ5eT2/QT5vXSF+EfyRWGPx8KYA6IHFHK0wC1uBAG8
         K1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616285; x=1758221085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWvv0dO99lFH0+UcixSCK2Xe0maLZGpO3NhcPA2OOyE=;
        b=jDQK3GGs576IZ2Xo7YsB6FM5u91OXD1Kdy/HqXz3jKQ3cgb9p78NETHbry5+s8tATi
         kU3VGYZAWzdIsMMcW4Pjngb8YbEA1v3sFtf1PTwiBuOycAKmRug7LhPZYa/MhAcuFYdg
         sj4iHSXfefm37c2ruDnhWD034JmtmY0jf4hUx3Jg7nhyk9F531cUZPwPPAGZQf/6igBm
         iWo3yl3dAQPUOP/IJcJTKz1lpAX+r7Vamfi4y2ToORJio+WHEVOtZXqvDEmtmms49fvV
         7EleKc9v3Okn6r7N1zU6T8rVD0tDrKwClDS5sBUVeQN9DfYL7nlBaB3e626wMhpfU6Mp
         Cr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbIFIlZdeLbRSSvxgr49qemFutB77UlWBIELLYX0VaBtI2y4rrqlkAzSY3it5tDm+TERebRSBe4Q0m@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+H/VJGzNxrLtbYo/b+DCwEsbDuQc3Om8NpoIixEvgmDjRtJC8
	XdvdUdEDozitJgANe1rglQii4l/Su5ijRyhNb8br/E0IVEViDJeCueKI
X-Gm-Gg: ASbGnctrb0GKH3XgJ2TCZFSVJ9eQ7H0hZ6Wqkzk2YJBtFZ9PpE01zcL/UmQGJEpeMli
	XwDkkV/PxHnY0yagwy3Oq7hdujguGKOetOaHOoDIceEnlxC107VRCIpAVdR5keSW/zr76m/dovV
	JPIhywz86UeNdVuvUHWCONlWJJFiWUzkfAHTXe+LBSff3OE5TLGZl5++7cmgvji9++OY+/Mgipo
	bL1iLucP6xeScsv91rpX3rDO1jqmVYAJjjPFP1NA2oLKJ5XkOQGEd+sULbivhc6X8tHInGK0Uv9
	LRdwcHWXa9EAYSmEN07hvvvaPfAbvHuMYtqO7QONqfS6gBxBkiu9LRmNZhcEGL7n/tLG1vgA+Q5
	OnSzK0+FYBvhV9+TgLkbm+N8OSdK2qgUKxcZvy1XZdLIirJNPv0hV+hI54Vbl
X-Google-Smtp-Source: AGHT+IFKDe0caW6LVNj4UrcnbNbED3hTtYmCrg74uCtGPOQ9WMmIh1BkKDM+jjzJW+4ZpB3MwiOPTg==
X-Received: by 2002:a05:6a20:3d83:b0:24d:56d5:3681 with SMTP id adf61e73a8af0-2602a3a6eb3mr386297637.7.1757616285443;
        Thu, 11 Sep 2025 11:44:45 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b331e4sm2760887b3a.70.2025.09.11.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:44:45 -0700 (PDT)
Date: Fri, 12 Sep 2025 02:44:41 +0800
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
Message-ID: <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <20250911181418.GB1376@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911181418.GB1376@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_114446_363270_197F7B2D 
X-CRM114-Status: GOOD (  29.43  )
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

Hi Eric,

On Thu, Sep 11, 2025 at 11:14:18AM -0700, Eric Biggers wrote:
> On Thu, Sep 11, 2025 at 03:32:04PM +0800, Guan-Chun Wu wrote:
> > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > 
> > The base64 decoder previously relied on strchr() to locate each
> > character in the base64 table. In the worst case, this requires
> > scanning all 64 entries, and even with bitwise tricks or word-sized
> > comparisons, still needs up to 8 checks.
> > 
> > Introduce a small helper function that maps input characters directly
> > to their position in the base64 table. This reduces the maximum number
> > of comparisons to 5, improving decoding efficiency while keeping the
> > logic straightforward.
> > 
> > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > over 1000 runs, tested with KUnit):
> > 
> > Decode:
> >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > ---
> >  lib/base64.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/base64.c b/lib/base64.c
> > index b736a7a43..9416bded2 100644
> > --- a/lib/base64.c
> > +++ b/lib/base64.c
> > @@ -18,6 +18,21 @@
> >  static const char base64_table[65] =
> >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> >  
> > +static inline const char *find_chr(const char *base64_table, char ch)
> > +{
> > +	if ('A' <= ch && ch <= 'Z')
> > +		return base64_table + ch - 'A';
> > +	if ('a' <= ch && ch <= 'z')
> > +		return base64_table + 26 + ch - 'a';
> > +	if ('0' <= ch && ch <= '9')
> > +		return base64_table + 26 * 2 + ch - '0';
> > +	if (ch == base64_table[26 * 2 + 10])
> > +		return base64_table + 26 * 2 + 10;
> > +	if (ch == base64_table[26 * 2 + 10 + 1])
> > +		return base64_table + 26 * 2 + 10 + 1;
> > +	return NULL;
> > +}
> > +
> >  /**
> >   * base64_encode() - base64-encode some binary data
> >   * @src: the binary data to encode
> > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> >  	u8 *bp = dst;
> >  
> >  	for (i = 0; i < srclen; i++) {
> > -		const char *p = strchr(base64_table, src[i]);
> > +		const char *p = find_chr(base64_table, src[i]);
> >  
> >  		if (src[i] == '=') {
> >  			ac = (ac << 6);
> 
> But this makes the contents of base64_table no longer be used, except
> for entries 62 and 63.  So this patch doesn't make sense.  Either we
> should actually use base64_table, or we should remove base64_table and
> do the mapping entirely in code.
> 
For base64_decode(), you're right. After this patch it only uses the last
two entries of base64_table. However, base64_encode() still makes use of
the entire table.

I'm a bit unsure why it would be unacceptable if only one of the two
functions relies on the full base64 table.

Regards,
Kuan-Wei


