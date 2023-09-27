Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CCBE80A8A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hD5lpR0AvKcm4fNhPw26ipGzbHbz6aRIU4+j0z3hYOI=; b=ELOjDWgTF54rovTFwroGRhaUxq
	Nli/y8OD3TmH3xhAIwRXTVfwcYNjalyiivvUY2MFX3K52mdO6NRoPQ8NWeY+Q5+bKw36FKh5qPKEO
	1GoJMEBD4G1HzEEfhzlysaz/URdo6v61/CbYTakfuJ2KgjO5/PRR2G2fqkNhv3QeIumxdOjYAubZL
	Pxx49hwHDAOblcNLowQRqI3cDQUMSwmk7kHehN6r6XpFTIl63ApHSDIvZtlI5E8Gz6qll/wt9lzc0
	+vByrNoeVxSIx6uTumslJyn9DG7bv3o+HsswMbid6zX0+67XEk9wEM+iEX+z7zYBMCXnOCBLi/0CX
	fXUS3mww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUo7-0012BE-15;
	Wed, 27 Sep 2023 13:42:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlUo4-0012Aa-05
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 13:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695822142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hD5lpR0AvKcm4fNhPw26ipGzbHbz6aRIU4+j0z3hYOI=;
	b=SpWENG4eVcwDha41Vc2cZJI9pCO0peTRo9PmjD5nPIgDsFTE8S8UYhXxnIXBaaVZkXB9n7
	5ozyxcpJnd9P8w01lvrM+YE6TftajWmWQT02JCDakcX726XRCZBnKsb4ej+l6UpKcRLKMp
	ZCwY4FBaFWn6E3Z3/pnGtxAejprA3YY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-TrWJennpN7eDeJ_d46QhpA-1; Wed, 27 Sep 2023 09:42:21 -0400
X-MC-Unique: TrWJennpN7eDeJ_d46QhpA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40554735995so82737075e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 06:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822139; x=1696426939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD5lpR0AvKcm4fNhPw26ipGzbHbz6aRIU4+j0z3hYOI=;
        b=NP23u6PTq8BV29YJ32l2DI+FyIUNrAsNBsW0CgLQH58XSXrrkCT42XMNwZnPtc47Ug
         HhX6SpqXCadkihbZAaUZddvC1sX4reVxQ/Z6QrpAY+2qJE38YgkQMlem47CgoKI3v07n
         p/s9BOgw5MhYOd5RXdfwYM4dvvyT/tzdtEfRfn9TGgC9agadbEeLI5euH5G8XNv+CPv7
         74REVSmS/d+Qce+ZLCAEzxQ088p+lfKdD0pZtxRwli9BMJTl1LEePJnnXUPoG44H8C/v
         MVcX470UXOV9zNln1WG3kZE0Aa3lyJMgszoABIMks6gUZtyxrh8AEgRBrt4fkIbp6Huw
         LBfw==
X-Gm-Message-State: AOJu0YyT6rxmoNDb1DgTQxmyZ2t+QXqsd8xhdOCkEqWjBJBL+Ek4sR8d
	31BLbYk5CayjzOGqzZDgDVH1pYBF2Mn/6tEZcyQ3PxnLVxseXcnVAWyfMLQKie7sEF+fpSW1D1I
	hGB/DkjwmS3EFMFyXl9u0/SBz/n2OcHfnNkN6srHWVSs=
X-Received: by 2002:a5d:5281:0:b0:321:68af:947 with SMTP id c1-20020a5d5281000000b0032168af0947mr1673537wrv.8.1695822139516;
        Wed, 27 Sep 2023 06:42:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOTQ0DS4nOPHUzvew2RBJzeFHDmz3Mv3R4tfOUzRS5xw13hRymOeJ6IHzNF6pCdVVnJtpz1d280pGZUG++zak=
X-Received: by 2002:a5d:5281:0:b0:321:68af:947 with SMTP id
 c1-20020a5d5281000000b0032168af0947mr1673519wrv.8.1695822139119; Wed, 27 Sep
 2023 06:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230925163123.16042-1-emilne@redhat.com> <20230925163123.16042-3-emilne@redhat.com>
 <2f021d5f-22e3-4dea-b8c7-418d5a5f0d90@suse.de>
In-Reply-To: <2f021d5f-22e3-4dea-b8c7-418d5a5f0d90@suse.de>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 27 Sep 2023 09:42:07 -0400
Message-ID: <CAGtn9rn2d3YStq04T-FwXWzs9L498VK3W-tn8pyefxsHgZYP9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme-multipath: Implement new iopolicy "queue-depth"
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com, jmeneghi@redhat.com, 
	mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_064224_161638_190268FD 
