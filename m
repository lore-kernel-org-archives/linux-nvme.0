Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B5D3B9AB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 22:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=vAvXe+aXpogECVyG/I4dnFC6vaGW2sYa5VVcma1Gfsk=; b=EL2Yu4PuHEHeZB
	V47ZRDMidbx7V2QNbeDo8t7s5Dl+2ab+daRxKbP/UMC+jOMDdZ0+qk4E5IgQYGMgZPa1lFGpJPaZM
	DUWASFcaipudhhwLBAdB2M2+sbCQq7RWvm9tOCNwy6ctU2sTTsDJzj3obfocrYiEwEuk6UrhsqQq9
	xEkHzs5+4iYw1ZHRbW8FWpFS2haZ4FtB87i0lfNt3QEaOFC7Z0Ko6/BozGyIGHirPw5nPeoP9zz4P
	WM8iow4XnLfDa8pVLXrMl94Q/1IuiGWWceK9GITEQEoMAibY3zDVUIZNLxRXTAkrAWP9VI9LoHr1j
	XUXb0grR281cS78MNWcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT3s-0000000Fwmm-2uZB;
	Wed, 10 Dec 2025 22:53:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT3o-0000000Fwm6-0Vt0;
	Wed, 10 Dec 2025 22:53:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2244D4443E;
	Wed, 10 Dec 2025 22:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5540C4CEF1;
	Wed, 10 Dec 2025 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407207;
	bh=2uTNjBtdgRM2/ASK6piQyYjDXg3OsyxobRphNNNCmm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hnLYbnHSg+o17LZIPAr9wi4HEVVi+KKQ3Z5BmUn8PH/y7Y3UHYbT7DzEN2DYEsQPF
	 tzlBZICrTOgdp2JO79cHYdonJi4+dC+yv9PPX4NTzH6eu9JqOKKtBAy5R3h9tgunpB
	 8PuH/Gc2TdPBzMLzBQCGv4iFsGYBqJ7M7ixbvPXJYIhgB008rosCj2KnuGe3qP2zeQ
	 hEyu9flYvHM7fFk9/wFHsUYsnT+8lbPqmc+6gLni1Zogeb/+GZ+qGRRRrseEQWcW+K
	 vviGe5IsC21Q4Vg/nVx067S3a/QDZ6q/4wDG9XrC0+YvxVMZnePuHgY39J80WxWwIx
	 5yv715g1nM33w==
Date: Wed, 10 Dec 2025 16:53:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 7/8] PCI: epf-mhi:Using new API
 dmaengine_prep_slave_single_config() to simple code.
Message-ID: <20251210225325.GA3545039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-7-53490c5e1e2a@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_145330_368306_D92D2FCA 
X-CRM114-Status: UNSURE (   6.12  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 08, 2025 at 12:09:46PM -0500, Frank Li wrote:

Add space, include actual interface, add commit log:

  PCI: epf-mhi: Use dmaengine_prep_slave_single_config() to simplify code

  Use dmaengine_prep_slave_single_config() to simplify
  pci_epf_mhi_edma_read(), pci_epf_mhi_edma_write(), etc.

