Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB78CC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRFc5B+SG1Cg3baSTTty4FeqVBlBbRnV1e8jPDxbED8=; b=aJ3/Opsrb7yQkwB5b0L/l7CuyN
	l/m/Mh91ib7aKHTmXcObiGxfSR8Q9jtHqVXKuGR0064wCha33UJvhlZ9yX7uBZfb+E6iiFICCethj
	8WHpp5qRrlyxqZTA88x5pf+ZyRrAodSrs8KOEwGUBMR299QnVs9Iaq+WogkACaPV9fFxHRik+Uz3a
	CEOakEXY/w0su9UTW54ftFwmcv13d04+L7a38UvVFsCOkhAUnjEsik8TDQHQG8sYWjN1+EBvnMYTj
	dzjdKlspLpMYt2oP1bMr6N7YqsLgeOvG8xr5bnyMpcmTDS9Ev6CsUVD74wTNruXL6c/2A6+FScq0N
	Q5ILxN3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCNF-000jAY-0g;
	Thu, 23 Mar 2023 04:16:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCNA-000jA5-39;
	Thu, 23 Mar 2023 04:16:20 +0000
Date: Wed, 22 Mar 2023 21:16:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	linux-pci@vger.kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	Jon Nettleton <jon@solid-run.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: Samsung PM991 NVME does not work on LX2160A system (Solidrun
 Honeycomb)
Message-ID: <ZBvSlHfXcX+oII5q@infradead.org>
References: <a1a1d17b-94fd-b53d-0850-c8f27440f0bd@linaro.org>
 <20230320161100.GA2292748@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320161100.GA2292748@bhelgaas>
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

On Mon, Mar 20, 2023 at 11:11:00AM -0500, Bjorn Helgaas wrote:
> > The problem is that I am unable to use Samsung PM991 NVME there.
> > It is 2242 card so probably also DRAMless. Kernel says:
> > 
> > nvme 0004:01:00.0: Adding to iommu group 4
> > nvme nvme0: pci function 0004:01:00.0
> > nvme nvme0: missing or invalid SUBNQN field.
> > nvme nvme0: 1/0/0 default/read/poll queues
> > nvme 0004:01:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

I have no idea who even does the PCI vpd accesses here, but either
way there's not much we can do from the nvme driver side.

> > The SUBNQN part can be handled by adding quirk in nvme/core.c file
> > but that does not change situation. It also does not appear when
> > used in x86-64 system.

Although this suggests something is fishy with the config space
implementation for this particular hardware, and NVMe just happens
to trip it.

