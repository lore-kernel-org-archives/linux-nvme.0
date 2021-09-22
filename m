Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D559C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:20:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E0E61168
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36E0E61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RaqLqM99HjTyXP9gjwyNGoGXP8EJkb4EYeprvoqAmTY=; b=kwF5HnqIMB+i0P
	8ITE11Y0Uc9god6UMmQM6IC0q/RsuoEvoPvN2cXp70zAT4Lom+cCl0u/psp6EJ/k5IlnApW1Vyv3+
	u8nRQBnmoKZmL7197FHjf5UGwWF+2752lf56uYDNf7DKYwuxmVvskgQP4UPM973WYLqJqfXbk5MlP
	GSbvsVtZy3ocxjHElOGzsnZO9Evz+nXQLAWbGyDnFuVhpOOlbmEsdk+hVWKEA/s4WJATWQvbvWJ5L
	RH1v7sMi1Fy9dF/m7/fWd4rVzVKBcP07lLahgKS9ATI2Z+FmEhLXTv6vXmpA6bV6Sx2HSVBC2kBaS
	OG1+OU1+I47pvaDMMszg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwYM-007IdP-45; Wed, 22 Sep 2021 07:20:26 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwYI-007Ibv-2T
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:20:23 +0000
Received: by mail-wr1-x42e.google.com with SMTP id d21so3725254wra.12
 for <linux-nvme@lists.infradead.org>; Wed, 22 Sep 2021 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yIWDbUeb9eVjg614LLtNWsjwRP6rzLhm90LjC7m9WB8=;
 b=RwRvzT9WSFDWEGPN4KQntoyoN9ipb/5tISApBgsHlothq1kXIF5aXHcUN/dO9CmwtV
 sWaxPZy6pH9zOYKFkBWlKASBviamDk1iBLoWeSaPjFzevqo1WiVkluoOcFYsa7UtJ/Kn
 YSB/1VPwXfiDeGLBBHuxIfOGZam6a3PfJSBcscliVvyB20E2YqWScPgT4VZd0/9MfT2f
 cYjZVfhVu54I1qhIYw2lZNCStKeLudDrXO01tdAQ0HgVNpXhKiAVuDsVXMYcG2kKfNSd
 sKLx0XNRTMMjVJyY2CVDOl6/4eR2blOql769DwE7x7jqJb6MWeuxbtr29fUHuJAw22s7
 Y2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yIWDbUeb9eVjg614LLtNWsjwRP6rzLhm90LjC7m9WB8=;
 b=olp+UzjPlPiL7CJWwNnl1PxtTixc9TtrcHhzxh4la+tHnh7uahlV/dZBGOpx51XCol
 LuQMS/S16VK8LG00VeyIyZCsCYTAVGuJJIlQi3CFKDFI1V4VcTxURryo7uyN5XH7+7ga
 fnHkulrjYwVb/B2USxrzU8cq1DPsICO5evg+CnVSo9xQIGRWOzM2t/v1PASBJ5SRO8cq
 uqvXqznhSstmxxZWJri+84WbYNLxDywtQdYNnrkeS+F8slIFm9LDaq1B7/ACcyG4vl2E
 kxknFcTKC2RTxSnV/HG16uEv2g+2p5Pwnm6/KzfFeu0upHu0ZOwbpneiUuYPZ7VMMWdN
 uVmg==
X-Gm-Message-State: AOAM532jY6hH22S44sPBa97li+rM1/Vzjw1O3OX62qA++heSL7ejOGM4
 zf3kh7IESAYIbnT073gUg9M0UINx4pMjTByICUAWG9pc+gc=
X-Google-Smtp-Source: ABdhPJwUTr4MdOkW7jZQVC8cFh/55BoLEygUfs6oW2DUmxurxeZfGGg2LbmR3gRaKBkDxZ/arWKjQhNTPCtMU6lM9VI=
X-Received: by 2002:adf:8b19:: with SMTP id n25mr42586574wra.216.1632295219240; 
 Wed, 22 Sep 2021 00:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125923epcas5p10e6c1b95475440be68f58244d5a3cb9a@epcas5p1.samsung.com>
 <20210805125539.66958-3-joshi.k@samsung.com> <20210907074650.GB29874@lst.de>
 <CA+1E3rJAav=4abJXs8fO49aiMNPqjv6dD7HBfhB+JQrNbaX3=A@mail.gmail.com>
 <20210908061530.GA28505@lst.de>
