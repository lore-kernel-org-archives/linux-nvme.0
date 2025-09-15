Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7527CAC593
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=09G9j06MNZe+y/tjN1dT5p6DESHL0gAogtQXwPWBuqc=; b=qy5zHVIMFAhrv3i3E1VufjHIf8
	H8TCKjO2YjnpKtPq9SE/S8nTzBuf2afRbZOr0WH8zcnma13kSWyR5pwlQplKzZNyhESGfYzIBI5GI
	87Vhqnp/VU3kSCfZxMvcnZ/F3J2+JfFPh1pgHlI7aGatEuh+QXq+ccmM9Fz0SE9SWF6AnZwvB6eW9
	8O+TRwjQRMh6qP7pjjTHTwOaRUtQwS/qQ99FzPqbzZvMlNYKCbcvEbLn7MDH4ID3QyNwDCFZnVlhb
	FWiF61egvDFu6is3+iIoTLab+5+BFQ4bDghc21K1kZd/pvNcuDe3xnurFgguwsle5sNMZ49trkdcn
	iHsuzliQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6yZ-00000003pJG-0ITX;
	Mon, 15 Sep 2025 11:02:27 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy6yW-00000003pHb-3VB4
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 11:02:25 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso29043645e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 15 Sep 2025 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757934143; x=1758538943; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09G9j06MNZe+y/tjN1dT5p6DESHL0gAogtQXwPWBuqc=;
        b=bpBB/Jb69V/4QqnRUtWaTLBhX7aWDbqIPIUtIkrpqkuJ6J2JMducGMXdvnUpNjC/XX
         gcK0qFM/ga2F+zRNEIHo6AwYvZxn3lvLviKVq0uBDqaYNG/KBBbtEbqxT2O8sBBhWMoW
         XqHE53F237n9WEjy3Y7/w73RaivkvJ2DO+y3zVHTS67laWx4aGvKk8nenPa1KbhZH8Y2
         tk80lhshVi3D3Ls7q1Tb6xIdTwFRwMWryD7dNWsy0vabye1T1llAltZtqpD71wwft4fi
         ygdHP44k783x5vsTkA6Z3ycBQHrqVp5ot/NmiIA84KEGsacuWMY76D4F/riGYnlhY7B2
         QkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934143; x=1758538943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09G9j06MNZe+y/tjN1dT5p6DESHL0gAogtQXwPWBuqc=;
        b=aNWoqU0925wK9qN+y2UIc2yhqfrnVt69nFGfdu5riEA7bCf7nrAlD566MopaZ1YGOe
         n2nGUooh9ICb3ZCu//rbbTmwgqPpe5vs4AaNuo3VqI0SrAaVxbNO1KRaf14nA4q4ZV5w
         eWO7S29B40Xa5hbJwI6YvYTBysoxB9hEG0DZjA95OV2B4FcQBxBF7+IABde7rOYN//aS
         AXxhKheSwQ2cMvwHnd9ftOl3NeYY1W4Wn069ZKzJUZRS5I0ygZaHYnP7sBXWgj9gk0bg
         jZVQAeY3kb9f2tdUPHuUhpObWbboiynVPA0OJvaVCe77NAR7rpf2lAWlgiswIcMzbPKi
         RxBg==
X-Forwarded-Encrypted: i=1; AJvYcCWBwWprxBRIhfwG0ET2ZnCwy3/LyltIzjBGT9KMw4UbXEbwbCRYLY2aaaEkAlM2+BXMKNIRA9bGSpah@lists.infradead.org
X-Gm-Message-State: AOJu0YywZ80QKGsA0P5q/ZrwA66qkleG2RNUosOVO/qUrs4xtgPVr6mj
	WViSGULdmp5iZmTt8u6ysyW9SjTPkByUdqqxJiqtww/kKb1Mx0KiS3vR
