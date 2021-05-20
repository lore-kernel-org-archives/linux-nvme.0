Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB9C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:04:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EA2610A1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 18:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EA2610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6M+fDSz16oMR4oDz077IXdCroImqkYpGShHjmg3FEM0=; b=CiuO8pyAJbjHZd1BlgA16Wz0wr
	1BCMk/jIwCHPugdJB+FZtaxi7ZaiHtEKmxbSybRLG4OAeJVW4DtGI7fGgC2x3GrGyJ+LMppuJIH5B
	YiRxr+z2ygdOpolJLvVDr1p83ehYuoAoCUQrHExvnqpyo/zdUOG9dUzPqT52gNpqKXhoPjO4xJktd
	jzCE8n4ErNEgWgiWPCsryfsagB25nrMjvNzgzczx//NwXBu2U3+GHscAzmAInApquEN8NxRgA6mD0
	IteExxeSnIMlaxF+SbF0vwstJy9NfanPa4o4SaFCNYmehrZ4LXCGZmqkOvL5OdqWs5DmbPPQxHIIB
	BoADycJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljn1W-002Cqp-Bk; Thu, 20 May 2021 18:03:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljn1Q-002CpQ-Jp
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 18:03:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MxqGt4EjGjExp0gtJaENYLBLnEckbUhU+rlO4cN61x8=; b=O4Q3WIzLweS1P9lGNP9ZDX+Sig
 guen72ZmoaMBQSBfjh06v7o+anRZYa+4zTWfSJbPqb1XJ6cVaDKtRujyeAMRnfIHsFEfAs001j/bK
 eIvBIcVyYqkC2T5mwLdPBHi9g2jRlHCxjk5NCpD3ujVd4nCnaoIwJwszI4EicZPJTXOmy8+nErvSu
 UgAAI07tLR2PeslhNZaNMvGpedcvcLBaa8wrh91yY6HVrSaxWifSwVPWkUMMZtLjfwAa+UDIn/RSj
 IIqI/8kcICHtOwwGBkphjITDG3dTHDzluMw+rj39km54/RIvHSuMh3lGFugNUUtS+j69kaL4F1ufE
 ewbhE6Cg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljn1O-00GYvk-78
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 18:03:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E95760FF1;
 Thu, 20 May 2021 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621533825;
 bh=+S8gvzrrVIm9MmYR5IHUp56ZCZSVIkWr11OHTYVVHjw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QBltvNlp1cuGHicXMTZJMAwd56LlDbbW14zoq4ivEXNwFrQHR/GlRO+cpnSVEARgn
 /CNpJcY/rFmqoYsYMXgtBsK5LZyfiiDnUTyhkeyI6d9qHgke9NrgTIC2pD+NwCFOlf
 UTRA7rdArULfg3fwozgPV7jcNMqESB1EXgB4XZ9VWLVOP0PEuV1bOUgZ6ODCrQLetE
 39+TYx7RRWm217PQ6ywAQ3Fb3D3idiPAdkw+0Fjb7eP5rCxpiemMwkpx2tYQvHq75v
 97MJtq79ZQf9E4CDymZbyGnkUNLkHNx0MF3+xCitb9JOcXg5ZTt2ojckMc20UomZsd
 dDyDERAsBCaXA==
Date: Thu, 20 May 2021 12:03:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Liang, Prike" <Prike.Liang@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210520180343.GA3783@C02WT3WMHTD6>
References: <BYAPR12MB3238055D4B08CC91D9ABFD39FB2A9@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210520165848.GA324094@bjorn-Precision-5520>
 <MN2PR12MB4488F16CE50BFD4E1F453CFAF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488F16CE50BFD4E1F453CFAF72A9@MN2PR12MB4488.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_110346_297429_60B2272C 
X-CRM114-Status: GOOD (  12.05  )
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

On Thu, May 20, 2021 at 05:40:54PM +0000, Deucher, Alexander wrote:
> It doesn't really have anything to do with PCI.  The PCI link is just a proxy
> for specific AMD platforms.  It's platform firmware behavior we are catering
> to.  This was originally posted as an nvme quirk, but during the review it
> was recommended to move the quirk into PCI because the quirk is not specific
> a particular NVMe device, but rather a set of AMD platforms.  Lots of other
> platforms seems to do similar things in the nvme driver based on ACPI or DMI
> flags, etc.  On our hardware this nvme flag is required for all cezanne and
> renoir platforms.

The quirk was initially presented as specific to the pci root. Does it make
more sense for nvme to recognize the limitation from querying a different
platform component instead of the pci bus?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
