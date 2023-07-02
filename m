Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B6FEB64D9
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jul 2023 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWm1Q8sdAyt2jBRHxfN6SZALsllcNv2NuQ4A8MYAaTY=; b=NyOBuGTXXgEimYmNqCjr5BmoqT
	c0ZAvhUwwV/ca5B/as/GOS8hT6ukWEnV+0Mg5zJIjAz8iE0Tv4nEXMOMpBRBjfvRzlhXrVgXwXKBZ
	/heGyseL31vicje06gxjctMFwAxilI7ScL3wX0E1bgDL1CXApezrwpo9C/0Q8hirAweZxHUrX11nG
	oAgx23NsgL5kGCVcwgssgKlBzYuCJ7z75VxsVcG7nOadPUGIStgomzRFbVb5/Oz52x8mqCz49TqNi
	JtuQCLbqdywOTNCh6nROxV/XGWDGDe/Sj0Ag5wOpM8hZcWey8xi78VEyXsbbWAgrAkOdnp8ySupa4
	wU1UiXTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFxf7-007vkR-1D;
	Sun, 02 Jul 2023 14:02:49 +0000
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFxf0-007vje-1e
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jul 2023 14:02:44 +0000
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b699284ff4so57315371fa.2
        for <linux-nvme@lists.infradead.org>; Sun, 02 Jul 2023 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688306559; x=1690898559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kWm1Q8sdAyt2jBRHxfN6SZALsllcNv2NuQ4A8MYAaTY=;
        b=EpctdH794h3i58nZzk/DSybnH4Vu3Ctn9Vlh0M1msU4Xyps0F5i2hzNQ4Z8dZNsMRz
         cuGFHWA0PMIoj31b+WGU97fQ77iyXaDXBC3wBzI5iFCOdn4QsaS1pwwou31K+d85Px1e
         h6wry+RW4/m6beyOTh0kii4TqPJBBlnxNzptRmxy56565Vgssb2eC0Kqr8waMd3bC7OF
         aH4zgroUDl7p4Gtol1QXNzA72ZE9fVeqGRL9dxym0nVV8lvKnvpJJuhOJeJz2XZBLIh9
         /jRTZR0fE7lb+EMb/k/epE+OmuLL+HK6J9D4kogUusUPsy+3yEx7KVRTEyIU1Jfa5THw
         ZpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688306559; x=1690898559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWm1Q8sdAyt2jBRHxfN6SZALsllcNv2NuQ4A8MYAaTY=;
        b=KAgjfTQbui8d9FR5R3U6AtHp5pY3Z0aWNSqP9Ll6F4GnZD43BkWO8K0Kers9f/wF4J
         yowoy7BfqXldu13QbcIXQkkuC/SRtOBAn862JkGnK3IMB1+1QtaIJcv+kB/TBFBRrIWA
         kerRWRODZCjiAlLqrR8tRWyKO67X8qdDtilRIO0n6T1soiCeAW6tRBB5+8FaevKcOWnG
         tKcnyXupAaU6TUuzMCxM9WfscPTM+kNxtDRUd/2XvXM1tN4yrtWig+LTw0Kj7pw//hFd
         s7tATyeyKQQ6YLe3NCPAbJP7Q2C+wkKCc3SfL1+KcT/SHijEpT5cmnJmB18SN1fCwSH4
         tjDQ==
X-Gm-Message-State: ABy/qLaFnDBaTwSu3SNptUBfOm8dsHSCDCYHwLXICa2sKu5VHSZ5uO42
	uFQvFDnCXYkZNchE3t9ErEAl0LlhfLZhJ4Dsxnw=
X-Google-Smtp-Source: APBJJlFsglcAsKxo+iUG5Wbz7GLnZq5Pdr+tCj3SIkaxSPH54saGRar03rJ1W3vWHXY9RszuusXrssaZrkN/t5keQPY=
X-Received: by 2002:a2e:920c:0:b0:2b1:bfe7:457b with SMTP id
 k12-20020a2e920c000000b002b1bfe7457bmr5204579ljg.13.1688306559088; Sun, 02
 Jul 2023 07:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230624103502.8772-1-irvincoteg@gmail.com> <c68c669a-21e0-b257-5a1c-bfabf8d6f558@nvidia.com>
 <CALL+9egLCiTFyOpvt9tUhmkr-x3PoCzi3JeDxZ-FTCyP7BkDxw@mail.gmail.com>
In-Reply-To: <CALL+9egLCiTFyOpvt9tUhmkr-x3PoCzi3JeDxZ-FTCyP7BkDxw@mail.gmail.com>
From: irvin cote <irvincoteg@gmail.com>
Date: Sun, 2 Jul 2023 16:02:27 +0200
Message-ID: <CALL+9eiBWAQw=uL3qSH06NwAuYKbGzGAg8YeHitG5Qm4sj21fw@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: check id->mc before setting NVME_NS_METADATA_SUPPORTED
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_070242_549287_D8A65456 
X-CRM114-Status: GOOD (  30.05  )
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

Apologies I understand now, no need to check MC if both FLBAS and MS
are checked,
Thanks

On Fri, 30 Jun 2023 at 19:41, irvin cote <irvincoteg@gmail.com> wrote:
>
> >The MC field is primarily for use when sending a format command to know
> >what are valid possibilities. If the reported MS and FLBAS are out of
> >sync with metadata capabilities, then the controller is broken.
>
> Beware having MC and FLBAS out of sync does not necessarily mean we
> have a broken controller :
> MC could be 0 (no metadata support at all) and FLBAS has no way to
> express that, it can only indicate which metadata type was selected by
> the user.
> In such a case we could wrongfully signal metadata as supported when it is not
>
> On Tue, 27 Jun 2023 at 18:02, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >
> >
> >
> > On 24/06/2023 13:35, Irvin Cote wrote:
> > > The NVM Command set Identify Namespace Data Structure defines
> > > the metadata capabilities field (mc) that determines support for
> > > metadata. Check for the value of this field before enabling the
> > > NVME_NS_METADATA_SUPPORTED in the nvme_ns data structure.
> > >
> > > Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> > > ---
> > >   drivers/nvme/host/core.c | 5 +++--
> > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 3ec38e2b9173..465206b5cf6f 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -1841,7 +1841,8 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> > >                * Note, this check will need to be modified if any drivers
> > >                * gain the ability to use other metadata formats.
> > >                */
> > > -             if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
> > > +             if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns)
> > > +                             && (id->mc & NVME_MC_EXTENDED_LBA))
> > >                       ns->features |= NVME_NS_METADATA_SUPPORTED;
> >
> > this probably should go into the WARN_ON_ONCE above since it violate the
> > spec.
> >
> > >       } else {
> > >               /*
> > > @@ -1852,7 +1853,7 @@ static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
> > >                */
> > >               if (id->flbas & NVME_NS_FLBAS_META_EXT)
> > >                       ns->features |= NVME_NS_EXT_LBAS;
> >
> > we can check the NVME_MC_EXTENDED_LBA here and WARN_ON_ONCE if there is
> > a spec violation.
> >
> > > -             else
> > > +             else if (id->mc & NVME_MC_METADATA_PTR)
> > >                       ns->features |= NVME_NS_METADATA_SUPPORTED;
> >
> > same here.
> >
> > >       }
> > >   }

