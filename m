Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8C5EB64D0
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Tpur26Y/ARKY6+TM990Wsu3ePZMrhp4qlhZt3XSVxw=; b=iBeNk6p7CN30FlfeNC/JVFdJOY
	FDCyRMUmy4SQTA0wQ7u7BVrZPRrlMjpaLit4GCdegKJgCx/aqMJefsjBO5PwBtWIxa/DvLH5Ufujl
	1MyZM0lBZap/ZIe0iz2YkXQP6jBKvAWLMYCK3J/C7wGPrLI4ryEw90V1wNH+u5lonrM5N6oP+mZ8d
	eYvtW0/37jZ66myZjWXr3NjkybOHpqVvCgdcGrP1aJ4NcxOpg3D9jnW8alNhHih9mFxIxaLpaMjO0
	pW5t6ta1A+Rj6BmZA1eVxeqdExs65wdVbEEh0n4tWd9s67tcLK3jOhopsgqEZ2Cx+KmlpIBQ552XY
	NVlwQtKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q99Mw-008w4q-1P;
	Tue, 13 Jun 2023 19:07:54 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q99Mr-008w3a-23
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 19:07:52 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543d90cc675so3158357a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686683267; x=1689275267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tpur26Y/ARKY6+TM990Wsu3ePZMrhp4qlhZt3XSVxw=;
        b=MtRY8UJsJzilzMV+eKvM7yoTEjT4E/SOmMa7J0vLAx7zrI+O5dRQVu++Keg0Coo0q4
         oYs9P0M6XH3CMrkdeQdcbw1tI29FbX89GGiP7wRwci9HF8/HEe3tzc54u8yRUNDrZhGb
         95RFY2P3ngSotuFPy5nbMJNGbzVZDMUWWiRgu8Jy1FpzKsOyDggQEnq0XjiP1bUEejeg
         35WVEed9eKUJIMX80q0uWUP8Zn2As02fN/qJu6J688LLQwwyH7SJFK+exZoQScKVLrCE
         ozb++1q+1xJi27UWat4WZjDaFgXEBrVbu676erf5m9CMrQpykadpGtEG/YPMKpCO7zun
         Icxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683267; x=1689275267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Tpur26Y/ARKY6+TM990Wsu3ePZMrhp4qlhZt3XSVxw=;
        b=fK7gVEjGsOwc/3q9s+0pBtxAw0DcsRxJrR1vxDYVe3oAMQWADe8AHbB3zeI4cRUatl
         IgPC4wxyE8dyw0DNZiJilHPWFpalUzuxxrM1zdJQ3X2i69cItQGQntKxO/yJRk+piqgW
         geqrpeuHHeh5KfEgTbqpsQHD8bDZZmgEcgP8gSjcKGfsXu4abvUKvujHSJjx8ssDyuT0
         Uam3qzKTpCe3/cWoeXgzvSqRJA2Vh4QuYcaVdO/L+EQQXucXGhx8PfXFMRuPyOEDnT3E
         f6jnIcsrEvl3QhLlxdvmtPTx/f8Quz1KYhSeNYvKCHZ7vgMslyzqhjZwrkd0fyLcRTm1
         3iaw==
X-Gm-Message-State: AC+VfDy74BlHxrdkKJl9JLwTYfuYicXRseM1h3XoWUph+Ttao1qaCKDC
	dWXfR+UEYFP5eBVlzgkLgUDjVfzCbfrVFERBUWU=
X-Google-Smtp-Source: ACHHUZ4EjW1rgRX6mG45pd8+FsnN266Mr3BstYTy7GWcAG7FART14K4zglsaFzZ3hRGmwnlMjs03h5vUoO3AwfjX4SQ=
X-Received: by 2002:a17:90a:1b22:b0:25b:d3f9:af01 with SMTP id
 q31-20020a17090a1b2200b0025bd3f9af01mr6062724pjq.35.1686683266965; Tue, 13
 Jun 2023 12:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230606082134.20623-1-irvincoteg@gmail.com> <ZH9y9j2KBHRW+Olj@kbusch-mbp.dhcp.thefacebook.com>
 <CALL+9eipeO-pt1pyHpEq30R+2gq4YrKAUy=XsFCZZzJsK318bA@mail.gmail.com>
In-Reply-To: <CALL+9eipeO-pt1pyHpEq30R+2gq4YrKAUy=XsFCZZzJsK318bA@mail.gmail.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Tue, 13 Jun 2023 21:07:35 +0200
Message-ID: <CALL+9ehxXYZ-gq69Oq-FW4bFFoFteP8te0EBvrR=vSaUd9EaMA@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: warn and abort if shared ns with empty list
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_120749_673809_29F5035D 
X-CRM114-Status: GOOD (  35.09  )
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

I have investigate the question a bit more and I have come to make
these three observations:

In case of a hot unplug :

It looks like in the case of a hot unplug the ns heads that have an
empty list are removed from the subsystem's list of nsheads regardless
of the head's refcount; as per nvme_ns_remove. Therefore after a
hot-unplug then replug we should not see stale ns heads from before.
Even if we did see stale ns heads from before the unplug then the new
head might not be added because of nvme_subsys_check_duplicate_ids
failing


Why I think we only have shared namespaces when reaching this location:

In nvme_find_ns_head, when we check for the emptiness of the head's
list (meaning we've asserted (h->ns_id == nsid &&
nvme_is_unique_nsid(ctrl, h)) we should only have shared namespaces
because otherwise we would have two private namespace with the same
nsid while asserting nvme_is_unique_nsid.


The refcount problem:

If the list is empty and the refcount is not 0 we will take a
reference on the head that we will never put back.

Hence I think we should either erase the check for the head's list
emptiness if the condition never occurs or if it does, warn and exit.

On Wed, 7 Jun 2023 at 11:40, irvin cote <irvincoteg@gmail.com> wrote:
>
> But in the case you are describing, wouldn't it fail at
> nvme_subsys_check_duplicate_ids?
>
> On Tue, 6 Jun 2023 at 19:55, Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Tue, Jun 06, 2023 at 10:21:34AM +0200, Irvin Cote wrote:
> > > In nvme_find_ns_head if we find a shared ns but it has an empty
> > > list or its refcount is 0 we gloss over it and go to the next.
> > > Ignoring when such a case happens means that when nvme_find_ns_head
> > > returns NULL, we could create a new nshead with the same nsid. Hence
> > > we could find ourselves with two shared nsheads having the same nsid.
> > > Instead warn the user through dev_err and exit.
> >
> > Let's say you're holding a reference on the old "head" and then hot
> > remove the drive. The kernel will tear down the device and its
> > namespace, but the subsystem and empty head will remain due to that
> > held reference.
> >
> > Now plug the drive back in. Today, the controller will attach to the
> > previous subsystem, and make a new "head" for its namespace (because the
> > old one is empty), and you can continue from there, though the new
> > handle names may look a bit odd.
> >
> > This change won't make the re-added namespace visible to the user, which
> > doesn't sound right.
> >
> > > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > > ---
> > >  drivers/nvme/host/core.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index c8a471482421..175f1516083f 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3341,6 +3341,11 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
> > >                       continue;
> > >               if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
> > >                       return h;
> > > +             else {
> > > +                     dev_err(ctrl->device,
> > > +                             "Found shared namespace with empty list or 0 refcount\n");
> >
> > I don't think we're guaranteed this path is using a "shared" namespace.
> >
> > > +                     return ERR_PTR(-ENOENT);
> > > +             }
> > >       }
> > >
> > >       return NULL;

