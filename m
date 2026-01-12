Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2292EC9EC90
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkeL1hab0CFCim+DqDUJotGybfkWJvU5iBwr8yfBI5c=; b=kcscPIiFYO+Yl8aWiPUARvKEYN
	gkwzdJShR/bdy1NqdDSWOngnV8oZNG0xMvjLZf5v5kQOx8AENwm+WKiISok4cn/7BwbrAEmAtwmVN
	vIJTzzAMmW+9aoAtPMBOD4SdHj5DW4g9mPSbAKtXFoBmoUUowUayF4BlxHgLEesz38vmiM9F1Al1l
	vQDjT51kTTAtlDxa8S+yHmazLyc/LZ15Z8qQ9FAE8phqWg2yNleZYL+ssI6HMocyX8ZFjpyDaoMgG
	+a1URZl8biPZc5HQyp1CpMWQWPKhGzOZ3ctnaZ0w8ONyUfHWud37aQ6hOQ6cbhbVb4Hoo7UWdNFku
	UY2+Fqqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfI59-00000005Q2H-3jmb;
	Mon, 12 Jan 2026 13:35:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfI58-00000005Q2A-2nJF
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 13:35:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CB3A46000A;
	Mon, 12 Jan 2026 13:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D250C16AAE;
	Mon, 12 Jan 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768224941;
	bh=hAdDNP0uJNY4vw73AVjOI055cmk4EXKQe7NLD05xkKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSAsE2ckcMezYmFQIV9Yd3FvJ6NJatqBOWcglypCWCOOZcaRknUNzSGc1K1VDI6Q8
	 G0+bUFIRre9DiQ8r9tI7UlnoO5tRY7Ry76RH6d/S7VS+YRTR2msLcsGXwXF2zA6GqL
	 zAG+Ci/fWtl+3TQ+geYxXPx0H9l0tZmRXY9i5MC54T3nrR1oqNAMPtLFhAgceeehCA
	 ZFYReahADgOJcNjwd5qjjTEduqvXJghwtfiQ2LHpMDlzRrYztueJoEt6PIR8kE07Fe
	 L87h2tJEN7v2yrW04x6YoiiBTm9Sh/MqmMFic8lIUkq6ZP2FA7EvHBPS1NOjCL+ibG
	 Gxx+qqK3PtHNw==
