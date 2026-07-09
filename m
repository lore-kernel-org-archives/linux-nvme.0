Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF633C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=lcOeZjQ1Y6NqCwb7DExMzSG3PRvuO4awJLokV768DDQ=; b=mr5RtuW689vb0L
	Q+IK07aZrCiBtzN7SUHnWplaO0OkJbl8WfFAqTzZGkh6gD7v7yCFqRmXyns6s52fGNA9p0PuWxOaG
	pljgw45Wr3pzItM5hZlSoAWbbTzeyzQNANSyYJs/2DkeTcV5CSHjeSfaBACUsJaTu+JQLichJtJ3N
	0KZVjM8L7ruBeuTsl3H3Q321o/yxMJBrHqGqdDcX8swggNXWi06NZT9rRxZ+jcLehOuo546TNJ0ay
	vlNMgcWe0/SFvEnwJk5n47Gb0ZfhkhphhvRdII+JbiXsMnLga/ArrZDWRglz8Tqbg6qcXktL/VGz1
	n3GzQaGIIJK5GDR5Jm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whun0-00000003WZ8-3ix0;
	Thu, 09 Jul 2026 19:52:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whumz-00000003WYS-2Ffu;
	Thu, 09 Jul 2026 19:52:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC5F343DA6;
	Thu,  9 Jul 2026 19:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847051F00A3A;
	Thu,  9 Jul 2026 19:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783626724;
	bh=lcOeZjQ1Y6NqCwb7DExMzSG3PRvuO4awJLokV768DDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=S2EkifLAg5Vb/F4xGBkmYhaBJDuKem8xeb/s+2BBHrtqfj48ztECd0b0dtDbQqK1j
	 D+w5+l2qQVV5aUepaSkDOQsG29C7qnGPdK79ZEb0YVbD1YEW+UNXKIltN5YBMT4EPV
	 FcPSNTgXRpJ/eAj3R9RcOE4lwhl2tfTphskwzM2O2HC04/mr1QseGM7v4LlZ4GGq2a
	 5zwlZAeP42X8xSmgqNjtfhwHxfE9J9pjrvbWi07T1Hly6CpBQtZbfplLpIjCEKHqVh
	 P1nGdAO6CsjxXvbR9aYLMB1+77MRyvT3L+iIg+Mq1P0nclzyyeBjIF2EWu959z3kfb
	 l8rUmv/qTxJLw==
Date: Thu, 9 Jul 2026 14:52:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank.Li@oss.nxp.com
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
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v7 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Message-ID: <20260709195203.GA874193@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-dma_prep_config-v7-3-1f73f4899883@nxp.com>
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

On Thu, May 21, 2026 at 11:32:49AM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Use dmaenigne_prep_config_single() to simplify code.

s/dmaenigne/dmaengine/ both in subject and commit log.

