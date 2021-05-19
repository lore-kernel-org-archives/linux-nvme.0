Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A10C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 14:30:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432E96135A
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 14:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E96135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4e7Kj+eoVcx8DTLAxoTl7PtMjDx7wi62L2JRsu2lv64=; b=dQ+Rm4CM3mtyOI/15ASUkj4I4
	gHsszFtWpGv/s49XaanvLD4gQsuVCz9JKjgDzLZoL20mtsytSjYZopjDLuAFVn0KIwTL906aUpZm6
	deVmz0vngg7K7I7slaNCO8E9GMecLjLvlonkgCyD0506FqYjCsFxAZTaBKrZ8fl2cC0CqGfMqZiLd
	01iPKbPQhwxPZvVxt+9o1m4hEdLEf8Y6Enn8+F35o3JA827MaIZCH6Eb3zOTSPRKmvuSFKuD9Of8n
	ztNPqCZkOSDWEpAZWtKO5IfG+t+r4Ik02rYr7Ot2EnY+qL3/eXFFz6LfKruOfOtoYnmTZaNRyDty8
	Q9FkZS5pQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljNCs-004GVf-38; Wed, 19 May 2021 14:29:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljNCo-004GUT-BH
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 14:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tcFFwK4ubLQGtrrFPo8oxWhQ57twWHPmskXcZ4gjHVg=; b=vQZ0oE/Tmcgmrmfr8q7uHojZcn
 e2cOK30LWc+R42vpiAYJ4wQ+3ih9wgFdcXeSuAPvEIPXMwd3qEpoiyePSRsmwvkPcJPdeBABbpD1L
 dJfHoaN8WBP/Nd3+8zCqILKJMLk0B9/1vhoAHwYonCQviudd2iVp9Nxxnud23HIwUss5GILgUKL9s
 xP909t0mJwBNnDQn6HYolWDG/s4CUXIDS3M56B8hlQE8tR07ToO4H3pQQBMAhvLA5dwKINVKiAr+4
 k6jspPJRBiHlq5BBnT5c1nqNiZfugjOgejRIFMFK4P7E9JXYvgFYWZZpBlnKcBCyRcMYC2UVYODP6
 +D4zyMew==;
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljNCl-00FXke-Nl
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 14:29:49 +0000
Received: by mail-ed1-x52e.google.com with SMTP id i13so15600847edb.9
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tcFFwK4ubLQGtrrFPo8oxWhQ57twWHPmskXcZ4gjHVg=;
 b=BtHDAoL/+vmnzwn32dO9VJomqAbxA3WrOWdvMI/O2GfiBg4CuHAKVMC6I0vwHgsuZ4
 CylF+U8iERN8XVcl3Ql7hVq5hT1OB4jIae3YAOAQcFb9n3q+J9/704oX2lYVRfWy4y72
 6fFwGXHUuXsHqinRvlK31XoT17jOGw09GBuRtWNk1d3gaLa3UTu9TssB/jyRRXhqRzcq
 Y/KiN3VxvWrCVUgbgfgR/XgA58pZeRt6/xzgKlYIbwiHLXT0zc72GmA3Hs9B6uqLf6mL
 9XqsvureCREqDo8pcdj2Wt4maaSPk/3m/eFflPUKdIKdNymktGxgYs/GF/fkTugIL6DA
 cjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tcFFwK4ubLQGtrrFPo8oxWhQ57twWHPmskXcZ4gjHVg=;
 b=U0igmQtGpvkHQcScyBLFsqxzkjQXuR29+7OEL1dP670C6nKm4UqsLGlgJ1hra8z/pO
 XwYbE69Ftw1eVWDf/Bz+91nv4PESP1grZfSSLEA9486gK+iEmDhtPlMTLV4m+w96NxLe
 yMpQcBJqVjnp3K40589mdl5JW2B21aBbbHH66/aoPh2hmlGBKXSCSTKcunNBhL76rtjC
 LjuOwWTpLVIUMD6StnKIPzP25/85Q36zoJjnJtROybKGsb7CpDQS3aZHHUSrB6IkgdpG
 p94v4k/fsrCenaD5o2Rqjoqr7SQY3rHFvFUsbBJEf9QxT121opzpBmR8mUm8ddxaQ9hH
 Vzjg==
