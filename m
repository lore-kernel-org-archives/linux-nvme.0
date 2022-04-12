Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D102CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7o0wUzyOY/+FD6VFQN9oVi/IzcL+aUAPKC1xjSwZ4yQ=; b=Df/jeiFbydHoKnZxYALmcqf79N
	KiQlbNHSKqFVsx5SCwPfpfNHZjyYzOX1ginQbuRh0+xzCbxPdarSvCC4oV9q9G+FEySHWWhqSJmOA
	kv+d7IgyBM6NRiQ0GUKWbXuFAxTgH4x26toK18jE5KowPNSQMobo7QuLF9csJLckUJh4OSJGMRMFs
	1y5EolAT8TRV9VRRrMhxilXxjsAr6Q629F26/J7N3RKdU3zvbklX8XO/TanqGNXvekA4oYV0sL6f0
	rTX5fizMSIl4r9gZ9hegajFZXNjv5F7NEmSfNcsvH5McPXpzsl4tMr+I/NqgHlMT9VrRi9E1c+Qdz
	frbdkJHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neEzx-00DpI1-S3; Tue, 12 Apr 2022 11:47:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neExs-00DoJY-Nx
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 11:45:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7061168AA6; Tue, 12 Apr 2022 13:45:34 +0200 (CEST)
Date: Tue, 12 Apr 2022 13:45:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <20220412114533.GA31047@lst.de>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-4-hch@lst.de> <YlUdQjIXwL++K0Uu@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlUdQjIXwL++K0Uu@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_044545_001562_C3D2B1E6 
X-CRM114-Status: GOOD (  16.00  )
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

On Tue, Apr 12, 2022 at 08:33:38AM +0200, Klaus Jensen wrote:
> > +	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
> > +		.driver_data = NVME_QUIRK_BOGUS_NID, },
> >  	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
> >  		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
> >  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> > -- 
> > 2.30.2
> > 
> 
> When I fix this in QEMU properly, can we move this quirk to the
> core_quirks and match on firmware revision? That way I don't have to
> request a new DID.

Do we known that only one firmware revision reported by Qemu is actually
broken?  For now I'd like to get the regression fixed ASAP, and I don't
think Qemu ever fully got identifiers right so far.  We can always
change it later if needed.