X-Gm-Gg: ASbGncs62HRLRftuEpz3xtTYQEfv3DNQeZYa96PL+eeU8wOkTP/m4HoWXkZ3r69BkGd
	Pi+enWwXK1hkzUsyj++MWp43fo4i8pZ2/aYMfcGQuDxKGQkj5xXqcug51EKjAwErVUH2es6tVqc
	HL1SYDNndPWy/tUMCf16NQdOZb7RYqkgwIxn3fUtR0EyphOUFmLQejp4wpxpaAoO6PRaG0H3vao
	i2Rrit33mOCM+KOZOGkVXUg5bNPMynBh0w9wa5lwlsID2x5goDgvi+YOqiT9Z1V7SbDxo8mElXl
	M9/p0CslqXWO3KMYhEn+DyWJeNhei53PchzJ5Y/g8fl9BjX418jt/CZisdOCIkwlogC1laFZF37
	qlHpTelyKHRuko9cjE8vR43vMZvTgrjcligb5YkARCrWbJh9nfWYEhAfLwZT5
X-Google-Smtp-Source: AGHT+IEGWi7WSzkVoFDGqX2MXPtsSn7cc9zia88pj05NLpV/q+zlVJHp4+lOIa9wC9pExz4PmhCy3A==
X-Received: by 2002:a05:600c:58c1:b0:45d:e0d8:a0bb with SMTP id 5b1f17b1804b1-45f21214d99mr76359545e9.23.1757934142746;
        Mon, 15 Sep 2025 04:02:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e900d8f0e9sm8457904f8f.35.2025.09.15.04.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:02:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:02:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250915120220.6bab7941@pumpkin>
In-Reply-To: <aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
	<20250911073204.574742-1-409411716@gms.tku.edu.tw>
	<CADUfDZqe2x+xaqs6M_BZm3nR=Ahu-quKbFNmKCv2QFb39qAYXg@mail.gmail.com>
	<aML4FLHPvjELZR4W@visitorckw-System-Product-Name>
	<aML6/BuXLf4s/XYX@visitorckw-System-Product-Name>
	<20250914211243.74bdee2a@pumpkin>
	<aMfFOoQIIdMkVdYl@visitorckw-System-Product-Name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_040224_898604_2005F06F 
X-CRM114-Status: GOOD (  32.86  )
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

On Mon, 15 Sep 2025 15:50:18 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> On Sun, Sep 14, 2025 at 09:12:43PM +0100, David Laight wrote:
> > On Fri, 12 Sep 2025 00:38:20 +0800
> > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> > 
> > ...   
> > > Or I just realized that since different base64 tables only differ in the
> > > last two characters, we could allocate a 256 entry reverse table inside
> > > the base64 function and set the mapping for those two characters. That
> > > way, users wouldn't need to pass in a reverse table. The downside is that
> > > this would significantly increase the function's stack size.  
> > 
> > How many different variants are there?  
> 
> Currently there are 3 variants:
> RFC 4648 (standard), RFC 4648 (base64url), and RFC 3501.
> They use "+/", "-_", and "+," respectively for the last two characters.

So always decoding "+-" to 62 and "/_," to 63 would just miss a few error
cases - which may not matter.

> 
> > IIRC there are only are two common ones.
> > (and it might not matter is the decoder accepted both sets since I'm
> > pretty sure the issue is that '/' can't be used because it has already
> > been treated as a separator.)
> > 
> > Since the code only has to handle in-kernel users - which presumably
> > use a fixed table for each call site, they only need to pass in
> > an identifier for the table.
> > That would mean they can use the same identifier for encode and decode,
> > and the tables themselves wouldn't be replicated and would be part of
> > the implementation.
> >   
> So maybe we can define an enum in the header like this:
> 
> enum base64_variant {
>     BASE64_STD,       /* RFC 4648 (standard) */ 
>     BASE64_URLSAFE,   /* RFC 4648 (base64url) */ 
>     BASE64_IMAP,      /* RFC 3501 */ 
> };
> 
> Then the enum value can be passed as a parameter to base64_encode/decode,
> and in base64.c we can define the tables and reverse tables like this:
> 
> static const char base64_tables[][64] = {
>     [BASE64_STD] = "ABC...+/",
>     [BASE64_URLSAFE] = "ABC...-_",
>     [BASE64_IMAP] = "ABC...+,",
> };
> 
> What do you think about this approach?

That is the sort of thing I was thinking about.

It even lets you change the implementation without changing the callers.
For instance BASE64_STD could actually be a pointer to an incomplete
struct that contains the lookup tables.

Initialising the decode table is going to be a PITA.
You probably want 'signed char' with -1 for the invalid characters.
Then if any of the four characters for a 24bit output are invalid
the 24bit value will be negative.

	David

> 
> Regards,
> Kuan-Wei
> 


