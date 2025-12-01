Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C574D116F1
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=; b=eSEmtxFkC1UqvK5oDVcP+Vxg8u
	bxlVSr8eUCoo7L20gL3ftYL96fkEEU0GawJZTX3cmQgsugwusvfNgsAcMRPBJ/K2MekAXy3GZBSHC
	evhW/MA7vX6YoSjPLsaPg4jN0mGIRrAchNWDWi69hr2fTzAKdP55E63pJFt/+LH4XvE4xV+eKR/Ci
	nG7NCCVZ2n/kTc7kC9oa+UrrjwFP2KeRmWBt5uckvlKnSN3pJCsBaGPpLAJ9xSfe4sw65zk6A7yLh
	/ojCLdH/3NnbyqrRCPT6U53YT7cvtPtrXK14ff50I0sjeRv5ooHJ9vomle7J1vVNdQFinY3WFAuXS
	iiqOW1Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ1Bw-00000003L4N-24yU;
	Mon, 01 Dec 2025 10:31:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQ1Bs-00000003L31-2UaR
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 10:31:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764585089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
	b=RI0WHlb+agLyrliVXYooJ3jlq5+F+MCLCltlSpEidGtkwcKLquuYGc6+vjXKCHjAZm5nEB
	uoXQ/4SY08EV9SKOZfBB+NsfgPDyUGVEDFgaeUsRbmaiQOeCpW1e+l2QIVnCOAEvrbs+pX
	ZAKunYKzFNzIh6BP/80+OSwgweJx4N0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-0bT5WJ4wOIinQIjRVjFssg-1; Mon, 01 Dec 2025 05:31:29 -0500
X-MC-Unique: 0bT5WJ4wOIinQIjRVjFssg-1
X-Mimecast-MFC-AGG-ID: 0bT5WJ4wOIinQIjRVjFssg_1764585088
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78aa57a8157so53158987b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764585088; x=1765189888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XepCzKXSZv6JjslqxB2za4xngOadSy78tcQeBtMRexk=;
        b=vsOHgu57bvEXLj9mQEKmd+tpo12s/5ORRVmwpYfgyjbHsJQQmwr31MlWBa9pka9LCM
         og0XX3f6aPe1M2pi53CC6Enza9fTDMfjkwxV9DTu+vUkA0Int9g2l1XixiAfiPgxCh84
         giYUzBa2ziaD1E/VMP46zCsUHHFMwfpxjdvSU1lfuxvvUh3sqEE+Awiu/yaNRR+NOKMp
         1EkDHvfTK+hkvgaaNOyT2Au2B1FOi9Qq6fhWTsXa7CViRWFrMzYt8hw3j2fUB4hXO8eN
         JNNO+4TJ7eusHxBF22/ryfbcBR5gmhRFFtch+MIIV4LO5nCsC/qMgY1gEkYsyRU5atvG
         WOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM20DzAIGrbtwLFWqPq0QAAEkVBq3fgDm8FDNmVTzx4n1bpFtKK+o35y9zp8IJ/1LCc9KaURc68K+N@lists.infradead.org
X-Gm-Message-State: AOJu0YyGf99qOoXmUe/jr0Ox0wU+iMWsoskXku2X2fHhFwIBm2LYmi9K
	QwfGjgfhthIMjNCTcGzJIU+yvosPG8bw+1HLmSwTZdJtsjODPj+nAZl3vOj7CEFHOTR0Sg6b2Vk
	kalbInuxixvOd6RNtcy9XaS5b0wBq9tXbEmvsPlgVruGo7PAX8mQzbxct+LkFMe8GaurGfKJ8SU
	aRrEf6XRTBoLWyEnNA05PWsS/M/dYJTzAgZkEkHzmvrrE=
X-Gm-Gg: ASbGncs249YkfG1EBuJuoPuqoHnAsCDwWVIgTFX/I5HMlx7KAwu/D7qSKO4DUkahs2i
	zB2CokkRK27iEXrMRkxq2oIlWs4cs/SM/YNA6nnkeh5SHAb4exL/PmZ1Xw0KPrHlO/JoVwTwivH
	KANGuF14zbwu+c9fHO57SsXWfIp7uSXMcpUjWAW61u/dn/DA52p5MPVRjbdAkoCWwC
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id 00721157ae682-78ab6f19dbemr204012237b3.45.1764585088401;
        Mon, 01 Dec 2025 02:31:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv5zzmMokroNvK6hxRqePUK2sUy1kyOakdwZXoQ77gSpCZtxQfALMHCo45aGmJsVIK/6txSFE4cjS1pCWEh08=
X-Received: by 2002:a05:690c:6f8e:b0:77f:a301:4634 with SMTP id
 00721157ae682-78ab6f19dbemr204012007b3.45.1764585088053; Mon, 01 Dec 2025
 02:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
In-Reply-To: <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 1 Dec 2025 11:31:17 +0100
X-Gm-Features: AWmQ_bnf2BodBLtXxgPiuMZc2dFAC9eikQedB20yLRtD3dfyefefH-ZDvfFzYn8
Message-ID: <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, gruenba@redhat.com, 
	ming.lei@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K6OxSbxeOLXyFMNSrL6Da9-ErIA3pBX602KAFS_X6lA_1764585088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_023132_703304_51765916 
X-CRM114-Status: GOOD (  16.82  )
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

On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gmail.c=
om> wrote:
> zhangshida <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=94 16:33=E5=86=99=E9=81=93=EF=BC=9A
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Replace duplicate bio chaining logic with the common
> > bio_chain_and_submit helper function.
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  fs/gfs2/lops.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> > index 9c8c305a75c..0073fd7c454 100644
> > --- a/fs/gfs2/lops.c
> > +++ b/fs/gfs2/lops.c
> > @@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev,=
 unsigned int nr_iovecs)
> >         new =3D bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_N=
OIO);
> >         bio_clone_blkg_association(new, prev);
> >         new->bi_iter.bi_sector =3D bio_end_sector(prev);
> > -       bio_chain(new, prev);
> > -       submit_bio(prev);
> > +       bio_chain_and_submit(prev, new);
>
> This one should also be dropped because the 'prev' and 'new' are in
> the wrong order.

Ouch. Thanks for pointing this out.

> Thanks,
> Shida
>
> >         return new;
> >  }
> >
> > --
> > 2.34.1
> >
>

Andreas


