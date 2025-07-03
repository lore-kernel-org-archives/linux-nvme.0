Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3210C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mfVhLIztbpOU0fFeyGRy1DU7K+7ovt0Bag+g8Tv0gZk=; b=WcEvNomKaH++JEN+Bw0Q4fNJkN
	7AfQaj6ose/nVt7h2+rxbAhtiKB3fLo01WybxgCzz5DpuGz50oqWfuFTzsmuUaMnIDaVk6Hxgx4l7
	tx0on042Rluum6sxcWxGumO4aiNX6K/xZ41qK0nov0cBKuFQT2UU20rqrqvKjffXiDt58hLYZE39b
	ps2Lbhu3BiR9KuO48LfqMDb1IUNCfshE9wAHOvyoNuPuF9Wa2Lb1KMt0yiQ+m/XZnDA+uB3QqEdd4
	tQ+FH2eRHqMAnjvQKPNH+hVxPCRnVFwxDTsLqmeCETKags+QoRqi4V0GAEnHpjH2bie7qalU73W3x
	IwmQEUEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGpk-0000000Avvm-26tw;
	Thu, 03 Jul 2025 10:06:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFra-0000000Alsg-40jV
	for linux-nvme@bombadil.infradead.org;
	Thu, 03 Jul 2025 09:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=mfVhLIztbpOU0fFeyGRy1DU7K+7ovt0Bag+g8Tv0gZk=; b=DTUsB9atoK/utw6/L2U9Szb095
	7tT6Ewcy7KnQ8mjd8S9QLjzRpihoNjEFkD/33UpHcSV2dxyJb0W/FxlQXii0//L4uLkqs6ZvcIsA2
	rjvpcEXQeFA2w3KKhZU2v6DEHxSM/Na28xN6uLTya2ifGznINoMeib5Xp3YqdjTrx754TKdxOpyfj
	40PgYUdYoks2z1Jua+XOi+Url4AUNiVBZaXWjiX2e+1hbZrN5zCQIhca+syIq18wFa9ATsS7MrJXx
	s7Dc8ZHQvGNSMdBiukvTUjM1MWM5i8fhRP/nzdHBNcSGUWx7vfclv4YxlMmAKV5CUjPauBfOBDA+j
	Wy+j4Ctw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFrY-00000007eVb-0HzP
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:04:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E89D568C4E; Thu,  3 Jul 2025 11:04:06 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:04:06 +0200
From: hch <hch@lst.de>
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>
Subject: Re: [PATCH v2 1/3] nvme: add capability to connect to an admin
 controller
Message-ID: <20250703090406.GB4757@lst.de>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com> <20250702005830.889217-2-kamaljit.singh1@wdc.com> <22f8ec86-2d50-4237-9313-79bfc93c8e3d@kernel.org> <MN2PR04MB686294B136454530692AEC1ABC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR04MB686294B136454530692AEC1ABC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_100412_292676_D22619F3 
X-CRM114-Status: GOOD (  17.87  )
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

On Wed, Jul 02, 2025 at 06:39:09PM +0000, Kamaljit Singh wrote:
> >call this in all fabrics drivers.
> Like I mentioned in response for 3/3, this can affect other drivers like apple/fc
> and I don't have any way of testing them. If you're okay with that, I can move
> nvme_override_prohibited_io_queues() into nvme_init_subsystem(). I did some
> analysis and nvme_init_subsystem() seems to be covering reconnects as well.

This should go into generic code.  Apple does not support admin controllers.
FC should, and this does the right thing for them.

> >> @@ -3215,6 +3231,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> >>               kfree(subsys);
> >>               return -EINVAL;
> >>       }
> >> +     if (nvme_admin_ctrl(ctrl))
> >> +             dev_info(ctrl->device,
> >> +                     "Subsystem %s is an administrative controller",
> >> +                     subsys->subnqn);
> >
> >We do not print an equivalent message for other subsystem controller types. So
> >drop this.
> I left that msg in there for debugging purposes. I can either change it to
> dev_dbg() or if that's still not likeable/cluttering, I can remove it.
> Please let me know.

I'd leave this as dev_dbg only.


