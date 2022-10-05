Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B0C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=; b=JEhS2crt2CBI2HLArsXLX0oAKB
	88VfNnzQ66yaoboQlQjEIq/AsYg4/8HWZrwvZoAM/ofCgWFGBC/sDzmZ8C9nKeYaWYueNO8PBCK+s
	TvZYndWI6E7KCnO16S90YIIFNBDKn9auYohVANdndmAIprnIUSbuVIFYNxSwztE7Dp27ehGkQU1GS
	ok68sb7agg1UfPHac+lPsC3Knkfx6dOW++UeuZ0DIaFTi1UMOVk7rrWjRowRoPaEBx5Yp1cNBus43
	IINd4r38jXKbE3k1qUfQEO+XqOl6MVHYQCob6pf1WIyvyLXLBJCqghFZaGKXpJLWkSgFDhgPdwFeM
	FhOIdEXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og72d-00F3jZ-Nw; Wed, 05 Oct 2022 16:14:39 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og10f-00DQpz-22
	for linux-nvme@lists.infradead.org; Wed, 05 Oct 2022 09:48:14 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 70so15110360pjo.4
        for <linux-nvme@lists.infradead.org>; Wed, 05 Oct 2022 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
        b=dh/s9gbrJ1NP2il6j7m7392rb5m/0olUhLw6ywfYrwbm+b05mgthbXGVeHCne6faSe
         nEB8FWIww9/Mh3TPJYBTwQxHk9YQhBfOYEWSgISGS3x2V+1PSzpPW0fGwHCNvRUrDmsC
         V4LPjNBP1ZNWd2lWycmQ+cVlk2hOYpk0wbD3BQW90ktRdTfHVQoOGdzFfsVLA+UV8P0L
         yaYjHeb70WMgWdHpn0iX5L8LgNN78O1ThcYXr+GHqSaFRNBAWLFYqLr8IpSUK6wbVOaM
         BO7XUtm7Hdl6sqI52mxM7YweUuOKwjFV07IZc9k6gah2y9PsEzpdZlxqQ3TbFVT9xR+n
         gOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uAiOjs73GnPtRWDKlCBYpOmHeG3ElDSPTXYVbLmJn3Y=;
        b=Te/EclYB+GJHNkz7Z1b5k+ygAE6UEkN8QbdRyEKmzFYaJRcKiFbLJltK4rhJdC2Dts
         nOU9YHbmjT7ZSGqCuihXHEBU4vm2nvvMoSSsYtO3GFxSCT6L2V96W04I+M3ZtrPEXu5E
         2hY6PriStmV0Pu5r5nVGp2xYK1lhvzCbFUY8ZJ5bpk6b+eVcfoJXdkazNO7ZC/Ox4AIB
         095rq6374OnEAIBZK1HxIRVsoJ5mXqfLW4TwQ9ispQaE2T9ufW3LjG5+H9oN28y6c2a7
         d9kFkUPxSr6It5qJIQny3a14FlKiYONXagVAqYDmCrkCO6qXn+X2MDbaz1NuppK2Z046
         XnWw==
X-Gm-Message-State: ACrzQf0TRcD5TmCxxafKls2v8614ihNcvG4rE2zaX/OzJlljMIGqhYEs
	vlwa2/UHuxXBjJCxu9VuscK0U5xqk6Sf37gpyGdAzQ==
X-Google-Smtp-Source: AMsMyM6eqXlNc1atZOkkKgiG1yV3Y78Coz+AbzCXphLyt0GPdUFcokJxxEDnXeFGnrVe0bHv3fHf9rWqZFSPgK8TTJI=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr4350723pjb.164.1664963290949; Wed, 05
 Oct 2022 02:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221005032257.80681-1-kch@nvidia.com> <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
In-Reply-To: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Oct 2022 11:47:34 +0200
Message-ID: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
To: Chaitanya Kulkarni <kch@nvidia.com>, Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.dk, 
	efremov@linux.com, josef@toxicpanda.com, idryomov@gmail.com, 
	dongsheng.yang@easystack.cn, haris.iqbal@ionos.com, jinpu.wang@ionos.com, 
	mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, 
	ohad@wizery.com, andersson@kernel.org, baolin.wang@linux.alibaba.com, 
	richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com, marcan@marcan.st, 
	sven@svenpeter.dev, alyssa@rosenzweig.io, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, sth@linux.ibm.com, hoeppner@linux.ibm.com, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, hare@suse.de, bhelgaas@google.com, 
	john.garry@huawei.com, mcgrof@kernel.org, christophe.jaillet@wanadoo.fr, 
	vaibhavgupta40@gmail.com, wsa+renesas@sang-engineering.com, 
	johannes.thumshirn@wdc.com, bvanassche@acm.org, ming.lei@redhat.com, 
	shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com, 
	christoph.boehmwalder@linbit.com, joel@jms.id.au, vincent.whitchurch@axis.com, 
	nbd@other.debian.org, ceph-devel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_024813_166599_A3FBDE65 
X-CRM114-Status: GOOD (  23.65  )
X-Mailman-Approved-At: Wed, 05 Oct 2022 09:06:48 -0700
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

On Wed, 5 Oct 2022 at 07:11, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
> > Add and use the helper to initialize the common fields of the tag_set
> > such as blk_mq_ops, number of h/w queues, queue depth, command size,
> > numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> > is spread all over the block drivers. This avoids the code repetation of
> > the inialization code of the tag set in current block drivers and any
>
> s/inialization/initialization
> s/repetation/repetition
>
> > future ones.
> >
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> > ---
> >  block/blk-mq.c                | 20 ++++++++++++++++++++
> >  drivers/block/null_blk/main.c | 10 +++-------
> >  include/linux/blk-mq.h        |  5 +++++
> >  3 files changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 8070b6c10e8d..e3a8dd81bbe2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
> >       return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
> >  }
> >
> > +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> > +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> > +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> > +             unsigned int timeout, unsigned int flags, void *driver_data)
>
> That is an awful lot of arguments... I would be tempted to say pack all
> these into a struct but then that would kind of negate this patchset goal.
> Using a function with that many arguments will be error prone, and hard to
> review... Not a fan.

I completely agree.

But there is also another problem going down this route. If/when we
realize that there is another parameter needed in the blk_mq_tag_set.
Today that's quite easy to add (assuming the parameter can be
optional), without changing the blk_mq_init_tag_set() interface.

>
> > +{
> > +     if (!set)
> > +             return;
> > +
> > +     set->ops = ops;
> > +     set->nr_hw_queues = nr_hw_queues;
> > +     set->queue_depth = queue_depth;
> > +     set->cmd_size = cmd_size;
> > +     set->numa_node = numa_node;
> > +     set->timeout = timeout;
> > +     set->flags = flags;
> > +     set->driver_data = driver_data;
> > +}
> > +
>

[...]

Kind regards
Uffe

