Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE811C4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 06:57:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444C722597
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 06:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444C722597
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qWcUxfspe+JiuaCrHJge/sebqOoJup4TIq5oLKBYweI=; b=F9vcgJq1cx6mbthvBYQAqktEa
	PJRKbhuc0+Kb+GC99tI/3S5Wkwgu3npkfvA7Egmg4uT6Kd/Yu10RWQySVAI7OL44ubLlW3hj11G2T
	MX3YRNU3HYc/2fSNbA48/OsuStCLrCn6knP9kmF4iOtp8Rm4VDoeLWjKg7Mf9NAnxsNb878hv2fj0
	6IBdxMpBSu+T6Ja1qP0TsD6ddqonwc6BF4FryqRo9qh70sGYkVKs38sDb5k0HtWUsAnX3+qv2oV3o
	HFY/vURTdfOV1IIQJwG3dOgzGXCB8Uvnn7ewnQoz6c+22fbUN4TJODcFsKm1HRTh2dTyKhNq1yOQy
	3eTXJNYqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kohnu-0008MW-Tr; Mon, 14 Dec 2020 06:57:54 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kohnr-0008Ly-Mx
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 06:57:52 +0000
Received: by mail-ed1-x542.google.com with SMTP id v22so15970995edt.9
 for <linux-nvme@lists.infradead.org>; Sun, 13 Dec 2020 22:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SBDQ/ozr1+cMGjDjwKraN3A/q+s0aVrfJg3tJsBwW/c=;
 b=QvmF/vu64Ei8tR6QADdulsd7lyo1cn3N/x/le8e6+ICWMme6u7X1yVHpDnKhVV1PQu
 Ci3yOVEl0AVBmWSoyDWaBpd//YjERpJdy+Bni0re0LDz8TAHm7NrDKOPmoKrubq5MZ+2
 toB9XQXCemEc1yBiPwEk7S21aNkH6ZTAb0+Qdefdy/w44TZf5ag9SPLvrPnkPgoyTqV2
 PIC04Jaoe0g/SfzCNn6CzA2xcaLGe8ZkWY4AwmrvC2uixpwrStNMvX+2I1aMwGYmmUyQ
 Oh73T2RxBcRhpKRTo1ilj0rxuYeNHGtGyCU3rzgQ0obM6wvNwAxtLFDXLAXD5eTagEIL
 sIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SBDQ/ozr1+cMGjDjwKraN3A/q+s0aVrfJg3tJsBwW/c=;
 b=AouIlzKgEHX5xcMcswAmLwVPI0R0vxQtTWfhZhH4UNQ4c234HPxLKvrpD3Byh1nYIK
 riZ91hOPumqhlamxEAzEFHR5oZ7rSvdYJloxShdp7DAj1okiS70QMXxTE5NBcBDKb9dw
 AdMz6A87xQ6epnx2Ei8NZ/8Zq65WjaW22ouERb0YdN9UZRVj3aoR2QPW9i064ESFmGIA
 Zofg4Dkunp6DMuUKRoHIGsKybmaOLLpBdMbXtlD7mHw0mOQS0CClTQxHxShJhf2/q9dP
 rVlLTp3yD/IL8fyKMshziDIKzp7Wthatm8/D2RDyvdCQDkSgnrVilE1xCbQPtca1v86X
 f0cw==
X-Gm-Message-State: AOAM533IMghQix431XWgU2I1VwHMd0oemtSN8Bj2l2R9ZhGCC+kbQ/99
 4jJARrR8ySg8hAviruQWAELCBQDgT8gr9cqK1T8=
X-Google-Smtp-Source: ABdhPJy9fRCeat4gb5XKvmqoE7tXBBH2nVrfV3qBRQb1jokU/DqVjpgFa/P//03AdoLMtwqozlQM7SSYPoT/nhq5KVs=
X-Received: by 2002:a05:6402:17a3:: with SMTP id
 j3mr23295833edy.333.1607929067913; 
 Sun, 13 Dec 2020 22:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20201211135139.49232-1-selvakuma.s1@samsung.com>
 <CGME20201211135200epcas5p217eaa00b35a59b3468c198d85309fd7d@epcas5p2.samsung.com>
 <20201211135139.49232-2-selvakuma.s1@samsung.com>
 <20201211180451.GA9103@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201211180451.GA9103@redsun51.ssa.fujisawa.hgst.com>
From: Selva Jove <selvajove@gmail.com>
Date: Mon, 14 Dec 2020 12:27:32 +0530
Message-ID: <CAHqX9vYFudV1WX-R0oRBW7rKpCJzt_DgmW9FWZdDzOwMoCxfCw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] block: add simple copy support
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_015751_809261_19970646 
X-CRM114-Status: GOOD (  22.57  )
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
Cc: axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 snitzer@redhat.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, mpatocka@redhat.com,
 hare@suse.de, martin.petersen@oracle.com, joshi.k@samsung.com,
 javier.gonz@samsung.com, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 11, 2020 at 11:35 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Dec 11, 2020 at 07:21:38PM +0530, SelvaKumar S wrote:
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
>
> The default value for this limit is 0, and this is the function for when
> the device doesn't support copy. Are we expecting drivers to set this
> value to something else for that case?

Sorry. Missed that. Will add a fix.

>
> > +     cur_dest = payload->dest;
> > +     buf = kvmalloc(max_range_len, GFP_ATOMIC);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < nr_srcs; i++) {
> > +             bio = bio_alloc(gfp_mask, 1);
> > +             bio->bi_iter.bi_sector = payload->range[i].src;
> > +             bio->bi_opf = REQ_OP_READ;
> > +             bio_set_dev(bio, bdev);
> > +
> > +             cur_size = payload->range[i].len << SECTOR_SHIFT;
> > +             ret = bio_add_page(bio, virt_to_page(buf), cur_size,
> > +                                                offset_in_page(payload));
>
> 'buf' is vmalloc'ed, so we don't necessarily have congituous pages. I
> think you need to allocate the bio with bio_map_kern() or something like
> that instead with that kind of memory.
>

Sure. Will use bio_map_kern().

> > +             if (ret != cur_size) {
> > +                     ret = -ENOMEM;
> > +                     goto out;
> > +             }
> > +
> > +             ret = submit_bio_wait(bio);
> > +             bio_put(bio);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             bio = bio_alloc(gfp_mask, 1);
> > +             bio_set_dev(bio, bdev);
> > +             bio->bi_opf = REQ_OP_WRITE;
> > +             bio->bi_iter.bi_sector = cur_dest;
> > +             ret = bio_add_page(bio, virt_to_page(buf), cur_size,
> > +                                                offset_in_page(payload));
> > +             if (ret != cur_size) {
> > +                     ret = -ENOMEM;
> > +                     goto out;
> > +             }
> > +
> > +             ret = submit_bio_wait(bio);
> > +             bio_put(bio);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             cur_dest += payload->range[i].len;
> > +     }
>
> I think this would be a faster implementation if the reads were
> asynchronous with a payload buffer allocated specific to that read, and
> the callback can enqueue the write part. This would allow you to
> accumulate all the read data and write it in a single call.

Sounds like a better approach. Will add this implementation in v4.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
