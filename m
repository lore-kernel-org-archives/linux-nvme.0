Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAD1C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:59:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884B86120E
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 06:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884B86120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J/vde9OWPUEqQjOSSBUPiWpt+s96j3Zus3g9GH+3SO0=; b=MHRr1/ILyOzb0YU4Gm+3gL2Bn
	Cj7KovSQUOyF/M2emIKi4gSerN+KFUEooVhjURyh+3gkKaf92xmU4P8u7M5QzWR9e9KpRQMcnwDYs
	IsML16cF8S76KdDCWneDkiVobsjGId6bIY8g4Xw3pBq3QJHiDIIwM/iU4XH/qwgqzOTkS7vuD6Kef
	IUNsTBGsuTWxtRjDY3XYHxuHhXdo2o6smgXskjf48DfQ2avIGF6q3QRKyEbdqPyjgWx/d8EyN7PSC
	4AptfFJEAfQTDBWcVLoIz0eI+uvs7zwIikvxZXRG9R4OSdBBOMUlbfwGwnNO+FCnyUbsMT/4hlO9A
	CX+OLDduQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWZUM-00BlNw-4C; Wed, 14 Apr 2021 06:59:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZUG-00BlMQ-5v
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 06:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=iPvXMTpUNl3IxdG2GdqWLZcBOjF3pDi559BGFj5cKe8=; b=27ZtPyugWFeytELjQZ6OAluKa4
 +HABT92mnFPcNsz0vKDWblirxbwVe02+As6OeSMH0bF3txgzGhA3MWoDzDDSSYf+yZxs+ziH3Vrf4
 y8l/LO6AyE4lTej7Cts11HWt0IZg50WQLRjVtLr0TP+FpWB+I09LM5QMbFhd/4OfPLHUImNMHmWD4
 yjEOCv5KFAh8aZKZ9u9oT6YlvoSgBN4Gu9VPM52lMsmfFmIG2ch/sZOVYnT3Yz/Wno2SBp88U850p
 r7IglYNJ82PThccz93A9rR4npPt+96xHIhbPEV4vbB9zExYRW4UWz15hknRpGgRD2nvcpIEPx8Ksc
 RUB7ifIg==;
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZUD-007YKy-Cc
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 06:58:54 +0000
Received: by mail-io1-xd29.google.com with SMTP id f15so10900883iob.5
 for <linux-nvme@lists.infradead.org>; Tue, 13 Apr 2021 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iPvXMTpUNl3IxdG2GdqWLZcBOjF3pDi559BGFj5cKe8=;
 b=e5PSEGY9BDrjmpgpr1JDTixtaSfJ7lUkQfQofKGJFTaxWSf77oTAkZfVa/2O+TS5dW
 eKoMP9B+vnaz4hLpdAQWXWwhO25xpQs7hfZJKyS4+7XL71K5E2369zyC/5JZMUDY2/0G
 rcsd5BOHW/WDdWXnB60fXErG4m7mKCiymxzKVlqItMnrhqaF2na8AprV+mUZSSfD2XdZ
 j/XMXdcInl4r0vsmy0rtFemZRTCl8mDtEV0kYcRVD+xDrt45g2qUNZIJr3f4P1dreG8r
 0bCmU1FuJE2EZQsl5ACajy0rLM7hsKYhA6JgpY896xMy/C+GuqNMkUYjIj3itjHf1RRm
 DQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iPvXMTpUNl3IxdG2GdqWLZcBOjF3pDi559BGFj5cKe8=;
 b=KZQw2GZfdm8Vn4085j5H4vmeg0TiL2x0lQE1InUyv+Qrfdl9sskPlx90boeV8BX1Dn
 Jtpu4aNuRKY1B3XUmP1/PA/BFTCSaTnl33Y+lm06Ut9tw+OgxUMyD+AGBzqIaeIfbYGi
 HMnmZm2xMXgliKTtrZoulDOq1HCHPdQw0d5V7bb7p+q8au4taCICkbj7QOYHO5Pn0hRX
 6YaPmvua9gpPqT4ktvTec5QEqvJ4tqlAUqnlPwI4nmcWhVAZE9WQaH/q4roMAN2VcSi6
 85l+is3JcZPKrGeCFxYw0bn/1Uwbs+nGQSPsCXPgRT9Tc7TQOr1VkkmRyxG2dw2Oyf/f
 vfAA==
X-Gm-Message-State: AOAM531xYrTPAil3N4oeSdkLVPDYE4v8UkAVhqqgGU/ODoXuVdGAcAET
 D+9Qxtzm/AZrorfWN/5Nf422aJdGQvczT5eoVB4=
