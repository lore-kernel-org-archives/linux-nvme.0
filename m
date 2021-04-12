Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BCBC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 14:35:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109916128E
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 14:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109916128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FovHu45eCPWNWasxaNXSUplOxI4neePZDaIJBxGDiv0=; b=J9v1MfmlTVVhgxhjBz3bSrRwp
	vCeIaBqvgXf7tKOKRIq+C0QrrdT9/Kh8O3SLUjZCJzEgUeV7dKkYXYEnrmt0BsRsXUWpo2LHfijRk
	4QJT9QhJ4DjMhhiCybvey7m1+EamHjZbPsfQXe5EevIi9JV6iS7e2/hEho3glXkP0LudSizPP4V2F
	5z7QDd1vbs1UV6x6G7NwRv1y+ujfoyQo6hdcTMKLEs8X/vnX2BklCjqY3RzqPpJXz+sBRYDETfQiq
	M4UzlFKZJw/qRT4+kOV2fZJZORDwlF2r+B8q/lphHDolJp4ZFgcC1hKGq/ShC8ld1WJXLcffs8SBm
	Ybn3b7MJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVxen-006z4P-0A; Mon, 12 Apr 2021 14:35:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVxej-006z4E-SB
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 14:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nl+e8gruZE2jm3U6Sm5K1rbed6F1G7jwfaUBg/d7wnQ=; b=eLAwhV5w2juBhuMdJV9Z/XMyYV
 mVfPaIEtq7CToVu7W1qn0GyOB7OqIOE18svuyvOWv3ad6zJClUvLSnGkrEX0usuqU4wyao9M0I1Kp
 23Tpikfh9dh4K6XThrVJqPQvNicVO+id75Gdc9HD+CBfv5fClEvyumPN16sCWqmaJDZxyLV7TP9dD
 XGJspr2viuomH7aSEVF1I+bSyaysvkVci0/TDg0BUPZNfwrP/PcEhtyVY63oSvIJzB9FBftREOz1g
 qupZMoYTNOy7GciiOGpy/oowYY/HWg+TfbNnOJD+Pn8kgboMjCmVPtgI+vIRigfEbGHPC5tgUxYAd
 yHnhZ8rw==;
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVxeg-006JKS-O3
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 14:35:12 +0000
Received: by mail-il1-x133.google.com with SMTP id r5so3007543ilb.2
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nl+e8gruZE2jm3U6Sm5K1rbed6F1G7jwfaUBg/d7wnQ=;
 b=GEMfpQ63psb9h6jsOfJpCEamzHSC5KM6k6vvRkDUI9IH9wYf2vk0LAaZkhrDP5uqJP
 9re2EwPVlFlea8z1dP7DMq08Hkb4+lj/tUSRLs/1bu+vp5kF+WEOn/bASDlbEvfJ7qhW
 TlWimpek6XvxG+fPQApyWIlsa4gY3UMXD0CGekbaxI2O9nC2BkaWssIiIgM1Ko9hug7C
 up/g+Ahu5aAAgcAOkP9rxOVRJINfo5vYUVYAr32YtS3Cn/Y/qD5hCyLC7Q/RxewJ26OE
 4dWVYcA6NZn12wcJSGE7iUpBUs02nrhr/MQn5bid2/JRu4tb3w1285QRXJUb0EEhZTko
 bhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nl+e8gruZE2jm3U6Sm5K1rbed6F1G7jwfaUBg/d7wnQ=;
 b=ecDWOQjcBmsVT8PlvMm0H2r52wLUZDYxTAv/UE9V9cLs5PhIoV+1BMEljg5/CvLntU
 Rnu2QxSOc9paaHXBIk2ZiLHoAR6hesoouygeY3cmIm7KFfTq5jmiY2aB8ZE5MRe4kZXT
 0zsdDGiWY+3JbX0Pwh8uEqNvNNi3m7G8t3SGA27jzjk766M7J2MLwDPiIIxm3Lgx70f9
 Yze39iC024XH5pDgtRZEbXemKbAMFaK5eC6Ff8NxLXvxjvNN2CmEBvpMNHzTSZSlWV6U
 iS5NDFO0e8QOyItw9jgeW43Lg31eXA6QYRtxNCCDIkMv/UomZGlWqnv0OaQ0kZ/PxKCG
 9LQA==
X-Gm-Message-State: AOAM531QkP1dwijmRUpkajOedSJaK3TgKdh9o5EFuIrrscQa7V9VuJsn
 ZhvWxdCzgdJGvrgbjD6RW0DKPD5nQf1IaAlRoQs=