Date: Mon, 12 Jan 2026 14:35:35 +0100
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
Subject: Re: [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link
 entry during dma engine running
Message-ID: <aWT4p7RnFykJnuOz@ryzen>
References: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com>
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

Hello Frank,

On Fri, Jan 09, 2026 at 03:13:24PM -0500, Frank Li wrote:

Subject: dmaengine: dw-edma: support dynamtic add link entry during dma engine running

s/dynamtic/dynamic/

Also in patch 1/5:
s/dymatic/dynamic/


> Patch depend on
> https://lore.kernel.org/imx/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/T/#t

To make it easier for the reader, please include the full list of
dependencies, i.e. also include:
https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
here.


> 
> Only test eDMA, have not tested HDMA.
> Corn case have not tested, such as pause/resume transfer.

s/Corn case/Corner cases/


> 
> Before
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6780, BW=26.5MiB/s (27.8MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=28.6k, BW=112MiB/s (117MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=33.4k, BW=130MiB/s (137MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=1188, BW=149MiB/s (156MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1440, BW=180MiB/s (189MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1282, BW=160MiB/s (168MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=254, BW=127MiB/s (134MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=354, BW=177MiB/s (186MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=388, BW=194MiB/s (204MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=6282, BW=24.5MiB/s (25.7MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.9k, BW=97.5MiB/s (102MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=27.4k, BW=107MiB/s (112MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=1098, BW=137MiB/s (144MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1195, BW=149MiB/s (157MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1120, BW=140MiB/s (147MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=936, BW=117MiB/s (123MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1218, BW=152MiB/s (160MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=301, BW=151MiB/s (158MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=360, BW=180MiB/s (189MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=193, BW=194MiB/s (203MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=796, BW=99.5MiB/s (104MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1019, BW=127MiB/s (134MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=213, BW=107MiB/s (112MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=273, BW=137MiB/s (143MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=168, BW=168MiB/s (177MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=255, BW=128MiB/s (134MB/s)
>    IOPS=266, BW=135MiB/s (141MB/s)
> 
> After
> 
>   Rnd read,    4KB,  QD=1, 1 job :  IOPS=6148, BW=24.0MiB/s (25.2MB/s)
>   Rnd read,    4KB, QD=32, 1 job :  IOPS=29.4k, BW=115MiB/s (121MB/s)
>   Rnd read,    4KB, QD=32, 4 jobs:  IOPS=38.8k, BW=151MiB/s (159MB/s)
>   Rnd read,  128KB,  QD=1, 1 job :  IOPS=859, BW=107MiB/s (113MB/s)
>   Rnd read,  128KB, QD=32, 1 job :  IOPS=1504, BW=188MiB/s (197MB/s)
>   Rnd read,  128KB, QD=32, 4 jobs:  IOPS=1531, BW=191MiB/s (201MB/s)
>   Rnd read,  512KB,  QD=1, 1 job :  IOPS=238, BW=119MiB/s (125MB/s)
>   Rnd read,  512KB, QD=32, 1 job :  IOPS=390, BW=195MiB/s (205MB/s)
>   Rnd read,  512KB, QD=32, 4 jobs:  IOPS=404, BW=202MiB/s (212MB/s)
>   Rnd write,   4KB,  QD=1, 1 job :  IOPS=5801, BW=22.7MiB/s (23.8MB/s)
>   Rnd write,   4KB, QD=32, 1 job :  IOPS=24.7k, BW=96.6MiB/s (101MB/s)
>   Rnd write,   4KB, QD=32, 4 jobs:  IOPS=32.7k, BW=128MiB/s (134MB/s)
>   Rnd write, 128KB,  QD=1, 1 job :  IOPS=744, BW=93.1MiB/s (97.6MB/s)
>   Rnd write, 128KB, QD=32, 1 job :  IOPS=1278, BW=160MiB/s (168MB/s)
>   Rnd write, 128KB, QD=32, 4 jobs:  IOPS=1278, BW=160MiB/s (168MB/s)
>   Seq read,  128KB,  QD=1, 1 job :  IOPS=853, BW=107MiB/s (112MB/s)
>   Seq read,  128KB, QD=32, 1 job :  IOPS=1511, BW=189MiB/s (198MB/s)
>   Seq read,  512KB,  QD=1, 1 job :  IOPS=240, BW=120MiB/s (126MB/s)
>   Seq read,  512KB, QD=32, 1 job :  IOPS=386, BW=193MiB/s (203MB/s)
>   Seq read,    1MB, QD=32, 1 job :  IOPS=200, BW=201MiB/s (211MB/s)
>   Seq write, 128KB,  QD=1, 1 job :  IOPS=749, BW=93.7MiB/s (98.3MB/s)
>   Seq write, 128KB, QD=32, 1 job :  IOPS=1266, BW=158MiB/s (166MB/s)
>   Seq write, 512KB,  QD=1, 1 job :  IOPS=198, BW=99.0MiB/s (104MB/s)
>   Seq write, 512KB, QD=32, 1 job :  IOPS=352, BW=176MiB/s (185MB/s)
>   Seq write,   1MB, QD=32, 1 job :  IOPS=184, BW=184MiB/s (193MB/s)
>   Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=287, BW=145MiB/s (152MB/s)
>  IOPS=299, BW=149MiB/s (156MB/s)

We can clearly see the improvement, but overall, your numbers are quite low.
What is the PCIe Gen + number of lanes you are using?
Are you running nvmet-pci-epf backed by a real drive or backed by null-blk?
(Having nvmet-pci-epf backed by null-blk is much better for benchmarking.)

I'm using nvmet-pci-epf backed by null-blk, with a PCIe Gen3 link with 4 lanes.


Applying only your dependencies, I get:

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.1k, BW=47.2MiB/s (49.5MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=51.1k, BW=200MiB/s (209MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=72.2k, BW=282MiB/s (296MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=2922, BW=365MiB/s (383MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=18.9k, BW=2368MiB/s (2483MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=18.7k, BW=2334MiB/s (2447MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1867, BW=934MiB/s (979MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=4738, BW=2369MiB/s (2484MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=4675, BW=2338MiB/s (2451MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=10.6k, BW=41.4MiB/s (43.5MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=34.4k, BW=135MiB/s (141MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=34.4k, BW=135MiB/s (141MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=2624, BW=328MiB/s (344MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1277MiB/s (1339MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=10.3k, BW=1282MiB/s (1344MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=3195, BW=399MiB/s (419MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=18.6k, BW=2321MiB/s (2434MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=2162, BW=1081MiB/s (1134MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=4727, BW=2364MiB/s (2479MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=2360, BW=2361MiB/s (2476MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2997, BW=375MiB/s (393MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=10.2k, BW=1278MiB/s (1341MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=1434, BW=717MiB/s (752MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=2557, BW=1279MiB/s (1341MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=1276, BW=1276MiB/s (1338MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2110, BW=1058MiB/s (1109MB/s)
 IOPS=2127, BW=1068MiB/s (1120MB/s)


Applying your dependencies + this series, I get:

  Rnd read,    4KB,  QD=1, 1 job :  IOPS=12.5k, BW=48.7MiB/s (51.0MB/s)
  Rnd read,    4KB, QD=32, 1 job :  IOPS=55.3k, BW=216MiB/s (226MB/s)
  Rnd read,    4KB, QD=32, 4 jobs:  IOPS=175k, BW=682MiB/s (715MB/s)
  Rnd read,  128KB,  QD=1, 1 job :  IOPS=3018, BW=377MiB/s (396MB/s)
  Rnd read,  128KB, QD=32, 1 job :  IOPS=20.1k, BW=2519MiB/s (2641MB/s)
  Rnd read,  128KB, QD=32, 4 jobs:  IOPS=24.4k, BW=3051MiB/s (3199MB/s)
  Rnd read,  512KB,  QD=1, 1 job :  IOPS=1850, BW=925MiB/s (970MB/s)
  Rnd read,  512KB, QD=32, 1 job :  IOPS=5846, BW=2923MiB/s (3065MB/s)
  Rnd read,  512KB, QD=32, 4 jobs:  IOPS=6141, BW=3071MiB/s (3220MB/s)
  Rnd write,   4KB,  QD=1, 1 job :  IOPS=11.6k, BW=45.4MiB/s (47.6MB/s)
  Rnd write,   4KB, QD=32, 1 job :  IOPS=49.6k, BW=194MiB/s (203MB/s)
  Rnd write,   4KB, QD=32, 4 jobs:  IOPS=82.0k, BW=320MiB/s (336MB/s)
  Rnd write, 128KB,  QD=1, 1 job :  IOPS=3051, BW=381MiB/s (400MB/s)
  Rnd write, 128KB, QD=32, 1 job :  IOPS=13.0k, BW=1619MiB/s (1698MB/s)
  Rnd write, 128KB, QD=32, 4 jobs:  IOPS=12.5k, BW=1559MiB/s (1635MB/s)
  Seq read,  128KB,  QD=1, 1 job :  IOPS=3445, BW=431MiB/s (452MB/s)
  Seq read,  128KB, QD=32, 1 job :  IOPS=18.3k, BW=2283MiB/s (2394MB/s)
  Seq read,  512KB,  QD=1, 1 job :  IOPS=2048, BW=1024MiB/s (1074MB/s)
  Seq read,  512KB, QD=32, 1 job :  IOPS=5766, BW=2883MiB/s (3023MB/s)
  Seq read,    1MB, QD=32, 1 job :  IOPS=3038, BW=3038MiB/s (3186MB/s)
  Seq write, 128KB,  QD=1, 1 job :  IOPS=2961, BW=370MiB/s (388MB/s)
  Seq write, 128KB, QD=32, 1 job :  IOPS=12.3k, BW=1535MiB/s (1609MB/s)
  Seq write, 512KB,  QD=1, 1 job :  IOPS=1482, BW=741MiB/s (777MB/s)
  Seq write, 512KB, QD=32, 1 job :  IOPS=3144, BW=1572MiB/s (1648MB/s)
  Seq write,   1MB, QD=32, 1 job :  IOPS=1549, BW=1550MiB/s (1625MB/s)
  Rnd rdwr, 4K..1MB, QD=8, 4 jobs:  IOPS=2596, BW=1303MiB/s (1366MB/s)
 IOPS=2617, BW=1313MiB/s (1377MB/s)


So I can clearly see an improvement with this patch series.
Great work so far!


Kind regards,
Niklas