X-Google-Smtp-Source: ABdhPJxVn0379a/e+lrGuK9nJvBnaVZRkG+95gHH+6KyBvsrtfKcHhnhaQQ04D+xJ04y9zRQrXsU7onZw/arekICxKA=
X-Received: by 2002:a6b:f909:: with SMTP id j9mr30365082iog.138.1618383531741; 
 Tue, 13 Apr 2021 23:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
 <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
 <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vYvtOaVL4LG0gAGCMz+a8uha8czH==Dgg3eG+TWA+xeVQ@mail.gmail.com>
 <BL0PR04MB65146169A9C7527280C15D4AE74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB65146169A9C7527280C15D4AE74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
From: Selva Jove <selvajove@gmail.com>
Date: Wed, 14 Apr 2021 12:28:39 +0530
Message-ID: <CAHqX9vYPVwYLT5Bdk_GqKZWxpJNib9fYidEmT0j+bRikwyLgKw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210413_235853_454967_4A0730D0 
X-CRM114-Status: GOOD (  41.79  )
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

I agree with you. Will remove BLKDEV_COPY_NOEMULATION.

On Tue, Apr 13, 2021 at 6:03 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/04/12 23:35, Selva Jove wrote:
> > On Mon, Apr 12, 2021 at 5:55 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >>
> >> On 2021/04/07 20:33, Selva Jove wrote:
> >>> Initially I started moving the dm-kcopyd interface to the block layer
> >>> as a generic interface.
> >>> Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is
> >>> tightly coupled with dm_io()
> >>>
> >>> To move dm-kcopyd to block layer, it would also require dm_io code to
> >>> be moved to block layer.
> >>> It would cause havoc in dm layer, as it is the backbone of the
> >>> dm-layer and needs complete
> >>> rewriting of dm-layer. Do you see any other way of doing this without
> >>> having to move dm_io code
> >>> or to have redundant code ?
> >>
> >> Right. Missed that. So reusing dm-kcopyd and making it a common interface will
> >> take some more efforts. OK, then. For the first round of commits, let's forget
> >> about this. But I still think that your emulation could be a lot better than a
> >> loop doing blocking writes after blocking reads.
> >>
> >
> > Current implementation issues read asynchronously and once all the reads are
> > completed, then the write is issued as whole to reduce the IO traffic
> > in the queue.
> > I agree that things can be better. Will explore another approach of
> > sending writes
> > immediately once reads are completed and with  plugging to increase the chances
> > of merging.
> >
> >> [...]
> >>>>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> >>>>> +             struct range_entry *src_rlist, struct block_device *dest_bdev,
> >>>>> +             sector_t dest, gfp_t gfp_mask, int flags)
> >>>>> +{
> >>>>> +     struct request_queue *q = bdev_get_queue(src_bdev);
> >>>>> +     struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> >>>>> +     struct blk_copy_payload *payload;
> >>>>> +     sector_t bs_mask, copy_size;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     ret = blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
> >>>>> +                     &payload, &copy_size);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     bs_mask = (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> >>>>> +     if (dest & bs_mask) {
> >>>>> +             return -EINVAL;
> >>>>> +             goto out;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (q == dest_q && q->limits.copy_offload) {
> >>>>> +             ret = blk_copy_offload(src_bdev, payload, dest, gfp_mask);
> >>>>> +             if (ret)
> >>>>> +                     goto out;
> >>>>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {
> >>>>
> >>>> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would that
> >>>> user say "Fail on me if the device does not support copy" ??? This is a weird
> >>>> interface in my opinion.
> >>>>
> >>>
> >>> BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() callers
> >>> to use their native copying method instead of the emulated copy that I
> >>> added. This way we
> >>> ensure that dm uses the hw-assisted copy and if that is not present,
> >>> it falls back to existing
> >>> copy method.
> >>>
> >>> The other users who don't have their native emulation can use this
> >>> emulated-copy implementation.
> >>
> >> I do not understand. Emulation or not should be entirely driven by the device
> >> reporting support for simple copy (or not). It does not matter which component
> >> is issuing the simple copy call: an FS to a real device, and FS to a DM device
> >> or a DM target driver. If the underlying device reported support for simple
> >> copy, use that. Otherwise, emulate with read/write. What am I missing here ?
> >>
> >
> > blkdev_issue_copy() api will generally complete the copy-operation,
> > either by using
> > offloaded-copy or by using emulated-copy. The caller of the api is not
> > required to
> > figure the type of support. However, it can opt out of emulated-copy
> > by specifying
> > the flag BLKDEV_NOEMULATION. This is helpful for the case when the
> > caller already
> > has got a sophisticated emulation (e.g. dm-kcopyd users).
>
> This does not make any sense to me. If the user has already another mean of
> doing copies, then that user will not call blkdev_issue_copy(). So I really do
> not understand what the "opting out of emulated copy" would be useful for. That
> user can check the simple copy support glag in the device request queue and act
> accordingly: use its own block copy code when simple copy is not supported or
> use blkdev_issue_copy() when the device has simple copy. Adding that
> BLKDEV_COPY_NOEMULATION does not serve any purpose at all.
>
>
>
> --
> Damien Le Moal
> Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
