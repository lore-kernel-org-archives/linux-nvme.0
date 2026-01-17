Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8DBC98321
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jan 2026 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WAPXlulwTug0Y/JVI0B9w27fbHLQrc2foq0dKOvf4S4=; b=DLnf74pKtsqqiiUMdflw1JDAMa
	CwmP01ioOcPzWuNCYKLIAvKAnzqixD1Tc9j6uNzx2oFauAlzEExQQKDM1y+4DfQh+smxkHbhA00Ob
	e4RzKDjcoYvHtB0sPeKei9WheMMR0q1dX3UM7KzhJ16veWIgzY0tLlpQmE5R0wLf2PuqSs5QCu5lz
	7+wWdbIv9geuoSxYBmUptTj6lbhfCmV+tWqhg1e4yqWdmB4bvc6UOf87spay/hgh1LeK4hDJYcYlu
	m2gX9Z+bjWgomSQlWt3RZlb0zwy9PI3MbwzGbZ5BAqU8YoBjd87afq3KMZ8FyjFgegfRJUEOESv1O
	+xVfAKWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh4ZI-0000000FVS3-2qwu;
	Sat, 17 Jan 2026 11:34:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh4ZI-0000000FVRr-0ax2
	for linux-nvme@lists.infradead.org;
	Sat, 17 Jan 2026 11:34:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CFEC46013B;
	Sat, 17 Jan 2026 11:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28765C4CEF7;
	Sat, 17 Jan 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768649650;
	bh=fv7CZKE3aaSA68XB9hs5SRb1yJ22PTBB5qdBpAufLtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgL1BrgaT52iSum4tdHARsgvsLwD7xKFLvJG31MzNCvKC7ueYCW/5nHSK6dJ3u+QQ
	 o+yw64hK19tYtRwAIbTlrm9pB44tz2S1lCIgzvFb72fQKGydZYBwtggW428jL4u3sn
	 icci5MmA7ytNwQ6XoNAbfAQ2rSzhy71hQdvHuUk3ZWjJfLEy8DIiEycKWzIIfDBS4S
	 6UWaHkbDzoBflMWYP35UuBFFvw1tVCYZ1lMYt0O/ZCQGx6qiYOIykInc5Ju3w1o//w
	 jf9nvSwFKeZOxdZLguezq2PA3bcWlGqKkCe7TpjK+Un+Rk/aHIba+axo+cWkQ+SSEP
	 qaDQ6vyg69k7g==
Date: Sat, 17 Jan 2026 12:34:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Keith Busch <kbusch@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
	imx@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] dmaengine: Add new API to combine configuration
 and descriptor preparation
Message-ID: <aWtzqJKsCHPJqDDH@ryzen>
References: <20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com>
 <aWTwrOOXX3AR8Ght@ryzen>
 <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4elcu5iql65jeqfeqhmllquv253xh4gb37ivef2kyvsj5lps@w35ciehuwxym>
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

On Sat, Jan 17, 2026 at 04:35:40PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jan 12, 2026 at 02:01:32PM +0100, Niklas Cassel wrote:
> > Frank,
> > 
> > Thanks a lot for your work on this series!
> > 
> > On Mon, Jan 05, 2026 at 05:46:50PM -0500, Frank Li wrote:
> > >  Documentation/driver-api/dmaengine/client.rst |   9 ++
> > >  drivers/crypto/atmel-aes.c                    |  10 +--
> > >  drivers/dma/dmaengine.c                       |   3 +
> > >  drivers/dma/dw-edma/dw-edma-core.c            |  41 ++++++---
> > >  drivers/nvme/target/pci-epf.c                 |  21 ++---
> > >  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  52 ++++--------
> > >  drivers/pci/endpoint/functions/pci-epf-test.c |   8 +-
> > >  include/linux/dmaengine.h                     | 117 ++++++++++++++++++++++++--
> > >  8 files changed, 177 insertions(+), 84 deletions(-)
> > 
> > Is the plan to merge this series via the dmaengine tree?
> > 
> 
> It makes sense to take it through dmaengine tree given that the changes in PCI
> and other drivers are straightforward.
> 
> > If so, we might need an Ack from Mani on the pci-epf-mhi.c and
> > pci-epf-test.c patch.
> > 
> 
> Just did.

Great!

Keith, Christoph, any chance to get an ack on the NVMe patches?


Herbert Xu, David Miller (crypto API maintainers),
any chance to get an ack on the crypto driver ?
There does not seem to be an explicit entry in MAINTAINERS for the atmel
crypto driver, and another atmel crypto driver is marked as orphan.


Kind regards,
Niklas

