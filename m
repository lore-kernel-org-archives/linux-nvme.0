Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E13C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 12:43:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5647921D93
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 12:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5647921D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EfzJHUrim+bv5JcehjIQJSAPXtIV21dJbRkkn7hRgpg=; b=qLV0phonGMzpr57Xvh2bRs0rf
	Qd9qnZW7zMkqWUz4lJ5gN8VlV6+Ryz99VmDqTUP03sHgjsqFEIqz5dmtodmTZbCbzdQQEhqTuCtkd
	h8jcGjwHb3HD6JccOEIwL9qQzBXkkMvJKSJjKHJjT9Zwr6QwoUpjKVR7aNGOEAfYNsUO1XPvdbroY
	dzOnrL3+0uNToZW+Tj19fEfMaa6DUNFvxh2T9bUJLFShciv17yjdNFCbcYlrqqNywJX/ua9X43Kk1
	ceuUuQcbNMYAK92JkucnnG00677OvcJaHfRsB2mLcyX98wy0OtUJ6COw157H6K/71gb0fVjk96tMR
	aXPZqTpEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwPCK-0007QL-9G; Mon, 04 Jan 2021 12:42:56 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwPCI-0007O7-13
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 12:42:55 +0000
Received: by mail-ej1-x62d.google.com with SMTP id ce23so36585584ejb.8
 for <linux-nvme@lists.infradead.org>; Mon, 04 Jan 2021 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rZ4LGlK8t6B2Ly3eEurbHpHQoNf2RZlRTogtRk6wi6I=;
 b=OZtau2X7JLY3EeaL0vUwonTH8SRHkJASO32dRB2kYesG//bEP4SaZzuyAHIbE8uRxF
 YQh36KBJ91CaZYIzTSeOtCOZb732OFHaEZkCMVU8elBc+B0c1VwclwtLdl97I/2w/hEy
 IxeqAdS/qUEvl2AXaErOHhqjJlFH9X3MYC8E1JEHDyzpV3bmHF249p4uTdnLX2cwMbvR
 kff7QrA9uV+5VDrIBZIk4l/JAr59DBh5XV0TbcVJ1RtumQyK/+Zyb4BduSG4JOBtFN8X
 HporEIy9BjlXaD9ta87ZqYsiNKLeCUqatx+qz3gKeRdQMYN5Vh/TTuAVA7yejVk/9yDn
 5MPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rZ4LGlK8t6B2Ly3eEurbHpHQoNf2RZlRTogtRk6wi6I=;
 b=Knk0x0OTgffM87ZspQ01biSBd+f0WgZ44gppC8JUG4vLpCHyAei7HjRIkmeCGLzoVx
 JRvHTbRldTwvMZh4cNf68xfO+Z6gRqi7k63i2XFyJXNLf7lANGe+/Zf4OLfo1PQ0s8jc
 4o7Kzgjcj/mU6tNm/SLNsPx9/gUGXyVHRnh4gI3qOvyqJVI+9WpWzcdhpGN01YR13jxo
 0v7RBGtvFw4tNcK8OJ9G2Fu26oK6kAO5Wtauc47sHNgBBg5XGOQeeoWHDa+8Va5AMtC5
 I64pPg18Mn2WqrSHnaCbXxc08y99pmJcvY23AvWiBMYLtuy2CojaSyEbZXx20NIjmCMA
 TNDQ==
X-Gm-Message-State: AOAM532FIviR3cx9SBfLfTOuAoXf8sWLhMBrzEwFKprQux9N30qRf/mJ
 ai735ZTz668TdHnUEagBxDTI9bjKxkTCapzARCo=
X-Google-Smtp-Source: ABdhPJxwYB1Zb9l3tnKL6RKFyWxN5t6NeOfBATjkNz0+iOKlwVm8wlAvD0ezqYE3Ujva2bM13wJtSYbmW5Co7o5A/i4=
X-Received: by 2002:a17:906:68d1:: with SMTP id
 y17mr66905761ejr.447.1609764171043; 
 Mon, 04 Jan 2021 04:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20210104104159.74236-1-selvakuma.s1@samsung.com>
 <CGME20210104104245epcas5p26ed395efbf74e78a4e44048a6d7d6ba7@epcas5p2.samsung.com>
 <20210104104159.74236-2-selvakuma.s1@samsung.com>
 <BL0PR04MB6514554D569AC302850BA1DDE7D20@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6514554D569AC302850BA1DDE7D20@BL0PR04MB6514.namprd04.prod.outlook.com>
From: Selva Jove <selvajove@gmail.com>
Date: Mon, 4 Jan 2021 18:12:39 +0530
Message-ID: <CAHqX9vbuq=N0LwH25x6fHajy8Q65dyKyKJhJOksKYW1U3YGHZw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] block: export bio_map_kern()
To: Damien Le Moal <Damien.LeMoal@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_074254_126954_39F785A1 
X-CRM114-Status: GOOD (  22.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks Damien, Will update that.

On Mon, Jan 4, 2021 at 5:45 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/01/04 19:48, SelvaKumar S wrote:
> > Export bio_map_kern() so that copy offload emulation can use
> > it to add vmalloced memory to bio.
> >
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > ---
> >  block/blk-map.c        | 3 ++-
> >  include/linux/blkdev.h | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index 21630dccac62..50d61475bb68 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -378,7 +378,7 @@ static void bio_map_kern_endio(struct bio *bio)
> >   *   Map the kernel address into a bio suitable for io to a block
> >   *   device. Returns an error pointer in case of error.
> >   */
> > -static struct bio *bio_map_kern(struct request_queue *q, void *data,
> > +struct bio *bio_map_kern(struct request_queue *q, void *data,
> >               unsigned int len, gfp_t gfp_mask)
> >  {
> >       unsigned long kaddr = (unsigned long)data;
> > @@ -428,6 +428,7 @@ static struct bio *bio_map_kern(struct request_queue *q, void *data,
> >       bio->bi_end_io = bio_map_kern_endio;
> >       return bio;
> >  }
> > +EXPORT_SYMBOL(bio_map_kern);
>
> Simple copy support is a block layer code, so you I do not think you need this.
> You only need to remove the static declaration of the function.
>
> >
> >  static void bio_copy_kern_endio(struct bio *bio)
> >  {
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 070de09425ad..81f9e7bec16c 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -936,6 +936,8 @@ extern int blk_rq_map_user(struct request_queue *, struct request *,
> >                          struct rq_map_data *, void __user *, unsigned long,
> >                          gfp_t);
> >  extern int blk_rq_unmap_user(struct bio *);
> > +extern struct bio *bio_map_kern(struct request_queue *q, void *data,
> > +                             unsigned int len, gfp_t gfp_mask);
> >  extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, unsigned int, gfp_t);
> >  extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
> >                              struct rq_map_data *, const struct iov_iter *,
> >
>
>
> --
> Damien Le Moal
> Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