X-Gm-Message-State: AOAM531lVs9W7sSkIu1pePBjiWyYPAFCD3xy9vFi+EBxFqtuY3UkRKpK
 h1eu20rHfAtEzEaqlYD9utyqG4eVgOJU+Vysmq4=
X-Google-Smtp-Source: ABdhPJwqtoQx+cnuGcYqEPWSAjCfXjw+cIyi4i2isyfaocEzPn/TbP92EHZy+uW7JQnKdl20uXZgyXGNZab7i0NbJSI=
X-Received: by 2002:aa7:da03:: with SMTP id r3mr14857780eds.121.1621434584929; 
 Wed, 19 May 2021 07:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-18-smalin@marvell.com>
 <YKUFLVHrUdzEsUeq@unreal>
In-Reply-To: <YKUFLVHrUdzEsUeq@unreal>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 19 May 2021 17:29:32 +0300
Message-ID: <CAKKgK4z+Ha9cv0zHtjrBiTb=K9MvWZB-kzg5CP9__pCJYmyNVA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 17/27] qedn: Add qedn probe
To: Leon Romanovsky <leon@kernel.org>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 pkushwaha@marvell.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_072947_796476_BD93C08E 
X-CRM114-Status: GOOD (  26.13  )
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

On Wed, 19 May 2021 at 15:31, Leon Romanovsky wrote:
> On Wed, May 19, 2021 at 02:13:30PM +0300, Shai Malin wrote:
> > This patch introduces the functionality of loading and unloading
> > physical function.
> > qedn_probe() loads the offload device PF(physical function), and
> > initialize the HW and the FW with the PF parameters using the
> > HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
> > are used by the qede, qedr, qedf and qedi device drivers.
> > qedn_remove() unloads the offload device PF, re-initialize the HW and
> > the FW with the PF parameters.
> >
> > The struct qedn_ctx is per PF container for PF-specific attributes and
> > resources.
> >
> > Acked-by: Igor Russkikh <irusskikh@marvell.com>
> > Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > Signed-off-by: Shai Malin <smalin@marvell.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/nvme/hw/Kconfig          |   1 +
> >  drivers/nvme/hw/qedn/qedn.h      |  35 +++++++
> >  drivers/nvme/hw/qedn/qedn_main.c | 159 ++++++++++++++++++++++++++++++-
> >  3 files changed, 190 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
> > index 374f1f9dbd3d..91b1bd6f07d8 100644
> > --- a/drivers/nvme/hw/Kconfig
> > +++ b/drivers/nvme/hw/Kconfig
> > @@ -2,6 +2,7 @@
> >  config NVME_QEDN
> >       tristate "Marvell NVM Express over Fabrics TCP offload"
> >       depends on NVME_TCP_OFFLOAD
> > +     select QED_NVMETCP
> >       help
> >         This enables the Marvell NVMe TCP offload support (qedn).
> >
> > diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
> > index bcd0748a10fd..f13073afbced 100644
> > --- a/drivers/nvme/hw/qedn/qedn.h
> > +++ b/drivers/nvme/hw/qedn/qedn.h
> > @@ -6,14 +6,49 @@
> >  #ifndef _QEDN_H_
> >  #define _QEDN_H_
> >
> > +#include <linux/qed/qed_if.h>
> > +#include <linux/qed/qed_nvmetcp_if.h>
> > +
> >  /* Driver includes */
> >  #include "../../host/tcp-offload.h"
> >
> > +#define QEDN_MAJOR_VERSION           8
> > +#define QEDN_MINOR_VERSION           62
> > +#define QEDN_REVISION_VERSION                10
> > +#define QEDN_ENGINEERING_VERSION     0
> > +#define DRV_MODULE_VERSION __stringify(QEDE_MAJOR_VERSION) "."       \
> > +             __stringify(QEDE_MINOR_VERSION) "."             \
> > +             __stringify(QEDE_REVISION_VERSION) "."          \
> > +             __stringify(QEDE_ENGINEERING_VERSION)
> > +
>
> This driver module version is not used in this series and more
> important the module version have no meaning in upstream at all
> and the community strongly against addition of new such code.

Will be fixed.

>
> >  #define QEDN_MODULE_NAME "qedn"
>
> And the general note, it will be great if you convert your probe/remove
> flows to use auxiliary bus like other drivers that cross subsystems.

qedn is simply fitting in with the existing design of qed/qede/qedr/qedf/qedi.
Changing the entire multi-protocol design to auxiliary bus is being studied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
