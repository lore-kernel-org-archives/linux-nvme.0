Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7586E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=xoEPbO1RI0+yhq9zBVsxJqRm15X531u9jdU01eOqx7s=; b=c4v8Orxv0njiFN
	rNnNFiYVWe0BPpvnnMkxcTdcUu1ZJm9saXddbUdYN/0MsSv/Hyr8R61MYDFv5DxmuSh7jdsU5Z5Zo
	hT1+m+gA++Mo9/jStiUEnkquTWJbFWXplQxrLW8ylj/VKFtWuo3lu3uzF58yGcXWDeymMZQorH+rj
	LkvVVY+FQBq7RaOlPDWUqwmTVUj6NMvfRdzKpr0Jk0k/WPuvY0laiaFC7fLKxVICbhxJrbtFXMfhZ
	4ijwX4XbFdDcq3YODG+JYWPfMHhRWi9Vc2Aq6ZOEwwtiDF7f4YKywPK5GJXce1dHmb7yzPG1a40mk
	cjQzQta8PKk2+GpKBEDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLouL-00000001eMx-3vQS;
	Thu, 12 Dec 2024 19:31:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLoEh-00000001UWg-0FHD
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 18:48:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 073CFA429D0;
	Thu, 12 Dec 2024 18:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F1C4CECE;
	Thu, 12 Dec 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029309;
	bh=tOGMju40dv2/vvov0Gt5CZ9asbT5RPj1IsGYlrPDuWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GrywXcPkz1K16BghTpnDVl+HI5dqFkRdXuaU8bIFT+gOlNQfBTW7zuqyok64nlsVl
	 2W+8XKf1x1ZbEcbVbUAvb3UHz8GWzhJpc1U/w9euaRUoHA4tAyp2i+JJ0bZ8Ba/heD
	 mYkeb718epWf3scMI7hjGPZ8QOXDuB/TYH81k/fpnAzTBp7gFM6DZcbCOwYiW6PoNE
	 oLhjXDYAkd3ANF1/QT8bgwFucdEh8LTy0NSVKzaV46Hd9m0bzxC5E+0ExsAKl4rMiO
	 d528wzG1dBGuVJphKf7n9NdiDRa3q1FbE1e6j8Uo4Rbxkxzorgmz2TPRT9TZWzKbVp
	 /XmA+XqaTrhxA==
Date: Thu, 12 Dec 2024 12:48:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241212184828.GA3354708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-19-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_104831_226181_931A8C77 
X-CRM114-Status: GOOD (  22.08  )
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

On Thu, Dec 12, 2024 at 08:34:40PM +0900, Damien Le Moal wrote:
> Add a documentation file
> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> endpoint target driver. This provides an overview of the driver
> requirements, capabilities and limitations. A user guide describing how
> to setup a NVMe PCI endpoint device using this driver is also provided.
> 
> This document is made accessible also from the PCI endpoint
> documentation using a link. Furthermore, since the existing nvme
> documentation was not accessible from the top documentation index, an
> index file is added to Documentation/nvme and this index listed as
> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> API index.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

  Applying: Documentation: Document the NVMe PCI endpoint target driver
  .git/rebase-apply/patch:43: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.

> +The NVMe PCI endpoint target driver allows exposing a NVMe target controller
> +over a PCIe link, thus implementing an NVMe PCIe device similar to a regular
> +M.2 SSD. The target controller is created in the same manner as when using NVMe
> +over fabrics: the controller represents the interface to an NVMe subsystem
> +using a port. The port transfer type must be configured to be "pci". The
> +subsystem can be configured to have namespaces backed by regular files or block
> +devices, or can use NVMe passthrough to expose an existing physical NVMe device
> +or a NVMe fabrics host controller (e.g. a NVMe TCP host controller).
> +
> +The NVMe PCI endpoint target driver relies as much as possible on the NVMe
> +target core code to parse and execute NVMe commands submitted by the PCI RC
> +host. However, using the PCI endpoint framework API and DMA API, the driver is
> +also responsible for managing all data transfers over the PCI link. This
> +implies that the NVMe PCI endpoint target driver implements several NVMe data
> +structure management and some command parsing.

Sort of a mix of "PCIe link" vs "PCI link", maybe make them
consistent.

Does "PCI RC" mean "Root Complex"?  If so, maybe "PCIe Root Complex"
the first time, and "PCIe RC" subsequently?  I don't know enough about
this to know whether "Root Complex" is necessary in this context, or
whether "host" might be enough.

> +4) The boot partition support (BPS), Persistent Memory Region Supported (PMRS)
> +   and Controller Memory Buffer Supported (CMBS) capabilities are never reported.

Gratuitous >80 column line.

> +If the PCI endpoint controller used does not support MSIX, MSI can be
> +configured instead::

s/MSIX/MSI-X/ as is used elsewhere

> +The NVMe PCI endpoint target driver uses the PCI endpoint configfs device attributes as follows.

Gratuitous >80 column line.

