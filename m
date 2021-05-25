Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6988C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10D7613CC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10D7613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yv6hfTSc9NwYOtkX0rdpOXiNTkI9H54GtBTftJ2x9aM=; b=AHF2AwnbJP7jbO
	Lz7FRdMJgVyTki9GliuFO3Al/Wfo9kxL5dnqJsu+WG98maUzTqzeja1trp0xU4EHu7sdc1gWUMIvz
	ZC1YHyozsY8k2ms8uWK66xvA2Y087gaEOTalUDWg/tNi/llAMmgHQQpaS/TdOWK23OJZ18rw7TXPA
	pQnbS4QHM8EW5IlEKWUX/hrVjHiyDNTLYhKjagv3TEhGgl/DoOPF1FmP3NB362kO7hQ7umSNFIQMu
	61B1BbdrOY4gaSQKAKcC3pkQPxEemHgRN98njNluKlRQW3nIJbaK8x1mjGUuVpXNn3GOh3uU44Fzj
	bJJz9dkJN8bHh26aOMog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llbJ6-0075aE-Cb; Tue, 25 May 2021 17:57:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llb77-00701P-SA
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 17:45:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09FC561378;
 Tue, 25 May 2021 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621964708;
 bh=VQzn2Uwy7k+XCuaklTd13IhXV1K4fvx66UPWnJV9lyk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gxcHep0NQfSB0DCN6W20ZaMC715wgZ9EqOMb9FjdCmCT7ju3JKUNY+gHcsq/MMFFB
 mbNXw7rRuZMvBdZBb0NT6EqYFKyPg+WDg24oCVkLTxLSl2tIRAhZs6XKcV9F9NdVDN
 8xHUBrqJDvQuJ93P+2mGU939R4QDiD/a0raP5fVTHiwjrUWSPZ4GAe11tqpi4fpUUg
 rWyvWVWE86YpGg/I87s7P+L6s565SCB8wxe016bxrJ7vvjf8LxSyddkGLMSojjXkhm
 2X3uAYTLChgGKI/tKkY4jhunqwX719EuEclksJTGFRQ39jnCbjSw+yyvMaPlp1s14/
 LaM4oND1YuQwg==
Date: Tue, 25 May 2021 10:45:05 -0700
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
Message-ID: <20210525174505.GA3704559@dhcp-10-100-145-180.wdc.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_104509_992207_7EF1DA2D 
X-CRM114-Status: GOOD (  15.48  )
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

On Tue, May 25, 2021 at 03:18:46PM +0000, Limonciello, Mario wrote:
> > or by splitting the suspend method in different ones
> > for different use cases.  Platform-specific code (right now for Intel
> > and AMD) can then make sure drivers do get the right requests instead of
> > hardcoding platform information in every driver that wants to be able
> > to implement intelligent suspend behavior.
> 
> This seems like a gross assumption though that evicting the quirks into a
> central place that every driver needs to behave the same.  AMD's case is
> specific to NVME, particularly because APST will be used otherwise.

I don't think you mean APST. That feature enables controller power state
autonomy, and we do not messed with that on the driver's suspend path.

We do use the explicit nvme specific host managed power state feature,
though.

But I also don't see why this is specific to nvme. Are you saying that
if a some other protocol device was in the same slot, it would be okay
to use its protocol specific power settings? That doesn't sound right.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
