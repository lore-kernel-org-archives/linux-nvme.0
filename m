Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52886D72371
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jan 2026 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yN9BnikDwTPnlMVaZO6xRTvDqYPy2vdn2ljGsrfZHzU=; b=Ly2KfaMJGkNjtEwGPMFbKo5aQA
	n35d+yLQ8+6sdMcbJ7fbRQMW3RK9VHvLEJax15sbEiS9tHsITSpl4Weyebi/U1Ixy4FtSq5BbG1ot
	AP4efAv/hKlJX7x42NqhFW2vkdP6XPLfc0bN6oQRvDhjm5kcFO/4m9/zYNVX08gWcHLbJzWzoyKbS
	2BhvwKjCSBaHwsCur8u6S2sdjSeinPY9wExepibaNcgJpArKjopTacaakwrJV3ZIjnXaJdJkZfmzj
	munydbY3XqbN7Ozl521xPZah17Iu2G4DyGeVa2yLFLvrmEQJsv5LAwQw3WSXXo4c9Cv2omqMedK1b
	TrxZkqdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEc7-00000008k9R-1eGc;
	Fri, 23 Jan 2026 10:42:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjEc5-00000008k7K-0Dvc
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jan 2026 10:42:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 47D9F40A55;
	Fri, 23 Jan 2026 10:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD424C4CEF1;
	Fri, 23 Jan 2026 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769164920;
	bh=HLrViGVqTC3/G0gsvexqTtXtxspwQxSEDDyxgTv7J0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K88/W9CP38VNlsvsGY4cizpdtUmca1k9hFtwHK6PhgaPrnWH2CuKqJNx2ce/1927M
	 z23lyd1zE8UmSTz14bfD0pUa+rz3qzLSS3Gejq+50Di+KpU/4d5+UwtA2hPwwcKCQw
	 kfIBJcXPFtTQrxF11z1ZKTAgs+14yWjmqzr6G8gaUCSb7GY8R+LvDYI/JTEXRpG4xY
	 T563JVc+Z6dfwEZml6RKjN6FWTXb0TDprK6z1oRVCxsnbpX7vAUDYAHQCWqGTqzWW/
	 dIY1/0GXJC4d0etgGilNFSXTaohdoNdfOvXOnorf7evKJdma7+vkcUuZfBooAn9fJp
	 yREIVdvmIZieg==
Date: Fri, 23 Jan 2026 11:41:54 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH RFT 4/5] dmaengine: dw-edma: Dynamitc append new request
 during dmaengine running
Message-ID: <aXNQcowVEMaE1xr5@ryzen>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
 <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_dymatic-v1-4-9a98c9c98536@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_024201_113867_9FCEA03F 
X-CRM114-Status: GOOD (  11.72  )
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

On Fri, Jan 09, 2026 at 03:13:28PM -0500, Frank Li wrote:
> This use PCS-CCS-CB-TCB Producer-Consumer Synchronization module, which
> support append new DMA request during dmaengine runnings.
> 
> Append new request during dmaengine runnings.
> 
> But look like hardware have bug, which missed doorbell when engine is
> running. So add workaround to push doorbelll again when found engine stop.
> 
> Get more than 10% performance gain.
> 
> The before
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
> 
> After
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Hello Frank,

First of all, I hope that your:
[PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
series will make it to the upcoming 6.20/7.0 merge window.


This RFT series however breaks pci-epf-test:

Before:
#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
#            OK  pci_ep_data_transfer.dma.READ_TEST
ok 14 pci_ep_data_transfer.dma.READ_TEST
#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
#            OK  pci_ep_data_transfer.dma.WRITE_TEST
ok 15 pci_ep_data_transfer.dma.WRITE_TEST

After:
#  RUN           pci_ep_data_transfer.dma.READ_TEST ...
# READ_TEST: Test terminated by timeout
#          FAIL  pci_ep_data_transfer.dma.READ_TEST
not ok 14 pci_ep_data_transfer.dma.READ_TEST
#  RUN           pci_ep_data_transfer.dma.WRITE_TEST ...
# WRITE_TEST: Test terminated by timeout
#          FAIL  pci_ep_data_transfer.dma.WRITE_TEST
not ok 15 pci_ep_data_transfer.dma.WRITE_TEST


After a bisect, first bad commit:
commit 352fd8d5ed468ea616eb4974b5ac19203528b207
Author: Frank Li <Frank.Li@nxp.com>
Date:   Fri Jan 9 15:13:28 2026 -0500

    dmaengine: dw-edma: Dynamitc append new request during dmaengine running



Kind regards,
Niklas

