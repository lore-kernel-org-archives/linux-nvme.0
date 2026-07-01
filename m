Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7BCC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E9sVWXuasqckfwZ49dQxCjUW+bfKxLQTh2NSjuiC/+g=; b=SfaTp0kQsrCdvBu0Ya6QS8HZSa
	cBY5MQ7TyT89IIlImseE02Em+cfb+Pmlk/9vWdW2T7qT3sNPrppfO4NGR+iz//NdG3M38oTmS0Sok
	jqClyttzE7pK77rr3/8rhn19rUTL/a2JDjcu++iAuxbRdyFNqJna1vUx9Rd3o6TPLV2oottRlH8zQ
	UFkcXiZ0VLkNzO4JV00MLYTpYa1JWppEYY7N0ORKoiXgJGKR4Try2GcZ2xf/+0zNl/U2vm25Bhe30
	AS/aeTvRGK3cCDngj9WHMyDoL3zAtH8UCViwV3u8M1Fy1NdvtJCV9SRjXnnMK20ITOo5zdL9AJ+kT
	MhxV+s3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf4HB-000000038yW-1bNC;
	Wed, 01 Jul 2026 23:23:29 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf4H8-000000038xD-0hJB
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 23:23:27 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-51c0006ea8eso6547391cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2026 16:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782948204; cv=none;
        d=google.com; s=arc-20260327;
        b=j6KCssQI6nP8ceVPYkX5YQQ/ndt0BGAYR+CnM8biTB47nNmN1vzGCrqxym55z8HBv+
         awGR71WRb5wh+9DWuitiQC8etD/jXWp9OT5j87BmvmIrEfVrIic86RohvgAL4+RhksDQ
         rK89eJqrqBIyXlAoHhG/NqIai9P2tYza2EXq/AehcqpLaaAT6e2IHIiPgK/Bo6ORmyQk
         VeM1pEIimwjcZBRn7sSwcLPVQ7yO3VrLcMrvN3Qk+tV5u8mGLBG1Wb/XrzUGwp3ECMfu
         llUtffGxgHfJqXX2A7NlZC+iPcQJZp8yJWpfeZc5U7BCid9Y4lwP/hhRqZe9IxSkv6kc
         HVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E9sVWXuasqckfwZ49dQxCjUW+bfKxLQTh2NSjuiC/+g=;
        fh=a9uGG2DhynMi7gosJiiCftqj1lyMZhspOt5kJzGmVrM=;
        b=gOYFpWc40Poru3KItxaxVaAr8HDJvtRMmd2tK6n1A7hcSa2NcUn2jYH8G5S6z2m921
         War5E4zn6q4TvHOpj+iiLcmTFiVNyxBEbatZXDgTEkOFj8gnkkqU5QC1XQA+m5+enyr+
         RBAuSYAFtp+SUjASPyCp5BrTufr1x3MM0wvegNepmu9sigsoYY+gcnSXGeoTgtnpfbxX
         8DBpAwNAgzNIj2VVS3PCRS33XIdcqvYPz+QbL2V3vHEecrNeyejsFLSJ0Y21Q9w7G4y0
         k5v78L8buA5tcItjGT/nvSlsBe+GMjFSl2WBBgl/zPqpRVZxYg5P4cIJfHW/Ghe3xChZ
         fyog==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782948204; x=1783553004; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9sVWXuasqckfwZ49dQxCjUW+bfKxLQTh2NSjuiC/+g=;
        b=GEOnZhLohC+VpUER/ph17Ww33S8bLeLirpRYl9QhtWBKN0xoqT6Gwzx9Okp1Jrdt9L
         p/4ZND+pJGC+/RW2ikMC2VZVhgwwrzmBJ4D1vY0xY7LNXGwRjrbRZkdpKghgMpzZhAU5
         McBdz2xNpxAqmFwTYzTm2JJPxC85ppW9n1dWhoJudddYRCZCgKRJkqaDtkWqqPS6OPv7
         PVJamROfIKHdCG5rXlhDp25RH7RfdtmqaLx7QV9gQ+p1zQ6UeDMl1LhTNic6e9rAoTQS
         tcNWEu9u1/vmolZ32gvPJN1bnYb1g16/SaXUtvx0uu40w/C3XYXR+0TnsSzPkPAeIsSG
         yWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948204; x=1783553004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9sVWXuasqckfwZ49dQxCjUW+bfKxLQTh2NSjuiC/+g=;
        b=ANNO+gyYsSX9CmgLcw8jLfQ2aKDlXcR/kuNZJVChimQDwpiarLaHnLggyVqbOrYhEY
         yakP8qaSUNSwPkTuBlHZCQD1rT28q3C8+LMzYzoU3v4fliM94WXEx//X6nQhZbLby80m
         /lhzFHqFnQtfRWr6IkHs65LMdiHLjmrLr0Wco9pJsU1fPVCPCaGMsy1oYZYzhdkmZf12
         wboEWODlHXqlvkPfRy5vBzaIFPPeVb7KZsRlcqf5MttQ1hna3st6OXs4beYwahc3JoY9
         rVHw01qInD8FbUmaL1+N/FDvoTVCAlOQZDDHq0jvOfEVLYs7KmTBuYdDGHbOEo52axNf
         r02A==
