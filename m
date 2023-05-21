Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774F4C77B7C
	for <linux-nvme@archiver.kernel.org>; Sun, 21 May 2023 02:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5IUiSXXxlQHTTzonhOLUhW81XkUzv51nXMb8DadsjY=; b=rT8iwEg0qhNKsg4qnwgizoa70p
	+dIL9dq21OzkhJccQBe1fOoo4isWUlTf4vzR4xehWUdmCZC55wkqb2ajFLFzR3+w5aZAgjMwEbZsK
	zX9fwN2MskvhuN0LigdcAI7CUEaBTCBWKyQ3ArjnwFOxswPZGJ7jGl0CoAdWgFd6vkoDfw/PhaSGF
	Ka8VGHRTC35RPh06IHxgg83yEjPuNRqlI8Z5qm2ObqRAg/mOl+XfZ1QC8l6351kcOR5XShkd4aXik
	EFmBC+EyLZiFsE+yR0VeZKQ/Tr3siM+oP8/aNDOs+gF2vSU1mGLZa8Uijg9yJeHrHoqsCLHiCM922
	mBFUrOXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Yvr-002rGK-0N;
	Sun, 21 May 2023 02:36:27 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Yvo-002rFW-2N
	for linux-nvme@lists.infradead.org;
	Sun, 21 May 2023 02:36:25 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so3179041a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 20 May 2023 19:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684636582; x=1687228582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5IUiSXXxlQHTTzonhOLUhW81XkUzv51nXMb8DadsjY=;
        b=TaYlIaDKgoSxrIYLchGLlxsvM3Q0ZMblINw8TlbEJ54h1NWJKuBQIPke0o8CPgOtR5
         3BOMWaW8r5zeHKQcM6C95WO/TpmJuK0Xa3DXlQEihrt3HjZysMkEwcdHLs1WCk8hirWR
         OAhOBHsRK5niEl32EE6CFfVs+ebkcitNFU5zC8DFvQSbNVvdNMeMkqcurFwe5+dVaEce
         1ed5dWLDeKr+fVor7AwRncKbH1WYTDed3Kai9zqg0KXWraf/RMtuuRdNs+Jll2HanLc9
         0l4BWNOEiyXpZvJjujWxNPpOwbMeciPeBSiupSUq4rAnStKXGHGvJ2tbgYDJkpH7ASCn
         js3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684636582; x=1687228582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5IUiSXXxlQHTTzonhOLUhW81XkUzv51nXMb8DadsjY=;
        b=lL9CjxgSyJ7X0HoRZzqVJJfKPHFZU4+lXeThn0O6xfrmIMtJQvPXXxsoAITi1jiegd
         7mObCH96lU2EZ/SD7Zk3C11/BAtQcqqAE5Ekhx+gDZHHHKxxq0pFKZsRprF6WSz8h4V7
         8b3zYk8ml+9j4nSgUrACB7aoebyX4t4Jufe62ATsnNfkP3c4K7AgqVW3AJ++i3BjyqIn
         BZGK5AXPDDKTW5PDky65YhgUuOvtwkYombR29L+JQpCeXNtQDOEAtVy+KfX5arKQFgd7
         ohUPnXWBag3nXaRnG/Unxmk3HVeKp9jY8ghDbBk2j9nSbRJijnUE/IkjYwHiSPTjwshy
         YUSg==
X-Gm-Message-State: AC+VfDyb8fhQaOWCxJdXP6ba4UaDWqd3IS/nCtBNWiCbmOtZ5nxKagiA
	SVKcJ9rFn9hEm+o/0lZO15nbJvmSOFmaUHy1zRY=
X-Google-Smtp-Source: ACHHUZ7B2Uosl1nUxd//NqXNoM/Sb/LTJVBzL1DxAd2nqWFYCf8aOTz05ZROPIpWKkXOLcaoTjRnuUA/O++SDtqdMW4=
X-Received: by 2002:a17:902:d503:b0:1ac:a661:a4c9 with SMTP id
 b3-20020a170902d50300b001aca661a4c9mr8617244plg.33.1684636582562; Sat, 20 May
 2023 19:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230521000236.100402-1-irvincoteg@gmail.com> <d49afbae-4ce9-5c6f-a1ad-d07f14f2f2b7@kernel.dk>
In-Reply-To: <d49afbae-4ce9-5c6f-a1ad-d07f14f2f2b7@kernel.dk>
From: irvin cote <irvincoteg@gmail.com>
Date: Sat, 20 May 2023 23:36:11 -0300
Message-ID: <CALL+9eiXj1b2+8m1G0zy8=SMHD8-6NJdxNuEJ=K+ktixmfPXRA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci : redundancies in nvme_alloc_queue and nvme_init_queue
To: Jens Axboe <axboe@kernel.dk>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230520_193624_797320_32F6E73E 
X-CRM114-Status: GOOD (  17.27  )
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

Hi, I am really confused I had written one and apparently it didn't go
through, my apologies.
I will resend it

On Sat, 20 May 2023 at 22:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/20/23 6:02=E2=80=AFPM, Irvin Cote wrote:
> > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > ---
> >  drivers/nvme/host/pci.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 32244582fdb0..49ae26980a0f 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -1533,9 +1533,6 @@ static int nvme_alloc_queue(struct nvme_dev *dev,=
 int qid, int depth)
> >       nvmeq->dev =3D dev;
> >       spin_lock_init(&nvmeq->sq_lock);
> >       spin_lock_init(&nvmeq->cq_poll_lock);
> > -     nvmeq->cq_head =3D 0;
> > -     nvmeq->cq_phase =3D 1;
> > -     nvmeq->q_db =3D &dev->dbs[qid * 2 * dev->db_stride];
> >       nvmeq->qid =3D qid;
> >       dev->ctrl.queue_count++;
>
> Please put an actual commit message in here, any commit should have
> an explanation of WHY the change is being made. Your subject line
> is NOT enough, detail exactly why this is redundant.
>
> From a quick look the patch does look fine, but I'm not going to
> ack a patch that doesn't have a good commit message.
>
> --
> Jens Axboe
>
>

