Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F06D3B9AC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1SSHykmofa5yR6Vyw9fXrh2uc6s5eUP4tdQH2TzvHr4=; b=B1x+woC7ElrOeqBKV+atmWTNK3
	Pn8hv87ZK69OL1mn9kY/WPw+NlmwX4dAsmhpW2v5ebbPjr+B2V4w523aG9PSFxJAk2hBNfRVN2bL2
	EE1LZIODfYJ1bU8vv3medt85GUqJUb3viERGUzaNrCnknCZmLiAQ2NWf3b7ztJNxtjlipfHOgFkST
	6CrFvDOv3SOFRh0bKLhMh3GCa5NZLkkPrB3ySZmQDnO76s4R5WwKeOyfnmelXiL9Mu6DL3fFWRa0A
	Fxu2uZ1y5WW7/VCcN6THDzEvdUd9yJXoOheYIpzgsiaredqfUTe8tIHg3sXujUXEneVBESztnUHAp
	qOOegHAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFyMv-0000000B9SC-2Et1;
	Tue, 26 Nov 2024 16:24:53 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFyMY-0000000B9OG-1Wqd
	for linux-nvme@lists.infradead.org;
	Tue, 26 Nov 2024 16:24:31 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso7440473a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 Nov 2024 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732638268; x=1733243068; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SSHykmofa5yR6Vyw9fXrh2uc6s5eUP4tdQH2TzvHr4=;
        b=L39YypIP4ym0GdYpu9JCChpZgtAkTrkFZVZ4tovEUSNSLKF3aJynrKlGyw2vGk0jc2
         PvCc2cJCgzv8ecKnHIbGeqYAD036+ugGLdGyanui4ZFdpHDYYMQ7aPB1qN9dHOVrlkKR
         n5hBtHo3qRMtIUMVjB8q1dForejq5XisVk4hiwX0Nf5nF3am5bzvj6WolE79bTe6DoN4
         jZwLlH6eVnx4eQX0n4cg7PGltdKXc4a6g9hnmZSVvJgTO4FMngeVWZiEGQuU8j0NlJ2k
         0AeOIFi4Ax9nTvvhgnaW8lCo6yjTFJxadsHzss02mOlxdydToLlfcinprENJWqZ88AXP
         jXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638268; x=1733243068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SSHykmofa5yR6Vyw9fXrh2uc6s5eUP4tdQH2TzvHr4=;
        b=k/SBuJuiK/3dB9rIQ5U5J9Cf1CxNdLrYz3eubWvy0FhtNKLxjfUeJXHqCMW7slWcuE
         TgMC38n72B1KaIsphMwTpH4SEoowUa1Sd33Zdlz5aHcIyCiPnpC79CXuoKrGlAAjq/Zu
         Vki7RDkMp5ne4g8YTFShcxYjGh8WIZi1mtP/e7ljImVkEeidzsQ/r0Bg3qypVnAKjwev
         GX3rc6RWJl6KzqK36K5u53VeguoaY8YdfYyNxhyd3Ck/2RZT2WmdrnZC+9nMASZ9i0DZ
         oVXsjOXtNF8PhLFZUtvQbX/Yc2voICTpggS8cmA7g/0j+Oa2zzDb70+4nCYJwtcUksn/
         7Yrw==
X-Forwarded-Encrypted: i=1; AJvYcCWCAHb0RXeDcLVPQB5kipoV4VlJDiWczf3w7MffKwCVOAhj06+qMJuel3B530PUNL1sIaeqKxcz8ITn@lists.infradead.org
X-Gm-Message-State: AOJu0YzY8NVsppRVWqtMpB9tBNxMUJIc9nJR1Tvj/Ks9MXZyckzIWgem
	SEcuj9McW8WEgCrh3WgleI6mIA6orLiXGMYXoCmwe0tk9OJxxsHUl1jO5z/h3mbHcaXaNkd/NBW
	pYjcq5cnJcDf2nYdWGLYq2RXdQA==
