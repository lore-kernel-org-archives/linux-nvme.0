Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430CDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMdQruxukN7xczRg3+vAgQmSYHLw/uLRbeJd/4syR58=; b=aPUjYogf1a0bkoPFT3PU3i9ODg
	4sFK/gyE9ziTE2chOVtJ/wP4S+4svaoretcSSSA360Xn1aazN4CCvEceXxLvrKfYNR0UDuPU3DPxf
	gDDjQmIPwQuv8U2d2paeeuknkzEum9vr8w1Gje+b63OtyBEiAO5irdy7PCrJNCkPxWAy4LCUt59Xq
	L9HwhWq5tqmHMz6ybkTpknnFpaaZgZDuG1SxOd29dFdgZjlcFbt9o7XAMpC31y2q2u3lLqJkjyXB0
	v+Ac6/5WLgbL8wW4gvzjg2xCF6GGDscRRlRJqIMrNWTY94DfwF0vRvFFcPRonL2+ENNf3/9qC0suz
	2xhrPSLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTkSn-005V0d-L5; Mon, 14 Mar 2022 13:10:17 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTkSa-005Uwe-Bu
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:10:06 +0000
Received: by mail-lj1-x231.google.com with SMTP id 25so21787467ljv.10
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 06:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yMdQruxukN7xczRg3+vAgQmSYHLw/uLRbeJd/4syR58=;
 b=XKObeHOAEnAi5szMWcuxy6hbm6P5lMl58rcXpLysUh3Zs333P41+/w9w4CIS/yYEPS
 6FyZWgEMnZCAFdAWamB50WH6HDKh2UrQuRhYssI2r8YMp+uHrk8r/KRPUEB9/hcAeOhk
 6g+589fJuf/StdGXTDh5qXWB6Do2HhEf9UgvwRPUiYZ79x/wCGzEyinlj5g9uMPtbYti
 bVflhgMSaelokJOsgVIKbdOwdaORu68H12OWckf2pNsN6DRjR3/ALtRmy7TqG0ePERp8
 FzGmY7nezB9TC/9kwGfaIxrZKqBJ8DmQTR4Z3hUi7hLLLi71UMDHX4RcoGAG2ssoIDzM
 kpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMdQruxukN7xczRg3+vAgQmSYHLw/uLRbeJd/4syR58=;
 b=y7aQDqSUkTICN17f2kaHci/YFC79MFQtwfNejzXxwHtacm0RSJlloeh+4yhaa4iYTB
 22rFcVhS0z/Ameg9mRi5yfCzqMlIJPNzhrmoEICPLwgQ5xoHZ5extXOZcTkKoJC4NROU
 ChLxPWZBa4URpgJFvSr56jla3FFAGRl4dvWraVXa551TU24Q6+Dzm9MIQcPWUZMhUT+s
 Qj81YfLZv6P829ukXIWIxKN0CaPXJJFNutZ3lbNs6x0lgh2HaB7XNLkiWfPgamIc4TXO
 sG8gwR/USx9PthQ/3gNF+izlJFLarjGbWoIbimaTqcueWgaj2H4fwKQEh0IvY4441rQK
 Gs3g==
X-Gm-Message-State: AOAM533Vmb2FkAHPtrZrWYVV3Go2rhIfeJjH85TA0Kb/LASFIdO4OUn0
 5g7EAP5vcx+uDwKoqDS8lKd0l4yWcUM1XPm+j+Y=
X-Google-Smtp-Source: ABdhPJw1JcRokQe60GlwSImervGGE6MV8GniXt1BZxf+h7qeLDo5laRHUUleD/fkGbbNSp9VwAivyabaAaylx/wqv0k=
X-Received: by 2002:a2e:80cf:0:b0:247:f28d:b04e with SMTP id
 r15-20020a2e80cf000000b00247f28db04emr14585255ljg.528.1647263402899; Mon, 14
 Mar 2022 06:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
 <20220308152105.309618-9-joshi.k@samsung.com> <Yi8ynSFjllfuj4NB@T590>
In-Reply-To: <Yi8ynSFjllfuj4NB@T590>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 14 Mar 2022 18:39:38 +0530
Message-ID: <CA+1E3rK0-CXoCvE+5cKD_Vx=17b5A=HRhPrTeYtd4MeFKEAUrw@mail.gmail.com>
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
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
X-CRM114-CacheID: sfid-20220314_061004_433366_5DC0084D 
X-CRM114-Status: GOOD (  25.71  )
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

On Mon, Mar 14, 2022 at 5:49 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Mar 08, 2022 at 08:50:56PM +0530, Kanchan Joshi wrote:
> > From: Anuj Gupta <anuj20.g@samsung.com>
> >
> > Add support to carry out passthrough command with pre-mapped buffers.
> >
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  block/blk-map.c           | 45 +++++++++++++++++++++++++++++++++++++++
> >  drivers/nvme/host/ioctl.c | 27 ++++++++++++++---------
> >  include/linux/blk-mq.h    |  2 ++
> >  3 files changed, 64 insertions(+), 10 deletions(-)
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index 4526adde0156..027e8216e313 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bio.h>
> >  #include <linux/blkdev.h>
> >  #include <linux/uio.h>
> > +#include <linux/io_uring.h>
> >
> >  #include "blk.h"
> >
> > @@ -577,6 +578,50 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
> >  }
> >  EXPORT_SYMBOL(blk_rq_map_user);
> >
> > +/* Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough. */
> > +int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> > +                  u64 ubuf, unsigned long len, gfp_t gfp_mask,
> > +                  struct io_uring_cmd *ioucmd)
> > +{
> > +     struct iov_iter iter;
> > +     size_t iter_count, nr_segs;
> > +     struct bio *bio;
> > +     int ret;
> > +
> > +     /*
> > +      * Talk to io_uring to obtain BVEC iterator for the buffer.
> > +      * And use that iterator to form bio/request.
> > +      */
> > +     ret = io_uring_cmd_import_fixed(ubuf, len, rq_data_dir(rq), &iter,
> > +                     ioucmd);
> > +     if (unlikely(ret < 0))
> > +             return ret;
> > +     iter_count = iov_iter_count(&iter);
> > +     nr_segs = iter.nr_segs;
> > +
> > +     if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
> > +             return -EINVAL;
> > +     if (nr_segs > queue_max_segments(q))
> > +             return -EINVAL;
> > +     /* no iovecs to alloc, as we already have a BVEC iterator */
> > +     bio = bio_alloc(gfp_mask, 0);
> > +     if (!bio)
> > +             return -ENOMEM;
> > +
> > +     ret = bio_iov_iter_get_pages(bio, &iter);
>
> Here bio_iov_iter_get_pages() may not work as expected since the code
> needs to check queue limit before adding page to bio and we don't run
> split for passthrough bio. __bio_iov_append_get_pages() may be generalized
> for covering this case.

Yes. That may just be the right thing to do. Thanks for the suggestion.


-- 
Kanchan

