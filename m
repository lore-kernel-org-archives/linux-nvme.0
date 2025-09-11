Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55685CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UqP0yh780QZSEn09Gu4Ub7K64FPut2woI/zF5kWSvDk=; b=tdLAFS7JMS9DwV5eJZDU3Maxp+
	4xKwD8jmh13CbHUESmCOPTg0Egf2rMJ7jLnJIyU3QA5l0tg1X7iWrZM9geoAh0mVnqSnCUf+86+/O
	su3xVZ/SeVLPsyzpdjp1ojGFcUA9aI1inJRnmwIMJLpQQX0x/SuI33u67AGl51UJ7UNeF5AgCGm0M
	sUQ2O9eSajYf6DBt1EymjbTG9FyzOUcSW7PT94QA5IW7ktpKdEcdxKulay5d4AH00aod4qqT1jCgC
	+VJu7Y/0C4aBFHH0/QDh44r3Ng/PyeC0S1N1WkzPcwoNyyPQgozn5fh8q7TQI1xqDG38vqtHqTW6m
	a9GdRsbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwk7a-00000004CR2-3FF4;
	Thu, 11 Sep 2025 16:26:06 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwk7Y-00000004CPk-09R7
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 16:26:05 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b522fd4d855so771496a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757607963; x=1758212763; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqP0yh780QZSEn09Gu4Ub7K64FPut2woI/zF5kWSvDk=;
        b=QTUzz/8n5m61/U3JqIIJlxcPZRmOj8+NxTOGssWSdpWWi+z/HBAh0xTPLSOJtDpFpJ
         LkTywMiBp+wvlmO4RJkRnAbw8sRMDrZdVQepQaaq3QfPEVnHIy847hg6aacrCEGoGE0R
         9IC5cFB9aH5aCghKkjGoOBrDf89ADlVKvc8Lp5xQKR49Y1JWLiCSicodnrrrXr39NhIj
         vT3OWqCKiQIDkRWUrxbK+dxXjogovQFZpLA/8kuintS9UX29r0h/sXV8HhjAnBR95e6O
         zqDgUoGXf/X7GWmuSXVQ7RWLi2V2rDSgIT2ODzrCygu8z8by++VFnzFWYwUWsiIhDY53
         yiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757607963; x=1758212763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqP0yh780QZSEn09Gu4Ub7K64FPut2woI/zF5kWSvDk=;
        b=r4F4UZ+bRZs8XgEZunB7IqDv6WSjtucqEzpB875G8dOhUnymJQjCziJXKmhVMcpO1u
         ebyrxfUdE415ItfVY97E4JdBBSVsDUnCR5xGFGULthzlUG0nfZOIymrSIWoO13iOqpIN
         dI+s1Pgg53fypaVz8URDklDX7dUE/eBrPS5DssIZOsZOLtMZWV1O7Q9rFDby3VTFZ/iP
         hsdU5CddO3aKhPYFFjR0fjQMWL2gTfnMnYH2yOyK6VZmOw2krB7SEpev6EME2fHkZSjd
         bwwh/jMJdlY967QuIhsuerA/oViPmVrD0tmi4aztvgYGKp3ZheMOOHzY+ze+ah0G47ZC
         eovw==
X-Forwarded-Encrypted: i=1; AJvYcCV+Tp8tctH7z7McKjHob6sjZzMDZsvpt3csZ8a+zWp8V5isvM4LMYecaIQ+bBIrVyhX0B9gHZJRnGsy@lists.infradead.org
X-Gm-Message-State: AOJu0YzSyIPIlQuvperel/8FsdxBVxTl1mo1zm9PSLcrgkk3Tl6Oq8AI
	QMge07izRu1jKwXzlI7RC5Njx+dyyiFvOmMnMvQdqVVlGG+lW/cXLJiJ
