Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649EC43460
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 15:32:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19C9611AB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 15:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19C9611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JhrhAKq4mupGhd50cNvlWVMYN55tCy5r2SyEV4EqD48=; b=LOv3sX5SYIEvfo4ir+zKQQz+U
	2SPG7o9I8XWSBj28osJxyRxmDTHvjkwHrD2sq8XCDEpfTXVsmo2T27yTC8Jcp4CYqvXq4BGPvrQqD
	g95aax7i1Gk9i0JlMHcprWeT5FZEpKGkS3Q1j2NLRlssZsA03j3/3FmKVxPpbCyGdmE6MOVuaPGmN
	XOUG6/qNBJnADcPnCnlfr+StgEVnx6Usmm1Mm7May+WVAS9F2Ib7+s62zS5rdCLxn5YPlkWsKhM8q
	tt7hiemPvw31XjXldax41DaMc8VcxmsV/a5io1eaU59TeJUKguyh1wRdlsE+dx8UZFmSOhJ/rt/hG
	TAgJP1pEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljOAo-004PHV-RG; Wed, 19 May 2021 15:31:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljOAj-004PFs-Q7
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 15:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KIIjDHYT4cox7DdrgTakG29XXmNIvIg4vxJt02duAFY=; b=H7EtfBFAzYznMF3d+hntiZ5q1p
 G2LBpGAvMOHNq8p0sSEEe4KPjxxFXWaB96Tjy76uF/z97cC33leeq2zakkkAd9lOJUVc20qmUCvzb
 uEi5vlgcfToc+iBGai63uQ/mRt0vNQEuIVN+W0XMwew74y6Q+rffeVE6w3qGLnJOdIpAdpygwAYyu
 Oq6RSDxbk8gOHfxhx76QlKPnJmRVrnOLtSrDlC6dB9F+tyTKnyBACx7tXtw+FHeBCPKT7jG3efZqX
 3+m2ks+jr+UmRNboDptAyjm45eRXQTVlXCczML+HfYSuLeIKB771c++xF3i0KR8s2CPQ9xnuboXGg
 peRjC2CQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljOAg-00Faox-Ff
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 15:31:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7163461019;
 Wed, 19 May 2021 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621438302;
 bh=/5k+h9ogJ0bXYmfxI52m24QI7eZYZB1/fdwBPZW6G1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYbqRnPUb+Mwh2KgbD3B7EDNkLAtvZDJo5q4bR+n7uoM2GN2w2pGNtLUq/74DrsRo
 LI2tWamVnzZfnDWBodchGdrLVj9HgXz5Q2NfEkG2MlU4kPaEYsTcft/FzmgyO6vbKQ
 Lfw3+I8SVJINILOkUOm9GSxd0Dpeo/lEWAYBQx0dGwSbLjfhte0woaKVUL6t2zi3vZ
 81cJEu/T47PwoftHumNl1qJdbrWPeJrOyMjFjSfLVf1MtylHpZGfaCAjr9BcioSswS
 nlg6RepccUsw9JhKjh0knMYRFP8LCI7yhQCfJ4yQ3nnYeigl3+m64l8SEHV21EAsAF
 sa5dB5qL61DPg==
Date: Wed, 19 May 2021 18:31:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Shai Malin <malin1024@gmail.com>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net,
 kuba@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, Ariel Elior <aelior@marvell.com>,
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, Dean Balandin <dbalandin@marvell.com>
Subject: Re: [RFC PATCH v5 17/27] qedn: Add qedn probe
Message-ID: <YKUvWqvlZNGJqBCy@unreal>
References: <20210519111340.20613-1-smalin@marvell.com>
 <20210519111340.20613-18-smalin@marvell.com>
 <YKUFLVHrUdzEsUeq@unreal>
 <CAKKgK4z+Ha9cv0zHtjrBiTb=K9MvWZB-kzg5CP9__pCJYmyNVA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKKgK4z+Ha9cv0zHtjrBiTb=K9MvWZB-kzg5CP9__pCJYmyNVA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_083142_582952_D3727956 
X-CRM114-Status: GOOD (  28.57  )
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

