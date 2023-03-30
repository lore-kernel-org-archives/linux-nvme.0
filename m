Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82EBC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNUGs7yKfBFC1B8PDt10II7FMSSlTydS7EGiHNu1RbU=; b=hgAxxE8detGKjkjQXcTtW/9pnz
	KGtFHAir+ekEOYTfZ7NNs+H5izR1W0+s4Q5ygMJuaBo1RJl7Tiu5qCUZSckQvGZtKFZeLNh7j3FFw
	0ozndnghO/KrIX7JITK4AA54s8JPb1ylHg6R/OnP2+CcpAYBfjIzirifIvtuVcuHldYSMO2vCVlkw
	cWd5PK6qyLXN+Xq3ZARw5gtWvmUVXE8RJKCLZqR+5dH4w0URCvbQAm7IdmocMnFaasJ/Hr08limQt
	JmooNl1nP6IMjOMQVpFRYB7PGLqkrypfaeiRU75Xgxj5RlH7XT6MCbyrNEVHjfQIcCAcbo0J3o+ix
	vlWsED4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phu6R-004E5v-2l;
	Thu, 30 Mar 2023 15:22:15 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phu6L-004E0J-2e
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 15:22:14 +0000
Received: by mail-yb1-xb34.google.com with SMTP id b18so23944920ybp.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680189724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNUGs7yKfBFC1B8PDt10II7FMSSlTydS7EGiHNu1RbU=;
        b=XrdblRIkrpnme1n6kkW3GbRSdT8hFxh/P2Ch4hQt+7CaVQpDENRH762vGYHNeD3GgO
         znniDBlCghprRcjLgsAEa/cQ1e7xnOcjqObsdRyiQTahf1Xze30/20RIGA//1Kz0XHtw
         L1XJNis3i8X8MqPuiWxwz2mChl+qiiDl22e6NpQSEfd1k3VkvvAP3j81HwK4Jjub9ML1
         16JgaLps4ZDjq7RSMaBBL/JMAL+rTn0ODC3W17+yS6PjVfh80FKeNaTrslgq2h65Y2lM
         wdh2KqoDQ0bwjBrDlZ3f9iN5SX9hmaXZK31UNK4/udUidQRCJfLM4VYedou1LIpRzg+x
         roNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNUGs7yKfBFC1B8PDt10II7FMSSlTydS7EGiHNu1RbU=;
        b=zL2N3oyTZzLynEv2K2SE/JZnqkdUNsl7PfMHriJIX1OgAo0Bqi9Jyf7wxZj9/LhniC
         HKEr1ABGDEcg52DS7ogoQkVbxn88d2vjYGWTlzn1rciv5yR+A3KAjhhbVMWe5Bx0N3m5
         fmj0jh6XGgv9EjrVSNMDGBYY5Kq6Vv+qmGJqerHbOGpWA6LJM3LZkB+X6HViBtA9gHJg
         NAz0F+z9IB/XePzsztSOEKD8SyRqgxZCTlLSlvHKZhzcR0DtRbcrkaGdnP91nTY5yknN
         QXBMKU+LFVdpL0uWe/rc0jINQ/Ubq+dLKu7mZHbHbvKNA4oDRAF9PlkSufoqcMLU12Kt
         VVnw==
X-Gm-Message-State: AAQBX9cf2MpnSqKLoZlh1coV0GyF9Jcbtbt9X2zv3NY92/UO/cpfAB13
	r0Rtk0ULAc3H5ooQ1thy5kPC1dCe7Dw545IaY+I=
X-Google-Smtp-Source: AKy350af9dirrryOJXb1UWHeQHVFQI5GJBkJybiFkxBW+xnISF2ErTcLRbUGhDBcOsgKxifwL+Bv9k0Jd11YNeK0OFM=
X-Received: by 2002:a05:6902:1004:b0:b75:968e:f282 with SMTP id
 w4-20020a056902100400b00b75968ef282mr15539300ybt.11.1680189724556; Thu, 30
 Mar 2023 08:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230327084103.21601-1-anuj20.g@samsung.com> <CGME20230327084244epcas5p1b0ede867e558ff6faf258de3656a8aa4@epcas5p1.samsung.com>
 <20230327084103.21601-5-anuj20.g@samsung.com> <20230329-glitter-drainpipe-bdf9d3876ac4@brauner>
 <20230329124236.GB3895@green5> <20230330-strode-deforest-b65424417062@brauner>
In-Reply-To: <20230330-strode-deforest-b65424417062@brauner>
From: Nitesh Shetty <nitheshshetty@gmail.com>
Date: Thu, 30 Mar 2023 20:51:53 +0530
Message-ID: <CAOSviJ2T=MdYbGtd9CBx8bCZh9in3MpzfOywxSVEFQEpi6dAgA@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device.
To: Christian Brauner <brauner@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, bvanassche@acm.org, 
	hare@suse.de, ming.lei@redhat.com, damien.lemoal@opensource.wdc.com, 
	joshi.k@samsung.com, gost.dev@samsung.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_082209_867626_0BE1D884 
