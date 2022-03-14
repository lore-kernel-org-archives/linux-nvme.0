Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9166C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOlO6xEd5yx0VwcP8XWEvIq5tVmdflWzEZnP6Ir9Ujc=; b=msU29lUU8BSMIcP3+DnySbmeIn
	BR5yJZb12ttsYiMYNlpG6gdGgwceHWWiIKQqX5AccMykpuooIg9ELU4IJg+99p5jZ5JpFVhvSr8A3
	m1JgQgW5NFwud3dJFBkFs1mRvxbmBBU0wW2UIwT0jSLvR6vPVy+r3J6y+VoWodNHNjqwPfZ6Qr4pl
	Q3dua+hTkK9KQFaCHOajsKHHz+w0H4bTdC5ZxO4P+Umr6B75JuDptxLSe5O18qP7ddQJfbZoRfChf
	dWEjpT2AUWBltFCIvjHhsj6KztrurBWI+zuVzmLPa4ouqPPb3ZZDDZnQT6ajerBLmM13YEFP7Ng7d
	FLS0PpQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTkPP-005UYS-Il; Mon, 14 Mar 2022 13:06:47 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTkPM-005UXa-52
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:06:45 +0000
Received: by mail-lf1-x12b.google.com with SMTP id n19so26959550lfh.8
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BOlO6xEd5yx0VwcP8XWEvIq5tVmdflWzEZnP6Ir9Ujc=;
 b=eg5+VRwSBYiF1RlBhiqx8YBZfrTp8tDo2CBqIiHVxbW/cy7mI9mctOY5WA6nmA1sIU
 F52i8oNVLQ3VQHNOQ42PKTdDBtczLN7iHpElSmgiuhn7yu33HCY8LNHjSp5CQI5IRT4O
 hEPFfRJpfwJkbuCzQeDkkDseOxtWW/UtmW1Kud3IcO+kyNOWIPfJS3dS9EwfwQVHi9RL
 Rx9zDZ61EsdOMjPWC2CEULkoVP6ZRQRb0HWHRXq4M0H8rW6qtFairBPqk+9x0UFWOcWW
 fDHBFCuuW4enFi5mEKHF26oTEJ/lDz/+88pLprKNzBV5abucsFvpuH/ZPm/gxvQLA2KO
 414A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BOlO6xEd5yx0VwcP8XWEvIq5tVmdflWzEZnP6Ir9Ujc=;
 b=xPh3xVOekxLtqKkA0cmK5k0pbWunpSh0DNGuN3aXu1rcaChxfNWtYmg5FoYxOskLfd
 5n+IpEB+64/uGxfurqY0u9ETu5TufVKVnhxYRsTc9IwrRu2vId3XJGZ08y0YqpKkXfuu
 XaD5j3AfID6hIO79uC53zrKvy3rRPQKlHFh+x0c2UgizE8Clf+Wh1fdto0LWIZ7WeSCz
 /I5jxNfIUw8Z7pBfEazvpz3CIPslxYa+8Qs8n6+6/ixJ/J/wTaedqKP6XH8HAdng8LLJ
 /O7ITYQDVV+Elbj4M0kgASGaGZrS3rTuhn+16THj3raCi8DdGKwIJ0fMlEkdW2CDeVEG
 kgow==
X-Gm-Message-State: AOAM532MAT2zScskcSXHpf7EDkhrt2/Soo1RqWXcPvUNNq2JkU0VG19g
 1dhncyb2nM4QUI4uvwI8m7AMHVYBs+FTRNHu9Aw=
X-Google-Smtp-Source: ABdhPJyKsx6rDrIjB2kvaUMha+gSykJsyREiIENgJXnLx/p7Ae+DAKriux6QPaRucljomwqpUfAhuVOouegoMHfpJXo=
X-Received: by 2002:a05:6512:2353:b0:448:92cd:d1fb with SMTP id
 p19-20020a056512235300b0044892cdd1fbmr3524447lfu.355.1647263201992; Mon, 14
 Mar 2022 06:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
 <20220308152105.309618-9-joshi.k@samsung.com> <20220311064321.GC17232@lst.de>
In-Reply-To: <20220311064321.GC17232@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 14 Mar 2022 18:36:17 +0530
Message-ID: <CA+1E3rKnsdap7wb4RqO7HCBq8hxjF48k9NydMRAKht43xnhB9A@mail.gmail.com>
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
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
X-CRM114-CacheID: sfid-20220314_060644_250365_0F4D59A8 
X-CRM114-Status: GOOD (  23.75  )
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

On Fri, Mar 11, 2022 at 12:13 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> > +                  u64 ubuf, unsigned long len, gfp_t gfp_mask,
> > +                  struct io_uring_cmd *ioucmd)
>
> Looking at this a bit more, I don't think this is a good interface or
> works at all for that matter.
>
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
>
> Instead of pulling the io-uring dependency into blk-map.c we could just
> pass the iter to a helper function and have that as the block layer
> abstraction if we really want one.  But:
>
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
> I can't see how this works at all.   block drivers have a lot more
> requirements than just total size and number of segments.  Very typical
> is a limit on the size of each sector, and for nvme we also have the
> weird virtual boundary for the PRPs.  None of that is being checked here.
> You really need to use bio_add_pc_page or open code the equivalent checks
> for passthrough I/O.

Indeed, I'm missing those checks. Will fix up.

> > +             if (likely(nvme_is_fixedb_passthru(ioucmd)))
> > +                     ret = blk_rq_map_user_fixedb(q, req, ubuffer, bufflen,
> > +                                     GFP_KERNEL, ioucmd);
>
> And I'm also really worried about only supporting fixed buffers.  Fixed
> buffers are a really nice benchmarketing feature, but without supporting
> arbitrary buffers this is rather useless in real life.

Sorry, I did not get your point on arbitrary buffers.
The goal has been to match/surpass io_uring's block-io peak perf, so
pre-mapped buffers had to be added.

-- 
Kanchan

