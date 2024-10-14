Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E086ED16261
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5fv0GS9HNRY6DhIQgCx1EpMAUP5fp9FBItB4EJcBfU=; b=CFeZrdRgU8KzDz0Uw9wMRMTCfm
	259/+zTIpQwY87G2OsgYO3HesqLWfAtyGcWOdLSuh/d7H/uVDzhdJ699nyXxTTBpvZ+Q/6dchzcaa
	S/clnGH02imrbGxDJo3zUzjxf8guZAQsmhiHUWu71rnqNKWmiA3PErbNVibJQBCwsYzrzlsQnlIVo
	Ku0xEf78JG7lXn6vLxdZ8Iij94C/UR2Lt+DKmcNwWmuuW1JMBpR1Ycv3rjm1oOYmjt/9SZqlm40Bp
	nfs9uybj16XySBrbjurWeEndGkBWpBp3uMYxmp/plE1iq8531xbYf6K+ax3Pzf5fxehf0X1vlSusU
	ZTJVxoDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0L6p-00000005GrS-0EXY;
	Mon, 14 Oct 2024 13:27:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0JW2-00000004yWF-2dUc
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 11:46:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 890DB227AA8; Mon, 14 Oct 2024 13:45:29 +0200 (CEST)
Date: Mon, 14 Oct 2024 13:45:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Message-ID: <20241014114528.GA31937@lst.de>
References: <20241011121951.90019-1-dlemoal@kernel.org> <20241011121951.90019-3-dlemoal@kernel.org> <20241014084219.GA23780@lst.de> <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ba5cda-338e-48bf-b82e-60e4721b1bfb@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_044534_831824_2962C6B0 
X-CRM114-Status: GOOD (  18.37  )
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

On Mon, Oct 14, 2024 at 06:10:36PM +0900, Damien Le Moal wrote:
> Nope, the PCIe "transport" is the front-end of the endpoint driver.
> What this patch does is to allow this driver to be created by passing it a
> string that is normally used for "nvme connect" command, which calls
> nvmf_create_ctrl().

That's a pretty wrong and broken layering.  PCIe isn't any different
than RDMA or TCP in being a NVMe transport.

> The entire thing was created to not add a PCIe host transport but rather to use
> a locally created fabric host controller which connect to whatever the user
> wants. That is: the PCI endpoint driver can implement a PCI interface which uses
> a loop nvme device, or a tcp nvme device (and if you have a board that can do
> rdma or fc, that can also be used as the backend nvme device used from the pci
> endpoint driver).

You can always use the nvmet passthrough backend to directly use a
nvme controller to export through nvmet. 


