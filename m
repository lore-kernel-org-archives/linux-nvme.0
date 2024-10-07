Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF932CFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 10:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woF9k4BKswIfMgGTQjPP0h8vXB+SUPovvybuHiWXm9s=; b=2JPyLten7BDveNCs6VtvIoGLEn
	I8X9veoFahwqjPex+2Mq9GPAAxvn9okOUML3/4WVCX6ws7DaZTGJjFL3LkwzxYnA/JdrG2E2YJsH2
	/8G392sAqmYipIwITlCa0seB7XTiE9mDq74DJiK659+N4JOSCWH1MnMlQ8ZvSc41QyMgyQAqgDZTN
	+MmQbu6MIw0pOy7SaM+XNl9MQKzuz5Er95N8neHVor9C/UheqZn2TGoveIpdY7jyqvEhk11Ymcet7
	aVIdehWwuf/BLXrKwESkcC6H/JyWJQ1sgk/LVqXEy8S+jlBt5FFkWGxLo4gz34K43XwjLe0LoZKwF
	svpUAwpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkjZ-000000021DJ-2ImR;
	Mon, 07 Oct 2024 10:12:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxkjW-000000021CG-0Nix
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 10:12:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A1A14A41A01;
	Mon,  7 Oct 2024 10:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E505C4CEC6;
	Mon,  7 Oct 2024 10:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728295972;
	bh=A4mVW+NY0i2mTRbjd0MsKzvQOK8+Z8feayyGgEKqI6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3mmBNwX9c1Z760gy2vCO1/3tfZCVfWshnX6r9NvN4ckQ1+3ti5NS+viE43QbapBX
	 COc9hAuSmjjRuSo/r9UT8KCC0YvouzLNRGxLRy/a9SRZMRv29KcHviKeOidc9khOiP
	 4388oV8+RHUb37Kn0+vhXj/ddhf0gkwctBnDHsIhFvLCBEF653gVuV4iUJtOBZOFgB
	 qtKo0OVJPbGCt+d+3BBWwXzxuCThhDndwwgqDhf282/YiZGwJ76801dBATzR3er62V
	 sx+yU+qzhrOiaSocVDmyUlA4gZkwn52k0aqddvuzAsTGgiuTC4T3n0/rBM2UvuER3o
	 AdD5nM7iZ+UmQ==
Date: Mon, 7 Oct 2024 12:12:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <ZwO0H0WCnORq9EzQ@ryzen>
References: <20241007044351.157912-1-dlemoal@kernel.org>
 <20241007044351.157912-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-5-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_031254_210811_BF3C5CC3 
X-CRM114-Status: GOOD (  14.26  )
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

On Mon, Oct 07, 2024 at 01:43:50PM +0900, Damien Le Moal wrote:
> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

(snip)

> Early versions of this driver code were based on an RFC submission by
> Alan Mikhak <alan.mikhak@sifive.com> (https://lwn.net/Articles/804369/).
> The code however has since been completely rewritten.

Here you state that the code has been completely rewritten...


> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/pci/endpoint/functions/Kconfig        |    9 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-nvme.c | 2489 +++++++++++++++++
>  4 files changed, 2506 insertions(+)
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-nvme.c

(snip)

> --- /dev/null
> +++ b/drivers/pci/endpoint/functions/pci-epf-nvme.c
> @@ -0,0 +1,2489 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe function driver for PCI Endpoint Framework
> + *
> + * Copyright (C) 2019 SiFive

...yet here you claim Copyright (C) SiFive.

*If* the code has been completely rewritten, then you probably should
put yourself and/or your current employeer as the copyright holder.


Kind regards,
Niklas

