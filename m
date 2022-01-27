Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7313BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5OC6d3lGaiCactmd/xMDmrnP0MikjxAmGKwgY6B8rNA=; b=AU4TPHxBrszyjoddBFRUOiTR5z
	TtIz+91c+JWHfzwriv1LeLQd0jAsT05XrWjj7LDCh1nXv2+MnJNr/jbD4T8gB44lhPAMiDWLhfU9o
	+hJbEKlfGPcsNgwAxesPCUN5lHOqZeKDoz0T7qmDCtuAcFr9P968N8wdspbxR2Gx36Ta6oRrVKwqg
	bTP1xCvJVK1z37jdYaKrx3JZDaiOrnqQ2bKOUL/srrde2EFzRt6syBs32DXn9cW0qKE+vTkaOgKzb
	7ICLAehvhxNQAbCnFuX85U2OK/9o4Ry65crWWSshqLtiEHLtKC5s3Ng2Ekeo93LXtJHvvK4UsW89Y
	Cp+WySJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD5v6-00G5xR-TS; Thu, 27 Jan 2022 14:38:40 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD5v2-00G5w2-D9
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 14:38:39 +0000
Received: by mail-pj1-x102a.google.com with SMTP id h12so3140695pjq.3
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5OC6d3lGaiCactmd/xMDmrnP0MikjxAmGKwgY6B8rNA=;
 b=BRy4W+xYso6FWfmNoAQig2ZnwCU+Pqrczm0lNLitMBWjXPxZzaT25dQCnSvtDuPWEW
 mSXC4yFdQrnzSuc0QlaVDDXjXbc3IU7QzaBPs5iVma0PKtjWWmfSGisU+r5fRLK33NKF
 aIrfYxdqQlN6eJ0rNPsqEJwtmi4JkPHFo6T8orNS23sn0lGKJMcxu00urRsT4Xuh7vLU
 lTvuA/At8LN3g1iHHKv7avFwjgtkdjQoHfhSgpktyzfI4AhotBsqEuCMsdKhcqrhyTSK
 r74gA21UDb45f5+ZppsGpR9AGK/lQjmDfhQmZXP/1heUU1aIixqhe3t1uqAhJiWH6Qn7
 qeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5OC6d3lGaiCactmd/xMDmrnP0MikjxAmGKwgY6B8rNA=;
 b=MQRCiyZuKFmVvpTV3/4xdcvzTgZabvjOmHH2YMeXoCxGvJmbVr3LSHJE+g5F46Botf
 3/y6xGF8cIKg2yrtGchlOC8k3b1hGXOmeS2oZyTCKU8HQlYcFdWRmiQKe1HCTVRAVXxk
 i6ovpnC4pPicExliypR8EWwz0lyuXWIAMfBratgcOrmAs4OJbPvKghP68KFiRUT7nTyN
 AXR0hub4ExBPExLrm80p25MSmoKBjwLnj9b31xlIKOONcu2LNx68bPJkVSVtifoLOmRy
 xVMaS2C2dVp/qu7dhYnPg0TM+uzs7Q3NFySU8IXF6qc5SAVxOa98A++t7uK1t8M7tVK4
 1iWg==
X-Gm-Message-State: AOAM5334mWNfp0PyGvCKVipUg6Cs5Ag2oqahc3CMygfvKmfBt+Hrtgfn
 XJSXk1QsmuxpUTJFXtuAkMKO4nOpyH6nJE7Qh8A0B5Bx
X-Google-Smtp-Source: ABdhPJybFXXY9mmFQkfuJzQBLrraeIouIJJp9xPpVJ/3yElzmYBK/hQYvnyadQ53YF4fstj50Vni0rIpjiDgMzuCKI8=
X-Received: by 2002:a17:902:c652:: with SMTP id
 s18mr3688054pls.1.1643294314524; 
 Thu, 27 Jan 2022 06:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20220127082536.7243-1-joshi.k@samsung.com>
 <CGME20220127083034epcas5p4aaafaf1f40c21a383e985d6f6568cbef@epcas5p4.samsung.com>
 <20220127082536.7243-2-joshi.k@samsung.com> <20220127092746.GA14431@lst.de>
In-Reply-To: <20220127092746.GA14431@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 27 Jan 2022 20:08:08 +0530
Message-ID: <CA+1E3r+ohVCy4dTPwYLmPCsH6y6R2zg0GGv_-NQybP83Y1yfLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: introduce and export blk_rq_map_user_vec
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_063836_491187_949A5807 
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

On Thu, Jan 27, 2022 at 2:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jan 27, 2022 at 01:55:35PM +0530, Kanchan Joshi wrote:
> > Similiar to blk_rq_map_user except that it operates on iovec.
> > This is a prep patch.
> >
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >  block/blk-map.c        | 19 +++++++++++++++++++
> >  include/linux/blk-mq.h |  2 ++
> >  2 files changed, 21 insertions(+)
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index 4526adde0156..7fe45df3e580 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -577,6 +577,25 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
> >  }
> >  EXPORT_SYMBOL(blk_rq_map_user);
> >
> > +int blk_rq_map_user_vec(struct request_queue *q, struct request *rq,
> > +                 struct rq_map_data *map_data, void __user *uvec,
> > +                 unsigned long nr_vecs, gfp_t gfp_mask)
> > +{
> > +     struct iovec fast_iov[UIO_FASTIOV];
> > +     struct iovec *iov = fast_iov;
> > +     struct iov_iter iter;
> > +     int ret;
> > +
> > +     ret = import_iovec(rq_data_dir(rq), uvec, nr_vecs, UIO_FASTIOV, &iov, &iter);
> > +     if (unlikely(ret < 0))
> > +             return ret;
> > +     ret = blk_rq_map_user_iov(q, rq, NULL, &iter, gfp_mask);
> > +     kfree(iov);
> > +
> > +     return ret;
>
> I see very little point in adding this function vs just open coding it.

Fine, I will kill this and open-code in nvme instead.


-- 
Kanchan

