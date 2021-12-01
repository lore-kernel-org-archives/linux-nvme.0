Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B38C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Dec 2021 02:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42m790/IGCobksWss1SnqgLm+pgiOFsHShM/cPNqVew=; b=a41ttCVOl/gu5mqT3HFVfExOaI
	1AdiRs1vojWpVFRFD/a0grxuNpGkkHdnMrkghPJGBJWTXXsoS5gdVtlc9VgjRLMyj8R6opYTzMRMP
	eIjq0xIoeiKTOvXQxVW8an/RKEBRe6UDbg7F0nJe/IbdaMBNPnCF6SrZngKzG0T9UmBjtEUO/5YIU
	jj0k2O668ZWLa+L8mryfiHfbqYMqp6zGG5l6Bp+fTQvbCZGR0v4zUXJLxHE2hFvpvDucOtGiVd50P
	hPkpDM++gIKg8jhjMwBVBStN6FxmOgZFtGRhcJXNpye3QfLHz0kHPHWxRBrojIf6SjdE4PqZiNFMa
	stIHu0sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msEzl-007Hzn-T6; Wed, 01 Dec 2021 02:05:17 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msEzi-007HzB-MH
 for linux-nvme@lists.infradead.org; Wed, 01 Dec 2021 02:05:15 +0000
Received: by mail-ed1-x534.google.com with SMTP id x6so94518729edr.5
 for <linux-nvme@lists.infradead.org>; Tue, 30 Nov 2021 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=42m790/IGCobksWss1SnqgLm+pgiOFsHShM/cPNqVew=;
 b=p9fqmzZg9PnnKxpdk0nUus8Val7ofxjRnlBL6LmhrlLq9sG2JksQ6WRwVK7OnSAo4U
 v4UaEeEGAiDbX/IbGk+0wB8MNsMxPIx3tDCWDv5lJRot8LbbvhV4XK1Lavo7GIGDMdTW
 ew4Sm+rRUKMsUfsN4BReHOO9wH6FkewypwsRzO4Isseb64JR0Kyvh0D1qoEpv9833Lo2
 KQ/gP6dA5KoeyuFfVhQpQ8LUZ0KA2RDyrZH884OwH79WLn0avJpNz/Ig2lUdQRAyWJFa
 vElftcF1oHLggR2MXv+LminZcUK9t1McDeSM5amDHRaum9YD41//D3gGSrn7hTUpphsF
 Jhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=42m790/IGCobksWss1SnqgLm+pgiOFsHShM/cPNqVew=;
 b=TcwiNi6LzwdJeE6M2PSZijQQSiSlSUhE13xrZr5zCLXqlwkfIdcR97/wB+jD2UoQbx
 +RGS9gkgf40P9HJb/1X2XMsrpWpEZkhLIrJWdpzXzubvhJxZGjRlICWQeGeaoX6iCrG1
 5LNFMcaM2Jr/VQQliWrL4ZeCelXuLHkIwKt9vj3qmQ6kpHsLiofvymhMRlNJDJjsyZd6
 YxUEy/VHsnctvigLM28V6Wcs/AhXuRUWX4JoWdSJgVImW0wQUUSvR95d2Pz81lVeWN/u
 +neG0T2JHxHaeduKAi1QDNzLaJu6eLL5RZ+FbzB+IO3K3gHY/Ha3oBfQRbe2Fqc+BOFf
 VbRw==
X-Gm-Message-State: AOAM533zAtNIHXyPTWJIxdG9ZxDtK9kKdM/W6bys4M+Rdq2EP3hnx+Tb
 Gx7+L4t0UOKodW8EU2C3WllYnePvf32uuDZdLMo=
X-Google-Smtp-Source: ABdhPJzA7jfhRFpemSo5Uszm7kBcaFbtdUFFGtyZcN7KnARwI28LZLMZVWhkafHSKbJrfcD3JF5S6BYNiw+cthcJmAo=
X-Received: by 2002:a17:907:3d94:: with SMTP id
 he20mr3598141ejc.75.1638324311884; 
 Tue, 30 Nov 2021 18:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
 <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 1 Dec 2021 10:04:46 +0800
Message-ID: <CAD-N9QV2NjeM_Rb0MuotXLefooX3CwXySmyjNXQhfyVVPPADEg@mail.gmail.com>
Subject: Re: [PATCH] driver: nvme: fix missing error code
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_180514_776959_455B2B98 
X-CRM114-Status: GOOD (  22.01  )
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

On Tue, Nov 30, 2021 at 11:48 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 09:50:14PM +0800, Dongliang Mu wrote:
> > Smatch reports:
> >
> > drivers/nvme/host/multipath.c:865
> > nvme_mpath_init_identify() warn: missing error code 'error'
> >
> > In one error handling path of nvme_mpath_init_identify(Line 865), error
> > is not initialized as an errno.
> >
> > Fix this by assigning error to -EINVAL.
>
> Nak, the code is correct as-is. Returning a negetive error will abort
> the initialization process. We don't need ANA support in order to manage
> this controller, so failing a controller for an optional condition
> isn't helpful.
>

OK, I see. Let's ignore this patch.

> The other parts of this function returning negetive errors should be
> fixed to return 0, though.

Do I need to modify the error value to zero and submit another patch?
Or you will take care of it?

>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/nvme/host/multipath.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 7f2071f2460c..2cbeb6d6b064 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> >                       "ANA log page size (%zd) larger than MDTS (%zd).\n",
> >                       ana_log_size, max_transfer_size);
> >               dev_err(ctrl->device, "disabling ANA support.\n");
> > +             error = -EINVAL;
> >               goto out_uninit;
> >       }
> >       if (ana_log_size > ctrl->ana_log_size) {
> > --
> > 2.25.1
> >

