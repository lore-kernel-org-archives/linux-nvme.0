Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21604C6FD1D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kW0nhN+MJjduSbj2eCKtTmFxk2OT8HS0PznhYbGtPTM=; b=ij0a3ED0EdS9YUKQRICWq1sL8x
	NsyqGEz8Byn00K/kjLvZDn6FlNn8uB7g1tWNDChrRLVRnz54E2W9d0ks22rsn4IfyrGpbaIEIrHWi
	LmDBnIE3nt0UIkyjPBLVLhyftepPiCjCOgjtRGDAGsbNW1i2GdglzL0WIK0pJVEmR3Kw1e6ekE00K
	MgRdq9DfJBIQTJfSP8+f933gP+3gxrCthnvk13LV7BOKbvJ6GdSqW3ut9Rnt4lfzZTNPZFENUQBoG
	iT0VWfIM2K13PaNzKSbqrCUI6kJ2xs/MSfOOBAMQlxdmHa9/hMTP/kudQZEbK3KVZ9T6JBU618QZT
	hRfSMf4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgqX0-00Bslk-31;
	Mon, 27 Mar 2023 17:21:18 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgqWx-00Bskb-1j
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 17:21:17 +0000
Received: by mail-wr1-x434.google.com with SMTP id d17so9561663wrb.11
        for <linux-nvme@lists.infradead.org>; Mon, 27 Mar 2023 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679937671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW0nhN+MJjduSbj2eCKtTmFxk2OT8HS0PznhYbGtPTM=;
        b=jMycVUhHVftLtI83DVEutydlCn4Rnjy9Zw94fQ3pLh9v4gAJGWCoGi4SGiGmIwFKXk
         AILHsKgI4wZpR6OhN0kyNPL0nOGjZbIDSNFS8OIeHC/aB7fX4HelVmX9mhMnQOUr1ZoH
         3fgKsevg5QltWFRp2UeUU/YJpQxPVoNigZM66A4gNYoAMkspuiM+txRy/CqBOxe/MXVl
         BqbQ04AFVWwnKWnlqAbGme2wjb5oJbZyH6BgJgCqgVosWWM/G+/xEY32T4NUfeYW6eSC
         NRUcwrq+s1euMyOcgH4sdLjptVFLZxrhIWJEd9o/UvHTuVO+cAjN5qsK/1il92lFeHLl
         gmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW0nhN+MJjduSbj2eCKtTmFxk2OT8HS0PznhYbGtPTM=;
        b=Nr2MIh/skvC71Gcy6TuRIviwQvHVSUTzFFp3vBN4y7iom+Zdo30URoeftYvPvSYSOP
         583g2p8ytfcyxVJTfsBjsicNAM/qPldRixVBEZ/eLT3ivICEK3frNfJHiR7IBaFnQ8Ey
         g6qJp61lKKdbzjFJF8pOy4YHG5lGsOX3e5WremtLYuCtm1kOo/NGIXRYXE+9ppPYi13S
         4xM+RMZojpaiivyQD9b2I1wY4IB/WCprXRfu/wb0jhzy42cDO0l5XcKU7t49B4YyudyT
         GL3QSDwxgk76jJEy2BRScxmcHBfevx6LAnPL69qSNNSV0fY8ANag+SaCm40hKQK4t0B8
         lnKw==
X-Gm-Message-State: AAQBX9fmAEZn/7I+QMI8yUgZRh+BkbfYHzAbsDiuPJkdNBQbGYciJFPO
	zq8zq2dHYfrFY6NVwx8aVS6TtPkX5IIgIfUGplA=
X-Google-Smtp-Source: AKy350a4utJV1mHAd+//ciS/7jPRA+GMjsq8cxwf+CqIVJ08XiMWLibsFdiv8E24YJJYOsY0uLVUfAu06bJvj7678E4=
X-Received: by 2002:a5d:5691:0:b0:2cf:efad:9c23 with SMTP id
 f17-20020a5d5691000000b002cfefad9c23mr2029558wrv.14.1679937671209; Mon, 27
 Mar 2023 10:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230324212803.1837554-1-kbusch@meta.com> <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
 <20230324212803.1837554-2-kbusch@meta.com> <20230327135810.GA8405@green5> <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZCG0O6RdlA/sUd7C@kbusch-mbp.dhcp.thefacebook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 27 Mar 2023 22:50:47 +0530
Message-ID: <CA+1E3rK2h9gyy26v1NmwTFtUsCwMkc1DgkDsCFME+HjZJPn5Hg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_102115_595705_F0D8C412 
X-CRM114-Status: GOOD (  17.78  )
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

On Mon, Mar 27, 2023 at 8:59=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Mar 27, 2023 at 07:28:10PM +0530, Kanchan Joshi wrote:
> > > -   }
> > > +   if (blk_rq_is_poll(req))
> > > +           WRITE_ONCE(ioucmd->cookie, req);
> >
> > blk_rq_is_poll(req) warns for null "req->bio" and returns false if that
> > is the case. That defeats one of the purpose of the series i.e. poll on
> > no-payload commands such as flush/write-zeroes.
>
> Sorry, I'm sending out various patches piecemeal. This patch here depends=
 on
> this one sent out earlier:
>
>   https://lore.kernel.org/linux-block/3f670ca7-908d-db55-3da1-4090f116005=
d@nvidia.com/T/#mbc6174ce3f9dbae38ae2ca646518be4bf105f6e4

That clears it up, thanks.

> > >     rcu_read_lock();
> > > -   bio =3D READ_ONCE(ioucmd->cookie);
> > > -   ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
> > > -                   struct nvme_ns, cdev);
> > > -   q =3D ns->queue;
> > > -   if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_=
bdev)
> > > -           ret =3D bio_poll(bio, iob, poll_flags);
> > > +   req =3D READ_ONCE(ioucmd->cookie);
> > > +   if (req) {
> >
> > This is risky. We are not sure if the cookie is actually "req" at this
> > moment.
>
> What else could it be? It's either a real request from a polled hctx tag,=
 or
> NULL at this point.

It can also be a function pointer that gets assigned on irq-driven completi=
on.
See the "struct io_uring_cmd" - we are tight on cacheline, so cookie
and task_work_cb share the storage.

> It's safe to check the cookie like this and rely on its contents.
Hence not safe. Please try running this without poll-queues (at nvme
level), you'll see failures.