X-Gm-Gg: ASbGnctdwj0mCutfl1zDek8QzSRch1LtssHy3k4Ng6KExhKsCS/XWy9lGbvw5Vnv0IV
	EsSRx+qzBSGDhAewiow/92lMp92wqxtLQM8gBz7hrjBcb6MM9YkJwQbhbdlL4knT5LPZyjf9Rzs
	fUC0Q4lurs38Ib4faLUbzAkOnzZ9XbksJLVw5R9ZMczA26dLMihOn7ZAKxS4XypE0DHCxLg6oxw
	BqAFeI2YqvWe6NQAKI/+WnyyqChiX4Oql/tDOH275sBiOpHl9HKpuhBNrm/RmeF/i/mOW53b6ID
	Goxbr7rZtnvUVa2GeWqlR3wW9XKtj41qAkYW6TAmjcq03rpnf5e6rOtEAq6U/5lq+JtUk0nAkWu
	IP1moHSRiqQuM7JfFY4uzDlbOCfq/3VuFl+JU/gmiYu9LKRv0JAAy9FAH2gKC+4qDaPJbd/PwPc
	pe9vxi5A==
X-Google-Smtp-Source: AGHT+IH5XMd0HGbOFMyruweaNH1fol7mWk5Y5V4J67dhEP3/uGyRjyhKDuxNRCKL+82zJXTUnSBwfw==
X-Received: by 2002:a17:903:228f:b0:24c:be1f:c204 with SMTP id d9443c01a7336-25d24da3763mr450845ad.22.1757607962668;
        Thu, 11 Sep 2025 09:26:02 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98e7647sm2677426a91.21.2025.09.11.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:26:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 00:25:56 +0800
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
Message-ID: <aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_092604_079185_463D8A74 
X-CRM114-Status: GOOD (  31.77  )
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

Hi Caleb,

On Thu, Sep 11, 2025 at 08:50:12AM -0700, Caleb Sander Mateos wrote:
> On Thu, Sep 11, 2025 at 12:33 AM Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:
> >
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
> >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> 
> Does base64_table still need to be NUL-terminated?
> 
Right, it doesn't need to be nul-terminated.

> >
> > +static inline const char *find_chr(const char *base64_table, char ch)
> 
> Don't see a need to pass in base64_table, the function could just
> access the global variable directly.
> 
> > +{
> > +       if ('A' <= ch && ch <= 'Z')
> > +               return base64_table + ch - 'A';
> > +       if ('a' <= ch && ch <= 'z')
> > +               return base64_table + 26 + ch - 'a';
> > +       if ('0' <= ch && ch <= '9')
> > +               return base64_table + 26 * 2 + ch - '0';
> > +       if (ch == base64_table[26 * 2 + 10])
> > +               return base64_table + 26 * 2 + 10;
> > +       if (ch == base64_table[26 * 2 + 10 + 1])
> > +               return base64_table + 26 * 2 + 10 + 1;
> > +       return NULL;
> 
> This is still pretty branchy. One way to avoid the branches would be
> to define a reverse lookup table mapping base64 chars to their values
> (or a sentinel value for invalid chars). Have you benchmarked that
> approach?
> 
We've considered that approach and agree it could very likely be faster.
However, since a later patch in this series will add support for users to
provide their own base64 table, adopting a reverse lookup table would also
require each user to supply a corresponding reverse table. We're not sure
whether the extra memory overhead in exchange for runtime speed would be
an acceptable tradeoff for everyone, and it might also cause confusion on
the API side as to why it's mandatory to pass in a reverse table.

By contrast, the simple inline function gives us a clear performance
improvement without additional memory cost or complicating the API. That
said, if there's consensus that a reverse lookup table is worthwhile, we
can certainly revisit the idea.

Regards,
Kuan-Wei

> 
> > +}
> > +
> >  /**
> >   * base64_encode() - base64-encode some binary data
> >   * @src: the binary data to encode
> > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> >         u8 *bp = dst;
> >
> >         for (i = 0; i < srclen; i++) {
> > -               const char *p = strchr(base64_table, src[i]);
> > +               const char *p = find_chr(base64_table, src[i]);
> >
> >                 if (src[i] == '=') {
> >                         ac = (ac << 6);
> > --
> > 2.34.1
> >
> >

