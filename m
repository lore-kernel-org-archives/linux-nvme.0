Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F48DC4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 07:07:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4D3225A9
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 07:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4D3225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cwbIrUoX87QeCmJGp7SmqWmGpqcjjAPxlWTZLgg0PrA=; b=u8n3VVnWgdYvOelJF3cTu/HOB
	TQ/YJ4iay5aLK9snpDjbOAnR6UBlntXqWxutur1w5FWsacjNnLWQC0zAFrdcqynXLxZZQhsWryhXO
	CXc3+DgbqtyEdJM0SVU3i51Yd0dqBk4DlFiGFI1DBRPATst+Tc4/BzqzCF8bBP+ZqMb1thhh4ppEP
	aFcV5XlDpEO6p6qJXdQrMRCYnnilmbYZAoN+Pf6N2mGtAu4xNpvAmVWAXoK5R0eRzQFOjCdcEGpf3
	11JcE2a+fs1aPfQhQonmLUdrEYJv5xc1G25a5fnrA6BA8WLaS9u1Od/Vi1M+EzjEKiryG2jl0dxft
	+6iK3YhjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kohxA-0000bw-7f; Mon, 14 Dec 2020 07:07:28 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kohx6-0000bR-Ty
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 07:07:25 +0000
Received: by mail-ej1-x643.google.com with SMTP id 6so6443949ejz.5
 for <linux-nvme@lists.infradead.org>; Sun, 13 Dec 2020 23:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QWzR/ajntQQ8OUu1eo9cHzjXBqYXTELyiik0EYAgp6c=;
 b=BZQh5xNlSsdb6hrrLdcbHcyRgcGFT9VrZOvm68joTduKjVi50NMmX22Yugytx7Xo7H
 w2vZaNPSJQSAYyk8ZabBa2YDHeJqQAC69t+CcHfIfBAxCCOoAlIK0TqYUG6pAk527fWZ
 VGQ5x9zaF8Ai0ogqnOor13smC6PoDtuDitdzZTdLzkkp8hPUmh5XZRzM8M11ukL1h5Nc
 deqr7VXcjIrlzRbxOlaUpVePANjCg54N45MIs+7kgw8s2AtMOBhmHjIF4tbU34Cy+GxZ
 FpsqKBBLubkEmgd74TfY82x27SkLuBNKrz5lpwjmAUyUTzz2Bl/YauGXzLp4xdF3i00q
 Qqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QWzR/ajntQQ8OUu1eo9cHzjXBqYXTELyiik0EYAgp6c=;
 b=T3U9jiwYDmYfWeLv7iFEnCnBZTZXpnHoFMSI0dizxdkDNjBdnSJbPmBc9C1QId5I0n
 y7dk418jJjbaxsiCIld7ekPI46IY5mBi4BiAAuKhP0t0Pi/gI+CYxB64mcdJ9zWtuvLo
 Z82k/huC3s9yhflC3X8Ry0ofXcj9/wzJuUTO9XFvcpgH6+qip8l8md2Sc1AMad2XozI8
 Fq+UqIr8drMC//TOCyWGys16+BiRNiOK6i3ANxU+9hcBSPEQPxbPaG/oITXsfWRdZZb5
 4+MlogLd/sWqB6O+2zalMA5vjDtfbzgimAps/SLbZBamwg8WutrYp4WGajEG9R5DMisd
 f5ZQ==
X-Gm-Message-State: AOAM530WVzUpId8mkr0QCJBIbVXPXmZr+06KSjRZMNOlMqqZ3tpdkthk
 +DCyYj6Q7kUiVLlomgNbyqv0LMeQ1lL8n46n4MQ=
X-Google-Smtp-Source: ABdhPJznXbr+iFcyZQ0stzB05Z3JXUu6f2/PCyWYcbP3IUZ3HcqQL6yvr7ZEoaMx/h/x22bIeETtTTVWUHBtMe+z7b0=
X-Received: by 2002:a17:906:68d1:: with SMTP id
 y17mr21530318ejr.447.1607929643589; 
 Sun, 13 Dec 2020 23:07:23 -0800 (PST)
MIME-Version: 1.0
References: <20201211135139.49232-1-selvakuma.s1@samsung.com>
 <CGME20201211135200epcas5p217eaa00b35a59b3468c198d85309fd7d@epcas5p2.samsung.com>
 <20201211135139.49232-2-selvakuma.s1@samsung.com>
 <SN4PR0401MB359867B95139ACD1ACFF0E709BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB359867B95139ACD1ACFF0E709BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From: Selva Jove <selvajove@gmail.com>
Date: Mon, 14 Dec 2020 12:37:08 +0530
Message-ID: <CAHqX9vYfGONfavB1hLRtdeSwhU6VWrPLzXFfmgwkB6-pgB9o7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] block: add simple copy support
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_020725_014087_048F882A 
X-CRM114-Status: GOOD (  16.47  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
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

On Fri, Dec 11, 2020 at 9:56 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 11/12/2020 15:57, SelvaKumar S wrote:
> [...]
> > +int blk_copy_emulate(struct block_device *bdev, struct blk_copy_payload *payload,
> > +             gfp_t gfp_mask)
> > +{
> > +     struct request_queue *q = bdev_get_queue(bdev);
> > +     struct bio *bio;
> > +     void *buf = NULL;
> > +     int i, nr_srcs, max_range_len, ret, cur_dest, cur_size;
> > +
> > +     nr_srcs = payload->copy_range;
> > +     max_range_len = q->limits.max_copy_range_sectors << SECTOR_SHIFT;
> > +     cur_dest = payload->dest;
> > +     buf = kvmalloc(max_range_len, GFP_ATOMIC);
>
> Why GFP_ATOMIC and not the passed in gfp_mask? Especially as this is a kvmalloc()
> which has the potential to grow quite big.
>
> > +int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
> > +             sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
> > +             int flags, struct bio **biop)
> > +{
>
> [...]
>
> > +     total_size = struct_size(payload, range, nr_srcs);
> > +     payload = kmalloc(total_size, GFP_ATOMIC | __GFP_NOWARN);
>
> Same here.
>
>
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index 6b785181344f..a4a507d85e56 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -142,6 +142,47 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
> >                                   GFP_KERNEL, flags);
> >  }
> >
> > +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> > +             unsigned long arg, unsigned long flags)
> > +{
>
> [...]
>
> > +
> > +     rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> > +                     GFP_ATOMIC | __GFP_NOWARN);
>
> And here. I think this one can even be GFP_KERNEL.
>
>
>

Thanks. Will fix this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
