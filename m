Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22663C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XjdOGRorC0nLuKT+vnf4KghH4qK564bOF026m1uq2LM=; b=Ymw4NZv7jAd6reIddKonohqZcv
	JBAoP9FSBG5AriZ71Y1uej7APjCqIeqmcSr02Kreh+w4f1ms1ppGcJcU+EYvjP5z7Gew6elleneM7
	E0yKb/n25zbdqMGk1298vBe4zYOj6PFghYJyFxA6ZB9tG0QAXj0qUwN3/XcffPHtDIRbFCTGMKhO9
	MsilLm70t1Be37w1FooFNGk65TU8ct72BsGTSIG3/AwdcHsTk8gtyPdb8wWTk6qp+RZUNmpGuZDxa
	8DqsXxyqxWwJ6cg9ABCXSnYXeRcJ34p5kcy5ZtIwk9AUpHv8ggq4h7eKZOGhD1QC0LefXWwi/PCN1
	kOZzerkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXRYb-00HQd5-20; Thu, 24 Mar 2022 17:47:33 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXRWt-00HPot-RZ
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 17:45:49 +0000
Received: by mail-lj1-x229.google.com with SMTP id h11so7193285ljb.2
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XjdOGRorC0nLuKT+vnf4KghH4qK564bOF026m1uq2LM=;
 b=qn5ODB5qgGzbNY6LyHQ1PpJ+e8WZnGb3VIdgWKJ4RWs7GjUS5wjCq7s+T4SpWzyyRz
 X5Kv8cFbzPU1ALMGYa5T8WOKpm0YB33F4W56+qyixcVsxniuEIBj//m/DJEJnq38UrXs
 Eza/doKWtG2viDJxbE93l6gb1wq/dqhYes8nQfFolowATEmhocCTqet3SrVAaIdCgFVH
 ET9VDmte4nWETFRNYj9+ixpoXev6v5YAd2bMDMRF8A28SoDBtTRjFTNaR+7uOkgyQ58r
 1JGivxE8gPTnFFm7NcbScjnOreo9c7fXFQrtZpcYtCUtAjcjyHiZpx6ghM0sQ8Nfvvx0
 iMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XjdOGRorC0nLuKT+vnf4KghH4qK564bOF026m1uq2LM=;
 b=J6HN963asKW3w7NHmgKGTP8pKmBSe2klZoPQzIutPRNqf22tx3eR8/5+SAw9q+SCjK
 AMyxr1xAC9yWWFL93ZSufG5RB+2ZtdIZtxBcQtWKM5/pNqfqHrMa5d/8LpS39vA90J5+
 BFYW2d1C9QHy/UulThy5F0iLoVpr5nmGTyMpnszMSI/S3K/Az5u8nKiDNUrsffHxEjkJ
 4EAYmXADmzGxvGuRliW2XjgdQ0spSaWSm83H1yOyUrNwlJBAF5huyVWTAmZkrqEcdCbm
 SFy7rRESYVzK48vgVUSh+Z9N/+FnJb4jV88kHV9R/zHPgEJiLF5muK/pt+WDiL6s1+w8
 DrHw==
X-Gm-Message-State: AOAM5310X7x+CscieWOeXi+fHR+76N1oW5a8tRQIy9ZdXCamiUHS2ZLM
 auGDILKCygRejqZVcKbjR/2Rs2sO+JVclVQxJ5o=
X-Google-Smtp-Source: ABdhPJz0+kF30iUk1IKjKuHkn6OMlOdoGxgUwTrEvzpunKZL2D1zUDJ7ekei/or9tWttmHRiMEUXp+orM938M0EQA9Q=
X-Received: by 2002:a2e:90d6:0:b0:246:e44:bcf6 with SMTP id
 o22-20020a2e90d6000000b002460e44bcf6mr4820564ljg.501.1648143946143; Thu, 24
 Mar 2022 10:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152716epcas5p3d38d2372c184259f1a10c969f7e4396f@epcas5p3.samsung.com>
 <20220308152105.309618-12-joshi.k@samsung.com> <20220310083503.GE26614@lst.de>
 <CA+1E3rLF7D4jThUPZYbxpXs9LLdQ7Ek=Qy+rXZE=xgwBcLoaWQ@mail.gmail.com>
 <20220324063011.GA12660@lst.de>
In-Reply-To: <20220324063011.GA12660@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 24 Mar 2022 23:15:20 +0530
Message-ID: <CA+1E3rJAK9fPuS6g_po_vpvde_LpOjkuoU=E5h=v9rnHhc3+mw@mail.gmail.com>
Subject: Re: [PATCH 11/17] block: factor out helper for bio allocation from
 cache
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_104547_936595_D1F67239 
X-CRM114-Status: GOOD (  16.29  )
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

On Thu, Mar 24, 2022 at 12:00 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 10, 2022 at 05:55:02PM +0530, Kanchan Joshi wrote:
> > On Thu, Mar 10, 2022 at 2:05 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Tue, Mar 08, 2022 at 08:50:59PM +0530, Kanchan Joshi wrote:
> > > > +struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
> > > > +                         struct bio_set *bs)
> > > > +{
> > > > +     if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE))
> > > > +             return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
> > > > +
> > > > +     return bio_from_cache(nr_vecs, bs);
> > > > +}
> > > >  EXPORT_SYMBOL_GPL(bio_alloc_kiocb);
> > >
> > > If we go down this route we might want to just kill the bio_alloc_kiocb
> > > wrapper.
> >
> > Fine, will kill that in v2.
>
> As a headsup,  Mike Snitzer has been doing something similar in the
>
> "block/dm: use BIOSET_PERCPU_CACHE from bio_alloc_bioset"
>
> series.

Thanks, that can be reused here too. But to enable this feature - we
need to move to a bioset from bio_kmalloc in nvme, and you did not
seem fine with that.