X-CRM114-Status: GOOD (  29.56  )
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

On Thu, Mar 30, 2023 at 11:18=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Mar 29, 2023 at 06:12:36PM +0530, Nitesh Shetty wrote:
> > On Wed, Mar 29, 2023 at 02:14:40PM +0200, Christian Brauner wrote:
> > > On Mon, Mar 27, 2023 at 02:10:52PM +0530, Anuj Gupta wrote:
> > > > From: Nitesh Shetty <nj.shetty@samsung.com>
> > > >
> > > > For direct block device opened with O_DIRECT, use copy_file_range t=
o
> > > > issue device copy offload, and fallback to generic_copy_file_range =
incase
> > > > device copy offload capability is absent.
> > > > Modify checks to allow bdevs to use copy_file_range.
> > > >
> > > > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > > > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > > ---
> > > >  block/blk-lib.c        | 22 ++++++++++++++++++++++
> > > >  block/fops.c           | 20 ++++++++++++++++++++
> > > >  fs/read_write.c        | 11 +++++++++--
> > > >  include/linux/blkdev.h |  3 +++
> > > >  4 files changed, 54 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/block/blk-lib.c b/block/blk-lib.c
> > > > index a21819e59b29..c288573c7e77 100644
> > > > --- a/block/blk-lib.c
> > > > +++ b/block/blk-lib.c
> > > > @@ -475,6 +475,28 @@ static inline bool blk_check_copy_offload(stru=
ct request_queue *q_in,
> > > >   return blk_queue_copy(q_in) && blk_queue_copy(q_out);
> > > >  }
> > > >
> > > > +int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_i=
n,
> > > > +               struct block_device *bdev_out, loff_t pos_out, size=
_t len,
> > > > +               cio_iodone_t end_io, void *private, gfp_t gfp_mask)
> > > > +{
> > > > + struct request_queue *in_q =3D bdev_get_queue(bdev_in);
> > > > + struct request_queue *out_q =3D bdev_get_queue(bdev_out);
> > > > + int ret =3D -EINVAL;
> > >
> > > Why initialize to -EINVAL if blk_copy_sanity_check() initializes it
> > > right away anyway?
> > >
> >
> > acked.
> >
> > > > + bool offload =3D false;
> > >
> > > Same thing with initializing offload.
> > >
> > acked
> >
> > > > +
> > > > + ret =3D blk_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out,=
 len);
> > > > + if (ret)
> > > > +         return ret;
> > > > +
> > > > + offload =3D blk_check_copy_offload(in_q, out_q);
> > > > + if (offload)
> > > > +         ret =3D __blk_copy_offload(bdev_in, pos_in, bdev_out, pos=
_out,
> > > > +                         len, end_io, private, gfp_mask);
> > > > +
> > > > + return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(blkdev_copy_offload);
> > > > +
> > > >  /*
> > > >   * @bdev_in:     source block device
> > > >   * @pos_in:      source offset
> > > > diff --git a/block/fops.c b/block/fops.c
> > > > index d2e6be4e3d1c..3b7c05831d5c 100644
> > > > --- a/block/fops.c
> > > > +++ b/block/fops.c
> > > > @@ -611,6 +611,25 @@ static ssize_t blkdev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> > > >   return ret;
> > > >  }
> > > >
> > > > +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t=
 pos_in,
> > > > +                         struct file *file_out, loff_t pos_out,
> > > > +                         size_t len, unsigned int flags)
> > > > +{
> > > > + struct block_device *in_bdev =3D I_BDEV(bdev_file_inode(file_in))=
;
> > > > + struct block_device *out_bdev =3D I_BDEV(bdev_file_inode(file_out=
));
> > > > + int comp_len =3D 0;
> > > > +
> > > > + if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
> > > > +         (file_out->f_iocb_flags & IOCB_DIRECT))
> > > > +         comp_len =3D blkdev_copy_offload(in_bdev, pos_in, out_bde=
v,
> > > > +                          pos_out, len, NULL, NULL, GFP_KERNEL);
> > > > + if (comp_len !=3D len)
> > > > +         comp_len =3D generic_copy_file_range(file_in, pos_in + co=
mp_len,
> > > > +                 file_out, pos_out + comp_len, len - comp_len, fla=
gs);
> > >
> > > I'm not deeply familiar with this code but this looks odd. It at leas=
t
> > > seems possible that comp_len could be -EINVAL and len 20 at which poi=
nt
> > > you'd be doing len - comp_len aka 20 - 22 =3D -2 in generic_copy_file=
_range().
>
> 20 - -22 =3D 44 ofc
>
> >
> > comp_len should be 0 incase of error. We do agree, some function
>
> I mean, not to hammer on this point too much but just to be clear
> blk_copy_sanity_check(), which is introduced in the second patch, can
> return both -EPERM and -EINVAL and is first called in
> blkdev_copy_offload() so it's definitely possible for comp_len to be
> negative.

Acked. Will be updated in the next version.

Thank you,
Nitesh Shetty

