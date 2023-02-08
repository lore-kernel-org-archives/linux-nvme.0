Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098EEC05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F7seHkC16IPWnL5DBNYqyCu6nzQ0gws31dDz0EuBqHc=; b=O8SvjNxUQwj89XZvG488IQ4zKM
	Ix8P8IJjx7T0BDPvPtwgeiOA8s+wcTquimRyOcNL7kYz7Jh/NaVlSXrVnAk/o2yS30WJQy0kT/cYt
	JweWN5TLEyke6/bySAPTxmzI/YKo9BcWPOFJVN0N0CopljPZkhgfq2ZgmJkFS3E3Th548uveSB4t7
	iGsdMEro8TtpjAuXgUlz1WbLaqYUgv2EGnVPbQy/48V1b+ocudYw6pf7InumKw9ontF978bCCf+hZ
	hIZaZavH5TKixjAmDL/HMTXhu0XMz7+XHs/C72QLawc0gzBO7o2b+NxcqwdYsy/ZdusyjcWZ8FtJw
	Zh33qGRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPoPm-00GVJv-Qm; Wed, 08 Feb 2023 17:39:26 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPoPj-00GVIm-OI
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 17:39:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 631B8B81D21;
	Wed,  8 Feb 2023 17:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54474C4339E;
	Wed,  8 Feb 2023 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675877960;
	bh=SwnmGwvsN9gjTFazpqy98P9wu39uIObVqrLKsmEHZlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0yE/r9FAoDt3ZaABe+cV94Ao10uHMB6KlKMJ7i3hcfrg/jNMIu8Y0c+vaV49uPHI
	 I2ZXUBAwHzZCeduzxTJDc7/YU/QhwUKxh5zdQnFSceoJhZUAQyHWDxpDIAVCe3+xyG
	 0a9TL05e8QZCE8G3mnn2h0mz4n+oyVGhZa1E/mXaX8ObIGtcyvRTHQMI119buFSQeo
	 y+xIVJFBYsGKDTc3ZAEB0C5k6v4HH8xNvGVE/iZcrIdK1OGbeK2+0JORT38voSKXaS
	 JZT8ZOIMlcPa2snL9jzAp+O4oAQElh+tCUL9XzN7tPb1WJLUdAZsVz+KXT5YBTCnUd
	 51M0SYPc823yQ==
Date: Wed, 8 Feb 2023 10:39:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
Cc: Klaus Jensen <its@irrelevant.dk>,
	"Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Lewis, Nathaniel" <Nathaniel.Lewis@sony.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <Y+PeRAFwUkig00cR@kbusch-mbp.dhcp.thefacebook.com>
References: <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de>
 <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
 <Y+IpsEd8kMoljOAa@cormorant.local>
 <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y+NEe3OWshJeHsNB@cormorant.local>
 <BYAPR13MB248670C9FD77D33422E4368681D89@BYAPR13MB2486.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB248670C9FD77D33422E4368681D89@BYAPR13MB2486.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_093924_006540_FCE45CFC 
X-CRM114-Status: GOOD (  13.48  )
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

On Wed, Feb 08, 2023 at 05:26:42PM +0000, Grochowski, Maciej wrote:
> > `nvme-cli id-ctrl /dev/nvmeX` should do nicely :)
> 
> Thanks I attach you output of id-ctrl for both PM1733 and PM9A3.
> 
> Also I am not sure if you use DPC but in our setup we have NVMe in PCIe slots with DPC configured in the BIOS and also inside kernel we enable it via "pcie_ports=dpc-native" parameter. 
> I potentially can check behavior without DPC but not sure how much value is with testing Error Recovery/HotPlug without DPC enabled.

Are you observing DPC events during the error injection recovery? I didn't see
any in the previous logs.

If you have DPC enabled, it really doesn't make sense to aer_inject on anything
downstream capable ports. Those types of errors would be contained by the DPC
hardware; the kernel will get a DPC event instead of an AER.

