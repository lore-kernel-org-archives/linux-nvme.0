Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF4CCA470
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 20:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sZhEGqG5f02SA+cxa1EF4uynlEuBc23Gw/Zg/k7vIsQ=; b=yJUbms7mD5Fr9lhWXr6atjLn9g
	uPDcJhZxxeS6YxVYs/7P7MfFdhYG3OpjjUJRwuWokwA3ubEHDbYhSLKN3jUfYY6lsjJ/YxVbyu9to
	qQaxa8ukuPOHIR0ItWFUc6zvpp3cxwWKnn/M4UPP0HEh/8qxrdezUmu5A85basZSOAwzEkVW1cegA
	luZbc2L8T+KavFw0+FOvHP33s9LVthzHiq+oEfGOtk39AT7BG47FRPoF8ZxFml8DVSLf/ZfDB7k5D
	JKNvuzr6oks5j+OL/lEr5w4XHuK32jDrgK5/UnDotTZ5boNlZHlK28lVbLOsSWD8xrYsLiBrveFkz
	E36Badpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sBv-00000000mNh-24m3;
	Mon, 06 Oct 2025 20:52:19 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5sBs-00000000mNK-21MQ
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 20:52:17 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso35990875e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 06 Oct 2025 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759783934; x=1760388734; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZhEGqG5f02SA+cxa1EF4uynlEuBc23Gw/Zg/k7vIsQ=;
        b=eLbBE+tsx6Nf8QXvUto7yO4I95Ot5LD1cDyRnkg5IqwDs/lD7tmExO/3XVJPOiXudg
         MIdxLvf3lRqfWCme3CNT3XI71+gRmOdTwlviyU7NekCcOMRqBakiT5kCBZDfew9+VpN/
         TDcpj3y8CbhMIMpB8KupJoj16wDKN2fhNmkXnTv9xqSluYJ5+bsBRLHI9rm2IKkvl9fI
         aj4GRiQyvY+FquNlDJ9kRt+CxbsV5k7xBf9Gp9iHCh3lSD5dLf/QnznxG244P2hn38IQ
         dizNZY6UHL2Go1mPMIy4hu1sPPLzz0WzV0Ih2LOIMNUWsSUqkphrt9CtveVugeDZx9Jo
         Bn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759783934; x=1760388734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZhEGqG5f02SA+cxa1EF4uynlEuBc23Gw/Zg/k7vIsQ=;
        b=UHk4o4DGnMbNTDmfMfk0Y4kz82LbSJAV/FuxzsuUk/eRS5vf/b1Va1jTzdircqJtav
         V8rreuVZX219VSjNoYv8iknGUGQ3BHN+g/29VZYl4la4asucpk7R2crqQnYINs1Y28pU
         kFW/q2gy9uZwyC+o0NhwF774GrWwZ7oSrmEOX+Y5L5X6RyIEOsYu5s8Nb2CL8Cm3A15F
         xjgYJGPnNbmQEbZCXcjDfRHC+pcrntvwxmKJeoVDOS1swxNjPJEsrpp+jzSbCTqYjnxz
         vULEdRrUD/2WUYHsVNsVNAj8Y3Gai0u/VKY0KikHwDKPzyWcQxHQ8wXddjXa/MwOiMkg
         9gpw==
X-Forwarded-Encrypted: i=1; AJvYcCVrmEaLv2IAdEFtE8BKT1CYs4foQutD1XBhiHeCqWIJy4gOiwTN46gkvIUPv/zWu/HvhLJQBNy4NOuW@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6o2OyL+XlYmM7g3h8Xssl6PvOT0D3h+7bSY/YsFUNZRQMG5DW
	vqu4MXro6RpOn6d+io3vr2t3HtkK4MHAm9nnqJexq6nCGOknXcgl4gBK
X-Gm-Gg: ASbGnct8yrcB03qvaApv/nzl26KskvqcAw2dhQFgnmOyPqHDOXv84mui6LfLNHwQjXM
	m9Xc7kpr8c4vr+c5uHLHU5wQgEkNHEKQRceT2qiObQ7XR6xNPQ/CoaLzLNvVD2u9LuxMd6Q3Lc7
	QoHxVzvYtT5QjFCGMEI4ujgNU6WXZDgxv8qbNyqXgyvfQirMFe/hi1PstSBAHm7uxyj9NPNXTDs
	P8oVcWpvA7IFiIdUYnegaTEyJMGSnSqGgabcrKUyNB8p/sQUXJnLh4J8kqnFCvHeP71aMZujJDl
	TJjN3n8ES1stEMNExhC8lZm3NLYmqHv7VIwxbBZuaZJNHtdeUzT21g46oBoUEztzRULoymxmz8d
	kZPq5wx803cth6hmjpkWKXIbXHY94iurljK3hV8sbbPiNS/dNm3PzBa2rESF4mO5T/OUJFygYOu
	0HCxgOEt9lzdPxZUVf+DxW48s=