X-Gm-Gg: ASbGncseTm6fh0boGRAIutjojOYuhA/A17PIktNFDRdwjUzePeFEOubUKabda4/Vm4B
	C2EYRMmAMVUcRkwPcSoQX7iZQmSAP/mVkBdOOCUQkZI3EQVu17JkCyGQO+OLkpw==
X-Google-Smtp-Source: AGHT+IEh+egU5r+E38GEVvMrAItGqOuNyV0IAyzdCyASKTwVbSpUev9AcXCnHID80AFjxWCtKJHJF+gu99Vy1r/Grt0=
X-Received: by 2002:a17:906:d511:b0:a9a:1437:3175 with SMTP id
 a640c23a62f3a-aa509d6c7cfmr1244797866b.51.1732638267654; Tue, 26 Nov 2024
 08:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20241125070633.8042-1-anuj20.g@samsung.com> <CGME20241125071502epcas5p46c373574219a958b565f20732797893f@epcas5p4.samsung.com>
 <20241125070633.8042-7-anuj20.g@samsung.com> <2cbbe4eb-6969-499e-87b5-02d19f53258f@gmail.com>
 <20241126135423.GB22537@green245> <a9d500a4-2609-4dd6-a687-713ae1472a88@gmail.com>
In-Reply-To: <a9d500a4-2609-4dd6-a687-713ae1472a88@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Tue, 26 Nov 2024 21:53:50 +0530
Message-ID: <CACzX3AtBc-Vio1H28MM2tRvcLzTYBTFJt8CKgF5NeGTniKFUbQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/10] io_uring: introduce attributes for read/write
 and PI support
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	martin.petersen@oracle.com, brauner@kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com, 
	linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_082430_400909_6A137978 
X-CRM114-Status: GOOD (  25.83  )
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

On Tue, Nov 26, 2024 at 9:14=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 11/26/24 13:54, Anuj Gupta wrote:
> > On Tue, Nov 26, 2024 at 01:01:03PM +0000, Pavel Begunkov wrote:
> >> On 11/25/24 07:06, Anuj Gupta wrote:
> >> ...
> >>> +   /* type specific struct here */
> >>> +   struct io_uring_attr_pi pi;
> >>> +};
> >>
> >> This also looks PI specific but with a generic name. Or are
> >> attribute structures are supposed to be unionised?
> >
> > Yes, attribute structures would be unionised here. This is done so that
> > "attr_type" always remains at the top. When there are multiple attribut=
es
> > this structure would look something like this:
> >
> > /* attribute information along with type */
> > struct io_uring_attr {
> >       enum io_uring_attr_type attr_type;
> >       /* type specific struct here */
> >       union {
> >               struct io_uring_attr_pi pi;
> >               struct io_uring_attr_x  x;
> >               struct io_uring_attr_y  y;
> >       };
> > };
> >
> > And then on the application side for sending attribute x, one would do:
> >
> > io_uring_attr attr;
> > attr.type =3D TYPE_X;
> > prepare_attr(&attr.x);
>
> Hmm, I have doubts it's going to work well because the union
> members have different sizes. Adding a new type could grow
> struct io_uring_attr, which is already bad for uapi. And it
> can't be stacked:
>
> io_uring_attr attrs[2] =3D {..., ...}
> sqe->attr_ptr =3D &attrs;
> ...
>
> This example would be incorrect. Even if it's just one attribute
> the user would be wasting space on stack. The only use for it I
> see is having ephemeral pointers during parsing, ala
>
> void parse(voud *attributes, offset) {
>         struct io_uring_attr *attr =3D attributes + offset;
>
>         if (attr->type =3D=3D PI) {
>                 process_pi(&attr->pi);
>                 // or potentially fill_pi() in userspace
>         }
> }
>
> But I don't think it's worth it. I'd say, if you're leaving
> the structure, let's rename it to struct io_uring_attr_type_pi
> or something similar. We can always add a new one later, it
> doesn't change the ABI.
>

In that case I can just drop the io_uring_attr_pi structure then. We can
keep the mask version where we won't need the type and attributes would go
in the array in order of their types as you suggested here [1]. Does that
sound fine?

[1] https://lore.kernel.org/io-uring/37ba07f6-27a5-45bc-86c4-df9c63908ef9@g=
mail.com/

