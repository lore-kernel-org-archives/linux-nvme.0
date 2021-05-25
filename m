Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5016DC47086
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:02:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F97F6124C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F97F6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NWvT16whjkwoJcI6ld7LeUEyKA2n4ZzI5LG8jvd5xcA=; b=UaSCO6tb5zrL3J
	XoaIEGrUJgpmN/PPcqUjEBDCXm/TOvx6XBfldUyw/9oufPqZlWS68LyskZtZuXFrfjBvWEdB16yjJ
	0bdeVDlZRvIvJhsbL8hu27q+ikI+A6Wj6uwLXoxA8fhNu+k9mfq8ku/XdCm8IZNHneWIoARfrGMvz
	Psyr1yLXsK3kpj+YAnqSJfG0PGv9AZS/n77Ch9+6a9Du+v/Nbionpv2K30x8+KbdSMhgjdPIL7rW5
	6lbivShZ4cF3RTndJr1qX4+GVwxIv99pPyJ4CB8QYjKqJuGOBrPSH0lFpM7VpdvF+8rIQw+UoZtgJ
	rXhJYpy5dT8a5onns+nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldFr-007xef-5a; Tue, 25 May 2021 20:02:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lld9W-007vfy-8Q
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 19:55:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B68361279;
 Tue, 25 May 2021 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621972545;
 bh=Gi6ayU3S/uSPTA7tyHYg+ZCfi5MqI+WeAzzStERs+bk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BVq/lzPEQ7ubl7B9QFbC2qwYHwl6dTpEOAP60rXXPpaHPySMpP8yr2x+RozKRY1tf
 6vkN82wdp3aGAnvLpcrJHmynwVqwYS+lhRafuxDD2mvMOS7wTgXzhtXoztwSfbrHeM
 sUw+80xOl2D12xTUtHymwFoyrCdbH6SxoTUwfADUS6bZo/o+39evoiSofmXikeO6NE
 U+WqXfuiwNO2fmy+WuFPfIesBaAjyz6WjbSMVPkShWo6d7msRJ1pS3EFN1GGflaE+k
 tZSOxLTfeZCUC6LAzTygZZDrfzq6q+5Nuo/5JE3QefQF2s7YDFEytakz2yau3U4xg5
 cGlMsMdXzxW9Q==
Date: Tue, 25 May 2021 12:55:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, Hans de Goede <hdegoede@redhat.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Message-ID: <20210525195543.GA3704707@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525174505.GA3704559@dhcp-10-100-145-180.wdc.com>
 <BYAPR12MB2693CD60B17E4FCEED7DD5FCE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2693CD60B17E4FCEED7DD5FCE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_125546_404244_2C2A47D6 
X-CRM114-Status: GOOD (  22.45  )
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

On Tue, May 25, 2021 at 06:27:52PM +0000, Limonciello, Mario wrote:
> [AMD Official Use Only]
> 
> > > This seems like a gross assumption though that evicting the quirks into a
> > > central place that every driver needs to behave the same.  AMD's case is
> > > specific to NVME, particularly because APST will be used otherwise.
> > 
> > I don't think you mean APST. That feature enables controller power state
> > autonomy, and we do not messed with that on the driver's suspend path.
> 
> Relying upon the drive to go into the appropriate low power state via APST is one
> aspect of it, and then ASPM for the PCIe link state.

That's not quite accurate. The driver has no use for APST in the s2idle
path. We use explicit host managed power settings here, and this works
the same with controllers that don't even support the optional APST
feature.

> > We do use the explicit nvme specific host managed power state feature,
> > though.
> > 
> > But I also don't see why this is specific to nvme. Are you saying that
> > if a some other protocol device was in the same slot, it would be okay
> > to use its protocol specific power settings? That doesn't sound right
> 
> Maybe Prike can comment more here, but all of these s2idle designs we're talking
> about are mobile designs without external PCIe.  OEMs make the decisions on
> what PCIe devices are chosen and how they go into the lowest state. 

While assuming nvme might be a plausible design choice, for any device
type occupying the slot, any driver bound to it needs to make the device
ready for cold before letting the s2idle process proceed. That's why the
quirk shouldn't be nvme driver specific.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