X-Google-Smtp-Source: AGHT+IFRLlb8uWC1dqxKo8J55feiaCNAhabM0Ub7mobnG4dCUMmuEgByLy76YakZhK1VJ6qhsA7FmQ==
X-Received: by 2002:a05:600c:8b6e:b0:46e:3d50:362a with SMTP id 5b1f17b1804b1-46e710ffff6mr85930215e9.4.1759783934211;
        Mon, 06 Oct 2025 13:52:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723624b3sm171254835e9.17.2025.10.06.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:52:13 -0700 (PDT)
Date: Mon, 6 Oct 2025 21:52:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v3 3/6] lib/base64: rework encode/decode for speed and
 stricter validation
Message-ID: <20251006215212.2920d571@pumpkin>
In-Reply-To: <aNz21InCM4Pa93TL@wu-Pro-E500-G6-WS720T>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
	<20250926065617.14361-1-409411716@gms.tku.edu.tw>
	<CADUfDZpu=rK4WwSmhNgxHQd2zeNvn8a7TmKCYuTL5T7dZ0x_4A@mail.gmail.com>
	<aNz21InCM4Pa93TL@wu-Pro-E500-G6-WS720T>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_135216_586937_1AD7BF82 
X-CRM114-Status: GOOD (  44.92  )
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

On Wed, 1 Oct 2025 17:39:32 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> On Tue, Sep 30, 2025 at 05:11:12PM -0700, Caleb Sander Mateos wrote:
> > On Fri, Sep 26, 2025 at 12:01=E2=80=AFAM Guan-Chun Wu <409411716@gms.tk=
u.edu.tw> wrote: =20
> > >
> > > The old base64 implementation relied on a bit-accumulator loop, which=
 was
> > > slow for larger inputs and too permissive in validation. It would acc=
ept
> > > extra '=3D', missing '=3D', or even '=3D' appearing in the middle of =
the input,
> > > allowing malformed strings to pass. This patch reworks the internals =
to
> > > improve performance and enforce stricter validation.
> > >
> > > Changes:
> > >  - Encoder:
> > >    * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
> > >      symbols, avoiding bit-by-bit shifting and reducing loop iteratio=
ns.
> > >    * Handle the final 1-2 leftover bytes explicitly and emit '=3D' on=
ly when
> > >      requested.
> > >  - Decoder:
> > >    * Based on the reverse lookup tables from the previous patch, deco=
de
> > >      input in 4-character groups.
> > >    * Each group is looked up directly, converted into numeric values,=
 and
> > >      combined into 3 output bytes.
> > >    * Explicitly handle padded and unpadded forms:
> > >       - With padding: input length must be a multiple of 4, and '=3D'=
 is
> > >         allowed only in the last two positions. Reject stray or early=
 '=3D'.
