Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A3BD3B9AB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 22:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=GUKdVQ5d1trTIO1MCY5GWlfCx3n73Ve94j/adBGF67w=; b=PoofY7SFGGD9Xn
	fAI60pbhTnVzfU1aGar9X7BatQWvlSQnkXQlnzleMVv7w9Ds7fI118RT4fCTz/HSh3wtJkjBRltZe
	tCuukCWcXo+FUldqpGkNr0E+O8HZitzp+tYHKdzdzDXiv7k52qBypd5bhIZl+07dv6l797qP8RLrj
	AVhnckzy0Bv+83MfXaasHnoFtypP8K3EMMcVFIpfdy1X+b1CYfYg+8OTWJ8rFioIYgQSq0o4nE8u3
	xWlKOM4XVvLfwnolDE1bPagfklNSngvl3rdshqSQfizYn9Ru+qFoKXqmslYILsI4vMQyDkxhM3CFj
	DjIQ6ceD90cnsEgjfyQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT1S-0000000FwXb-2lmQ;
	Wed, 10 Dec 2025 22:51:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTT1P-0000000FwWp-3NK9;
	Wed, 10 Dec 2025 22:51:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7293143BE9;
	Wed, 10 Dec 2025 22:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3412EC4CEF1;
	Wed, 10 Dec 2025 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765407057;
	bh=a2bzuFLMtFhycfladekqoVs0KC0eCxKrtmBPj8wRj2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DIXY6p8LCPnJLjTXOvDC6QVcMRuMXwOKfkk9G5nBdKrdw12H04e9XOplPEaTYQEQu
	 qN1UMXZoVsxKgTyduWwg/mc9Xz6xSe/NXPVCTOeM7MBf4Y6owfshKbx9t1FeL57Cy2
	 kR1lMy7F3jGcTZ5QGXFtt1cKPpUdFJ+F5FhFZQzN2MQFSHx0dxlPLTtsg+oK8PfHPo
	 ygIXiJGtF+R+PIaIV0xR8XFMAGjFsIbQiKUQV1u1tKlHVML6M48AdG14XCJC/+r2wk
	 h/7D+HK1dFOxpErXp4kNUumDSXqEAKCch1UQ/wQKSOCvunW9qNNdFDOHLE6Zvqj23E
	 X34k775mY3NDw==
Date: Wed, 10 Dec 2025 16:50:55 -0600
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
Subject: Re: [PATCH 2/8] PCI: endpoint: pci-epf-test: use new DMA API to
 simple code
Message-ID: <20251210225055.GA3544934@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-2-53490c5e1e2a@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_145059_864876_59CCF17F 
X-CRM114-Status: UNSURE (   6.34  )
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

On Mon, Dec 08, 2025 at 12:09:41PM -0500, Frank Li wrote:
> Using new API dmaengine_prep_slave_single_config() to simple code.

Capitalize and include actual interface:

  PCI: endpoint: pci-epf-test: Use dmaengine_prep_slave_single_config() to simplify code

  Use dmaengine_prep_slave_single_config() to simplify code

