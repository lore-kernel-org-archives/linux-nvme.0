Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8F1C3600C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7oUlXQTE4USpfOU4bhU00bGxcL8wzVl02D95/iuVNsI=; b=ruNKoSM/mNPc+yS31csbgiSkL3
	20b4puvds2l+bUvJpZa8swft3PVSvtt+f1pSMtRIOOiwYMOnzNs0EO8YtZAcUhGPte2TGZ4E4qOvz
	RrtQu5vGnhN1WZww9NV8MHUN5WJLhuvwaAWDrr1vPUBUYnELgA6Xq1Xk/jnSRbEvp8cLMmxABVnZw
	VbjENLL8XwdJw7JTXX+WZ9/9+BaxywdaXpGeDAgWnr3Fz+p5TLDcZBteSBFkLB0f1Lx8Vc7g8BAWq
	BSjTDawwKJ21lkPmXfuYKcPaJ4WaJ+nXu00IJ9UzJB1XZ9LrujyZbVDJBRqvGP9YVN/noyzkTQbwy
	fMD1Q4QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txzlh-0000000CQZp-3pET;
	Fri, 28 Mar 2025 02:48:25 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txzlf-0000000CQZC-3W88
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 02:48:25 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so351427a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Mar 2025 19:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743130103; x=1743734903; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oUlXQTE4USpfOU4bhU00bGxcL8wzVl02D95/iuVNsI=;
        b=gOtKTYLvs2CjiQ8Jyky2zjC3wLJCwQEcDysuVSeKVqKKtsZR656DYwztwd0pu05ZOF
         jCNbOjxYEkJCe9Pw89DfOKO/FbSAdnchOyAT9FdvZj4nBUoFQ8sTo2Uwq2diQ1exnMaN
         byH7VQX6IighrcjDwyVQOw0X1I9Kpatana1zy6XWZ6gfJK6ejNpH9bhq+1lSQtWBraaQ
         DNJcRtI5YX9IOTNnNPWI798wEutgwypkJko1ym6hIYo4eNs4Kr0PYmfXazImN8diOLi1
         Jci4iORFXoJPT3sgU1D/kygjUmSi+96mc3iMsEgcikGqUDnXe2b9QusHZSlgv0RDN6ye
         NWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743130103; x=1743734903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oUlXQTE4USpfOU4bhU00bGxcL8wzVl02D95/iuVNsI=;
        b=Z9PNfDunpYqS4x7MFYTP+SCQ4p4vUhxzobZl27Ix0ZPfQ5TgTimf+Du3UN7kI9nqQa
         xOAzyKlrNcWvGv3PTZ9XOcOIUY1vHcfXiVvfo8AHw1CYCPXDiwTWpRTJQmAzutXReBq0
         thvJUkNQa/bBloZc/z7+/hMxCt9T0sVwYrlxNSz0GiMTyFVxsNjmCU4PQxeRwWp/aYiC
         D6xfSuuflrkxfWqtCfTw+VHG/TJxSJaxtyijOao2lvSombnvFtG0TU82ldaIB7+i5V16
         5cEMBAubiHSUNyvnHJ+ewnZF0XGIWHpMiMvAtHh+5bcCe51Xda8T9CuLohnIRBaNCfOS
         DWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoXq9m+bPamJnRNz+bNYfsXHpS3hrd8GLtsHe6S9DznkGO0U6LR83JgCeQtpqFl06EyzSE7BLjzL+d@lists.infradead.org
X-Gm-Message-State: AOJu0YwLhMGdkRbeJ1mQtIFPpWLRLLdCfrUG3gFtmJEkrjxD7Truh3W8
	E8ozvmUy+lvCK823npHbKYXHO08gq4zFunNvHuUeKp+8a4TrfFGcJ/zNhBmbk9dFL+Meuu5ZLNj
	Xx1LUU7XJWTEIg9No5YTS90SU9WFeQd6N9cwHRg==
X-Gm-Gg: ASbGncv7ijCaBe3rxnHLNSPXGDVO3QaWBkUfPApoh17rqh8IAAZYe1rhYI7HQ/+3+PT
	drBzMY0xbmnnKRLacG7PibJoD5jVJkQOD47y8u85QctHwyJbGp4YcWwvnzQwGlLk0LMb2Nm5dVO
	59NIactzSo9l3QH0L3DKCtM+Yi
X-Google-Smtp-Source: AGHT+IH5+njc/B9zdYdMwIxhAZN2UDtU62BqIvQxdf8FL37O1ElaoBnGJuHjBhevSMlUpnHeDnICzSch78C6MeU5HDw=
X-Received: by 2002:a17:90b:4d07:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-303b1dba5e1mr2943196a91.0.1743130102743; Thu, 27 Mar 2025
 19:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250321205722.3947901-1-csander@purestorage.com>
 <20250321205722.3947901-3-csander@purestorage.com> <20250327104232.GB10068@lst.de>
In-Reply-To: <20250327104232.GB10068@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 27 Mar 2025 19:48:11 -0700
X-Gm-Features: AQ5f1JracAj1NqSM2tKPDpP46TcYNxt437uXCSHVplEHIBbua7GDryFHdYertZc
Message-ID: <CADUfDZrqrAQzcf14B1ZxJoxVWOg2giXNCop18WG=62eMEHO7Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] nvme/ioctl: don't call blk_mq_free_request() in nvme_map_user_request()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_194823_875289_2BC2C896 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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

On Thu, Mar 27, 2025 at 3:42=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Mar 21, 2025 at 02:57:21PM -0600, Caleb Sander Mateos wrote:
> >       ret =3D nvme_execute_rq(req, false);
> >       if (result)
> >               *result =3D le64_to_cpu(nvme_req(req)->result.u64);
> >       if (bio)
> >               blk_rq_unmap_user(bio);
> > -     blk_mq_free_request(req);
> >
> >       if (effects)
> >               nvme_passthru_end(ctrl, ns, effects, cmd, ret);
> >
> > +out_free_req:
> > +     blk_mq_free_request(req);
>
> We'll want the request freed before nvme_passthru_end here to avoid
> deadlocks with namespaces scanning.

Good point, I'll send out a v4.

Thanks,
Caleb

