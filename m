Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A44C9EC88
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PSgqU+F7X2s8rj28W/xLbkWudW7i4G77/ULJT1GEutM=; b=y1j5P0qY7hp5Z7CNgJe1rq7dk9
	P8wEnuQBeIUiRs+JmArZu3bEaCcXWn6ku58XZ0eksKhhxQM7jZH+6F5utFS2Eugtzb7nxBFSE2Wru
	aie4EONjeJeXD8+zil7DYXO1/8tFSYUoC3yXwYLo+0Z+kvKjRZMGDF/u6Ierc8QdIeUSDeI+YgnFz
	qxZeDnxH013rjWuFsSt5PDaZzhi9CzEzvEWZ+MeE2bPvv/X8JRaayc9vXXeYOsCaX9gQMwmhano+g
	wB8eOBlrq5wsAIt6OI1QYPb3TJiW1C0N36AV2F7UhUDPwxbymnUMMYghqlwtfnrS9M86i4VDC1njj
	koctxBVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfHYD-00000005Mru-2MnJ;
	Mon, 12 Jan 2026 13:01:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfHYC-00000005Mrh-2iFr;
	Mon, 12 Jan 2026 13:01:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BDC636013C;
	Mon, 12 Jan 2026 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2987C19422;
	Mon, 12 Jan 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222899;
	bh=WLtpL3iiLHc+bo5wxz2Ay2u3w3qNsN2rTz0oFg1Enb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXpL3ocfh373K5bNXWgVfNocnwtPg11QneBpqIT66SgmmZ/6+awvuRRAs6hTWn3Iq
	 bcl9sVDzTDUlH58n7OTWA7Ow5zH/zTAidmSunr1zSCV7wYLQ6IuEpHb1q50qGePdf/
	 PAhA4LZm8r4xFIuS2KE+Ngg9rjsPTcO2qGiQXm+GwTe17ykNXaZGF5UZzQJLYgf+xD
	 BPDMm+HMpYRLY0M9QmCK6sJM+ACJnMQ0KQyXmq2N5t91Gcbl0TWXezGTixppahR1vh
	 vJ5SiF+P4EuQP4AruPe8Gy2Byg9B6EUPJJ2EtOAoKb4j4WrHjKfzutdV+iRJD1El6U
	 X3sv697FjFtzg==
Date: Mon, 12 Jan 2026 14:01:32 +0100
From: Niklas Cassel <cassel@kernel.org>
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
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aWTwrOOXX3AR8Ght@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
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

Frank,

Thanks a lot for your work on this series!

On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
>  Documentation/driver-api/dmaengine/client.rst |   9 ++
>  drivers/crypto/atmel-aes.c                    |  10 +--
>  drivers/dma/dmaengine.c                       |   3 +
>  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
>  drivers/nvme/target/pci-epf.c                 |  21 ++---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
>  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
>  8 files changed, 177 insertions(+), 84 deletions(-)

Is the plan to merge this series via the dmaengine tree?

If so, we might need an Ack from Mani on the pci-epf-mhi.c and
pci-epf-test.c patch.

Likewise we might need an Ack from Keith/Christoph on the
drivers/nvme/target/pci-epf.c patches.


Kind regards,
Niklas