On Wed, May 19, 2021 at 05:29:32PM +0300, Shai Malin wrote:
> On Wed, 19 May 2021 at 15:31, Leon Romanovsky wrote:
> > On Wed, May 19, 2021 at 02:13:30PM +0300, Shai Malin wrote:
> > > This patch introduces the functionality of loading and unloading
> > > physical function.
> > > qedn_probe() loads the offload device PF(physical function), and
> > > initialize the HW and the FW with the PF parameters using the
> > > HW ops->qed_nvmetcp_ops, which are similar to other "qed_*_ops" which
> > > are used by the qede, qedr, qedf and qedi device drivers.
> > > qedn_remove() unloads the offload device PF, re-initialize the HW and
> > > the FW with the PF parameters.
> > >
> > > The struct qedn_ctx is per PF container for PF-specific attributes and
> > > resources.
> > >
> > > Acked-by: Igor Russkikh <irusskikh@marvell.com>
> > > Signed-off-by: Dean Balandin <dbalandin@marvell.com>
> > > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > > Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
> > > Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> > > Signed-off-by: Ariel Elior <aelior@marvell.com>
> > > Signed-off-by: Shai Malin <smalin@marvell.com>
> > > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > > ---
> > >  drivers/nvme/hw/Kconfig          |   1 +
> > >  drivers/nvme/hw/qedn/qedn.h      |  35 +++++++
> > >  drivers/nvme/hw/qedn/qedn_main.c | 159 ++++++++++++++++++++++++++++++-
> > >  3 files changed, 190 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/nvme/hw/Kconfig b/drivers/nvme/hw/Kconfig
> > > index 374f1f9dbd3d..91b1bd6f07d8 100644
> > > --- a/drivers/nvme/hw/Kconfig
> > > +++ b/drivers/nvme/hw/Kconfig
> > > @@ -2,6 +2,7 @@
> > >  config NVME_QEDN
> > >       tristate "Marvell NVM Express over Fabrics TCP offload"
> > >       depends on NVME_TCP_OFFLOAD
> > > +     select QED_NVMETCP
> > >       help
> > >         This enables the Marvell NVMe TCP offload support (qedn).
> > >
> > > diff --git a/drivers/nvme/hw/qedn/qedn.h b/drivers/nvme/hw/qedn/qedn.h
> > > index bcd0748a10fd..f13073afbced 100644
> > > --- a/drivers/nvme/hw/qedn/qedn.h
> > > +++ b/drivers/nvme/hw/qedn/qedn.h
> > > @@ -6,14 +6,49 @@
> > >  #ifndef _QEDN_H_
> > >  #define _QEDN_H_
> > >
> > > +#include <linux/qed/qed_if.h>
> > > +#include <linux/qed/qed_nvmetcp_if.h>
> > > +
> > >  /* Driver includes */
> > >  #include "../../host/tcp-offload.h"
> > >
> > > +#define QEDN_MAJOR_VERSION           8
> > > +#define QEDN_MINOR_VERSION           62
> > > +#define QEDN_REVISION_VERSION                10
> > > +#define QEDN_ENGINEERING_VERSION     0
> > > +#define DRV_MODULE_VERSION __stringify(QEDE_MAJOR_VERSION) "."       \
> > > +             __stringify(QEDE_MINOR_VERSION) "."             \
> > > +             __stringify(QEDE_REVISION_VERSION) "."          \
> > > +             __stringify(QEDE_ENGINEERING_VERSION)
> > > +
> >
> > This driver module version is not used in this series and more
> > important the module version have no meaning in upstream at all
> > and the community strongly against addition of new such code.
> 
> Will be fixed.
> 
> >
> > >  #define QEDN_MODULE_NAME "qedn"
> >
> > And the general note, it will be great if you convert your probe/remove
> > flows to use auxiliary bus like other drivers that cross subsystems.
> 
> qedn is simply fitting in with the existing design of qed/qede/qedr/qedf/qedi.

I know.

> Changing the entire multi-protocol design to auxiliary bus is being studied.

It will be required to do at some point of time.

Thanks

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