X-CRM114-Status: GOOD (  31.93  )
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

Obviously having to look at the number of active requests on all paths
for each I/O has a performance cost, but the tradeoff is that you pay
a CPU cost in order to get better path distribution/utilization and hopeful=
ly
lower I/O latency.  And, you only pay this cost if queue-depth is used.
Otherwise the patches barely touch the code path.

I am not an expert in modern CPU cache architecture, but the updates
to the atomic counters on the request/completion are all per-hctx, the
path selector only does a read, which I think is a simple (no LOCK prefix)
read on x86.  The cost would be in the CPU touching the cacheline.

I tried some alternatives that did not always get the most current value of
nr_active for *each* I/O but didn't get suitable behavior.  I/O requests ca=
n
be submitted very quickly, a lazy computation may not adapt fast enough.

-Ewan

On Wed, Sep 27, 2023 at 3:38=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 9/25/23 18:31, Ewan D. Milne wrote:
> > The existing iopolicies are inefficient in some cases, such as
> > the presence of a path with high latency. The round-robin
> > policy would use that path equally with faster paths, which
> > results in sub-optimal performance.
> >
> > The queue-depth policy instead sends I/O requests down the path
> > with the least amount of requests in its request queue. Paths
> > with lower latency will clear requests more quickly and have less
> > requests in their queues compared to "bad" paths. The aim is to
> > use those paths the most to bring down overall latency.
> >
> > [edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
> >        and compilation warnings, updated MODULE_PARM description
> >        and changed to use new blk_mq_queue_nr_active() instead of addin=
g
> >        additional atomic counters.]
> >
> > Co-developed-by: Thomas Song <tsong@purestorage.com>
> > Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> > ---
> >   drivers/nvme/host/multipath.c | 48 +++++++++++++++++++++++++++++++++-=
-
> >   drivers/nvme/host/nvme.h      |  1 +
> >   2 files changed, 47 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipat=
h.c
> > index 0a88d7bdc5e3..deea7fd4aa95 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
> >   static const char *nvme_iopolicy_names[] =3D {
> >       [NVME_IOPOLICY_NUMA]    =3D "numa",
> >       [NVME_IOPOLICY_RR]      =3D "round-robin",
> > +     [NVME_IOPOLICY_QD]      =3D "queue-depth",
> >   };
> >
> >   static int iopolicy =3D NVME_IOPOLICY_NUMA;
> > @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const s=
truct kernel_param *kp)
> >               iopolicy =3D NVME_IOPOLICY_NUMA;
> >       else if (!strncmp(val, "round-robin", 11))
> >               iopolicy =3D NVME_IOPOLICY_RR;
> > +     else if (!strncmp(val, "queue-depth", 11))
> > +             iopolicy =3D NVME_IOPOLICY_QD;
> >       else
> >               return -EINVAL;
> >
> > @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct =
kernel_param *kp)
> >   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
> >       &iopolicy, 0644);
> >   MODULE_PARM_DESC(iopolicy,
> > -     "Default multipath I/O policy; 'numa' (default) or 'round-robin'"=
);
> > +     "Default multipath I/O policy; 'numa' (default) , 'round-robin' o=
r 'queue-depth'");
> >
> >   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
> >   {
> > @@ -329,6 +332,41 @@ static struct nvme_ns *nvme_round_robin_path(struc=
t nvme_ns_head *head,
> >       return found;
> >   }
> >
> > +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head=
,
> > +             int node)
> > +{
> > +     struct nvme_ns *best_opt =3D NULL, *best_nonopt =3D NULL, *ns;
> > +     unsigned int min_depth_opt =3D UINT_MAX, min_depth_nonopt =3D UIN=
T_MAX;
> > +     unsigned int depth;
> > +
> > +     list_for_each_entry_rcu(ns, &head->list, siblings) {
> > +             if (nvme_path_is_disabled(ns))
> > +                     continue;
> > +
> > +             depth =3D blk_mq_queue_nr_active(ns->queue);
>
> That would require an 'atomic_read' on each path for each I/O.
> Which absolutely sucks for performance.
>
> Considering that we really are only interested in a rough idea about
> path usage, wouldn't it be better to use READ_ONCE()/WRITE_ONCE()
> for accumulating the nr of requests per queue?
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                Kernel Storage Architect
> hare@suse.de                              +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andre=
w
> Myers, Andrew McDonald, Martje Boudien Moerman
>


