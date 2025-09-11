Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A25CAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6obS77W4gL8mbr6C+eeuSSKKzH7RwZdvT4ZIG8wkffg=; b=fL0+17gPu1kOLODAkZ6hgoYj5N
	C2r48PO32qa94Dv7ruT2n+RxaITsa6ZX/tgL3NaTVFh8Hvo703SZwyiD1Q6WF7h1E8sJScC63fkqd
	DmbVDJE5FD9B5HLhIwhX7C9eTjy2/mWbsP5o5Wt3cNikmJOaoE0WZSpmcWHD5/fYcUKIiX9wmjtGq
	lG8YHSv1nzjoWBf9QGd6tl3r6iq4SSliqJAGV32aVe7VOwSz3wMrf2qx852zmpTJDOCqnFORrS+E4
	vujgBLTwqtpyGsGkislvUN7WZedZeKFtTZr0PpNiZMWbOF1WtzmxRFcpbuT65t/f6k4t7mh4Ph8G2
	nDrgBxdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjky-000000044fQ-1gNZ;
	Thu, 11 Sep 2025 16:02:44 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwjkw-000000044eK-1DMf
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 16:02:43 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-772759a7dfbso64369b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1757606561; x=1758211361; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6obS77W4gL8mbr6C+eeuSSKKzH7RwZdvT4ZIG8wkffg=;
        b=e1CMGy8JtI0FdzHwz0weJ0RCuwysy77BeeCHbIjET+SWUCn6oWLaOho2WYW+zQYbbS
         nhrF6vC9XkPAtcnZm/fwD+fQnTSoBuXKvV85Uu7NxbirO/CCeMmk17swJyKcCt944Wlt
         +HBzV4pJjPZy1Fjvuj7J8vjfyGHs8vzkYrRdFQPt6szmAMZsOoaNxOPAn1WBuZkAFhtL
         hhNhNqNozgG8AWspQsKG9qwaS6+8zJGkYC5WZKmNE8VS06jcJS6jfvdvgbWFQ2k3WKpU
         vYrwdp5PcjDVU9xiTejyo/h6lvYpjhisl9Hy9lvGEDx5XyX1sZNH8NJGDmOocbQc/6Bt
         Z96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606561; x=1758211361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6obS77W4gL8mbr6C+eeuSSKKzH7RwZdvT4ZIG8wkffg=;
        b=Ggx/ckt1SqKpzyJNvyZjAO5QDBd6YXOb8JcfBKUQmJhspZ7T468xgGoa6S2JSC6NWK
         XPEsi2efzflqoutaJVI1/6Vd374LAFkgiSpzUpSSHiHdHUGLR3bUYSXQJ7+BlpMHkwpO
         zg9NcIXF1AIJHLmxVxAM5NH0moXY85Sa3dI4lfW7glJEVBTEYZXfmt76NbmYv1kUbd6i
         wLGVQsjUIWyJwXH3O8ExcJ7nQrWHTviTwRlRA9jxdUDNTDwu7ZQjlVqTzxbdWPOpa4oB
         /eRuGsdIo4h6FYSemx8dSYRhrRtJlVGJShmJAPkjGOnniVxUN+rXlv+ztxMSjrbiEfAH
         MnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBh+7BbiLYI2Da6fdOWW5K+oq/mba8ps/2R4x3v+/WBpHedIm3p1gUGTXyTZdXYPba9HfVbVE1F+sC@lists.infradead.org
X-Gm-Message-State: AOJu0YzVY3Ju7TG08jn5hwbru4wH45t+dGqo7ve2cx7qQgfgKdCOcWTe
	OYjwKedh5xe8OvLnhqe4wH1xeCvrZgeiJ+tQmgbRPom/8dBczed/r14V6zza1h2IXAjq3LH/veZ
	2+D+lRDUxngVcFomC/BB6u9aoxh7bnJEJwsEoiOxvFQ==
X-Gm-Gg: ASbGncsH764vyNpU0ordN3+79889ESi8tVHEU4cUr+bLuxbwVu9zPrUbwvzbVPQLLw2
	CYns9d0xptOXF+y/tqYblgLMwu0dZND6mWeVLa5Iv7QKzL7h5OzTabF/sORPLy+60j0SgF+RSFZ
	23jjs01CeAUgd096HOG6zIFiBHC29Cn+hX496CNoQ04tqfYhlMV5WojGitenGqHLL7IbtcCMjB2
	wo8O8wklvAtqTnL/+S7TuHMiWNS9TnVdP93CbR6sXIS25oXmA==
X-Google-Smtp-Source: AGHT+IFBr1IxqXcIUO6bB0xT/+wQnm8xy0aPESUSNVEBROoDUbw28I831Lcf+8PW91sQeC1Tp7s6n5Wn1luV5rDxNOA=
X-Received: by 2002:a17:902:f708:b0:25c:8005:3f04 with SMTP id
 d9443c01a7336-25d217ec277mr163925ad.0.1757606559660; Thu, 11 Sep 2025
 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw> <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
In-Reply-To: <CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Sep 2025 09:02:26 -0700
X-Gm-Features: Ac12FXzfe0LPetqhsRB28hxh2v9SigeWVoVMRD9W7aqYfRcyJIKVJDep7LH3j1c
Message-ID: <CADUfDZo43a2w64umSCeqJyHrsujh2jHFTQADC5kGuX+d27RnVw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better performance
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org, 
	ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com, 
	jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_090242_329502_7A76AD8D 
X-CRM114-Status: GOOD (  19.97  )
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

On Thu, Sep 11, 2025 at 8:50=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Sep 11, 2025 at 12:33=E2=80=AFAM Guan-Chun Wu <409411716@gms.tku.=
edu.tw> wrote:
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
> >  static const char base64_table[65] =3D
> >         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789=
+/";
>
> Does base64_table still need to be NUL-terminated?
>
> >
> > +static inline const char *find_chr(const char *base64_table, char ch)
>
> Don't see a need to pass in base64_table, the function could just
> access the global variable directly.

Never mind, I see the following patches pass in different base64_table valu=
es.