X-Google-Smtp-Source: ABdhPJzIyljg2UrVufiKLCV4AtEnX0lojUYHBV69oqiVNW99rdpYudFQX35/feDopBRdXXdq5MJ1SOwFrLXrR9vCLQU=
X-Received: by 2002:a05:6e02:11a9:: with SMTP id
 9mr13004896ilj.288.1618238107878; 
 Mon, 12 Apr 2021 07:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
 <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
 <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
From: Selva Jove <selvajove@gmail.com>
Date: Mon, 12 Apr 2021 20:04:55 +0530
Message-ID: <CAHqX9vYvtOaVL4LG0gAGCMz+a8uha8czH==Dgg3eG+TWA+xeVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, 
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, 
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, 
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>, 
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "kch@kernel.org" <kch@kernel.org>, 
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_073510_833725_8B708401 
X-CRM114-Status: GOOD (  40.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 12, 2021 at 5:55 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/04/07 20:33, Selva Jove wrote:
> > Initially I started moving the dm-kcopyd interface to the block layer
> > as a generic interface.
> > Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is
> > tightly coupled with dm_io()
> >
> > To move dm-kcopyd to block layer, it would also require dm_io code to
> > be moved to block layer.
> > It would cause havoc in dm layer, as it is the backbone of the
> > dm-layer and needs complete
> > rewriting of dm-layer. Do you see any other way of doing this without
> > having to move dm_io code
> > or to have redundant code ?
>
> Right. Missed that. So reusing dm-kcopyd and making it a common interface will
> take some more efforts. OK, then. For the first round of commits, let's forget
> about this. But I still think that your emulation could be a lot better than a
> loop doing blocking writes after blocking reads.
>

Current implementation issues read asynchronously and once all the reads are
completed, then the write is issued as whole to reduce the IO traffic
in the queue.
I agree that things can be better. Will explore another approach of
sending writes
immediately once reads are completed and with  plugging to increase the chances
of merging.

> [...]
> >>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> >>> +             struct range_entry *src_rlist, struct block_device *dest_bdev,
> >>> +             sector_t dest, gfp_t gfp_mask, int flags)
> >>> +{
> >>> +     struct request_queue *q = bdev_get_queue(src_bdev);
> >>> +     struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> >>> +     struct blk_copy_payload *payload;
> >>> +     sector_t bs_mask, copy_size;
> >>> +     int ret;
> >>> +
> >>> +     ret = blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
> >>> +                     &payload, &copy_size);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     bs_mask = (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> >>> +     if (dest & bs_mask) {
> >>> +             return -EINVAL;
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     if (q == dest_q && q->limits.copy_offload) {
> >>> +             ret = blk_copy_offload(src_bdev, payload, dest, gfp_mask);
> >>> +             if (ret)
> >>> +                     goto out;
> >>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {
> >>
> >> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would that
> >> user say "Fail on me if the device does not support copy" ??? This is a weird
> >> interface in my opinion.
> >>
> >
> > BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() callers
> > to use their native copying method instead of the emulated copy that I
> > added. This way we
> > ensure that dm uses the hw-assisted copy and if that is not present,
> > it falls back to existing
> > copy method.
> >
> > The other users who don't have their native emulation can use this
> > emulated-copy implementation.
>
> I do not understand. Emulation or not should be entirely driven by the device
> reporting support for simple copy (or not). It does not matter which component
> is issuing the simple copy call: an FS to a real device, and FS to a DM device
> or a DM target driver. If the underlying device reported support for simple
> copy, use that. Otherwise, emulate with read/write. What am I missing here ?
>

blkdev_issue_copy() api will generally complete the copy-operation,
either by using
offloaded-copy or by using emulated-copy. The caller of the api is not
required to
figure the type of support. However, it can opt out of emulated-copy
by specifying
the flag BLKDEV_NOEMULATION. This is helpful for the case when the
caller already
has got a sophisticated emulation (e.g. dm-kcopyd users).

>
> [...]
> >>> @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >>>       if (b->chunk_sectors)
> >>>               t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
> >>>
> >>> +     /* simple copy not supported in stacked devices */
> >>> +     t->copy_offload = 0;
> >>> +     t->max_copy_sectors = 0;
> >>> +     t->max_copy_range_sectors = 0;
> >>> +     t->max_copy_nr_ranges = 0;
> >>
> >> You do not need this. Limits not explicitely initialized are 0 already.
> >> But I do not see why you can't support copy on stacked devices. That should be
> >> feasible taking the min() for each of the above limit.
> >>
> >
> > Disabling stacked device support was feedback from v2.
> >
> > https://patchwork.kernel.org/project/linux-block/patch/20201204094659.12732-2-selvakuma.s1@samsung.com/
>
> Right. But the initialization to 0 is still not needed. The fields are already
> initialized to 0.
>
>
> --
> Damien Le Moal
> Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