In-Reply-To: <20210908061530.GA28505@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 22 Sep 2021 12:49:52 +0530
Message-ID: <CA+1E3rLeM=GZn1gR_KN7b6o8LHDistp1ZoHBb0N54ayK-2+tPA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] nvme: wire-up support for async-passthru on
 char-device.
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>, hare@suse.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_002022_198582_FE800161 
X-CRM114-Status: GOOD (  33.58  )
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

I am sorry for taking longer than I should have.

On Wed, Sep 8, 2021 at 11:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 07, 2021 at 09:50:27PM +0530, Kanchan Joshi wrote:
> > > A few other notes:
> > >
> > >  - I suspect the ioctl_cmd really should move into the core using_cmd
> > >    infrastructure
> >
> > Yes, that seems possible by creating that field outside by combining
> > "op" and "unused" below.
> > +struct io_uring_cmd {
> > + struct file *file;
> > + __u16 op;
> > + __u16 unused;
> > + __u32 len;
> > + __u64 pdu[5]; /* 40 bytes available inline for free use */
> > +};
>
> Two different issues here:
>
>  - the idea of having a two layer indirection with op and a cmd doesn't
>    really make much sense
>  - if we want to avoid conflicts using 32-bit probably makes sense
>
> So I'd turn op and unused into a single cmd field, use the ioctl encoding
> macros for it (but preferably pick different numbers than the existing
> ioctls).

I was thinking along the same lines, except the "picking different
numbers than existing ioctls" part.
Does that mean adding a new IOCTL for each operation which requires
async transport?

> > >  - that whole mix of user space interface and internal data in the
> > >    ->pdu field is a mess.  What is the problem with deferring the
> > >    request freeing into the user context, which would clean up
> > >    quite a bit of that, especially if io_uring_cmd grows a private
> > >    field.
> >
> > That mix isn't great but the attempt was to save the allocation.
> > And I was not very sure if it'd be fine to defer freeing the request
> > until task-work fires up.
>
> What would be the problem with the delaying?

When we free the request, the tag is also freed, and that may enable
someone else to pump more IO.
Pushing freeing of requests to user-context seemed like delaying that part.
If you think that is a misplaced concern, I can change.
The changed structure will look like this -

struct nvme_uring_cmd {
       __u32   ioctl_cmd;
       __u32   unused1;
       void __user *argp;
      union {
                struct bio *bio;
                struct request *req;
             };
       void *meta;
};
cmd->bio will be freed in nvme-completion while cmd->req will be freed
in user context.
Since we have the request intact, we will not store "u64 result; int
status;" anymore and overall there will be a reduction of 4 bytes in
size of nvme_uring_cmd.
Would you prefer this way?

> > Even if we take that route, we would still need a place to store bio
> > pointer (hopefully meta pointer can be extracted out of bio).
> > Do you see it differently?
>
> We don't need the bio pointer at all.  The old passthrough code needed
> it when we still used block layer bonuce buffering for it.  But that
> bounce buffering for passthrough commands got removed a while ago,
> and even before nvme never used it.

nvme_submit_user_cmd() calls blk_rq_map_user(), which sets up req->bio
(and that is regardless of bounce buffering I suppose).
For sync-ioctl, this bio pointer is locally stored and that is used to
free the bio post completion.
For async-ioctl too, we need some place to store this.
So I could not connect this to bounce buffering (alone). Am I missing
your point?

One of the way could be to change blk_update_request() to avoid
setting req->bio to NULL. But perhaps that may invite more troubles,
and we are not saving anything: bio-pointer is inside the union anyway
(in above struct nvme_uring_cmd).


-- 
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