> > >       - Without padding: validate tail lengths (2 or 3 chars) and req=
uire
> > >         unused low bits to be zero.
> > >    * Removed the bit-accumulator style loop to reduce loop iterations.
> > >
> > > Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 run=
s,
> > > KUnit):
> > >
> > > Encode:
> > >   64B   ~90ns   -> ~32ns   (~2.8x)
> > >   1KB  ~1332ns  -> ~510ns  (~2.6x)
> > >
> > > Decode:
> > >   64B  ~1530ns  -> ~64ns   (~23.9x)
> > >   1KB ~27726ns  -> ~982ns  (~28.3x)
> > >
> > > Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
> > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > ---
> > >  lib/base64.c | 150 +++++++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 110 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/lib/base64.c b/lib/base64.c
> > > index b20fdf168..fd1db4611 100644
> > > --- a/lib/base64.c
> > > +++ b/lib/base64.c
> > > @@ -93,26 +93,43 @@ static const s8 base64_rev_tables[][256] =3D {
> > >  int base64_encode(const u8 *src, int srclen, char *dst, bool padding=
, enum base64_variant variant)
> > >  {
> > >         u32 ac =3D 0;
> > > -       int bits =3D 0;
> > > -       int i;
> > >         char *cp =3D dst;
> > >         const char *base64_table =3D base64_tables[variant];
> > >
> > > -       for (i =3D 0; i < srclen; i++) {
> > > -               ac =3D (ac << 8) | src[i];
> > > -               bits +=3D 8;
> > > -               do {
> > > -                       bits -=3D 6;
> > > -                       *cp++ =3D base64_table[(ac >> bits) & 0x3f];
> > > -               } while (bits >=3D 6);
> > > -       }
> > > -       if (bits) {
> > > -               *cp++ =3D base64_table[(ac << (6 - bits)) & 0x3f];
> > > -               bits -=3D 6;
> > > +       while (srclen >=3D 3) {
> > > +               ac =3D ((u32)src[0] << 16) |
> > > +                        ((u32)src[1] << 8) |
> > > +                        (u32)src[2];
> > > +
> > > +               *cp++ =3D base64_table[ac >> 18];
> > > +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> > > +               *cp++ =3D base64_table[(ac >> 6) & 0x3f];
> > > +               *cp++ =3D base64_table[ac & 0x3f];
> > > +
> > > +               src +=3D 3;
> > > +               srclen -=3D 3;
> > >         }
> > > -       while (bits < 0) {
> > > -               *cp++ =3D '=3D';
> > > -               bits +=3D 2;
> > > +
> > > +       switch (srclen) {
> > > +       case 2:
> > > +               ac =3D ((u32)src[0] << 16) |
> > > +                    ((u32)src[1] << 8);
> > > +
> > > +               *cp++ =3D base64_table[ac >> 18];
> > > +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> > > +               *cp++ =3D base64_table[(ac >> 6) & 0x3f];
> > > +               if (padding)
> > > +                       *cp++ =3D '=3D';
> > > +               break;
> > > +       case 1:
> > > +               ac =3D ((u32)src[0] << 16);
> > > +               *cp++ =3D base64_table[ac >> 18];
> > > +               *cp++ =3D base64_table[(ac >> 12) & 0x3f];
> > > +               if (padding) {
> > > +                       *cp++ =3D '=3D';
> > > +                       *cp++ =3D '=3D';
> > > +               }
> > > +               break;
> > >         }
> > >         return cp - dst;
> > >  }
> > > @@ -128,39 +145,92 @@ EXPORT_SYMBOL_GPL(base64_encode);
> > >   *
> > >   * Decodes a string using the selected Base64 variant.
> > >   *
> > > - * This implementation hasn't been optimized for performance.
> > > - *
> > >   * Return: the length of the resulting decoded binary data in bytes,
> > >   *        or -1 if the string isn't a valid Base64 string.
> > >   */
> > >  int base64_decode(const char *src, int srclen, u8 *dst, bool padding=
, enum base64_variant variant)
> > >  {
> > > -       u32 ac =3D 0;
> > > -       int bits =3D 0;
> > > -       int i;
> > >         u8 *bp =3D dst;
> > > -       s8 ch;
> > > -
> > > -       for (i =3D 0; i < srclen; i++) {
> > > -               if (src[i] =3D=3D '=3D') {
> > > -                       ac =3D (ac << 6);
> > > -                       bits +=3D 6;
> > > -                       if (bits >=3D 8)
> > > -                               bits -=3D 8;
> > > -                       continue;
> > > -               }
> > > -               ch =3D base64_rev_tables[variant][(u8)src[i]];
> > > -               if (ch =3D=3D -1)
> > > +       s8 input1, input2, input3, input4;
> > > +       u32 val;
> > > +
> > > +       if (srclen =3D=3D 0)
> > > +               return 0; =20
> >=20
> > Doesn't look like this special case is necessary; all the if and while
> > conditions below are false if srclen =3D=3D 0, so the function will just
> > end up returning 0 in that case anyways. It would be nice to avoid
> > this branch, especially as it seems like an uncommon case.
> > =20
>=20
> You're right. I'll remove it. Thanks.
>=20
> > > +
> > > +       /* Validate the input length for padding */
> > > +       if (unlikely(padding && (srclen & 0x03) !=3D 0))
> > > +               return -1;
> > > +
> > > +       while (srclen >=3D 4) {
> > > +               /* Decode the next 4 characters */
> > > +               input1 =3D base64_rev_tables[variant][(u8)src[0]];
> > > +               input2 =3D base64_rev_tables[variant][(u8)src[1]];
> > > +               input3 =3D base64_rev_tables[variant][(u8)src[2]];
> > > +               input4 =3D base64_rev_tables[variant][(u8)src[3]];
> > > +
> > > +               /* Return error if any Base64 character is invalid */
> > > +               if (unlikely(input1 < 0 || input2 < 0 || (!padding &&=
 (input3 < 0 || input4 < 0))))
> > > +                       return -1;
> > > +
> > > +               /* Handle padding */
> > > +               if (unlikely(padding && ((input3 < 0 && input4 >=3D 0=
) ||
> > > +                                        (input3 < 0 && src[2] !=3D '=
=3D') ||
> > > +                                        (input4 < 0 && src[3] !=3D '=
=3D') ||
> > > +                                        (srclen > 4 && (input3 < 0 |=
| input4 < 0))))) =20
> >=20
> > Would be preferable to check and strip the padding (i.e. decrease
> > srclen) before this main loop. That way we could avoid several
> > branches in this hot loop that are only necessary to handle the
> > padding chars.
> >  =20
>=20
> You're right. As long as we check and strip the padding first, the
> behavior with or without padding can be the same, and it could also
> reduce some unnecessary branches. I'll make the change.

As I said earlier.
Calculate 'val' first using signed arithmetic.
If it is non-negative there are three bytes to write.
If negative then check for src[2] and src[3] being '=3D' (etc) before error=
ing out.

That way there is only one check in the normal path.

	David

>=20
> Best regards,
> Guan-Chun
>=20
> > > +                       return -1;
> > > +               val =3D ((u32)input1 << 18) |
> > > +                     ((u32)input2 << 12) |
> > > +                     ((u32)((input3 < 0) ? 0 : input3) << 6) |
> > > +                     (u32)((input4 < 0) ? 0 : input4);
> > > +
> > > +               *bp++ =3D (u8)(val >> 16);
> > > +
> > > +               if (input3 >=3D 0)
> > > +                       *bp++ =3D (u8)(val >> 8);
> > > +               if (input4 >=3D 0)
> > > +                       *bp++ =3D (u8)val;
> > > +
> > > +               src +=3D 4;
> > > +               srclen -=3D 4;
> > > +       }
> > > +
> > > +       /* Handle leftover characters when padding is not used */
> > > +       if (!padding && srclen > 0) {
> > > +               switch (srclen) {
> > > +               case 2:
> > > +                       input1 =3D base64_rev_tables[variant][(u8)src=
[0]];
> > > +                       input2 =3D base64_rev_tables[variant][(u8)src=
[1]];
> > > +                       if (unlikely(input1 < 0 || input2 < 0))
> > > +                               return -1;
> > > +
> > > +                       val =3D ((u32)input1 << 6) | (u32)input2; /* =
12 bits */
> > > +                       if (unlikely(val & 0x0F))
> > > +                               return -1; /* low 4 bits must be zero=
 */
> > > +
> > > +                       *bp++ =3D (u8)(val >> 4);
> > > +                       break;
> > > +               case 3:
> > > +                       input1 =3D base64_rev_tables[variant][(u8)src=
[0]];
> > > +                       input2 =3D base64_rev_tables[variant][(u8)src=
[1]];
> > > +                       input3 =3D base64_rev_tables[variant][(u8)src=
[2]];
> > > +                       if (unlikely(input1 < 0 || input2 < 0 || inpu=
t3 < 0))
> > > +                               return -1;
> > > +
> > > +                       val =3D ((u32)input1 << 12) |
> > > +                             ((u32)input2 << 6) |
> > > +                             (u32)input3; /* 18 bits */
> > > +
> > > +                       if (unlikely(val & 0x03))
> > > +                               return -1; /* low 2 bits must be zero=
 */
> > > +
> > > +                       *bp++ =3D (u8)(val >> 10);
> > > +                       *bp++ =3D (u8)((val >> 2) & 0xFF); =20
> >=20
> > "& 0xFF" is redundant with the cast to u8.
> >=20
> > Best,
> > Caleb
> >  =20
> > > +                       break;
> > > +               default:
> > >                         return -1;
> > > -               ac =3D (ac << 6) | ch;
> > > -               bits +=3D 6;
> > > -               if (bits >=3D 8) {
> > > -                       bits -=3D 8;
> > > -                       *bp++ =3D (u8)(ac >> bits);
> > >                 }
> > >         }
> > > -       if (ac & ((1 << bits) - 1))
> > > -               return -1;
> > > +
> > >         return bp - dst;
> > >  }
> > >  EXPORT_SYMBOL_GPL(base64_decode);
> > > --
> > > 2.34.1
> > >
> > > =20
>=20


