Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E28C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:15:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8C361284
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 12:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8C361284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Z8pjYP1Hq1x/kIpC6YhkK9OSWYVwINbUD3Hv53OdjE=; b=GF/BoQjVVd1h2x
	wUrU8PdOFmL4Q0UXuQaoED7MIg5yxHtG64NuGXsv3HyOQRl302cq4/fVGmp4F2Gf88fG47ozjZKPt
	mQDpGQBEZ+C+2VWN/dE+cUfsDT64cGVxOEjw5Bi/rIGPyLg/tFtHvwUdYprCPbAOwIqBcgoLyWT6f
	EgsdQmuT5QRb2CrRUpHIeuvVvFwoaOF/gwOg2a6P1VEUR42BHbKaQftr9Ojv3lyKMabNkgWIztxid
	Ea2xRvBe65lWVrN8Vvq7JNz8Yeozph/Kij3JaeM7m9Sh6ZSSLTeI7yL1JdUDRCzj6Onwal8IF6u6p
	YUprMe3cmJZA3Tv74spQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llVyJ-004wYd-7q; Tue, 25 May 2021 12:15:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llVyG-004wWg-TQ
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 12:15:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 53A606736F; Tue, 25 May 2021 14:15:35 +0200 (CEST)
Date: Tue, 25 May 2021 14:15:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device
 to D3 for s2idle
Message-ID: <20210525121534.GA3822@lst.de>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <BYAPR12MB32388D6D92DF64035651D900FB259@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB32388D6D92DF64035651D900FB259@BYAPR12MB3238.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_051541_121305_2D438F10 
X-CRM114-Status: GOOD (  15.57  )
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

On Tue, May 25, 2021 at 12:11:25PM +0000, Liang, Prike wrote:
> @@ -2856,8 +2856,15 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
>         status = acpi_get_handle(adev->handle, "PXSX", &handle);
>         if (ACPI_FAILURE(status)) {
>                 status = acpi_get_handle(adev->handle, "PEGP", &handle);
> -               if (ACPI_FAILURE(status))
> -                       return false;
> +               if (ACPI_FAILURE(status)) {
> +                       /*
> +                        * In order to support NVMe D3 during s2idle, the property of AMD platform
> +                        * is defined in the GPP6.NVME device.
> +                        */
> +                       status = acpi_get_handle(adev->handle, "\\_SB.PCI0.GPP6.NVME", &handle);
> +                       if (ACPI_FAILURE(status))
> +                               return false;
> +               }

This whole chink also really needs to move out of the NVMe driver.  We
can't accumulate tons of crap in a generic PCIe driver to work around
all kinds of broken x86 platforms.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