X-Forwarded-Encrypted: i=1; AFNElJ9IGrD4FNqA8VuEYRcygB6vfrprgXRB9sMpGI4+xiUrfH14A3m04oYtldrGcscJ2mXO/Z0tyoXCY+/0@lists.infradead.org
X-Gm-Message-State: AOJu0YxcXzEw5zZN53Hr/nzuGtSpKQfxCLK9OKrpcSRtoBY6AXkbYZZJ
	Tt6TU5c3e8Fz4jtKI1llQJ6+bbhKj5kG0yYGgihaBv++ezcaw113U5D+MsX5IcIBgx/yoxJZz32
	JLQKw7hcD7d7pnWd+lEq/jGNr2GK9TUWDnzeeRt8GqELJtGpe/owihW6Ohw==
X-Gm-Gg: AfdE7cmdWdncAtja1t4R9bJdn2sZBsaEmHDXzbxV2YJ0NUcpvjoLw7SCWm5aIcnx8hb
	3gBDzOZkjMHtxVNEc9BGTz1z3vf5F4sJIJ2eiSePS9q2Y6WVFnNkmaLhXDJ2sRXv4FPm0zENmfn
	Cn30hn4B5l8SbXEpMMZvphuAByLfjPlj9yxZ/r+HwiFwMCXAtPd3gL+M566IyZAKHi7dRKOvW6w
	m0ZlU3ftBWAmvcDX26bGf8RiVUwyeeYqBqALOVelC88q6EVw5NXfH4QGUonnubQqihNXknC
X-Received: by 2002:ac8:590f:0:b0:516:d557:15bb with SMTP id
 d75a77b69052e-51c26b00624mr49300541cf.46.1782948204428; Wed, 01 Jul 2026
 16:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260625212722.1302344-1-sgogte@purestorage.com> <9be94be1-2831-4973-b571-47bcd1c023aa@suse.de>
In-Reply-To: <9be94be1-2831-4973-b571-47bcd1c023aa@suse.de>
From: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>
Date: Wed, 1 Jul 2026 16:22:48 -0700
X-Gm-Features: AVVi8CfJNiOHR2iKrsjkgqmzfwhoEbmZbaU0hz9BxJjS3fzz8RG8P0a6aBMUzcg
Message-ID: <CAMof9cXY3jrYVq_Q8Wo04w96pQegQf23cucXDM977y8WUqjWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] nvme-rdma: parallelize I/O queue setup
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com, 
	randyj@purestorage.com, adailey@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_162326_415334_089E39B0 
X-CRM114-Status: GOOD (  23.49  )
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

On Wed, Jul 1, 2026 at 4:08=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 6/25/26 11:27 PM, Surabhi Gogte wrote:
> > This patch series parallelizes nvme-rdma connection and reconnection by
> > setting up I/O queues in parallel instead of sequentially. Allocation a=
nd
> > startup of each queue are combined into a single per-queue async work
> > item, so per-queue connection latency overlaps across all queues. This
> > matters most on high-core-count hosts with many I/O queues, where seria=
l
> > setup dominates connect time.
> >
> > Patch 1 is a preparatory refactor: nvme_rdma_alloc_queue() takes a queu=
e
> > pointer so allocation and startup can be folded into a single async
> > worker.
> >
> > Patch 2 contains the implementation for async setup of I/O queues.
> >
> > Testing on a 64-core host with 64 I/O queues shows nvme-rdma connection
> > time reduced from ~1.4s to 416ms.
> >
> > Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> > ---
> > Changes from v2->v3:
> > - Split the series into two patches: extract the nvme_rdma_alloc_queue(=
)
> >    refactor into a separate preparatory patch.
> > - Replace the atomic error flag in struct nvme_rdma_ctrl with a per-wor=
k
> >    nvme_rdma_setup_ctx { queue, err } struct.
> > - Fix formatting changes regarding line overflow indentation and nestin=
g.
> >
> > Changes from v1->v2:
> > - Remove separate workqueue and use the async API instead.
> >
> > Previous versions:
> > v1: https://lore.kernel.org/all/20260529001354.1003640-1-sgogte@puresto=
rage.com/
> > v2: https://lore.kernel.org/all/20260604195321.2232838-1-sgogte@puresto=
rage.com/
> >
> > Surabhi Gogte (2):
> >    nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
> >    nvme-rdma: parallelize I/O queue allocation and startup
> >
> >   drivers/nvme/host/rdma.c | 135 ++++++++++++++++++++++++--------------=
-
> >   1 file changed, 82 insertions(+), 53 deletions(-)
> >
> I would think that the same argument holds for nvme-tcp as the drivers
> are pretty similar. Can you update nvme-tcp, too, to take advantage of
> parallel I/O queue setup?
>
Hi Hannes,
Yes, It's in progress. I am currently working on it.
I will send a separate patch series once it's done.

