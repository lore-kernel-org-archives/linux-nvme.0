Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72641E7718B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zvSKxwaULmcQUmG8O9eqMgir7x2Ing1GeL8NoO0Fd4=; b=nDEP6J6RobwaILHUpKcE1jj12j
	qCQ+mT8wsB4TxPOpxkx9tST9b816WaWz1JIZ4qK/jCoQvyCG5wgOJ01S508cFaufHFOq7HLT/1Yid
	vkI8GBQ8OuPJW8FdzmuEtAOwVKVLBjZXZuDaUivYdR3X2DeD8ueMmuzrSWgya5BqmBcrixJpsDHq4
	pNh7ltRvjt8QBl2vQg0ijHIBsydiMZbI986ObGs0hZn66iYmA3FoAgVon1o+NYagEbLEh+Hck01De
	eJMH0p1k5WsdgLZMCmfrUBWU0HbLGHhXBw7oA4QcPaR+ELOCOiwvVhnYcizrZTN6IPKTb+kaWpys9
	tx/5RsSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPene-00000009emN-1qRH;
	Mon, 23 Dec 2024 09:32:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPemR-00000009ecD-4AFd
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 09:31:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 430A3A40CB7;
	Mon, 23 Dec 2024 09:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B6BC4CED3;
	Mon, 23 Dec 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734946273;
	bh=lvzt1Zms38U56aqRZCSaql9Ng6jr4KG6HO3o52vRj5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXav9sIIRiHiZ0xj8LAaqsHYwcYHAWhG8Gf9pETBFzpUuSz2XpLgJi8Op6LQA/KvK
	 f2jChCvIUwReu8jKPILaGvUd4wU1NGr3jZqwm1GujTw86ST07CZ4aUggTyLTm+NIK3
	 g9kbzLMvqcJcxFySktffQE4ypfrCNFHrdzpNuCNV5ZkB2r/u1QoBHGMcp8uHi14166
	 IYTP25QJix5oOJY+j3pFK74PiduKb4y8ulVLo9Puyk5iUMSZkdBTg0tlK3pdn4GyAu
	 TAEEnqXZ4K9fwf6vSrrdez1RQkCHK3h+5shUTQSWJ3hMHEFt8S0Y1QCytoAgChIMS8
	 oM3rPDRXR01/A==
Date: Mon, 23 Dec 2024 10:31:07 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v7 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <Z2kt26T3SKrmrUXI@ryzen>
References: <20241220095108.601914-1-dlemoal@kernel.org>
 <20241220095108.601914-18-dlemoal@kernel.org>
 <20241220161945.GA1007198@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220161945.GA1007198@rocinante>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_013116_152594_3FE263B2 
X-CRM114-Status: GOOD (  12.58  )
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

On Sat, Dec 21, 2024 at 01:19:45AM +0900, Krzysztof Wilczyński wrote:
> > +config NVME_TARGET_PCI_EPF
> > +	tristate "NVMe PCI Endpoint Function target support"
> > +	depends on NVME_TARGET && PCI_ENDPOINT
> > +	help
> > +	  This enables the NVMe PCI endpoint function target driver support,
> > +	  which allows creating a NVMe PCI controller using an endpoint mode
> > +	  capable PCI controller.
> > +
> 
> Perhaps:
> 
>   This enables the NVMe PCI Endpoint Function target support, which allows
>   for the creation of an NVMe PCI controller using an endpoint mode capable
>   PCI Express controller.

I like your suggestion.

However, looking at drivers/nvme/target/Kconfig:

$ git grep "This enables" origin/master drivers/nvme
origin/master:drivers/nvme/target/Kconfig:        This enables debugfs support to display the connected controllers
origin/master:drivers/nvme/target/Kconfig:        This enables target side NVMe passthru controller support for the
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe loopback device support, which can be useful
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe RDMA target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe FC target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe FC loopback test support, which can be useful
origin/master:drivers/nvme/target/Kconfig:        This enables the NVMe TCP target support, which allows exporting NVMe
origin/master:drivers/nvme/target/Kconfig:        This enables support for NVMe over Fabrics In-band Authentication in

It seems to use both:
"This enables the NVMe ... support"
"This enables NVMe ... support"

In this case, I think it reads better if we use the latter.

In fact, in all these cases I think it reads better without the "the".
Perhaps add a clean up patch that drops the "the"?


Kind regards,
Niklas

