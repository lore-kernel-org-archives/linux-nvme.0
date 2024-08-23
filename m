Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93056C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7yB6VAHKbIzeQXG3zUqLPNdeA3vVRa0tJD9qSA+79M=; b=EXpMl10N6oibEX7tBpEMOlhsmM
	HJihbIIuCXL33j5oljCnrrJLHBc0wET2hYRj9NGAyPsUuZYvqWJFz0P+Uka28vRwvSVFLxGPq416M
	20EjRcA9Ajxf9305O4B1S88LfUqI2YSyQN4cd336WsTVbkNcPn1v8OurV+g1mh/xxKPFCwhOxQQQF
	ycdYSmQlRvUdq/GMXAc2oHafNnEXkAtkeXJT2Fc2Uk+xk+Y1oE77NrCvCfuhk1Twd6d0Vr/rnKq23
	eNhCjRyDgZOMTmz/G5Kr53OOge/W9MoIw4NBMgISAOZWa6HmdvKPYdk/OIZTbLN/3BTxVoRxZ0t/o
	su5J3hqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shWBr-0000000HIRG-1AUu;
	Fri, 23 Aug 2024 15:27:03 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shWBo-0000000HIQc-1cZS
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 15:27:02 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso2669827a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 08:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724426818; x=1725031618; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7yB6VAHKbIzeQXG3zUqLPNdeA3vVRa0tJD9qSA+79M=;
        b=ChZU/Zk9/FqY1uQBDz43Gbo5Gxfh2wZ5dwt/7xzQG6vb8jL59JJ9Q0T3PjCJ4Gw5Kk
         rYBVs+dl8oBXWEa2GPwgXvGubohVmkYfsPW269zghkaDngG17VMYcL2Ap0AmSJs7W5TD
         B/kra/gr+FC3fe5Btn6S7W3fXyrC3aEl3d7PQTEDD1uuKaQAhVVxXpGLVscUrd3ylcWS
         vr1xqKUJs02XOGAdEyY/+1vYSWW1sOeTphL4BsjlkAbBdZ++b6xNe53LwzXa++GaMs04
         zpoDjabgujvASBD+D/7YPxurH5bTDCr9u9X+7zXKb++CmcVjSYWGXjUdqM+FlSlIzETp
         q+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426818; x=1725031618;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7yB6VAHKbIzeQXG3zUqLPNdeA3vVRa0tJD9qSA+79M=;
        b=L6NA4bX5fXbiRKgX2WsXdHZ8LRzJzz+UFtP7WgkGi7MjNkYPNIF766GimW7u3XX/iT
         h/4ejO/gnHD5y2H1YXSj3MxS4av+T7jDY0qMfyLoqg7+vEb2IOTcYMedHn+mMtSexFbe
         yscD90egNIO5gYpI2cmXA2oq6uV4niH0Vg/3CqHJ3XRMYdrgilcF5zW0p248bT7AbOvL
         a7tdB60w702nP9KxBI0n3jVJYkp0/dCbitfDna0bf63MD7oNY/+qNhgPiXL2IVEkgFSb
         UkZZgR8ee3YvCpQtR4WlZbowHZSHOu+1oQnTNOwtxA85laKb9Hbj5yS9+65UWf9+3HvG
         xtbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVsInZfgG3IWJridePjdXx9bdWNDdCHUKAO8NIEi30xCm+aelw+iSFRKFGAGdKjAvOtMiF0RUe6O3X@lists.infradead.org
X-Gm-Message-State: AOJu0YwFCY//qHkaPK7nhRrHUvJrRfAdBMmKQd7dv+4wtVKLVpuJnS7X
	AU9XGCjF8gTidpL15R9E/VXpXI+TWmUtuJ+LDpXzd7aABWGjbJq8LL+ZCm502cU=
X-Google-Smtp-Source: AGHT+IEPBRrvqYLczLrz5uAUIgdvZeys8IrsInsUDRj6hYXkpiBfN0r+7q3YG4sZ3xitUwGrl8+FtQ==
X-Received: by 2002:a17:907:d90:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a86a518b32amr204451666b.5.1724426818019;
        Fri, 23 Aug 2024 08:26:58 -0700 (PDT)
Received: from ?IPv6:2003:de:3736:a00:d7e5:6139:e909:29dd? (p200300de37360a00d7e56139e90929dd.dip0.t-ipconnect.de. [2003:de:3736:a00:d7e5:6139:e909:29dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f47c579sm270822966b.153.2024.08.23.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:26:57 -0700 (PDT)
Message-ID: <5476d3dc188caea1fa0e7cdedcdc07f58b4ec643.camel@suse.com>
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
From: Martin Wilck <martin.wilck@suse.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
 <hare@suse.de>, Daniel Wagner <dwagner@suse.de>, Stuart Hayes
 <stuart.w.hayes@gmail.com>,  linux-nvme@lists.infradead.org
Date: Fri, 23 Aug 2024 17:26:56 +0200
In-Reply-To: <ZsiQ4yCji0PexMQ-@ryzen.lan>
References: <20240822201413.112268-1-mwilck@suse.com>
	 <ZsiQ4yCji0PexMQ-@ryzen.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_082700_449304_512AC409 
X-CRM114-Status: GOOD (  27.73  )
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

On Fri, 2024-08-23 at 15:38 +0200, Niklas Cassel wrote:
> On Thu, Aug 22, 2024 at 10:14:13PM +0200, Martin Wilck wrote:
> > For multipath devices, nvme_update_ns_info() needs to freeze both
> > the queue of the path and the queue of the multipath device. For
> > both operations, it waits for one RCU grace period to pass, ~25ms
> > on my test system. By calling blk_freeze_queue_start() for the
> > multipath queue early, we avoid waiting twice; tests using ftrace
> > have shown that the second blk_mq_freeze_queue_wait() call finishes
> > in just a few microseconds. The path queue is unfrozen before
> > calling blk_mq_freeze_queue_wait() on the multipath queue, so that
> > possibly outstanding IO in the multipath queue can be flushed.
> >=20
> > I tested this using the "controller rescan under I/O load" test
> > I submitted recently [1].
> >=20
> > [1]
> > https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.=
com/T/#u
> >=20
> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > =C2=A0drivers/nvme/host/core.c | 8 ++++++--
> > =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 33fa01c599ad..e2454398c660 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2217,6 +2217,9 @@ static int nvme_update_ns_info(struct nvme_ns
> > *ns, struct nvme_ns_info *info)
> > =C2=A0	bool unsupported =3D false;
> > =C2=A0	int ret;
> > =C2=A0
> > +	if (nvme_ns_head_multipath(ns->head))
> > +		blk_freeze_queue_start(ns->head->disk->queue);
> > +
>=20
> From someone reading this code, it looks quite similar to
> nvme_mpath_start_freeze().

That function takes a struct nvme_subsystem as argument, and walks over
all namespaces in that subsystem, whereas here we're just acting on a
single namespace.

> Perhaps create a new helper, with proper kdoc, and possibly also add
> kdoc to
> nvme_mpath_start_freeze(), so that a user can easily tell (from the
> kdoc)
> when to use which function.

What's the benefit of introducing such a trivial helper, used only in a
single place of the code?
Thanks for the suggestion, but I'd like to see other maintainers'
opinions about this.

Thanks,
Martin


